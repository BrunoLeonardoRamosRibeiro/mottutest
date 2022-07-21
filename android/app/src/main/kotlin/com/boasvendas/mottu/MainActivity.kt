package com.boasvendas.mottu

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import okhttp3.*
import java.io.IOException


class MainActivity : FlutterActivity() {

    private val CHANNEL = "boasvendas.com/estados"
    private lateinit var channel: MethodChannel
    private val BATTERY_CHANNEL = "boasvendas.com/battery"
    private lateinit var batteryChannel: MethodChannel
    private val URL_ESTADOS = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
    private val client = OkHttpClient()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        )

        channel.setMethodCallHandler { call, result ->

            if (call.method == "getAll") {
                val request = Request.Builder()
                    .url(URL_ESTADOS)
                    .build()

                client.newCall(request).enqueue(object : Callback {
                    override fun onFailure(call: Call, e: IOException) {

                        result.error("INDISPONÍVEL", "O acesso está indisponível.", null)
                    }

                    override fun onResponse(call: Call, response: Response) {
                        result.success(response.body()?.string())
                    }
                })

            } else {
                result.notImplemented()
            }
        }

        batteryChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            BATTERY_CHANNEL
        )

        batteryChannel.setMethodCallHandler { batteryCall, batteryResult ->
            if (batteryCall.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    batteryResult.success("$batteryLevel%")
                } else {
                    batteryResult.error("UNAVAILABLE", "Battery level not available.", null)
                }


            } else {
                batteryResult.notImplemented()
            }
        }

    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null, IntentFilter(
                    Intent.ACTION_BATTERY_CHANGED
                )
            )
            batteryLevel =
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE,
                    -1
                )

        }
        return batteryLevel
    }
}
