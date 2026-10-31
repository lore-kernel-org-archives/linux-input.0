Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483854;
	b=vexUxhqPnazdBhigs4CP3QaJCkwTgg24xwW1az2Db94Lt0FBSorN3WND1S3zrPzxTqf4
	 dnlFIr8ZgKm8jcrzK8qDAVTjT9+gyw3PjdNlTrmmHpTjn5jOvvhjgfe1Vy6Vqe919Wcrl
	 J6jSKx+MOtCoon54VOA3YvatiBpCV9LwLX03s8VDNsTG7T8l/Ch8He69UFN5x8SSsSQGh
	 l7+keImZPtw9BKKbYm1Ocv10EOk8GNBQ5IM3bWmQ21RzHyXMzogz/4QGKbhmtBqUW0HeU
	 xJNOgqFuBBqFP58jdq4nAIc1EZ5CVBp40mmKCXsW+s8IhUEiWrOA9l7VKvp3ok2rmxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UqEZeuoGybDtjamz1CGigzLih1o2504AoQHvUTu6Z0I=;
	b=aAw3OV7FUmowOFbbVHLVCfyaIYPYyVoa1a4hF2efNjOSZlWkKJGX21O2zoXU5jODU+dM
	 83/cxUWzLaE9T+SlvbNsdqq1Ig5oIYktRhkiC1JWIPleH5fhFhvOLlUT7ZD/8AimjVB8t
	 H7ENEFBlbnVMbmJjvYSYaiyAeQ6G+NLDmE0/tM/e+hujnADMJISRJFrjOBszdTgJTgI5G
	 R+ntmhoTGalC0JGAhtVDZqYoYdladn5BNOY1G56q8nOxN8PBcqWxS/NCOrWyDDQzixjtD
	 ORvpnKhQJA9wd1oRY88Pqblna3rFeyczB3uQJM9a5wfIagbzhkG8Nm97iiGvthO7EpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UnhJBq06;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46E606A31C
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 21:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B46E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UnhJBq06
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso2785181a12.0
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483853; x=1794088653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UqEZeuoGybDtjamz1CGigzLih1o2504AoQHvUTu6Z0I=;
        b=UnhJBq06NV1sTHO66kyYaXJ6r3yUfVL+5S7sdxFRS3CT7/ylQINI+rTRcNhF7lYtlV
         MIl7RkXdvC8dq95W3z7DdEXfkhve10AdK/PlbCq951ekC180XK7uXo/zD5mvy6WMACEJ
         P3IfLuY4nkBGdeh+2qpDZSS+syAT5rq1KzmDtea7ZPVTf4eJ71wz56nDVDSgou8UV9Cx
         fIwyGr7dbGw0Biia8EKPASz+8pha+nq46WSCyoa+dHW66PXP9R8v4zP2faVpQPB/9Rxw
         8429ka9znDquyndUsKLu7s/DiYZNpW08idiqCYDmJWAHJpGP7H2LM4kD/zEDEsb0TnEi
         +IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483853; x=1794088653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UqEZeuoGybDtjamz1CGigzLih1o2504AoQHvUTu6Z0I=;
        b=dNS1pHTN5JlN8X8YC5mXBlh/KWb5T1r92KKy781o6m6Ta9gUua/RrMcUX+/lZ4hA88
         GhvRpBEE4rCa4+CGxaAE8QNbwlXz5NdNQAVS3mxaFlU81HikHkj4e7z3dUfG24jOCWZA
         5+9l3LWEXUE0haViqlpXBS4z1OMXHkqdePa4ZURTd/eTuXtX7RyDNoBSZ3HD4u4zEmxC
         /2YGu1S4wOTye4hbyCXjFPe5Xge51LLVyMVyjWLOht9qz8AKiau9ItK+LseTY1XhIJUT
         gg7qQdCc+eHSCY3etGjke5b6xNMrzDJRbakyhbecgy1bQnnae40bfKc+XU2tsFGNrlLs
         WMFg==
X-Gm-Message-State: AFq9FYKqYxTleqSHqEL6BPH1BsLTQyPWrwJ+GiYfiFZ3VpNcYokFY7KD
	IyZew1JOkYWhhFNmIGsCH94etNN/ink0g1Jjj3cdNmHiLTzLlhVevCdK
X-Gm-Gg: AYBFou0kW0bcNoD5k7J6ZHMDkBPDhwgoFP5lp1K9N8r86p5WUGYkW94nTEKnbM6VB/Y
	DpRthnasHZS983nDc1/gC6FDD960nZmI1clb7/l3Z9hpgTcwt6j4Gwt5VDSti2DENUv3WhjxWCM
	E6zLJvAZ9vemzupbg3tFCIYgb61HfnOyF+i/WqSrqog4i3Lx7F/7v1V0Y2CppTBmvfA8jtnHVN9
	XUuRfDmgmvUn/JvT2gkDHktZ+jcKA9cfgeuHiu5bz/voTaNbozmRtQow/Qmn4xdjxfrZ/z6jXVF
	3jd8GiRnbd1PlED8pAOonKB4EIwGckWgRyukZn8I/PbON4iVwx7rajD9uStvD/DaZek3OPsd9/v
	hyBACUmgY3WRiWwglEas0t9zy4i/ASxQXMp/Ow/6F4aaC95x+5M+2vOr/P4mavBiBeImZixtiB8
	ebUi75bVVT5VNWyiVJzPr8JtWyEQPBffHJJLsP02A8NKKuf53Orip3/5aTTRJzLHtjJ6WhTaBY8
	eOgaxBlmZNuWWrW4mNFdCHG1bdsGHf+7oK3KO4dlnCf8bm0ubkCCC9ouDKXUf/007iKke4GB70Z
	ncTo/P+EL6h2NWd7ckIJ9+dyVGeDgPe5Q3I7MFpkwT0V18iNS802HbBS
