Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9D42669E
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104303; cv=none; b=iUXmpbnOzEDUzl9oB285hH+isvazhw5uTnEWF8MgPKE00xbpLcx38Mb/wXC0BJS+HfjQOg7HVy4A9MIGqB/OJkib7CQRTjSudy+u4oGCmlgczf6zcTqfcBBpkwlZP6exFe43StBkX18GLzs+Ivn31bPQLPevwA46mra9xud3Kwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104303; c=relaxed/simple;
	bh=ZxobgAnXXFtu+luTyBrW6xofEaS+5nRX4tb2YO+Ziyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXPSpJ1Vv85ZA5+i4umladxPrxGBQ3wyhTFIaB2/KJcU6b82HXHVfCj4fgg8D3H8ffi3B0vhavbCbUii7rCiP/ypeUg1N8PAZZUs568Y3BVlsdwT1Svt6dkHF31VwNEHMQRlqCxBfAO4rbaRLu2MHwOKZYzEC7/ZO5CfRBaERc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=z3dDBieM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="z3dDBieM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b915ded5so60659665e9.3
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104298; x=1781709098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trDNQkj/0qrlzEVX1f99jKS+y2H6/G/TDAJPZf3g4nc=;
        b=z3dDBieMwel783NpAmEUBFy6aaOtU2NtG3N6yCn3bKHElP2O/Vro89dtehzYVfoTJ6
         kExxF4IlnPXGUtkBHJbTjDuTJUt6gqgZ5NWAFhhfjaNfCyieASDUXFDpcUQxVMQzCm3o
         dQyNni1XldVGfPP7VzufKcJqrB1GqV37Im8qoTu4wUr7dI9+G6AAirIx31/ytB97yjFC
         RQ3M/7GHaKd55QIdOacl0GCcSI+gh2svwKVBFrwHoCva53T96llNhf5G7UMkcJivN2kX
         qsL2BDk2J4qguuEPyDDKPMtUb7ytvpXtvMUzPwM4XE5Kfig7h/6XUbHeSC+UonUQKFZe
         kVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104298; x=1781709098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=trDNQkj/0qrlzEVX1f99jKS+y2H6/G/TDAJPZf3g4nc=;
        b=XyyzTRISRo11VXrLIAwJ+L+HpklN1FaMmt1kMK3W1jtG8mShY1eDgQLy5hcmuxm88l
         q1yu4qx/fg1aaSGdMnZjPP+8YpmVHRgNZcDGukgDVZMpicDG3P5Wn2vmAa5gU4dHt99r
         U5qCk9u0AJnQAMmB8cOslHQ9Ry7CERX17IUD7CX+ow6C5yp8heosmLG/20hivr6Cynfo
         Pq4Df3dk5irl+llPRElyUcOE+NrK+KMfeXmDtvWsq9qK02/lvT0rVuyWaVllpHfY0GwK
         di8ZBlFRMau4dZ0xJZkimODIK0qF0eOPiXOxTBrmh/EGnsqWq1ns7kYHDnk14HIhnsiz
         rnPg==
X-Forwarded-Encrypted: i=1; AFNElJ/DzGDAO5wSG3d6Y3Kex/03klk9tDBvbtAE+VcIZ9EzAVzdbuBP4R+R3kfAi+/a3t9kwZ7s/qnRSahAGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OAWbpFDxdeGKHGMJkVM/eWjgaogsul6gQr1jPhQgzEK6RNuR
	YA0DZQdbZXsnXi18hQN1eNzdRzgoKZuxk63ZqV3GcprgEVorUuP3nAQ9KZ+OBD15jGPCrLYlJph
	sB7Dn
X-Gm-Gg: Acq92OEIqEhG1ebojkLA8/Y6y1hnsHPxipIIacx93qi+e3kH6aLkx/MZfK/Mgv58IUb
	D6T2kF5tfuryXHQYgEJvYvA8Kax3xReSONCZ8Z4+tsCXIyvUFHLYM5SZHVS62mQpmjN5pORm85T
	RDWaYkERfg6gM4NtHfL7wq9gwF7gwrIr5OLdCkSolEKSJxT5A/WmZXSnRD4rmT4Y5L1t1wSMJYZ
	jhamy4X92fOn984Vr3sANGxCFV1U5PxlnY8ZA3dfZBiYxSVgni7TCDdvb97wb9BoFLXJ7nWdDGi
	ZhuckvP4/Rj62fEuP3dgsOVB/AzKfNsoB36nfPmxfZ7p9nWPYDRkTkzNWHps7hl7bpfHQxUmnyt
	2trSo7r9sBLlICHEQ0DVObqt8zNFamShwHH8uLroNM9D6oO07HzgiM8A7iveZ2dGXgpwytecqQ1
	MEpwyf2rJGIpSGcupvuoKce1nPPY9pypQifPhPGiOgetRE51jwuQE=
X-Received: by 2002:a05:600c:5010:b0:490:bb20:de64 with SMTP id 5b1f17b1804b1-490c25b337amr404087285e9.5.1781104298687;
        Wed, 10 Jun 2026 08:11:38 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:38 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 10 Jun 2026 16:11:26 +0100
Subject: [PATCH v2 03/12] HID: hid-asus: use named initializer for
 'asus_devices[]'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-3-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=5215;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=ZxobgAnXXFtu+luTyBrW6xofEaS+5nRX4tb2YO+Ziyc=;
 b=PbZDAbTgj9qsg7a7Q1oYFqch4nNEnw2hhNFTLh1DygV2VN46PqidRPYzXp93W+xTUYR5adqnY
 y5mVzkFn4TWDYDrCd7fP9pehgKfud63d8HD9Qnma/0/L333uhhFF5OE
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

