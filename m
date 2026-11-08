Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794159578;
	b=LGfIu1CVA6LQCbXr8nxl8eNKaxkRxwngEBOWGe1XEOeJ06M47gdbtbvdBYRfDXObGa5+
	 dmF49VnE4g2qoUFNxoOMcBeL+FehvUw7tEbR6wQcmdNtGRqMqDm2g6KW8FXeNYu+hRBSe
	 OsWaVQv004JmYoXQ0s9CtvTHVS9yvDBZ1ntyx7enUZ1UpAcw3R14isYfmee90Cvd3GYVa
	 ESfHXQ6sOzNGTvYatScmUMpGyzdnYkrmjUccatQw+AlwkH5YGs17+0fk38/NkRlXjB4Jh
	 lt/rBCiWVjJd4+n/H0uNin+NERWurR9xXPUewpEEPEkyUUR/pW/LqoZGLte7tOON2sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794159578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FWLNFxQvZrw9A+I66cYEqbTs7osHQCjzFuAurBrSmg8=;
	b=znuEGrSPeDBkoEk78DILvugH4QmyAnIwl1dsR/+L75FqH07tTN6atgz97NH/TTrMWs0Q
	 96ELHXfQYzJjkC3D2uRlqFaBPclYgBXKZcRtzuRRo2u9hupuTNdyRqg4BesmyEVDAS11W
	 ng5U1JRfPHiQykh1D97Egy7H2mhs42xSDVCVKfcRPIzcDO2U1rdf3eVyslfUuujIfby2m
	 1XHZ3ZBCQ/mP+BfM193u/Y6xRmR//Jj3uuYuV08Rb8cS7bVaN3fXvGYc/DPoYBzf12SGR
	 Wmm7YkAmOqImfYVfBK7R0frIZ+8VEtuq8OIQnc65aeYT9DDY/shkvjg4/6j1VEQ6O+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=jYBypFjD;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F27606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 17:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F27606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=jYBypFjD
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso995205e9.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 09:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794159576; x=1794764376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FWLNFxQvZrw9A+I66cYEqbTs7osHQCjzFuAurBrSmg8=;
        b=jYBypFjDuGhJUDmAOKurjX9ZDjxq1+PnwS5hqnef1qVDTHhbtGS3mE/SHnu/E+K0Fk
         8ypv5n/pqCNRr+MVx5c6OS8hRAwwcWCxG8q1JW9tDcsQRkdpKSAKhfxYZJamnuoarrPa
         DC3ZoRkCM4ceP6f9u20MyZnx0FiThg92o6mPOun42rNtetsfQ4F+BZruQuf4X2g2VRHO
         3dsZzX6vAsU5iWWv9sgOQhCE7AjVfwA9w7dvJJpw79bQkC6/DT4rdJrpRGXHTzg47BGV
         wmgjNA8Nxs/6ZhCQB24bnYgWflVljg0G0k3p+Nwdjmk2l8vVwSz/wlBGruvO5IZAi/Ce
         Or5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794159576; x=1794764376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWLNFxQvZrw9A+I66cYEqbTs7osHQCjzFuAurBrSmg8=;
        b=BozCfEU7Me8j592L1i7vbeXDbuBrPZgDYDzsODsE4HlMi3Tprr0fAs9CXhkOyMXpyO
         GRaC9CQYwvYsHztNnhU7KpnW8nFTeQxHPpM5cS4pMGC8EYQdDtNH1VhkkHbPr5PYfFHA
         /VCfuOuA+DDMxFFvQFJwlj26oMNq/xoN3YZ96oshH27nzTAHaEMujtNaisDOZYrjcQpA
         0uDEnCpY0cQSlOTWhqtKPcTtqfKNDNw6zPRXrTFzCJwKRHlAfMgmyvigSAFpLZyXwumM
         vUiq49CbO4GjiIYFNVppSQ5iZGpRxmrO6WLeGxj20VseGpfERmwF0lXxGqQBMyJW9M4u
         NTiQ==
X-Forwarded-Encrypted: i=1; AL+hErFBiJthn1SquEdx1wm2gtC/K4jF1FHI7QX+iW+UkMHElzLjyjBAvojs4csYnIeRLQYHLtS3d1J2AVxJvQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8k/mTh+AwIliyL/vSTo1ulQbVTuob8X4Knapyc4lmrueryLDu3
	La5y7I11bpTSXGj3MJg44+Sw9Yd01du3zj0S1HjTg0E3Z261cTAc8Pny
