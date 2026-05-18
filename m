Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900C3FCB0B
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120417; cv=none; b=KvV7IOv1f7FSaJOVLWiphzbS7tGyJwFMiKDSl9/PxeCd7yQsPfHeRTDvRRNDsy1v8HliG7WhGHeq/qcJC6vldDPG6dzW+3dlLGdDFUOtTOSvxUKefVJiBLDH5sF1hXI2lflxrLT0TQmfeEcq94N/LJLEMjskYAHz++wWe4t096o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120417; c=relaxed/simple;
	bh=ZxobgAnXXFtu+luTyBrW6xofEaS+5nRX4tb2YO+Ziyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JsYfprnJ0uBrCYNcOJKEL8xq14sQUx/mM8vV4LwJPNxwLUTxSlyThwhx9Ron/aCtuXBfsWry3HFYmucm6o5080SjXR5TqZsL7/zc0fiSYqH1aqLbRZ2bXsJTXhx31pjJD9XRf2TJskxu9F6K+HD8BLY7adB18TAAn6/5sq3bA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=yoX7/e/4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="yoX7/e/4"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44a5174670eso1359897f8f.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120405; x=1779725205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trDNQkj/0qrlzEVX1f99jKS+y2H6/G/TDAJPZf3g4nc=;
        b=yoX7/e/4eZkl9YZ5Htr4tp1S/+E5iA82mt2BC7T536r0qPBr2wOmNGjkLuKhNCauLu
         upsAr94ZaaPl0B2fCb7eH2nx7ZsYZDMWKpuy4yD104UaOTJuXeEitTWmgDdj15HsWCoR
         4ZDJxjixOHZoZXFCzEWvArhiA0BPrXamxf0wOp68FxkJ12OQ/Qw9k9rWarZM+5d8b/3h
         pP7q3qbWxwjMBjzDljEqLGPzcbKtR+yR0GASetnLSs+yNfW0We9SCl4BqtHzfoA/tAS5
         iBCcbzQF1TvTt9XDUeJiGZnoDw0UfEXe+HmRNaq0H9Xy+tKFEfHMjLelw6FN/dBb+ASl
         LFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120405; x=1779725205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=trDNQkj/0qrlzEVX1f99jKS+y2H6/G/TDAJPZf3g4nc=;
        b=eKuR4U6ilKUal9MHH/L/hP1cdF8ZNHfPkQYIa5OJAEE453xdBv+DiRmq0aY3wt7/6L
         PSTicq0eBmnIaizKZeQVqVGLSEE2DaZqYlyKMMqD2gKbtgNhmkazMIIHgPHGng8N/aVK
         wkys5TaWBXeU3AZcLWjnflj1mIJOqiq6jnYEE2Jp5bHQwBqL13VpTgBzc9yDNvf61a6Y
         zbudpwARyYRHAdgaN5I/Q3QrRuDOGkGX3SB/VcG9mKClmFzNq42/oheLeJ2U+ksHguOV
         en1i8HLSg8e7ArZnA5JH2C/LHTdq+mHm+pAtoF3OWqAONETSohZvIYUiojR0tryoLRmb
         1MuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1qlhQhQ5GTrOLb4552daDdOx9w9A7lcvdtAsvHcG4biFQa8ZM6bG5X1khq+sAhw7qIrXUIbq2GaPSEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyftydOVHmQSP+EcBOtSe/yifJBUzrQ0/42cXOCNqluZ7QfczXA
	Oa0tVGJVpLK84LXDy+1g6y6ahjHa7hMTNUQ+OOQDE/QXnRL08/AgDthB3WVG15AYlHA=
X-Gm-Gg: Acq92OGZjwl92PukNIeYwU5k9z/WK1yHyef2qhRQt4SQhLy0Oqb8JOAHnmrczyGVm+F
	4D1z8jeJBjOLC9yU4xtZSHFAEznlrOA4336cMPJCLQERHrf16UasZ79kHLzboSdggbUNdeUDUOo
	thY+2iOwLmmKsL2ByI4YqE6A9imW4hQ5KVzlI0Ojy8zOOIhUaEij/+3PgNxVL7hsLjy+K+Y1BXI
	0BnRphK85aiDeQcA5vovI1L4HoSXDUs7CY6RG4JupBJa7nC2/F2Z5XDbvSjiPD8pCvjDrWhbB3g
	qXjiWrODfUonVL7p1croX8lPSfpwD/oqtKvCosVCf9PEwNkmr7wcliXaQXtjaqdz0jR6GYV6SjB
	hZYBWx5xCQGVtFo5ZJutyXhU/BQZ5lUp0D1PLvZFcFctlol+jIU/+ptd0BuKKLuH0dj335nGVm9
	6dy3gCVIn0liVMI5ua4lfPQipvX7g3aw2+8IFS+2Q0
X-Received: by 2002:a05:6000:400d:b0:449:af52:6167 with SMTP id ffacd0b85a97d-45e5c58fd33mr25735832f8f.8.1779120404683;
        Mon, 18 May 2026 09:06:44 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:44 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:22 +0100
Subject: [PATCH 03/11] HID: hid-asus: use named initializer for
 'asus_devices[]'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-3-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=5215;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=ZxobgAnXXFtu+luTyBrW6xofEaS+5nRX4tb2YO+Ziyc=;
 b=THQtjtGIkxW5y6IvECx3naOLiAvoZDB01oeZrl8rXPDAaSmWtSgT2TBWYT2qH5u/DGYkrIeO+
 dOjJ5FtvhDUBM8LgvocRW5nrJW2vKvL8GShY2vAoYK0F2ebysim43Xs
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

