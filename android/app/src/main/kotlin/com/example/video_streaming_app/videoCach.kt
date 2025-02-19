package com.example.video_streaming_app

import android.content.Context
import android.util.Log
import java.io.File

class VideoCache(private val context: Context) {

    // Get the cache directory
    private val cacheDir: File = context.cacheDir

    // Cache a file (either .m3u8 or .ts)
    fun cacheFile(url: String, data: ByteArray): File {
        val fileName = url.hashCode().toString() // Generate a unique file name
        val file = File(cacheDir, fileName)
        file.writeBytes(data)
        return file
    }

    // Get a cached file
    fun getCachedFile(url: String): File? {
        val fileName = url.hashCode().toString()
        val file = File(cacheDir, fileName)
        return if (file.exists()) file else null
    }

    // Clear the cache
    fun clearCache() {
        cacheDir.listFiles()?.forEach { it.delete() }
    }
}