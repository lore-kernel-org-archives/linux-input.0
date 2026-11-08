Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136087;
	b=wtIl6fNNw9FeVz463F5pr8L5AiRzhruqWvbDDp9Gyr9um6+UQQIuON3UsuUG6s4Pl50S
	 51mXDSIOJkFoSgWLONVt9lcx0EseozOAuKNDHz4t1oeEm2yAZ1wtTK7kGFjmWmWxCe8uR
	 EeH5UzryLV93oPrc+dtyMMTbyP+5vZ2j8an2pvRnvn9CKI5KFW3YWdUWLTDSG179Z/+DB
	 1eLspohIAFJtatDhEN7ZWnXfWCno/zvbEOB8Gu/zGLbnRKRkG+Do0rKv9kPedgjUoDL9z
	 17emlSTaTnxBA48uOABof3TThmxJZBEhpFrpjcNyjJILimamyy+TjAm3pP4hcuDyDvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kDXz5lIwn5l3qkSLFAnkDkLHOlG7ul+kDS5VLR45/PA=;
	b=tch1csGvqLCN8x01hity2yhPlqT8/B+zzolVF9dd4FTt9+zXQX4ULN2Zu6e7nW+SMoCt
	 UMNxHf1TQ+2x3hNuFbLSPupo7QIlR4WyQvkT++egT5E+eX8Nktik9u0avnwVgegWcH0/L
	 TaO/MCMcvjJnYhiB67yOLEDqg0E1/U96cyzhxpsSYjCel/s/LpOt+8RHLikx0P4br3Lol
	 Yx+Y0l5qwSUF0ts4GYP9XTNINIY4cCueOjxVsv2e55fr+zdHE7wTrouW7IGcjm1I8rNqi
	 ClNUMk0ASjFyzrMndg9AahQRTnP6UuszT7i5VLAB8fnuUDzhqchwn7JqTa/WP0ckxrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVSRet9c;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00910606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 11:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00910606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVSRet9c
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso189255eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 03:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794136086; x=1794740886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kDXz5lIwn5l3qkSLFAnkDkLHOlG7ul+kDS5VLR45/PA=;
        b=YVSRet9cCkpS2JqTJABqgue3CzMJiwqT+A+QNAMdXW63nac/bxNClgFF+XSvTtL6wU
         V/jcBUzXOsljLLwcMM8YMs44AJqtTpjg4NdKzI6Q32Opat1yrkWkb/sRhi9Eyx1syGYC
         8BIw+TBWHps98mNGQPZeeDCADf40TKmGkX8RUAzCGPS+rNFn2ZQA5O4tCSSBYrooBntW
         EvhQx+L8aNqju8DNnvjMTDGSEhmq49qe5J7czGH38kuiGdVk8gxXUh+RsKD3fhblq6L/
         M7eN26Kug9raknfPyODuMI66PFSck+94Fm8R2Eg/h3yV03q3ivPgZMcBN5pnq5eHGcoC
         NVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794136086; x=1794740886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDXz5lIwn5l3qkSLFAnkDkLHOlG7ul+kDS5VLR45/PA=;
        b=EIf3MlaaDy/x5KQabiHExFcWnSFeaPb6Me8gbub7VaX0q7ADVEFu9V5RYReVGOyDLa
         gFI7JJrMmlpxAjOKr94f6UT2rs88ZC8IFLnAba7rBkuAu4Ll9vqtaTh5xI/LWfUkStqd
         isN1yJFzTXJ9KgYdM2ZbKwDxcGSGlzvkKeRGx0JeO+YYfw3fdhXnR7biGNh3eM4LI/Cn
         JSebWMV0xe5MDdcnvN63wRRqaovryQQDBNfnuqfu9ix4hGoZF6o10Y/DyBMgS1Tm0Juq
         p5lv4jCVsej5IQs1aZzURvZivXARYBnys5N/Lqu3ktY1d1MOEQdMvmZ5Z+2R9869AFXH
         ZDtg==
