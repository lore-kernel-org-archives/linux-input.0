From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Wed, 8 Jun 2011 22:56:29 +0800
Message-ID: <BANLkTin1YhxCE5J9suR93eWcWEtviFNLtg@mail.gmail.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
	<20110602144146.GB3508@nautilus.holoscopio.com>
	<BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
	<20110603124428.GA2379@nautilus.holoscopio.com>
	<BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
	<BANLkTikiX4X2OEET5qmejdWhs1XY7e3HWw@mail.gmail.com>
	<20110608125758.GA2465@nautilus.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38539 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab1FHO4b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2011 10:56:31 -0400
Received: by ywe9 with SMTP id 9so210024ywe.19
        for <linux-input@vger.kernel.org>; Wed, 08 Jun 2011 07:56:30 -0700 (PDT)
In-Reply-To: <20110608125758.GA2465@nautilus.holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Thanks, Benjamin and Cascardo.

2011/6/8 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> Thanks, Benjamin. That clarifies a lot and points what the real fix
> should be for this device.
> Chih-Wei, could you send us the results of your tests? I don't have the
> device available right now. I could get it next week, perhaps, if my
> client still gets it.

I'm glad to do so.
But what test results did you want me to show exactly?

Let me clarify my situation:
* Device under test: ASUS ET1602, touchscreen id (1bfd:1688).
* Kernel: 2.6.38, with android patches (from Google)
* Android version: 2.2.2 (froyo)

By the previous observation from getevent, I added
the following patch to android framework:

diff --git a/libs/ui/EventHub.cpp b/libs/ui/EventHub.cpp
index 0e11823..6ef9da1 100755
--- a/libs/ui/EventHub.cpp
+++ b/libs/ui/EventHub.cpp
@@ -670,7 +671,7 @@ int EventHub::open_device(const char *deviceName)
         device->classes |= CLASS_TOUCHSCREEN | CLASS_TOUCHSCREEN_MT;

     // Is this an old style single-touch driver?
-    } else if (test_bit(BTN_TOUCH, key_bitmask)
+    } else if ((test_bit(BTN_TOUCH, key_bitmask) ||
test_bit(BTN_MOUSE, key_bitmask))
             && test_bit(ABS_X, abs_bitmask) && test_bit(ABS_Y, abs_bitmask)) {
         device->classes |= CLASS_TOUCHSCREEN;
     }

Then the touch device (event7) is correctly recognized by
the android framework and works fine.

Without this patch, event7 is ignored and only event6 is detected,
but no touch event generated from it.

Let me know if you need more details.

I'll try Benjamin's suggestion tomorrow.

Regards,
-- 
Chih-Wei
Android-x86 project
http://www.android-x86.org