X-Gm-Gg: AYBFou1A1sGtuRrPyMN6zemlohTclF8I3vSfVlN5PqLnP0IjuopXuSOLTiAC7vGnf9h
	oaSC5Q1AKe/1J7o3TIiY0RL1rRUMGenkRUgZuF1OaQh3K6ak1oiOdnKSogzFlXzTHeGvVxHJayk
	aO3iP2F2fJJjaZlr8pmFc2RKpDy7Os/+gwFimsCdQHDKFZEo4QUEpaLsM+im5x/kCsL0vZyO/0x
	5kFD03LbD98vOO+1M1p3dyTaUUwljB3WcrZ80O3/rhf35FjL7q9OQni9Jz0aTPUls50E5EbZtVt
	HUm2a7JgeBGxvUpVosaI/NpDZy/Lfmg/IW+a2AueYgeHBSGBDPxbnHqbHAK1Z+hg2TjyWmWc1z+
	B11WH3sFwx0sa6bUUgTJIQ09mtrJht7Fw6b5ZrBDc7PG7bh+QivBMzlLACWTccBeAGbAfSXS3kl
	ATQMdAqU3xGJiDIw9noknUzrK3t/y2GqXjLYGhwt4IJC5EHMdpLotuZz0+lAxDA/k6L1INfxyRh
	Wy0MX+yaJ57LLY+sIL3ImA7PThAEg61CfT5IPHq6ma3UB5cFS170TLsU2cyFdXvxGSq+ZHA1mXW
	mcO4Ckxums9Hs/rtlCfxjF8RpprwTYhTLVT0ENH+LvtJ9VEltAdSpu+rCZUGLrPZ7EyxD77dOrK
	Ci+vqHAUfBKCq1nrjSBcuXMNIxZyxocyMdg==
X-Received: by 2002:a05:600c:c166:b0:4a2:fe11:9a8a with SMTP id 5b1f17b1804b1-4b943f77038mr38226945e9.0.1794159576381;
        Sun, 08 Nov 2026 09:39:36 -0800 (PST)