X-Gm-Message-State: APuU4Z+BgFC/9aHX/WUS5eDImYURl0ZJeTYozpQeKxUlRnqXlBSEbLaq
	VT3DcCxmet4T1wjzZR2THKY7tQ+xncFUJ5nqD4Ub42dgdga+44Yrp7A=
X-Gm-Gg: AYBFou370KS54IfTE8KIXF84c3HInye3uV3gQcDWp38H6HMSEXpy1cI3q6DyeEh2nYn
	4SiQg9MClV10lqANbdaZEevCVJx/wgHlvlu5T4OqWhLiDSfeuZB1QdmiIhZdUA4HBLLbwxQf6OQ
	hmuxwU94c8CN86gbmNinX/AAyQap+c6rFOs1/FbRkswFetEwCnqpdvZfBnnpuArQI1FtpBRreaW
	Vve6QwMh59cT94otebd5/0vw7ij/hd9A2K1Osh2402HbdUD47N6BUB+H5KrzteZVHOO2FN9ConT
	ztIk5tP7z6spEj1KLzbqAsOPsZp+MqdpBpX2kqK7D9Q18M498dpH5VIJevnEgxNpLhNTLqHmo0f
	HyxuINxAdItqujJn+CMJx6uRHlHRpDrMhtRQZBbGJjjDufIPsDxHZSTA/fL8ZSESMQ+pq1Nfo1R
	mcTr3IVeylBvXnCrXACd68DcA49eb/wGL8T/217/kw5dT/izgCEzi476eR3J1hAB801v2NH3ezi
	1fZHJCH3wNB3kIBy5+tsYbfjdayiDeMqxFM84KSG4ZA+NbGBpCCSjWW6qMj1QgH2bTWAuwPM5iq
	lP3aFuezBcfCFqI6Cmh6ta+aM/60+wScVqtqMG3s/+P27wcz23a1I8suOTyEzAtKhX9OzLk=
X-Received: by 2002:a05:7022:b0c6:b0:190:d0d9:3110 with SMTP id a92af1059eb24-1b39ff2dademr1703886c88.45.1794136085922;
        Sun, 08 Nov 2026 03:08:05 -0800 (PST)
