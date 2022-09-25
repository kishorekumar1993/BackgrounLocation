package com.example.background

import android.annotation.TargetApi
import android.app.Activity
import android.app.Application
import android.os.Build
import android.os.Bundle

object LifecycleDetector {

    val activityLifecycleCallbacks: Application.ActivityLifecycleCallbacks =
        ActivityLifecycleCallbacks()

    var listener: Listener? = null

    var isActivityRunning = false
        private set

    interface Listener {

        fun onFlutterActivityCreated()

        fun onFlutterActivityDestroyed()

    }

    @TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
    private class ActivityLifecycleCallbacks : Application.ActivityLifecycleCallbacks {
        override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
            if (activity is MainActivity) {
                isActivityRunning = true
                listener?.onFlutterActivityCreated()
            }
        }

        override fun onActivityDestroyed(activity: Activity) {
            if (activity is MainActivity) {
                isActivityRunning = false
                listener?.onFlutterActivityDestroyed()
            }
        }

        override fun onActivityStarted(activity: Activity) {}

        override fun onActivityStopped(activity: Activity) {}

        override fun onActivityResumed(activity: Activity) {}

        override fun onActivityPaused(activity: Activity) {}

        override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {}
    }

}