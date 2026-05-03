Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637335F612
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793238; cv=none; b=T/wCoi8e+C5bo5ijjTnWtfZXipDm7MtVAcxYWyTNJ5gZ4OijzaSJczkvLcOMQ2VjBkSC+Dfx12wJYqlcvvVLX5dkqpi5foe/73rQAFAzU5Ky/l32YhGZUiT8K7Sj8afw4qqeP/yMiQAIkw4or6Ampoosoi7blbP94J8JpKeJAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793238; c=relaxed/simple;
	bh=PPnVKyrsYxJJ4G4eNrO7KUeOUT6cgnm07ShuwgkFNEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpcYNSXIZlzPdDhlMnUs6MONjqu4PZO1RqSH7fXXma9h9FRLfaWDlxhlsKUlG0kIZYrIcUVCqvSKrwwTw5ZkgFwEAYGMQV6hStbzTeFcZScCh3SeWENExa1Gczkyrl2T9eIM/vJ9Rf7j3HoDuddZmWEBJUbGZlCss/n+ODOULkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJLAB3Ck; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJLAB3Ck"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso18177945ad.1
        for <linux-input@vger.kernel.org>; Sun, 03 May 2026 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777793237; x=1778398037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL+RRTxL9n7ZrU6H/241x49MhcKuis8NrbKzz4pOx+c=;
        b=hJLAB3Ck9p/j7XOJ98KdP2al/u1W6V0ZK0YsHk9hmvw1eEmvl2aB/juDXqHx9yx53v
         ufnLL6/wyLSOVnohYSKafmy/I1D31/Oc2TS+ILws76bTFOo/69lTf8yKbL9KgIr9nrHS
         G+D6kI0J/+vVJy15uRaNX3DdC+V5MPMEPa7v33lnMMwxj9WFH/mJOwrXRx5UuVAmmTtA
         Z1RjhrZv7noQ1Dj4DcccFfoVss/ZsXnkKnN6UUcd/X2ll5uCohV157KHU8FDfreK/OMu
         bRSqYDbi4PrhRlbzL5ruB1I2E7Nahr8ItoTyQchvLG60rMvR2Gj4haTMtdHGyrmkQWJY
         6tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777793237; x=1778398037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BL+RRTxL9n7ZrU6H/241x49MhcKuis8NrbKzz4pOx+c=;
        b=YTv5f2JABvEAJjjHN8quqYyKdTxiqMfrVJ/qKHGXaaMXJ77STvxW4sEfIsRrl3CnS3
         0HcORinwfUmGKA1LBXgUmfizxz7ThxzXiYPUSUWr40F8et55giMTgbAGW6ixr7LFWKRJ
         j9iksWa0rchcs1F19lhzY7JRVOE128eshSDkiogRTaA+Ofx9mlMYLlpn+xHXdc7WNNVs
         3rR/RLzh4Nz+BkBNanXksb03cAVAxTi7eO6Kg4hU+W8TGcT25WVcu9NUd1ZzS3GxcUzO
         HycU0xJfTtJOczlnRxZ+oAs7Ngg4YjnqwK0IunCTQrMnS7Gno/bYhzbBeXz4zZb/GSok
         zV+A==
X-Gm-Message-State: AOJu0YxXQ3RFw0hJyvdacKXX0sOsUQCZtZ/HUIrnf9L/OjqDik+WmbaF
	6gnb+5VjSrYjOudNY9WbIfVd0DkE/2Uh00F2gimjtTdMuqdlFAI8q4Mz
X-Gm-Gg: AeBDieuWJWB43nQSC7pNWlUCG2Ns4uo7CUWknWs394pQ1CQla+3C6fSW+Z+vZUVluag
	g0C+FW/a5GogfIR5lsHjVZLvHwkT9nBUXQXgam6EtTRU7WoTpR0D6Dn9T5+du6Ibts+6U/JbOc0
	nDd4MqXYnH+I5w4QegXHBLq9ElyaCPvqtwihku6e4wVbqWNB3/sdnVvKvK0WhodnimfUveCjEkY
	VHzM2dekQM0Gh7DP8E1MXkwSwliMKDhXeklNc18jSm1GuA0mhOJe64Pn4CXrJlCyfQdw4wwG0vG
	xDKUuYMqvWpY13X4ISucsvloF5R8l1t373Fgg7ZHgXLOvFSHLpqCJ32pcadZrjb6c4qumBKXn2Y
	fzKp3GReEJT2+MS9yOCBOHv5q6iYn3+qBHWX/jELqOliQaX//cUNDryFAeGd4vCR/eVnj7BTLyl
	MAzU2tCKumPotjd7rmqW/kAfwNEGkd51xVx5ocsQH0X5zqiGxx/9iPEIrEXV9s+a1f6LD8jQ==
