Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217482;
	b=Evy/ay33WxfXbpD9QmnTfnkhXgLA3vdsjESzXc9tL0BTC9TNeYHQF+zVdbfpqt4LXJAb
	 3emrh87qNUYt4eLJXUkQwJIUreyP/+yYBjOc5Ukes0oieRyRrwJ/V00IIlFxSM4OQNq2n
	 KEDgVBT6obhkX3gczLzz7zTBmYgJF9H6VMAWhQkhWTbNnYcPSF7ChqciEbtwWR8cTLJ84
	 rtMc178PCowtVe/2eb+XjV2OjM0Xj0QZI7CTkOgMiA2IKx2ZHpghJ/OOBVBZWz3xJ+XmO
	 AgbC8toNt1ooU7UzC56J2PK86/cU33gnV1CshAWJ7qIyMPrgoQV4OR05juYpHtsnEig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=g8A+Y6zXIPiBIQxTC+YPHzUv8cnmYiYdG+K+y89iVwA=;
	b=i34K+yPcw2EqanSrJ1hBRNulk9wuugMiPnu4SDOqVPeaYafBQey/lMZfG1QBxKyOSeBX
	 4rXklKwFCuk4MkjzyYUVi4IcURzsZKdyAefE79YnG6xCSWyEhzA30jGg+ixiUCiasckYN
	 BxB0q/3an8q1dMoRe9SzRLCjo3LgSFt7Mo6pZ+Jko2CAfgCYIRWPZLfi2hq9PbP62LCqD
	 WNyQtQwAsvEczXDTA3unz2iAl/QXYaA6c2k3JFQSZLxRLdvcbcY/so+uVTyD1r+iKLBXC
	 lJkFXsWJVagRUvB+Uum5R7hGTZlrGPPPVHlfA9aFqhwbGeXpxHev0BxRHcRAydqxquQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f1JJginy;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF600606D805
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 09:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF600606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f1JJginy
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so985664a12.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 01:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217480; x=1794822280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8A+Y6zXIPiBIQxTC+YPHzUv8cnmYiYdG+K+y89iVwA=;
        b=f1JJginyIgFtdDthYnWhcZR4ycToyifTR0/MGopPtXmNZeKpzYOPSx4jQjb321Dott
         WCZJPIevSpGVIdRTHrrVQuop6SB7HjhN1pgv27d3g2cW4q2CGdiZ6MNevcaJ1QF/s7ra
         NcP5m57oPR97kjZKHw0jQtKZnEOwfYGYvdXikH2SGm1walDCKSHvb2+zq7oa9HOdHw/7
         58fjRTCAjx/H/P2qkd3qQCrO2WPsZQh47N1fOA70jiWSHgfRqvSwKthEp3m9o1NfV86o
         ZmDbVU9TxAAwbiSN5TYdShc33K+62VzRbWtknAYIJYVpG/NuN5HgknPYnxDMCdRsTXGq
         1a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217480; x=1794822280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8A+Y6zXIPiBIQxTC+YPHzUv8cnmYiYdG+K+y89iVwA=;
        b=Djf3B2r6xdjL4JK8MyHjK9KP3q+Ww4oEpqCc92zlxIG+6p6423pngFMyx9OhYXLpXe
         jG3BVI9UYnncadjvAEAWT+EswmeKpScHQx4+Av0GhPYqyEiolkFPpoYb1JvN21pWnD/d
         yIYDZYlh6J1Q8IIqtIW1kjV+2TsrA+FRsYmu2hhZBdDUf0o58eCIgqBS/rNETAlZqxCP
         tfUtOG4tWtbwghpbBRr5/uox42MDJ3Qc1iuWnkZ3cbyfwQbqLDAF86N7KjRnW+u/+Feb
         MiGPhjR2Z5L6ztuuZ9RHgcvT14McsA9slMqSMjB/yWScmJ3iaUMitnabSHAfPiqpMzNN
         7xuA==
