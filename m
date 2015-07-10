From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH resend] input: fix sur40.c dependency/build errors
Date: Fri, 10 Jul 2015 08:15:57 -0700
Message-ID: <559FE1AD.5020907@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41150 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264AbbGJPQD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 11:16:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian floe Echtler <floe@butterbrot.org>

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
---
 drivers/input/touchscreen/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20150710.orig/drivers/input/touchscreen/Kconfig
+++ linux-next-20150710/drivers/input/touchscreen/Kconfig
@@ -993,6 +993,7 @@ config TOUCHSCREEN_SUN4I
 config TOUCHSCREEN_SUR40
 	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
 	depends on USB && MEDIA_USB_SUPPORT && HAS_DMA
+	depends on VIDEO_V4L2
 	select INPUT_POLLDEV
 	select VIDEOBUF2_DMA_SG
 	help
