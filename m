Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27972415F16
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164142; cv=none; b=lU8ZMG2axzrGl9DvFEKEo8w7HxNLeX9cVBSsr3BVY90fx54Rz4d/osBpITZvvBhZtirj0xqASZXJvRAgI1zI/fyQX/YWnHDGdVMReLkaVXdpx0vNIdJ5eEsSxbIjYzUtSkFDNwOUGsl/8J5CfpFbQjy9sdP5LVSU59XkpsM4SI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164142; c=relaxed/simple;
	bh=ZxobgAnXXFtu+luTyBrW6xofEaS+5nRX4tb2YO+Ziyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+HDJWz/aIHchqMBlpRHsJEaNg3Ekvo9+xnAPBUxKLQfJ8HRrcilZMB5+a9VgOSlFZCYVYcOK7aQ4ka3vudrcjI4rjkHfXWfbdS8sdDipOEf/SJ6IjSpsCJ45+sZR3dfcS+5fuO78bh1QLi/i8k31MP+KfNJbzJfFxUnbOVtxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=Oj0ngZEA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="Oj0ngZEA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49553515a8bso33138455e9.1
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785164138; x=1785768938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=trDNQkj/0qrlzEVX1f99jKS+y2H6/G/TDAJPZf3g4nc=;
        b=Oj0ngZEAsMuZoMtT3EqiEzUcgg/V9s89B3ohg0PdISZFlfSMxSDGW1ovbJ6s9hjhXH
         LFjIK/dDFY6OJa21WQzJOLXOiEl22N3TAQV0lgnRHX71h0E8O/Yfu2y819oLcRL0gjTR
         qdSPalXZXKUgbYAjrr8Gjy6rsG7wv+23RJAGTUv61WK91T5gW5xqA8zBVG5VhqEDYMeV
         BPI5iGr9VMmtr9HL2RCWsLcn/Dc4S0AEChPmRU5anmA1zTqnraWU6rzuxGbCh0vFf09j
         qUM49auroJyTcPfzzzTBPL0tm2MnDwTKTPSZmZsQj55b4XnskAk6rf8w4wdqt6PJy3OC
         co1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164138; x=1785768938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trDNQkj/0qrlzEVX1f99jKS+y2H6/G/TDAJPZf3g4nc=;
        b=BIL0YOWfsBd9aNec0fhZbDZpUuxU1NboOQrhgIYM1Aq+ukLLAfpvbEDpLd007yCdqc
         sZjxf8c+KS8HbWmdW9uWFHkXdXPUyZdSvXg2GClvfr5qnMC2hErDHlw9vKSfX2+uWwPG
         jV/6e6hZ3SzVgEcegF93Z3nb21C0q3sgqbNfN32lTY43xAygqDwwTMngIaHSxOfP29Y2
         WfR4V3VAX05qjPdUdHppmu+hBx8SbFTyHktdYBiYDtSJB49xpP2oMV+J6wy98j8VqJOj
         ANfFjpsvao/3op+CPuC/VTqTvpxIIBDK5bMqT/fSBg4s3njMUcybfC+6V6/BfYMz8bAF
         Vzyg==
X-Forwarded-Encrypted: i=1; AHgh+RqV5b/czp8L7vhad0gw8pJb5Z9y332GohpBZhZwt0a6dtfJWu7ph0uUirJiVtu2KpkQgPxUyOL0+w/U1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YylpqAkjGh+6xxl3hfLnxv3aJZUZyBbtbWjIOVhRl9fi6J9zIrI
	GubPBojQrozqsQdK8nO+p+zi9Bk1KORvUR/cfRezVc9l11eswJo1fV6FOHmMqYgGzC6P7e8E5dE
	S25BuivA=