X-Received: by 2002:a05:6402:a505:10b0:6aa:e46b:2ca with SMTP id 4fb4d7f45d1cf-6b4d5537ae9mr2710112a12.30.1793483852827;
        Sat, 31 Oct 2026 14:57:32 -0700 (PDT)
Received: from fargo (0x573d5d96.static.cust.fastspeed.dk. [87.61.93.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9ee7c9sm1429241a12.7.2026.10.31.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:57:30 -0700 (PDT)
From: "Jesper B. Christensen" <jaytersen@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	"Jesper B. Christensen" <jaytersen@gmail.com>
Subject: [PATCH] HID: asus: support the Zenbook A14 (UX3407RA) keyboard backlight
Date: Sat, 31 Oct 2026 22:57:10 +0100
Message-ID: <20261031215710.11126-1-jaytersen@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The ASUS Zenbook A14 (UX3407RA), a Qualcomm Snapdragon X2 Elite
(Hamoa)-based laptop, carries its main keyboard on an I2C-HID device
with the ID 0B05:0220. Its Fn/media hotkeys are emitted as vendor-page
(HID_UP_ASUSVENDOR) usages on report 0x5A.

In addition to the the standard I2C keyboard quirks and the keyboard
backlight quirk, a few new have been added:

  QUIRK_KBD_REPORT_SIZE: The UX3407RA seems to only accept 64 byte
   reports
  QUIRK_KBD_OOBE: Refactor existing Out-Of-Box mitigation into a
   quirk.

The keyboard backlight is software controlled. Since WMI is not
available on Snapdragon based platforms this change registers a
separate led device that sends hid reports to the Embedded Controller
(EC).

Signed-off-by: Jesper B. Christensen <jaytersen@gmail.com>
---
 drivers/hid/hid-asus.c | 88 ++++++++++++++++++++++++++++++++++++++++--
 drivers/hid/hid-ids.h  |  1 +
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c38a2b3b33d9..072df9816e50 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -66,6 +66,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ASUS_FAN_CTRL_KEY_CODE 0xae
 
 #define SUPPORT_KBD_BACKLIGHT BIT(0)
+#define EC_KBD_MAX_BACKLIGHT 3
 
 #define MAX_TOUCH_MAJOR 8
 #define MAX_PRESSURE 128
@@ -100,6 +101,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
 #define QUIRK_FILTER_CAMERA_COMPANION	BIT(15)
+#define QUIRK_KBD_REPORT_SIZE           BIT(16)
+#define QUIRK_KBD_OOBE			BIT(17)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -169,10 +172,12 @@ struct asus_drvdata {
 	bool battery_in_query;
 	unsigned long battery_next_query;
 	struct asus_hid_listener listener;
+	struct led_classdev kbd_led_cdev;
 	bool fn_lock;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
+static void asus_kbd_illum_toggle(struct asus_drvdata *);
 
 static const struct asus_touchpad_info asus_i2c_tp = {
 	.max_x = 2794,
@@ -469,6 +474,7 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
 		case KEY_KBDILLUMDOWN:
 			return !asus_hid_event(ASUS_EV_BRTDOWN);
 		case KEY_KBDILLUMTOGGLE:
+			asus_kbd_illum_toggle(drvdata);
 			return !asus_hid_event(ASUS_EV_BRTTOGGLE);
 		case KEY_FN_ESC:
 			if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
@@ -576,15 +582,23 @@ static int asus_raw_event(struct hid_device *hdev,
 
 static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
-	u8 *dmabuf __free(kfree) = kmemdup(buf, buf_size, GFP_KERNEL);
+	size_t alloc_size = buf_size;
+
+	if (QUIRK_KBD_REPORT_SIZE)
+		alloc_size = (buf_size > FEATURE_KBD_REPORT_SIZE) ?
+			buf_size : FEATURE_KBD_REPORT_SIZE;
+
+	u8 *dmabuf __free(kfree) = kzalloc(alloc_size, GFP_KERNEL);
 	if (!dmabuf)
 		return -ENOMEM;
 
+	memcpy(dmabuf, buf, buf_size);
+
 	/*
 	 * The report ID should be set from the incoming buffer due to LED and key
 	 * interfaces having different pages
 	 */
-	return hid_hw_raw_request(hdev, buf[0], dmabuf, buf_size, HID_FEATURE_REPORT,
+	return hid_hw_raw_request(hdev, buf[0], dmabuf, alloc_size, HID_FEATURE_REPORT,
 				  HID_REQ_SET_REPORT);
 }
 
@@ -702,6 +716,38 @@ static void asus_kbd_set_brightness(struct hid_device *hdev, u8 brightness)
 		hid_err(hdev, "Asus failed to set keyboard backlight: %d\n", ret);
 }
 
+static void asus_kbd_set_brightness_cdev(struct led_classdev *led_cdev,
+				    enum led_brightness brightness)
+{
+	struct asus_drvdata *drvdata = container_of(led_cdev, struct asus_drvdata, kbd_led_cdev);
+	u8 level = (u8)brightness;
+
+	if (level > EC_KBD_MAX_BACKLIGHT)
+		level = EC_KBD_MAX_BACKLIGHT;
+
+	asus_kbd_set_brightness(drvdata->hdev, level);
+	drvdata->kbd_backlight_brightness = level;
+}
+
+static enum led_brightness asus_kbd_get_brightness_cdev(struct led_classdev *led_cdev)
+{
+	struct asus_drvdata *drvdata = container_of(led_cdev, struct asus_drvdata, kbd_led_cdev);
+
+	return (enum led_brightness)drvdata->kbd_backlight_brightness;
+}
+
+static void asus_kbd_illum_toggle(struct asus_drvdata *drvdata)
+{
+	if (!drvdata->kbd_led_cdev.brightness_set)
+		return;
+
+	u8 current_level = drvdata->kbd_backlight_brightness;
+	u8 max_level = EC_KBD_MAX_BACKLIGHT;
+	u8 next_level = (current_level + 1) % (max_level + 1);
+
+	asus_kbd_set_brightness_cdev(&drvdata->kbd_led_cdev, next_level);
+}
+
 static void asus_kbd_wmi_fan(struct hid_device *hdev, struct hid_raw_event_data *data)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -956,7 +1002,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
 		return -ENODEV;
 
-	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
+	if (drvdata->quirks & QUIRK_KBD_OOBE) {
 		ret = asus_kbd_disable_oobe(hdev);
 		if (ret < 0)
 			return ret;
@@ -972,10 +1018,28 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	drvdata->listener.brightness_set = asus_kbd_backlight_set;
 	ret = asus_hid_register_listener(&drvdata->listener);
 	if (ret < 0) {
-		hid_err(hdev, "Unable to register kbd brightness listener: %d\n", ret);
+		if (ret != -ENODEV) {
+			hid_err(hdev, "Unable to register kbd brightness listener: %d\n", ret);
+		}
 		drvdata->listener.brightness_set = NULL;
 	}
 
+	// Non-x86 architectures do not have WMI, just register a led
+	// device directly
+	if (ret == -ENODEV) {
+		drvdata->kbd_led_cdev.name = "asus::kbd_backlight";
+		drvdata->kbd_led_cdev.brightness_set = asus_kbd_set_brightness_cdev;
+		drvdata->kbd_led_cdev.brightness_get = asus_kbd_get_brightness_cdev;
+		drvdata->kbd_led_cdev.max_brightness = EC_KBD_MAX_BACKLIGHT;
+		ret = led_classdev_register(&hdev->dev, &drvdata->kbd_led_cdev);
+		if (ret < 0) {
+			hid_err(hdev, "Unable to register kbd brightness led: %d\n", ret);
+			drvdata->kbd_led_cdev.brightness_set = NULL;
+		}
+
+		asus_kbd_set_brightness_cdev(&drvdata->kbd_led_cdev, 1);
+	}
+
 	return ret;
 }
 
@@ -1372,6 +1436,9 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brightness);
 
+	if (drvdata->kbd_led_cdev.brightness_set)
+		asus_kbd_set_brightness_cdev(&drvdata->kbd_led_cdev, drvdata->kbd_backlight_brightness);
+
 	return 0;
 }
 
@@ -1502,6 +1569,9 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16"))
+		drvdata->quirks |= QUIRK_KBD_OOBE;
+
 	/* Laptops keyboard backlight is always at 0x5a */
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
 	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
@@ -1539,6 +1609,9 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	if (drvdata->kbd_led_cdev.brightness_set)
+		led_classdev_unregister(&drvdata->kbd_led_cdev);
+
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
 	return ret;
@@ -1551,6 +1624,9 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	if (drvdata->kbd_led_cdev.brightness_set)
+		led_classdev_unregister(&drvdata->kbd_led_cdev);
+
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
 }
@@ -1673,6 +1749,10 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD),
 	  I2C_KEYBOARD_QUIRKS | QUIRK_FILTER_CAMERA_COMPANION },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_A14_KEYBOARD),
+	  I2C_KEYBOARD_QUIRKS | QUIRK_USE_KBD_BACKLIGHT | QUIRK_KBD_REPORT_SIZE |
+	  QUIRK_KBD_OOBE},
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index cb7f16d75fce..a992c0aabd45 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -221,6 +221,7 @@
 #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD	0x4b42
+#define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_A14_KEYBOARD	0x0220
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2 0x1837
-- 
2.53.0

