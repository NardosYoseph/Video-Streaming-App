package com.example.video_streaming_app

import android.util.Log
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.google.android.exoplayer2.*
import com.google.android.exoplayer2.database.StandaloneDatabaseProvider
import com.google.android.exoplayer2.upstream.*
import com.google.android.exoplayer2.upstream.cache.*
import com.google.android.exoplayer2.source.*
import java.io.File

class MainActivity: FlutterActivity() {
    private val CHANNEL = "video_cache"
    private lateinit var cache: SimpleCache
    private lateinit var exoPlayer: SimpleExoPlayer

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize the cache
        val cacheDir = File(cacheDir, "video_cache")
        val databaseProvider = StandaloneDatabaseProvider(this)
        cache = SimpleCache(cacheDir, LeastRecentlyUsedCacheEvictor(100 * 1024 * 1024), databaseProvider)

        // Initialize ExoPlayer
        exoPlayer = SimpleExoPlayer.Builder(this).build()

        // Set up method channel for Flutter communication
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "cacheVideo" -> {
                    val videoUrl = call.argument<String>("url") ?: ""
                    preloadVideo(videoUrl)
                    result.success(videoUrl)
                }
                else -> result.notImplemented()
            }
        }
    }



    private fun preloadVideo(url: String) {
    val dataSourceFactory = DefaultDataSourceFactory(this, "video-cache")
val cacheDataSourceFactory = CacheDataSource.Factory()
    .setCache(cache)
    .setUpstreamDataSourceFactory(dataSourceFactory)
    .setCacheWriteDataSinkFactory(null)
    .setFlags(CacheDataSource.FLAG_IGNORE_CACHE_ON_ERROR)
    .setEventListener(object : CacheDataSource.EventListener {
        override fun onCachedBytesRead(cacheSizeBytes: Long, cachedBytesRead: Long) {
            Log.e("VideoCache", "Cache HIT: Read $cachedBytesRead bytes from cache (Total: $cacheSizeBytes)****************************************")
        }

        override fun onCacheIgnored(reason: Int) {
            Log.e("VideoCache", "Cache MISS: Video is not fully cached (Reason: $reason)*********************")
        }
    })

    val mediaSource = ProgressiveMediaSource.Factory(cacheDataSourceFactory)
        .createMediaSource(MediaItem.fromUri(Uri.parse(url)))

    // Log when preloading starts
    Log.e("VideoCache", "Preloading video: $url *************************************")

    exoPlayer.addListener(object : Player.Listener {
        override fun onPlaybackStateChanged(state: Int) {
            when (state) {
                Player.STATE_BUFFERING -> android.util.Log.d("VideoCache", "Buffering video: $url")
                Player.STATE_READY -> android.util.Log.d("VideoCache", "Video is ready: $url")
                Player.STATE_ENDED -> android.util.Log.d("VideoCache", "Video ended: $url")
            }
        }
    })

    exoPlayer.setMediaSource(mediaSource)
    exoPlayer.prepare()
}


    override fun onDestroy() {
        super.onDestroy()
        exoPlayer.release() // Release ExoPlayer resources
        cache.release() // Release cache resources
    }
}