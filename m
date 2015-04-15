From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] input/touchscreen: fix sur40.c build errors
Date: Wed, 15 Apr 2015 08:54:06 -0700
Message-ID: <552E899E.2050703@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Florian 'floe' Echtler <floe@butterbrot.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors due to missing Kconfig dependency.

drivers/built-in.o: In function `sur40_disconnect':
sur40.c:(.text+0x22be6e): undefined reference to `video_unregister_device'
sur40.c:(.text+0x22be77): undefined reference to `v4l2_device_unregister'
drivers/built-in.o: In function `sur40_process_video':
sur40.c:(.text+0x22c1d4): undefined reference to `v4l2_get_timestamp'
drivers/built-in.o: In function `sur40_probe':
sur40.c:(.text+0x22ca82): undefined reference to `v4l2_device_register'
sur40.c:(.text+0x22cb1a): undefined reference to `v4l2_device_unregister'
sur40.c:(.text+0x22cbf7): undefined reference to `video_device_release_empty'
sur40.c:(.text+0x22cc53): undefined reference to `__video_register_device'
sur40.c:(.text+0x22cc90): undefined reference to `video_unregister_device'
drivers/built-in.o: In function `sur40_vidioc_querycap':
sur40.c:(.text+0x22ccb0): undefined reference to `video_devdata'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Florian 'floe' Echtler <floe@butterbrot.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/touchscreen/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20150415.orig/drivers/input/touchscreen/Kconfig
+++ linux-next-20150415/drivers/input/touchscreen/Kconfig
@@ -981,6 +981,7 @@ config TOUCHSCREEN_SUR40
 	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
 	depends on USB
 	depends on MEDIA_USB_SUPPORT
+	depends on VIDEO_V4L2
 	select INPUT_POLLDEV
 	select VIDEOBUF2_DMA_SG
 	help