X-Forwarded-Encrypted: i=1; AL+hErHU6DJYKwewL5z5UR3QY/HnGOa8h4axqZinTlZEL3f6nZkH2ihObssD+hH28n97867mbq3AGlR84A4rFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9uiPEQEMG4NfXkwYVXmgDlMsUhyv8AIoFcrORKAiyIfuhdJ79k
	uE8i3ZfSLtqkDz2vaIL2z8VYUAts1CxGlr2Rl6zwVdxq0cb2wMFo4p+Y
X-Gm-Gg: AYBFou0FOscNtt3LMdONIpEoM3+u9Gxb7AUXpar+z0MWMCMArbtn11YH4tKM0l7jDhI
	6Z9UrX2nAzh3IyejzfXKKe+gNO16oA8Z8BvAuDXBnZAva9edL3VsJnboyC6hnGtKLsfrsIkxiHi
	7uaP/mlqcWLbEAaHf8G+NGchTa+7rOXO/rVgJPsIlYNHE6n5r/2002dnXIf0A1wVRsuDCU1YXRQ
	s+Uu2Qwq6Y9oAuUW+G+ZrgDxOSi/DuoAksq4MF+YghGdbIJY+5B8JUUPKadA+QBIMgzTTTHfdCo
	InL9AKm78rzOPhcujg+S9vkHeWGy1X1sztw/BWnhMM83INMDa/Jq5qNPDdqV7tvb1uIU9cKytBO
	lVSTXGGym2VN2cVSKcUik1FglbmImvX1B3r9e/JZs3PFwR0/Sw3bN929Bi80eg6Ql9dLW2+/6Aa
	9gDyUvsRXSWSrVD4qOBTfJeBW26lgsxPRID0LF24qUJfbMm4HXhSySkshDEPlUBdqBfI8+ZbeDX
	P1gS3+NfqD62Y8CXIPx5LXcQETzCjvdvV6qcMA6DecaZuHSpJ5qZ2GNPjGc0gWk8sahETocwM7d
	fx+p2PSe1CqQzjDcl1h5pFHvNU4yiS/7tARBBj7tXmd/o/AoQ+FiQTIB
X-Received: by 2002:a17:907:3ea8:b0:c29:4b57:503e with SMTP id a640c23a62f3a-c4d6da00f7amr242929166b.1.1794217479893;
        Mon, 09 Nov 2026 01:44:39 -0800 (PST)