Received: from localhost.localdomain ([1.251.173.69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e8911sm5569287c88.5.2026.11.08.03.08.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 03:08:05 -0800 (PST)
From: Hijae Song <hijae99@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Hijae Song <hijae99@gmail.com>
Subject: [PATCH] HID: ayaneo-flip-kb: Add driver for keyboard backlight
Date: Sun,  8 Nov 2026 20:07:57 +0900
Message-ID: <20261108110757.41368-1-hijae99@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The AYANEO Flip KB has a built-in SiGma Micro USB keyboard (1c4f:007c)
with two HID interfaces: a boot keyboard and a vendor-defined one that
carries an 8-byte Feature Report (ID 0x41) controlling the RGB
backlight. hid-generic binds both, and the backlight is not exposed to
the OS.

Add a driver that exposes the backlight as a multicolor LED class
device, ayaneo:rgb:kbd_backlight. The report layout was determined by
experiments on real hardware:

  byte 1-3: blue, red, green
  byte 4:   firmware effect select (1 = static; 2 and 3 select
            rainbow and breathing, which are not used here)
  byte 5:   0 = off, 1 = on
  byte 6-7: constants 0x41, 0x5a

There is no separate brightness field, so brightness is applied by
scaling the color bytes. GetFeature does not reflect the current state
and is not used.

Turning the backlight off keeps sending the configured color with
mode=off rather than all zeroes, so that the keyboard's own Fn+Space
toggle keeps working afterwards. The LED is marked
LED_RETAIN_AT_SHUTDOWN so unbinding the driver does not blank it.

Both interfaces are bound to this driver so hid-generic stays away; the
boot keyboard interface is started unchanged.

Tested on an AYANEO Flip KB: color and brightness changes through sysfs
and UPower, Fn+Space toggling, behavior after reboot, and a third-party
LED client (HueSync).

Signed-off-by: Hijae Song <hijae99@gmail.com>
---
 drivers/hid/Kconfig              |  12 +++
 drivers/hid/Makefile             |   1 +
 drivers/hid/hid-ayaneo-flip-kb.c | 171 +++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h            |   1 +
 4 files changed, 185 insertions(+)
 create mode 100644 drivers/hid/hid-ayaneo-flip-kb.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index aa7fa11a..bba11e4b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -205,6 +205,18 @@ config HID_AUREAL
 	help
 	Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
 
+config HID_AYANEO_FLIP_KB
+	tristate "AYANEO Flip KB keyboard backlight"
+	depends on USB_HID
+	depends on LEDS_CLASS_MULTICOLOR
+	help
+	  Support for the RGB backlight of the AYANEO Flip KB's built-in
+	  keyboard. The backlight is exposed as a multicolor LED class
+	  device.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-ayaneo-flip-kb.
+
 config HID_BELKIN
 	tristate "Belkin Flip KVM and Wireless keyboard"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 48a863b2..4bac905c 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_HID_APPLETB_KBD)	+= hid-appletb-kbd.o
 obj-$(CONFIG_HID_CREATIVE_SB0540)	+= hid-creative-sb0540.o
 obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
 obj-$(CONFIG_HID_AUREAL)	+= hid-aureal.o
+obj-$(CONFIG_HID_AYANEO_FLIP_KB)	+= hid-ayaneo-flip-kb.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
 obj-$(CONFIG_HID_BIGBEN_FF)	+= hid-bigbenff.o
diff --git a/drivers/hid/hid-ayaneo-flip-kb.c b/drivers/hid/hid-ayaneo-flip-kb.c
new file mode 100644
index 00000000..8068b7d4
--- /dev/null
+++ b/drivers/hid/hid-ayaneo-flip-kb.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID driver for the AYANEO Flip KB's built-in keyboard backlight
+ *
+ * The keyboard enumerates as a SiGma Micro USB HID device with two
+ * interfaces: a plain boot keyboard and a vendor-defined one carrying a
+ * Feature Report (ID 0x41) that controls the RGB backlight. The layout
+ * of that report was determined by testing on real hardware:
+ *
+ *   byte 0: report ID (0x41)
+ *   byte 1: blue
+ *   byte 2: red
+ *   byte 3: green
+ *   byte 4: firmware effect select (0 = keep previous report, 1 = static
+ *           color, 2 = rainbow cycle, 3 = breathing, other tested values
+ *           behave like 1); this driver only ever asks for static color
+ *   byte 5: mode, 0 = off, 1 = on (other tested values behave like 1)
+ *   byte 6: fixed 0x41
+ *   byte 7: fixed 0x5a
+ *
+ * Copyright (c) 2026 Hijae Song
+ */
+
+#include <linux/cleanup.h>
+#include <linux/hid.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "hid-ids.h"
+
+#define FLIP_KB_REPORT_ID	0x41
+#define FLIP_KB_REPORT_SIZE	8
+#define FLIP_KB_MODE_OFF	0
+#define FLIP_KB_MODE_STATIC	1
+#define FLIP_KB_EFFECT_STATIC	1
+
+struct flip_kb {
+	struct hid_device *hdev;
+	struct led_classdev_mc mc_led;
+	struct mc_subled subled[3];
+};
+
+static int flip_kb_send(struct hid_device *hdev, u8 r, u8 g, u8 b, u8 mode)
+{
+	u8 *buf __free(kfree) = kzalloc(FLIP_KB_REPORT_SIZE, GFP_KERNEL);
+	int ret;
+
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = FLIP_KB_REPORT_ID;
+	buf[1] = b;
+	buf[2] = r;
+	buf[3] = g;
+	buf[4] = FLIP_KB_EFFECT_STATIC;
+	buf[5] = mode;
+	buf[6] = 0x41;
+	buf[7] = 0x5a;
+
+	ret = hid_hw_raw_request(hdev, FLIP_KB_REPORT_ID, buf,
+				 FLIP_KB_REPORT_SIZE, HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
+	return ret < 0 ? ret : 0;
+}
+
+static int flip_kb_brightness_set(struct led_classdev *led_cdev,
+				  enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_led = lcdev_to_mccdev(led_cdev);
+	struct flip_kb *kb = container_of(mc_led, struct flip_kb, mc_led);
+
+	if (brightness) {
+		led_mc_calc_color_components(mc_led, brightness);
+		return flip_kb_send(kb->hdev, kb->subled[0].brightness,
+				    kb->subled[1].brightness, kb->subled[2].brightness,
+				    FLIP_KB_MODE_STATIC);
+	}
+
+	/*
+	 * An all-zero color combined with mode=off makes the keyboard's
+	 * own Fn+Space toggle stop responding until a non-zero report is
+	 * sent again. mode=off already blanks the backlight regardless of
+	 * the color bytes, so send the configured intensities unscaled
+	 * instead of collapsing them to zero.
+	 */
+	return flip_kb_send(kb->hdev, kb->subled[0].intensity,
+			    kb->subled[1].intensity, kb->subled[2].intensity,
+			    FLIP_KB_MODE_OFF);
+}
+
+static int flip_kb_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct flip_kb *kb;
+	int ret, i;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Both interfaces match this driver, which keeps hid-generic from
+	 * binding to them, so the boot keyboard interface must be started
+	 * normally and left alone.
+	 */
+	if (!hid_validate_values(hdev, HID_FEATURE_REPORT, FLIP_KB_REPORT_ID,
+				 0, 1))
+		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	kb = devm_kzalloc(&hdev->dev, sizeof(*kb), GFP_KERNEL);
+	if (!kb)
+		return -ENOMEM;
+
+	kb->hdev = hdev;
+	hid_set_drvdata(hdev, kb);
+
+	kb->subled[0].color_index = LED_COLOR_ID_RED;
+	kb->subled[1].color_index = LED_COLOR_ID_GREEN;
+	kb->subled[2].color_index = LED_COLOR_ID_BLUE;
+	for (i = 0; i < 3; i++)
+		kb->subled[i].intensity = 255;
+
+	kb->mc_led.subled_info = kb->subled;
+	kb->mc_led.num_colors = 3;
+	kb->mc_led.led_cdev.name = "ayaneo:rgb:" LED_FUNCTION_KBD_BACKLIGHT;
+	kb->mc_led.led_cdev.max_brightness = 255;
+	/* Keep the backlight lit across driver unbind instead of blanking it. */
+	kb->mc_led.led_cdev.flags = LED_RETAIN_AT_SHUTDOWN;
+	kb->mc_led.led_cdev.brightness_set_blocking = flip_kb_brightness_set;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = led_classdev_multicolor_register(&hdev->dev, &kb->mc_led);
+	if (ret)
+		hid_hw_stop(hdev);
+
+	return ret;
+}
+
+static void flip_kb_remove(struct hid_device *hdev)
+{
+	struct flip_kb *kb = hid_get_drvdata(hdev);
+
+	/* Unregister the LED before the transport goes away. */
+	if (kb)
+		led_classdev_multicolor_unregister(&kb->mc_led);
+
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id flip_kb_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO,
+			 USB_DEVICE_ID_SIGMA_MICRO_AYANEO_FLIP_KB) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, flip_kb_devices);
+
+static struct hid_driver flip_kb_driver = {
+	.name = "ayaneo-flip-kb",
+	.id_table = flip_kb_devices,
+	.probe = flip_kb_probe,
+	.remove = flip_kb_remove,
+};
+module_hid_driver(flip_kb_driver);
+
+MODULE_AUTHOR("Hijae Song <hijae99@gmail.com>");
+MODULE_DESCRIPTION("HID driver for the AYANEO Flip KB keyboard backlight");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 341bf587..88302307 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1309,6 +1309,7 @@
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD	0x0002
 #define USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE	0x0034
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2	0x0059
+#define USB_DEVICE_ID_SIGMA_MICRO_AYANEO_FLIP_KB	0x007c
 
 #define USB_VENDOR_ID_SIGMATEL		0x066F
 #define USB_DEVICE_ID_SIGMATEL_STMP3780	0x3780
-- 
2.54.0 (Apple Git-157)

