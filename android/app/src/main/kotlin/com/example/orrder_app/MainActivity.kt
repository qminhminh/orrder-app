package com.example.orrder_app

import io.flutter.embedding.android.FlutterActivity
//import com.example.orrder_app.XiboReceiver
import android.content.IntentFilter
import android.content.Context
import android.os.Bundle

class MainActivity : FlutterActivity(){
    private lateinit var xiboReceiver: XiboReceiver

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        xiboReceiver = XiboReceiver()
        val filter = IntentFilter("com.example.MY_ACTION")

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(xiboReceiver, filter, Context.RECEIVER_EXPORTED)
        } else {
            @Suppress("DEPRECATION")
            registerReceiver(xiboReceiver, filter)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(xiboReceiver)
    }
}
