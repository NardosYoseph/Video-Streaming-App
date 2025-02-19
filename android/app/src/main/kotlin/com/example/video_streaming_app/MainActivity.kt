package com.example.video_streaming_app

import android.net.Uri
import androidx.media3.common.MediaItem
import androidx.media3.datasource.DefaultDataSource
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.exoplayer.hls.HlsMediaSource
import androidx.media3.exoplayer.source.MediaSource
import androidx.media3.ui.PlayerView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.app/video_cache"
    private lateinit var videoCache: VideoCache
    private lateinit var exoPlayer: ExoPlayer
    private lateinit var playerView: PlayerView

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        videoCache = VideoCache(applicationContext)
       initializeExoPlayer()
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "cacheVideo" -> {
                    val url = call.argument<String>("url")
                    val data = call.argument<ByteArray>("data")
                    if (url != null && data != null) {
                        val file = videoCache.cacheFile(url, data)
                        result.success(file.absolutePath)
                    } else {
                        result.error("INVALID_ARGUMENTS", "URL or data is null", null)
                    }
                }
                "getCachedVideo" -> {
                    val url = call.argument<String>("url")
                    if (url != null) {
                        val file = videoCache.getCachedFile(url)
                        if (file != null) {
                            result.success(file.absolutePath)
                        } else {
                            result.success(null)
                        }
                    } else {
                        result.error("INVALID_ARGUMENTS", "URL is null", null)
                    }
                }
                "clearCache" -> {
                    videoCache.clearCache()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
    private fun initializeExoPlayer() {
        // Create an ExoPlayer instance
        exoPlayer = ExoPlayer.Builder(this).build()

        // Set up the PlayerView (UI for video playback)
        playerView = PlayerView(this)
        playerView.player = exoPlayer
        setContentView(playerView)
    }

    private fun playVideo(url: String) {
        // Create a MediaItem for the HLS stream
        val mediaItem = MediaItem.fromUri(Uri.parse(url))

        // Create a DataSource.Factory
        val dataSourceFactory = DefaultDataSource.Factory(this)

        // Create an HlsMediaSource.Factory
        val hlsMediaSourceFactory = HlsMediaSource.Factory(dataSourceFactory)

        // Create a MediaSource
        val mediaSource: MediaSource = hlsMediaSourceFactory.createMediaSource(mediaItem)

        // Prepare the ExoPlayer with the MediaSource
        exoPlayer.setMediaSource(mediaSource)
        exoPlayer.prepare()
        exoPlayer.play()
    }
    override fun onDestroy() {
        super.onDestroy()
        // Release the ExoPlayer instance when the activity is destroyed
        exoPlayer.release()
    }
}