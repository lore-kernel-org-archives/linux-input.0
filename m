From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH] Implement driver for Topaz signature pads
Date: Fri, 7 Apr 2017 15:10:18 -0700
Message-ID: <20170407221018.vvav4f46e5c6ojfh@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rosenzweig.io ([107.170.207.86]:53282 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbdDGWRT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Apr 2017 18:17:19 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, b.zolnierkie@samsung.com

This patch adds a new driver targeting the T-LBK766SE-BHSB-R. This model
is a 320x240 signature pad communicating via USB HID packets.
Optionally, it can also communicate over RS-232, but this is not
supported in this patch. Enough of the protocol itself is implemented
here in order to blit bitmaps and fill rectangles, which is sufficient
for an fbcon terminal. In principle, a full framebuffer device could be
exposed, but this is not implemented due to performance concerns.

The signature pads, as the name suggests, normally have a pen bundled,
which could be exposed as input device. I purchased this device second
hand missing the pen, so this aspect of the protocol is neither reverse
engineered nor implemented.

At the moment, the driver requires the generic HID device to be disabled
in order for probe to be called.

See https://git.rosenzweig.io/?p=libsigpad.git;a=blob;f=protocol.md for
a work-in-progress protocol reference.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 MAINTAINERS             |   5 +
 drivers/hid/Kconfig     |   6 ++
 drivers/hid/Makefile    |   1 +
 drivers/hid/hid-ids.h   |   3 +
 drivers/hid/hid-topaz.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 274 insertions(+)
 create mode 100644 drivers/hid/hid-topaz.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80f1a5894411..3f9c78524d20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12376,6 +12376,11 @@ T:	quilt http://svn.sourceforge.jp/svnroot/tomoyo/trunk/2.5.x/tomoyo-lsm/patches
 S:	Maintained
 F:	security/tomoyo/
 
+TOPAZ SIGNATURE PAD DRIVER
+M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
+S:	Odd Fixes
+F:	drivers/hid/hid-topaz.c
+
 TOPSTAR LAPTOP EXTRAS DRIVER
 M:	Herton Ronaldo Krzesinski <herton@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1aeb80e52424..c3c938c796ea 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -985,6 +985,12 @@ config HID_ALPS
 	Say Y here if you have a Alps touchpads over i2c-hid or usbhid
 	and want support for its special functionalities.
 
+config HID_TOPAZ
+	tristate "Topaz signature pad HID support"
+	depends on USB_HID && FB
+	---help---
+	Support for Topaz signature pads that communicate over USB HID.
+
 endmenu
 
 endif # HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 4d111f23e801..c4a5bb8eb311 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
 obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
 obj-$(CONFIG_HID_THRUSTMASTER)	+= hid-tmff.o
 obj-$(CONFIG_HID_TIVO)		+= hid-tivo.o
+obj-$(CONFIG_HID_TOPAZ) 	+= hid-topaz.o
 obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
 obj-$(CONFIG_HID_TWINHAN)	+= hid-twinhan.o
 obj-$(CONFIG_HID_UCLOGIC)	+= hid-uclogic.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 86c95d30ac80..5f70e2ee7cd3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1119,4 +1119,7 @@
 #define USB_VENDOR_ID_UGTIZER			0x2179
 #define USB_DEVICE_ID_UGTIZER_TABLET_GP0610	0x0053
 
+#define USB_VENDOR_ID_TOPAZ	    0x06A8
+#define USB_DEVICE_ID_TOPAZ_LBK766  0x0043
+
 #endif
diff --git a/drivers/hid/hid-topaz.c b/drivers/hid/hid-topaz.c
new file mode 100644
index 000000000000..92a8f34a367f
--- /dev/null
+++ b/drivers/hid/hid-topaz.c
@@ -0,0 +1,259 @@
+/*
+ * HID driver for Topaz signature pads suitable for fbcon
+ *
+ * Copyright (c) 2017 Alyssa Rosenzweig
+ *
+ * Author: Alyssa Rosenzweig <alyssa@rosenzweig.io>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/fb.h>
+#include <linux/uaccess.h>
+
+#include "hid-ids.h"
+
+#define MODE_CLEAR		0
+#define MODE_XOR		1
+#define MODE_OPAQUE		2
+#define MODE_TRANSPARENT	3
+
+struct topazfb_par {
+	struct hid_device *hid;
+};
+
+static struct fb_fix_screeninfo topazfb_fix = {
+	.id = "topaz",
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_MONO01,
+	.accel = FB_ACCEL_NONE,
+	.smem_len = (320*240>>3),
+	.line_length = (320 >> 3)
+};
+
+static int topaz_send(struct hid_device *dev, u8 *packet, size_t sz)
+{
+	int ret;
+
+	u8 *buf = kmemdup(packet, sz, GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (!dev->ll_driver->output_report)
+		return -ENODEV;
+
+	hid_hw_output_report(dev, buf, sz);
+	kfree(buf);
+
+	return 0;
+}
+
+static int topaz_blit8(struct hid_device *dev, u16 x, u16 y, void *data)
+{
+	u8 packet[11 + 8] = {
+		0xF2, 0x07, 0x02,		// command + mode
+		(x & 0xFF00) >> 8, x & 0x00FF,  // coordinates
+		(y & 0xFF00) >> 8, y & 0x00FF,
+		0, 8,				// size
+		0, 8
+	};
+
+	memcpy(packet + 11, data, 8);
+
+	return topaz_send(dev, packet, sizeof(packet));
+}
+
+/* blit arbitrarily large bitmap, slicing it into 8x8 chunks */
+
+static int topaz_bitmap(struct hid_device *dev,
+			u16 x, u16 y, u16 w, u16 h,
+			const u8 *data)
+{
+	u8 block[8];
+
+	int dx, dy, row;
+
+	/* compute line length, padding as necessary */
+	int l = ((w + 7) >> 3) << 3;
+
+	for (dx = 0; dx < w; dx += 8) {
+		for (dy = 0; dy < h; dy += 8) {
+			/* blit 8x8 block */
+
+			memset(block, 0, sizeof(block));
+
+			for (row = 0; row < 8 && dy + row < h; ++row)
+				block[row] = data[((row + dy) * l + dx) >> 3];
+
+			if (topaz_blit8(dev, x + dx, y + dy, block))
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+/* fast fill or clear, depending on which mode is specified */
+
+static int topaz_rectangle(struct hid_device *dev,
+			   u16 x, u16 y, u16 w, u16 h,
+			   u8 mode)
+{
+	u8 packet[11] = {
+		0xFF, 0x12, mode,
+		(x & 0xFF00) >> 8, x & 0xFF,
+		(y & 0xFF00) >> 8, y & 0xFF,
+		(w & 0xFF00) >> 8, w & 0xFF,
+		(h & 0xFF00) >> 8, h & 0xFF,
+	};
+
+	return topaz_send(dev, packet, sizeof(packet));
+}
+
+static int topaz_clear(struct hid_device *dev)
+{
+	return topaz_rectangle(dev, 0, 0, 320, 240, 2);
+}
+
+static int topaz_backlight(struct hid_device *dev, bool on)
+{
+	u8 packet[] = { 0x81, 0x02 | (!on) };
+
+	return topaz_send(dev, packet, sizeof(packet));
+}
+
+static void topazfb_imageblit(struct fb_info *p, const struct fb_image *image)
+{
+	if (image->depth != 1) {
+		pr_err("Cannot blit nonmonochrome image\n");
+		return;
+	}
+
+	topaz_bitmap(((struct topazfb_par *) p->par)->hid,
+			image->dx, image->dy,
+			image->width, image->height,
+			image->data);
+}
+
+static void topazfb_fillrect(struct fb_info *p,
+			     const struct fb_fillrect *region)
+{
+	topaz_rectangle(((struct topazfb_par *) p->par)->hid,
+			region->dx, region->dy,
+			region->width, region->height,
+			region->rop == ROP_XOR ? MODE_XOR : MODE_OPAQUE);
+}
+
+static int topazfb_blank(int mode, struct fb_info *p)
+{
+	return topaz_backlight(((struct topazfb_par *) p->par)->hid,
+				mode == FB_BLANK_UNBLANK);
+}
+
+static struct fb_ops topazfb_ops = {
+	.owner = THIS_MODULE,
+	.fb_fillrect = topazfb_fillrect,
+	.fb_imageblit = topazfb_imageblit,
+	.fb_blank = topazfb_blank
+};
+
+static int topazfb_probe(struct hid_device *dev)
+{
+	struct fb_info *info;
+	struct topazfb_par *par;
+
+	info = framebuffer_alloc(sizeof(struct topazfb_par), NULL);
+
+	par = info->par;
+	par->hid = dev;
+
+	info->fbops = &topazfb_ops;
+	info->fix = topazfb_fix;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_IMAGEBLIT
+				     | FBINFO_HWACCEL_FILLRECT;
+
+	/* this is only a pseudo frame buffer device */
+	info->screen_base = NULL;
+	info->screen_size = 0;
+
+	/* LBK766 is 320x240; other models may differ */
+	info->var.xres = 320;
+	info->var.yres = 240;
+
+	info->var.bits_per_pixel = 1;
+	info->var.grayscale = 1;
+	info->var.red.offset = 0;
+	info->var.red.length = 1;
+	info->var.green.offset = 0;
+	info->var.green.length = 1;
+	info->var.blue.offset = 0;
+	info->var.blue.length = 1;
+	info->var.transp.offset = 0;
+	info->var.transp.length = 1;
+
+	if (register_framebuffer(info) < 0)
+		return -EINVAL;
+
+	return 0;
+
+}
+
+static int topaz_probe(struct hid_device *dev, const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(dev);
+	if (ret)
+		goto done;
+
+	ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
+	if (ret)
+		goto done;
+
+	ret = hid_hw_open(dev);
+	if (ret)
+		goto done;
+
+	ret = topaz_clear(dev);
+	if (ret)
+		goto done;
+
+	ret = topazfb_probe(dev);
+	if (ret)
+		goto done;
+done:
+	return ret;
+}
+
+static void topaz_remove(struct hid_device *dev)
+{
+	hid_hw_stop(dev);
+}
+
+static const struct hid_device_id topaz_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPAZ, USB_DEVICE_ID_TOPAZ_LBK766) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(hid, topaz_devices);
+
+static struct hid_driver topaz_driver = {
+	.name = "topaz",
+	.id_table = topaz_devices,
+	.probe = topaz_probe,
+	.remove = topaz_remove
+};
+
+module_hid_driver(topaz_driver);
+
+MODULE_AUTHOR("Alyssa Rosenzweig <alyssa@rosenzweig.io>");
+MODULE_DESCRIPTION("HID driver for Topaz signature pads");
+MODULE_LICENSE("GPL");
-- 
2.11.0

