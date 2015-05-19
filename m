From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] input: sur40: fix v4l dependency
Date: Tue, 19 May 2015 15:08:05 +0200
Message-ID: <6880566.G7eZ6NqpSp@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Echtler <floe@butterbrot.org>, Henrik Rydberg <rydberg@bitmath.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

The recently added support for the raw video stream in the SUR40
driver fails to link if the driver is built-in but v4l2 is not:

drivers/built-in.o: In function `sur40_disconnect':
:(.text+0xf2ed2): undefined reference to `video_unregister_device'
:(.text+0xf2eda): undefined reference to `v4l2_device_unregister'
:(.text+0xf2ee2): undefined reference to `vb2_dma_sg_cleanup_ctx'

This adds an explicit dependency, to avoid the broken build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e831cd251fb ("[media] add raw video stream support for Samsung SUR40")

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index cee8ffe4ffd9..90935f3918db 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -980,6 +980,7 @@ config TOUCHSCREEN_SUN4I
 config TOUCHSCREEN_SUR40
 	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
 	depends on USB && MEDIA_USB_SUPPORT && HAS_DMA
+	depends on VIDEO_V4L2
 	select INPUT_POLLDEV
 	select VIDEOBUF2_DMA_SG
 	help