Received: from torstein-desktop.internal ([2a01:799:3a1:9700:6e3a:d704:53e2:f00e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c4d6a4753aasm137786866b.45.2026.11.09.01.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:44:39 -0800 (PST)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] HID: lg-g15: add LCD pixel-content framebuffer
Date: Mon,  9 Nov 2026 10:44:24 +0100
Message-ID: <20261109094426.1432465-3-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109094426.1432465-1-torsteine+linux@gmail.com>
References: <20261109094426.1432465-1-torsteine+linux@gmail.com>
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

Add a 160x43 1bpp fbdev framebuffer for the GamePanel LCD's pixel
content, behind the new HID_LOGITECH_G15_FB option.

Updates use fbdev deferred I/O: when userspace dirties the framebuffer
(mmap, write() or the drawing ops) the frame is packed into the LCD's
column-major wire format and sent as Output Report 3. The packed wire
buffer is a heap allocation, not a stack array, since the USB core
refuses to DMA-map stack memory. A set bit is a dark pixel, so the
visual is FB_VISUAL_MONO01.

The keyboard ignores output reports unless an URB is queued on the
input endpoint, so the HID device is kept open while the framebuffer
exists. The fb_info is released from fb_destroy, as it may outlive the
HID device while /dev/fbN is still open. The last frame is re-sent on
resume, since the LCD loses its content across a USB reset.

Tested on Logitech G15v2.

Based on libg15.c.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
Based-on-work-by: Philip Lawatsch <philip@lawatsch.at>
Based-on-work-by: Alex Ibrado <alex@ibrado.org>
Based-on-work-by: Anthony J. Mirabella <mirabeaj@gmail.com>
Based-on-work-by: Mike Lampard <mlampard@users.sourceforge.net>
Assisted-by: Claude:claude-opus-5-5
---
 drivers/hid/Kconfig      |  13 ++
 drivers/hid/hid-lg-g15.c | 303 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 316 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..57305180818a 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -674,6 +674,19 @@ config HID_LOGITECH
 	help
 	Support for Logitech devices that are not fully compliant with HID standard.
 
+config HID_LOGITECH_G15_FB
+	bool "Logitech G15 LCD framebuffer support"
+	depends on HID_LOGITECH
+	depends on HID_LOGITECH=FB || FB=y
+	select FB_SYSMEM_HELPERS_DEFERRED
+	help
+	  Provide access to the 160x43 monochrome GamePanel LCD of the
+	  Logitech G15 and G15 v2 keyboards via a framebuffer device.
+
+	  The LCD is updated with deferred I/O whenever the framebuffer
+	  contents change. Say Y here if you want to draw on the LCD from
+	  userspace or bind a framebuffer console to it.
+
 config HID_LOGITECH_DJ
 	tristate "Logitech receivers full support"
 	depends on USB_HID
diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 50abe6c58b10..35d183787383 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/fb.h>
 #include <linux/hid.h>
 #include <linux/leds.h>
 #include <linux/led-class-multicolor.h>
@@ -13,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/usb.h>
+#include <linux/vmalloc.h>
 #include <linux/wait.h>
 #include <dt-bindings/leds/common.h>
 
@@ -22,6 +24,22 @@
 
 #define LG_G15_FEATURE_REPORT		0x02
 
+/*
+ * LCD pixel content, G15/G15 v2 GamePanel LCD only. Not a Feature Report:
+ * a numbered Output Report sent over the interrupt-OUT endpoint. The wire
+ * buffer has a fixed 32-byte header before the packed pixel data starts,
+ * and the packer's last (partial) row-group reads up to 132 bytes past
+ * the logical WIDTH/8*HEIGHT frame size, so the backing allocation must
+ * be padded to LG_G15_LCD_WIRE_SIZE, not just the logical frame size.
+ */
+#define LG_G15_LCD_OUTPUT_REPORT	0x03
+#define LG_G15_LCD_WIDTH		160
+#define LG_G15_LCD_HEIGHT		43
+#define LG_G15_LCD_ROW_BYTES		(LG_G15_LCD_WIDTH / 8)
+#define LG_G15_LCD_FB_SIZE		(LG_G15_LCD_ROW_BYTES * LG_G15_LCD_HEIGHT)
+#define LG_G15_LCD_WIRE_OFFSET		32
+#define LG_G15_LCD_WIRE_SIZE		0x03e0
+
 #define LG_G510_FEATURE_M_KEYS_LEDS	0x04
 #define LG_G510_FEATURE_BACKLIGHT_RGB	0x05
 #define LG_G510_FEATURE_POWER_ON_RGB	0x06
@@ -88,6 +106,17 @@ struct lg_g15_led {
 	u8 red, green, blue;
 };
 
+struct lg_g15_fbdev {
+	struct fb_info *info;	/* NULL when no framebuffer is registered */
+	/*
+	 * Packed wire-format buffer, heap-allocated (not a local/stack
+	 * array): it gets DMA-mapped by hid_hw_output_report()/usbhid, and
+	 * the USB core refuses to map stack memory (returns -EAGAIN, see
+	 * object_is_on_stack() in drivers/usb/core/hcd.c).
+	 */
+	u8 *wire;
+};
+
 struct lg_g15_data {
 	/* Must be first for proper dma alignment */
 	u8 transfer_buf[LG_G15_TRANSFER_BUF_SIZE];
@@ -99,6 +128,7 @@ struct lg_g15_data {
 	struct hid_device *hdev;
 	enum lg_g15_model model;
 	struct lg_g15_led leds[LG_G15_LED_ARRAY_SIZE];
+	struct lg_g15_fbdev fbdev; /* G15/G15 v2 GamePanel LCD only */
 	bool game_mode_enabled;
 	bool backlight_disabled;	/* true == HW backlight toggled *OFF* */
 	bool lcd_contrast_set;		/* LCD contrast written at least once */
@@ -1051,6 +1081,270 @@ static void lg_g15_setup_led_rgb(struct lg_g15_data *g15, int index)
 	gled->mcdev.subled_info = subled_info;
 }
 
+/********* G15 LCD framebuffer *********/
+
+#ifdef CONFIG_HID_LOGITECH_G15_FB
+
+/*
+ * fb_info private data. The fb_info can outlive the HID device (e.g. when
+ * /dev/fbN is still open on unplug), so the link back to the device is
+ * cleared in lg_g15_unregister_fb() and the fb_info itself is only freed
+ * from fb_destroy once its last user is gone.
+ */
+struct lg_g15_fb_par {
+	struct fb_deferred_io defio;
+	/* Protects g15 and serializes frame updates */
+	struct mutex lock;
+	/* NULL once the HID device is gone */
+	struct lg_g15_data *g15;
+	/* At least one frame was sent successfully */
+	bool sent;
+};
+
+static const struct fb_fix_screeninfo lg_g15_fb_fix = {
+	.id		= "G15 LCD",
+	.type		= FB_TYPE_PACKED_PIXELS,
+	/* A set bit is a dark pixel */
+	.visual		= FB_VISUAL_MONO01,
+	.xpanstep	= 0,
+	.ypanstep	= 0,
+	.ywrapstep	= 0,
+	.line_length	= LG_G15_LCD_ROW_BYTES,
+	.smem_len	= LG_G15_LCD_FB_SIZE,
+	.accel		= FB_ACCEL_NONE,
+};
+
+static const struct fb_var_screeninfo lg_g15_fb_var = {
+	.xres		= LG_G15_LCD_WIDTH,
+	.yres		= LG_G15_LCD_HEIGHT,
+	.xres_virtual	= LG_G15_LCD_WIDTH,
+	.yres_virtual	= LG_G15_LCD_HEIGHT,
+	.bits_per_pixel	= 1,
+	.red		= { 0, 1, 0 },
+	.green		= { 0, 1, 0 },
+	.blue		= { 0, 1, 0 },
+	.vmode		= FB_VMODE_NONINTERLACED,
+};
+
+/*
+ * Packs pixels column-major (8 vertically-stacked source rows per
+ * destination byte), not the row-major layout the linear fb buffer holds.
+ *
+ * fb is LG_G15_LCD_WIRE_SIZE bytes (padded, not just LG_G15_LCD_FB_SIZE) -
+ * the last of the six 8-row groups only has 3 real pixel-rows (43 isn't a
+ * multiple of 8), and this reads past the logical frame into that padding
+ * for the other 5.
+ */
+static void lg_g15_fb_pack(u8 *wire, const u8 *fb)
+{
+	unsigned int output_offset = LG_G15_LCD_WIRE_OFFSET;
+	unsigned int base_offset = 0;
+	unsigned int row, col;
+	unsigned int height_in_bytes = DIV_ROUND_UP(LG_G15_LCD_HEIGHT, 8);
+
+	for (row = 0; row < height_in_bytes; row++) {
+		for (col = 0; col < LG_G15_LCD_WIDTH; col++) {
+			unsigned int bit = col % 8;
+			unsigned int sub;
+			u8 packed = 0;
+
+			for (sub = 0; sub < 8; sub++) {
+				unsigned int pixel_offset =
+					base_offset + sub * LG_G15_LCD_ROW_BYTES;
+
+				packed |= ((fb[pixel_offset] << bit) & 0x80) >> (7 - sub);
+			}
+
+			wire[output_offset] = packed;
+			output_offset++;
+			if (bit == 7)
+				base_offset++;
+		}
+		base_offset += LG_G15_LCD_WIDTH - LG_G15_LCD_ROW_BYTES;
+	}
+}
+
+/*
+ * Deferred IO callback, runs when userspace dirtied the framebuffer (through
+ * mmap, write() or the drawing ops). Writes made while a frame is being sent
+ * re-arm the deferred work, so no update is lost.
+ */
+static void lg_g15_fb_deferred_io(struct fb_info *info, struct list_head *pagereflist)
+{
+	struct lg_g15_fb_par *par = info->par;
+	struct lg_g15_data *g15;
+	u8 *wire;
+	int ret;
+
+	mutex_lock(&par->lock);
+
+	g15 = par->g15;
+	if (!g15)
+		goto out;
+
+	wire = g15->fbdev.wire;
+	memset(wire, 0, LG_G15_LCD_WIRE_OFFSET);
+	lg_g15_fb_pack(wire, (const u8 *)info->screen_buffer);
+	wire[0] = LG_G15_LCD_OUTPUT_REPORT;
+
+	ret = hid_hw_output_report(g15->hdev, wire, LG_G15_LCD_WIRE_SIZE);
+	if (ret < 0)
+		hid_err_ratelimited(g15->hdev, "Error writing LCD framebuffer: %d\n", ret);
+	else
+		par->sent = true;
+
+out:
+	mutex_unlock(&par->lock);
+}
+
+static void lg_g15_fb_damage_range(struct fb_info *info, off_t off, size_t len)
+{
+	schedule_delayed_work(&info->deferred_work, info->fbdefio->delay);
+}
+
+static void lg_g15_fb_damage_area(struct fb_info *info, u32 x, u32 y,
+				  u32 width, u32 height)
+{
+	schedule_delayed_work(&info->deferred_work, info->fbdefio->delay);
+}
+
+FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(lg_g15_fb,
+				   lg_g15_fb_damage_range,
+				   lg_g15_fb_damage_area)
+
+static int lg_g15_fb_blank(int blank, struct fb_info *info)
+{
+	return 0;
+}
+
+static void lg_g15_fb_destroy(struct fb_info *info)
+{
+	struct lg_g15_fb_par *par = info->par;
+
+	fb_deferred_io_cleanup(info);
+	mutex_destroy(&par->lock);
+	vfree(info->screen_buffer);
+	framebuffer_release(info);
+}
+
+static const struct fb_ops lg_g15_fb_ops = {
+	.owner		= THIS_MODULE,
+	FB_DEFAULT_DEFERRED_OPS(lg_g15_fb),
+	.fb_destroy	= lg_g15_fb_destroy,
+	.fb_blank	= lg_g15_fb_blank,
+};
+
+static int lg_g15_register_fb(struct lg_g15_data *g15)
+{
+	struct lg_g15_fbdev *fbdev = &g15->fbdev;
+	struct lg_g15_fb_par *par;
+	struct fb_info *info;
+	void *buffer;
+	int ret;
+
+	fbdev->wire = devm_kzalloc(&g15->hdev->dev, LG_G15_LCD_WIRE_SIZE, GFP_KERNEL);
+	if (!fbdev->wire)
+		return -ENOMEM;
+
+	/* Padded to LG_G15_LCD_WIRE_SIZE - see the comment by that macro. */
+	buffer = vzalloc(LG_G15_LCD_WIRE_SIZE);
+	if (!buffer)
+		return -ENOMEM;
+
+	info = framebuffer_alloc(sizeof(*par), &g15->hdev->dev);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err_free_buffer;
+	}
+
+	par = info->par;
+	mutex_init(&par->lock);
+	par->g15 = g15;
+	par->defio.delay = HZ / 10;
+	par->defio.deferred_io = lg_g15_fb_deferred_io;
+
+	info->fbdefio = &par->defio;
+	info->fbops = &lg_g15_fb_ops;
+	info->flags |= FBINFO_VIRTFB;
+	info->screen_buffer = buffer;
+	info->screen_size = LG_G15_LCD_FB_SIZE;
+	info->fix = lg_g15_fb_fix;
+	info->var = lg_g15_fb_var;
+
+	ret = fb_deferred_io_init(info);
+	if (ret)
+		goto err_release_info;
+
+	/*
+	 * As with the G-keys settings report in probe, the keyboard ignores
+	 * output reports unless an URB is queued on the input endpoint, so
+	 * keep the device open for as long as the framebuffer exists.
+	 */
+	ret = hid_hw_open(g15->hdev);
+	if (ret)
+		goto err_defio_cleanup;
+
+	ret = register_framebuffer(info);
+	if (ret)
+		goto err_hw_close;
+
+	fbdev->info = info;
+	return 0;
+
+err_hw_close:
+	hid_hw_close(g15->hdev);
+err_defio_cleanup:
+	fb_deferred_io_cleanup(info);
+err_release_info:
+	mutex_destroy(&par->lock);
+	framebuffer_release(info);
+err_free_buffer:
+	vfree(buffer);
+	return ret;
+}
+
+static void lg_g15_unregister_fb(struct lg_g15_data *g15)
+{
+	struct fb_info *info = g15->fbdev.info;
+	struct lg_g15_fb_par *par;
+
+	if (!info)
+		return;
+
+	/* Waits for a running update; later ones see par->g15 == NULL */
+	par = info->par;
+	mutex_lock(&par->lock);
+	par->g15 = NULL;
+	mutex_unlock(&par->lock);
+
+	g15->fbdev.info = NULL;
+	/* The fb_info is freed by lg_g15_fb_destroy() once its last user is gone */
+	unregister_framebuffer(info);
+	hid_hw_close(g15->hdev);
+}
+
+/* The LCD loses its pixel content across a USB reset or power loss */
+static void lg_g15_fb_redraw(struct lg_g15_data *g15)
+{
+	struct fb_info *info = g15->fbdev.info;
+	struct lg_g15_fb_par *par;
+
+	if (!info)
+		return;
+
+	par = info->par;
+	if (par->sent)
+		schedule_delayed_work(&info->deferred_work, 0);
+}
+
+#else /* CONFIG_HID_LOGITECH_G15_FB */
+
+static inline int lg_g15_register_fb(struct lg_g15_data *g15) { return 0; }
+static inline void lg_g15_unregister_fb(struct lg_g15_data *g15) { }
+static inline void lg_g15_fb_redraw(struct lg_g15_data *g15) { }
+
+#endif /* CONFIG_HID_LOGITECH_G15_FB */
+
 static int lg_g15_register_led(struct lg_g15_data *g15, int i, const char *name)
 {
 	int ret;
@@ -1407,6 +1701,10 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		ret = lg_g15_register_led(g15, LG_G15_LCD_CONTRAST, "g15::lcd_contrast");
 		if (ret)
 			goto error_hw_stop;
+
+		ret = lg_g15_register_fb(g15);
+		if (ret)
+			goto error_hw_stop;
 	}
 
 	return 0;
@@ -1462,6 +1760,9 @@ static void lg_g15_remove(struct hid_device *hdev)
 	if (g15 && g15->work.func)
 		cancel_work_sync(&g15->work);
 
+	if (g15)
+		lg_g15_unregister_fb(g15);
+
 	hid_hw_stop(hdev);
 }
 
@@ -1481,6 +1782,8 @@ static int lg_g15_resume(struct hid_device *hdev)
 	if (contrast->cdev.dev && g15->lcd_contrast_set)
 		lg_g15_contrast_set(&contrast->cdev, contrast->brightness);
 
+	lg_g15_fb_redraw(g15);
+
 	return 0;
 }
 
-- 
2.53.0