X-Received: by 2002:a17:903:4b24:b0:2ae:6192:8d78 with SMTP id d9443c01a7336-2b9f257b634mr53308175ad.1.1777793236884;
        Sun, 03 May 2026 00:27:16 -0700 (PDT)
Received: from tranquility.wa.lan (60-241-74-71.static.tpgi.com.au. [60.241.74.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16a9esm64942945ad.50.2026.05.03.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 00:27:16 -0700 (PDT)
From: James Ye <jye836@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	lee@kernel.org,
	pavel@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	denis.benato@linux.dev,
	James Ye <jye836@gmail.com>
Subject: [PATCH 5/6] HID: asus: add microphone mute LED support for T3304
Date: Sun,  3 May 2026 17:26:42 +1000
Message-ID: <20260503072643.2774762-6-jye836@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503072643.2774762-1-jye836@gmail.com>
References: <20260503072643.2774762-1-jye836@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T3304 keyboard has a microphone mute LED indicator on the same key
(Fn+F9). Look this up with a led_classdev.

It does not have backlight LEDs, so return without failure from
asus_kbd_register_leds if backlight support is not present.

Signed-off-by: James Ye <jye836@gmail.com>
---
 drivers/hid/hid-asus.c | 51 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index e4c97fddfaf1..4f68bc40b8bf 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -100,6 +100,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
 #define QUIRK_T3304_KEYBOARD		BIT(15)
+#define QUIRK_HID_MICMUTE		BIT(16)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -144,6 +145,7 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct work_struct fn_lock_sync_work;
 	bool fn_lock;
+	struct led_classdev led_micmute;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -578,6 +580,26 @@ static int asus_kbd_disable_oobe(struct hid_device *hdev)
 	return 0;
 }
 
+static int asus_kbd_set_micmute_led(struct hid_device *hdev, bool enabled)
+{
+	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xd0, 0x7c, enabled };
+
+	return asus_kbd_set_report(hdev, buf, sizeof(buf));
+}
+
+static int asus_led_brightness_set(struct led_classdev *led_cdev,
+		enum led_brightness value)
+{
+	struct device *dev = led_cdev->dev->parent;
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (led_cdev == &drvdata->led_micmute)
+		return asus_kbd_set_micmute_led(hdev, !!value);
+
+	return -ENODEV;
+}
+
 static int asus_kbd_set_fn_lock(struct hid_device *hdev, bool enabled)
 {
 	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xd0, 0x4e, !!enabled };
@@ -752,9 +774,31 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	if (ret < 0)
 		return ret;
 
+	if (drvdata->quirks & QUIRK_HID_MICMUTE) {
+		char *name_micmute;
+		size_t name_sz = strlen(dev_name(&hdev->dev)) + 16;
+
+		name_micmute = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
+		if (name_micmute == NULL)
+			return -ENOMEM;
+
+		snprintf(name_micmute, name_sz, "%s::micmute", dev_name(&hdev->dev));
+		drvdata->led_micmute.name = name_micmute;
+		drvdata->led_micmute.default_trigger = "audio-micmute";
+		drvdata->led_micmute.brightness_set_blocking = asus_led_brightness_set;
+		drvdata->led_micmute.max_brightness = 1;
+		drvdata->led_micmute.flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
+		drvdata->led_micmute.dev = &hdev->dev;
+		ret = devm_led_classdev_register(&hdev->dev, &drvdata->led_micmute);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to register LED: %d.\n", ret);
+			return ret;
+		}
+	}
+
 	/* Check for backlight support */
 	if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
-		return -ENODEV;
+		return 0;
 
 	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
 		ret = asus_kbd_disable_oobe(hdev);
@@ -1315,7 +1359,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	/* Laptops keyboard backlight is always at 0x5a */
-	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
+	if (is_vendor &&
+	    (drvdata->quirks & (QUIRK_USE_KBD_BACKLIGHT | QUIRK_HID_MICMUTE)) &&
 	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
 		(asus_kbd_register_leds(hdev)))
 		hid_warn(hdev, "Failed to initialize backlight.\n");
@@ -1587,7 +1632,7 @@ static const struct hid_device_id asus_devices[] = {
 		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T3304_KEYBOARD),
-	  QUIRK_T3304_KEYBOARD },
+	  QUIRK_T3304_KEYBOARD | QUIRK_HID_MICMUTE },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
-- 
2.54.0