X-Gm-Gg: AR+sD131lVbyet2dIYSrVmCoWibL+q74+BD0WvWU/yPd1gqVKTdB8DLUQ/ZP8iD/KOw
	UTIXLVxo2RKtD6mg2Iqt46ELseC/Og7blBlPJICsQUTHaWY8l3RFMISmHaDPODAWVro2KWTYQFM
	rdPj4TpcdDRKcwqMUoxt7YhEKcrUec1NjjXc5CYZmSx6MiGP6hFs5mN1vdA6SknrFl+nYuNZplV
	VAhFjOE5doNCHNbtROOeIZIoQ/Rx3mDqNMK0Jp23YL0XXHu6PLFToHuw0CA6iPs/9EkhKDNeYQI
	/CUQ1DDGS5csHKK4ApgtxIZFxw/FTj5aC3RXs7tKs2y0RBEyvC6RFql4+pv4ApvBqg4iJ59Ba6a
	ZoOJRYqskInYvpp+aoKOvC/rISRaFHuWKZYHK/hsEZxjgn+D178Am/cinxvvQxqulCK/+/17Kyd
	NEQ4Te8SFqRXYNBNVCzW0=
X-Received: by 2002:a05:600c:3113:b0:493:c337:db0e with SMTP id 5b1f17b1804b1-496b5717cbcmr104616605e9.18.1785164137912;
        Mon, 27 Jul 2026 07:55:37 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm254241585e9.1.2026.07.27.07.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:55:37 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 15:55:28 +0100
Subject: [PATCH v3 3/8] HID: hid-asus: use named initializer for
 'asus_devices[]'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mod-devicetable-hid_device_id-v3-3-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785164134; l=5215;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=ZxobgAnXXFtu+luTyBrW6xofEaS+5nRX4tb2YO+Ziyc=;
 b=zvwkCzk3eNMQx2ZVTHYD/q8q2RvqSRXs9pUnJUwH+kB1HXoLNjZdWRK0wXIOcR9k2dUc9FS3R
 ejS1Xw71R/RBE6dPgT22VAoHySH1jkjCDL6aP8J1V1u1InmyzNCrL3k
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

This makes the code a little bit more readable and consistent
with other drivers in the HID subsystem that assign the
'driver_data' field in the 'hid_device_id' struct explicitly.

It was confirmed that hid-asus.o pre/post the patch are equal
using diffscope.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-asus.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..ba9a49e9c7f0 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1476,33 +1476,41 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 static const struct hid_device_id asus_devices[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD), I2C_KEYBOARD_QUIRKS},
+		USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD),
+	  .driver_data = I2C_KEYBOARD_QUIRKS },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
+		USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD),
+	  .driver_data = I2C_TOUCHPAD_QUIRKS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1), QUIRK_USE_KBD_BACKLIGHT },
+		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1),
+	  .driver_data = QUIRK_USE_KBD_BACKLIGHT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
+		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2),
+	  .driver_data = QUIRK_USE_KBD_BACKLIGHT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3), QUIRK_G752_KEYBOARD },
+		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3),
+	  .driver_data = QUIRK_G752_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT },
+	  .driver_data = QUIRK_USE_KBD_BACKLIGHT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	  .driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
+	  .driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD |
+		QUIRK_HID_FN_LOCK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	  .driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD},
+	  .driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD |
+		QUIRK_ROG_ALLY_XPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD },
+	  .driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD |
+		QUIRK_ROG_ALLY_XPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_XGM_2022),
 	},
@@ -1511,29 +1519,31 @@ static const struct hid_device_id asus_devices[] = {
 	},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD),
-	  QUIRK_ROG_CLAYMORE_II_KEYBOARD },
+	  .driver_data = QUIRK_ROG_CLAYMORE_II_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD),
-	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
+	  .driver_data = QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
-	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
+	  .driver_data = QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD), QUIRK_T100CHI },
+		USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD),
+	  .driver_data = QUIRK_T100CHI },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE_MEDION_E1239T),
-		QUIRK_MEDION_E1239T },
+	  .driver_data = QUIRK_MEDION_E1239T },
 	/*
 	 * Note bind to the HID_GROUP_GENERIC group, so that we only bind to the keyboard
 	 * part, while letting hid-multitouch.c handle the touchpad.
 	 */
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	  .driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
-		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
+		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD),
+	  .driver_data = 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);

-- 
2.43.0

