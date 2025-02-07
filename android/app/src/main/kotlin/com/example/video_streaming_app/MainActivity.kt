package com.example.video_streaming_app

import android.util.Log
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import com.google.android.exoplayer2.upstream.cache.SimpleCache
import com.google.android.exoplayer2.upstream.cache.CacheDataSource
import com.google.android.exoplayer2.upstream.DefaultHttpDataSource
import com.google.android.exoplayer2.upstream.cache.NoOpCacheEvictor
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.SimpleExoPlayer
import com.google.android.exoplayer2.source.ProgressiveMediaSource
import java.io.File

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.video_swipe_app/video_cache"
    private lateinit var cache: SimpleCache

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize the cache
        val cacheDir = File(cacheDir, "video_cache")
        cache = SimpleCache(cacheDir, NoOpCacheEvictor())

        // Set up MethodChannel
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "cacheVideo" -> {
                    val videoUrl = call.argument<String>("videoUrl")
                    if (videoUrl != null) {
                        cacheVideo(videoUrl)
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENT", "Video URL is null", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun cacheVideo(videoUrl: String) {
        val cacheDataSourceFactory = CacheDataSource.Factory()
            .setCache(cache)
            .setUpstreamDataSourceFactory(DefaultHttpDataSource.Factory())
            .setFlags(CacheDataSource.FLAG_IGNORE_CACHE_ON_ERROR)

        // Use ExoPlayer to cache the video
        val mediaSource = ProgressiveMediaSource.Factory(cacheDataSourceFactory)
            .createMediaSource(MediaItem.fromUri(Uri.parse(videoUrl)))

        val exoPlayer = SimpleExoPlayer.Builder(this).build()
        exoPlayer.setMediaSource(mediaSource)
        exoPlayer.prepare()
    }
}