Received: from rechenknecht2k24.fritz.box ([2001:9e8:1433:f800:e5a8:f920:676f:e82b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb0b0c2sm148511625e9.8.2026.11.08.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 09:39:36 -0800 (PST)
From: Benjamin Valentin <benpicco@googlemail.com>
To: hansg@kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	Benjamin Valentin <benpicco@googlemail.com>
Subject: [PATCH] HID: lg-g15: Add G15 LCD framebuffer support
Date: Sun,  8 Nov 2026 18:39:20 +0100
Message-ID: <20261108173920.424072-1-benpicco@googlemail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the LCD display on the G15 and G15 v2 to the driver.
Those keyboards have a 160x43 monochrome display, hid-lg-g15 already
binds the device.

All protocol knowledge was lifted from g15daemon, a userspace utility
written for this keyboard long time ago. [0]

To test it I had Copliot port the g15stats util to use a framebuffer
device instead of directly talking to the USB device [1] and also
ran samples/auxdisplay.

[0] https://sourceforge.net/projects/g15daemon/
[1] https://github.com/benpicco/g15stats-auxdisplay

Assisted-by: Copilot with GPT-6.1 Terra
Signed-off-by: Benjamin Valentin <benpicco@googlemail.com>
---
 drivers/hid/Kconfig      |  12 ++
 drivers/hid/hid-lg-g15.c | 319 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 329 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..d7a7e2708308 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -674,6 +674,18 @@ config HID_LOGITECH
 	help
 	Support for Logitech devices that are not fully compliant with HID standard.
 
+config HID_LOGITECH_G15_LCD
+	bool "Framebuffer support for Logitech G15 LCD" if EXPERT
+	default !EXPERT
+	depends on HID_LOGITECH
+	depends on HID_LOGITECH=FB || FB=y
+	select FB_SYSMEM_HELPERS_DEFERRED
+	help
+	  Say Y here to expose the 160x43 monochrome LCD on Logitech G15
+	  keyboards through a framebuffer device. This supports the original
+	  G15 and G15 v2 models. The display updates when its framebuffer
+	  changes. If unsure, say Y.
+
 config HID_LOGITECH_DJ
 	tristate "Logitech receivers full support"
 	depends on USB_HID
diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 02ef3e2094b4..ca1f3280c05a 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -5,15 +5,25 @@
  *  Copyright (c) 2019 Hans de Goede <hdegoede@redhat.com>
  */
 
+#include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/fb.h>
 #include <linux/hid.h>
+#include <linux/jiffies.h>
 #include <linux/leds.h>
 #include <linux/led-class-multicolor.h>
+#include <linux/math.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/usb.h>
+#include <linux/vmalloc.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 #include <dt-bindings/leds/common.h>
 
 #include "hid-ids.h"
@@ -79,6 +89,19 @@ struct lg_g15_led {
 	u8 red, green, blue;
 };
 
+#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
+struct lg_g15_fb {
+	struct usb_device *usb;
+	struct fb_info *info;
+	struct fb_deferred_io defio;
+	struct mutex lock; /* Serializes USB I/O and disconnect. */
+	u8 *report;
+	unsigned int pipe;
+	bool disconnected;
+	bool suspended;
+};
+#endif
+
 struct lg_g15_data {
 	/* Must be first for proper dma alignment */
 	u8 transfer_buf[LG_G15_TRANSFER_BUF_SIZE];
@@ -88,12 +111,285 @@ struct lg_g15_data {
 	struct input_dev *input;
 	struct input_dev *input_js; /* Separate joystick device for G13. */
 	struct hid_device *hdev;
+#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
+	struct lg_g15_fb *fb;
+#endif
 	enum lg_g15_model model;
 	struct lg_g15_led leds[LG_G15_LED_MAX];
 	bool game_mode_enabled;
 	bool backlight_disabled;	/* true == HW backlight toggled *OFF* */
 };
 
+#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
+#define LG_G15_LCD_WIDTH		160
+#define LG_G15_LCD_HEIGHT		43
+#define LG_G15_LCD_STRIDE		(LG_G15_LCD_WIDTH / 8)
+#define LG_G15_LCD_FB_SIZE		(LG_G15_LCD_STRIDE * LG_G15_LCD_HEIGHT)
+#define LG_G15_LCD_HEADER_SIZE		32
+#define LG_G15_LCD_PAGES		DIV_ROUND_UP(LG_G15_LCD_HEIGHT, 8)
+#define LG_G15_LCD_REPORT_SIZE		(LG_G15_LCD_HEADER_SIZE + \
+					 LG_G15_LCD_WIDTH * LG_G15_LCD_PAGES)
+#define LG_G15_LCD_REFRESH_DELAY	msecs_to_jiffies(50)
+#define LG_G15_LCD_USB_TIMEOUT		1000
+
+static void lg_g15_pack_report(u8 *report, const u8 *pixels)
+{
+	unsigned int page, x, bit, y;
+	u8 value, mask;
+
+	memset(report, 0, LG_G15_LCD_HEADER_SIZE);
+	report[0] = 0x03;
+	report += LG_G15_LCD_HEADER_SIZE;
+
+	/*
+	 * The LCD consumes vertical, LSB-at-the-top groups of eight pixels.
+	 * Its pixel polarity is opposite to FB_VISUAL_MONO10.
+	 */
+	for (page = 0; page < LG_G15_LCD_PAGES; page++) {
+		for (x = 0; x < LG_G15_LCD_WIDTH; x++) {
+			mask = BIT(7 - x % 8);
+			value = 0;
+			for (bit = 0; bit < 8; bit++) {
+				y = page * 8 + bit;
+				if (y >= LG_G15_LCD_HEIGHT)
+					break;
+				if (!(pixels[y * LG_G15_LCD_STRIDE + x / 8] & mask))
+					value |= BIT(bit);
+			}
+			*report++ = value;
+		}
+	}
+}
+
+static void lg_g15_fb_deferred_io(struct fb_info *info,
+				  struct list_head *pagelist)
+{
+	struct lg_g15_fb *fb = info->par;
+	int actual, ret;
+
+	mutex_lock(&fb->lock);
+
+	if (fb->disconnected || fb->suspended)
+		goto out;
+
+	lg_g15_pack_report(fb->report, fb->info->screen_buffer);
+
+	ret = usb_interrupt_msg(fb->usb, fb->pipe, fb->report,
+				LG_G15_LCD_REPORT_SIZE, &actual,
+				LG_G15_LCD_USB_TIMEOUT);
+
+	if (!ret && actual != LG_G15_LCD_REPORT_SIZE)
+		ret = -EIO;
+	if (ret)
+		dev_err_ratelimited(&fb->usb->dev,
+				    "LCD update failed: %d\n", ret);
+out:
+	mutex_unlock(&fb->lock);
+}
+
+static void lg_g15_fb_damage(struct fb_info *info, off_t offset, size_t len)
+{
+	schedule_delayed_work(&info->deferred_work, LG_G15_LCD_REFRESH_DELAY);
+}
+
+static void lg_g15_fb_damage_area(struct fb_info *info, u32 x, u32 y,
+				  u32 width, u32 height)
+{
+	schedule_delayed_work(&info->deferred_work, LG_G15_LCD_REFRESH_DELAY);
+}
+
+FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(lg_g15_fb,
+				   lg_g15_fb_damage,
+				   lg_g15_fb_damage_area)
+
+static int lg_g15_fb_open(struct fb_info *info, int user)
+{
+	struct lg_g15_fb *fb = info->par;
+	int ret;
+
+	mutex_lock(&fb->lock);
+	ret = fb->disconnected ? -ENODEV : 0;
+	mutex_unlock(&fb->lock);
+	return ret;
+}
+
+static int lg_g15_fb_check_var(struct fb_var_screeninfo *var,
+			       struct fb_info *info)
+{
+	if (var->xres != LG_G15_LCD_WIDTH ||
+	    var->yres != LG_G15_LCD_HEIGHT ||
+	    var->xres_virtual != LG_G15_LCD_WIDTH ||
+	    var->yres_virtual != LG_G15_LCD_HEIGHT ||
+	    var->bits_per_pixel != 1 || var->xoffset || var->yoffset ||
+	    var->nonstd || var->rotate)
+		return -EINVAL;
+
+	*var = info->var;
+	return 0;
+}
+
+static void lg_g15_fb_destroy(struct fb_info *info)
+{
+	struct lg_g15_fb *fb = info->par;
+
+	fb_deferred_io_cleanup(info);
+	vfree(info->screen_buffer);
+	kfree(fb->report);
+	usb_put_dev(fb->usb);
+	framebuffer_release(info);
+}
+
+static const struct fb_ops lg_g15_fb_ops = {
+	.owner = THIS_MODULE,
+	.fb_open = lg_g15_fb_open,
+	.fb_check_var = lg_g15_fb_check_var,
+	.fb_destroy = lg_g15_fb_destroy,
+	FB_DEFAULT_DEFERRED_OPS(lg_g15_fb),
+};
+
+static const struct fb_fix_screeninfo lg_g15_fb_fix = {
+	.id = "g15",
+	.type = FB_TYPE_PACKED_PIXELS,
+	.visual = FB_VISUAL_MONO10,
+	.line_length = LG_G15_LCD_STRIDE,
+	.smem_len = LG_G15_LCD_FB_SIZE,
+	.accel = FB_ACCEL_NONE,
+};
+
+static const struct fb_var_screeninfo lg_g15_fb_var = {
+	.xres = LG_G15_LCD_WIDTH,
+	.yres = LG_G15_LCD_HEIGHT,
+	.xres_virtual = LG_G15_LCD_WIDTH,
+	.yres_virtual = LG_G15_LCD_HEIGHT,
+	.bits_per_pixel = 1,
+	.red = {
+		.length = 1,
+	},
+	.green = {
+		.length = 1,
+	},
+	.blue = {
+		.length = 1,
+	},
+	.width = 90,
+	.height = 23,
+};
+
+static int lg_g15_fb_init(struct hid_device *hdev, struct lg_g15_data *g15)
+{
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_host_interface *alt = intf->cur_altsetting;
+	struct usb_endpoint_descriptor *out;
+	struct fb_info *info;
+	struct lg_g15_fb *fb;
+	int ret;
+
+	ret = usb_find_int_out_endpoint(alt, &out);
+	if (ret)
+		return ret;
+
+	info = framebuffer_alloc(sizeof(*fb), &hdev->dev);
+	if (!info)
+		return -ENOMEM;
+	fb = info->par;
+	fb->info = info;
+	fb->usb = usb_get_dev(interface_to_usbdev(intf));
+	fb->pipe = usb_sndintpipe(fb->usb, out->bEndpointAddress);
+	mutex_init(&fb->lock);
+
+	fb->report = kmalloc(LG_G15_LCD_REPORT_SIZE, GFP_KERNEL);
+	if (!fb->report) {
+		ret = -ENOMEM;
+		goto err_usb;
+	}
+	info->screen_buffer = vzalloc(PAGE_ALIGN(LG_G15_LCD_FB_SIZE));
+	if (!info->screen_buffer) {
+		ret = -ENOMEM;
+		goto err_report;
+	}
+
+	info->fbops = &lg_g15_fb_ops;
+	info->fix = lg_g15_fb_fix;
+	info->var = lg_g15_fb_var;
+	info->flags = FBINFO_VIRTFB;
+	info->screen_size = LG_G15_LCD_FB_SIZE;
+	fb->defio.delay = LG_G15_LCD_REFRESH_DELAY;
+	fb->defio.deferred_io = lg_g15_fb_deferred_io;
+	info->fbdefio = &fb->defio;
+	ret = fb_deferred_io_init(info);
+	if (ret)
+		goto err_buffer;
+
+	ret = register_framebuffer(info);
+	if (ret)
+		goto err_defio;
+
+	g15->fb = fb;
+	hid_info(hdev, "fb%d: G15 LCD, %dx%d monochrome\n",
+		 info->node, LG_G15_LCD_WIDTH, LG_G15_LCD_HEIGHT);
+	return 0;
+
+err_defio:
+	fb_deferred_io_cleanup(info);
+err_buffer:
+	vfree(info->screen_buffer);
+err_report:
+	kfree(fb->report);
+err_usb:
+	usb_put_dev(fb->usb);
+	framebuffer_release(info);
+	return ret;
+}
+
+static void lg_g15_fb_remove(struct lg_g15_data *g15)
+{
+	struct lg_g15_fb *fb = g15->fb;
+	struct fb_info *info;
+
+	if (!fb)
+		return;
+
+	info = fb->info;
+	mutex_lock(&fb->lock);
+	fb->disconnected = true;
+	mutex_unlock(&fb->lock);
+	flush_delayed_work(&info->deferred_work);
+	unregister_framebuffer(info);
+}
+
+static int lg_g15_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+	struct lg_g15_fb *fb;
+
+	if (!g15 || !g15->fb)
+		return 0;
+
+	fb = g15->fb;
+	mutex_lock(&fb->lock);
+	fb->suspended = true;
+	mutex_unlock(&fb->lock);
+	flush_delayed_work(&fb->info->deferred_work);
+	return 0;
+}
+
+static int lg_g15_resume(struct hid_device *hdev)
+{
+	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+	struct lg_g15_fb *fb;
+
+	if (!g15 || !g15->fb)
+		return 0;
+
+	fb = g15->fb;
+	mutex_lock(&fb->lock);
+	fb->suspended = false;
+	mutex_unlock(&fb->lock);
+	schedule_delayed_work(&fb->info->deferred_work, 0);
+	return 0;
+}
+#endif
+
 /********* G13 LED functions ***********/
 /*
  * G13 retains no state across power cycles, and always powers up with the backlight on,
@@ -1333,6 +1629,15 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			goto error_hw_stop;
 	}
 
+#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
+	if (hdev->product == USB_DEVICE_ID_LOGITECH_G15_LCD ||
+	    hdev->product == USB_DEVICE_ID_LOGITECH_G15_V2_LCD) {
+		ret = lg_g15_fb_init(hdev, g15);
+		if (ret)
+			hid_err(hdev, "Failed to initialize LCD framebuffer: %d\n", ret);
+	}
+#endif
+
 	return 0;
 
 error_hw_stop:
@@ -1377,15 +1682,20 @@ MODULE_DEVICE_TABLE(hid, lg_g15_devices);
 static void lg_g15_remove(struct hid_device *hdev)
 {
 	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+	if (!g15)
+		goto out;
 
+#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
+	lg_g15_fb_remove(g15);
+#endif
 	/*
 	 * g15->work is only initialized for the models that schedule it
 	 * (G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so only
 	 * cancel it when it was set up.
 	 */
-	if (g15 && g15->work.func)
+	if (g15->work.func)
 		cancel_work_sync(&g15->work);
-
+out:
 	hid_hw_stop(hdev);
 }
 
@@ -1395,6 +1705,11 @@ static struct hid_driver lg_g15_driver = {
 	.raw_event		= lg_g15_raw_event,
 	.probe			= lg_g15_probe,
 	.remove			= lg_g15_remove,
+#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
+	.suspend		= pm_ptr(lg_g15_suspend),
+	.resume			= pm_ptr(lg_g15_resume),
+	.reset_resume		= pm_ptr(lg_g15_resume),
+#endif
 };
 module_hid_driver(lg_g15_driver);
 
-- 
2.55.0

