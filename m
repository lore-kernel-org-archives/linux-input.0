Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591335;
	b=JsD1thve6oFWSWqHE2ZvwlaakG7JcDaVVdKLFcCOq7HqW1M6lj7YjNymzZvqVrLPmRBh
	 WCTButeSZ0e/Q21WKkoNKEeLcOwJypVip+ynsfHPbi2HxKPAwbOjJhnenlh0ItoNy2A++
	 I+Hs/FwtyZdqiZv26RhkeR7hsXClyz3qFKgjpN+WHYozo9VBK4O58baWtwq9ewwKFP7bg
	 hr/u0RYg0EMdj6uYAnkHLPJinolMXLdotHK6J7ts5c+3xmiBI+/zhswriH5uU12d9eA9U
	 kQSNEC2qgpN9+K2viT2gIqgx8IPMHn5ab+Qk9sBs4beziexn7LKczNZTMWKosE6ze2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=+5tpNRXvG2FD/kCmYtpjPEImwzwb0IfLf5mf0pcBb7M=;
	b=VTKkhoVFGCGwq7n7g/QkwJ2/S7TFGTPckxQ/sGg/nbrQvTRHuisVwF7tsOfwrS2H2B5h
	 LqSfXXPTfP+22zj1T0PieDJBYbcA1RoBQrOOikIlKj8Gw1CCluIh4Vxr8Zzrv+FRIsVmt
	 LuFf+oAEgiIRmlRlUizxpp4XOwJ2EuvhKSuTnUKZs04U1YrYeVmqw8FocwOU/C4VZB6Br
	 cpqMMiH2TJVwvWHz32wXK1xtAC91SbIkTZFirBP1e7cq5EaJtmxaajsj90oeEiwNbzPSE
	 zSvRs7ybpjIefZDqDtYgrgOgKpBWQg1CQ6pUO6CkSRNuqoOpGmaeydF7+CiuHFEwTdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VaOFNXz8;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7459606A335
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7459606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VaOFNXz8
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so51159335e9.3
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795591333; x=1796196133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+5tpNRXvG2FD/kCmYtpjPEImwzwb0IfLf5mf0pcBb7M=;
        b=VaOFNXz8Qpr78fV7aaws2PyThFPlXAn4JnPVXmLon1UJflIzDzgGSS4llD4hWfqmpZ
         HuBnXuCNzPLIqKCJwr/mA6B/6pFJV9z8OXOtaBqGjPzPotIdyWn6MAOxlK/dTlEAENPW
         rlC+2sc5yYoj2vMQVSK800S8wnKgtWL5RdmPu948WfkZZoHbMUoQ+zpiDT9QiE9u30lG
         3Sy3r835uKkIx148yl/ZmT8Ilzba/xHuUVJq8VZ31un3KgEFLTK+i/q3kr5yhGBklqqJ
         uxjQd0pr5+S/YdHUpYrbFcdCv2r6CEw6iHk5kIHcdeOEgRkpy24fZylP+sO2bjHOAr9I
         Ping==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591333; x=1796196133;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5tpNRXvG2FD/kCmYtpjPEImwzwb0IfLf5mf0pcBb7M=;
        b=BtVyoWgNnFNft1dnr/19Ko/BlU40sFltJtmuvDlssvgG+km83sMSt3a+5ONq89OXFx
         prfbGYxFNjBcDgsNtPdoOXdvrr38t68FVs+EQ+Zsfc2Rx2sBT8VjDTdSe/ZlFzD7tLzh
         Er3eQah/EYdgDMFZKMfDwEOTpsDMAwLtywhFdRH6xgZKik65RPICgcve+c6ojt5afCcD
         bazrPP/8vOggCuVy26SNhHKN2anCK3GAn+D6+RtfTaCTX5rG91/jbL7lE37pYpucjEPn
         YWZ0e2ukuiPJcJ2iulSdHZzC/LeuP681bl858zj7d3Ufhm/hpTzOu1P+h5oAkZx8EzW5
         61Aw==
X-Gm-Message-State: APuU4Z/8FQhtv94BqWaILuhLvlNCwrkknm+pi/IqQvid6DNkrUhYGhQ+
	yrrtPmSy/p7gC7CzYGjvqMX9V+wv8K44rZDJcPbbI46bPyln4iflGvX/3u737Ku1aUw=
X-Gm-Gg: AZFdTZeteAq1I6tTGMVFEsrmn5+kVE2R53n92agm+sW4GrBkhEqx95THm0Qa0SiBkb/
	V5JtaigTvpCd1I3UL/rm8+qQWkF7j6QR3VpSyDAhkXy95arkod/9x7pjf0QR2iqXayUeJ6TAYDB
	X/Ct2NuL1ynjI6IsINBwOEQbLkTERcgPQDQ56fbI2iha6G3fKKWYl98w0gnewhn0Mq+u2i9GPk1
	SAh2AzcloNXAIZ1iNk/8m3mVOV3JOBqRJOBJ1zrBtMpjMjuKh6Y3Nmukw0OQp1g4cfNooVCmCab
	JYdWj3Z5uFqA+IKcxHi32SXxDgM866N1W+uxYuRsOFDtSelPLwCW4Jkm66Bq8wf85LKSkWVRx+n
	1p+3YawEnZaQVv7s3fdmZ+JJ52AP0ISXM5NXsZBUE2DXHC3Yx02YI5rKYk7RetlX3Mq4IFx+Tz4
	euScKge6H2GlETl5e8D4d4A/SABaiIshQz0QtUASfpV6JUM8lORkJNq0pfHSLJgi2VjK3Orp/HE
	qZWkOEngOwEV8W2gTvrqAwaurnTiRg+L9CU8x7xKz9liXB/EoVqKn+ugxEaIDZmXQEmyrxlwVkK
	wbAkhHAVG3pI9Th24eZABt2ACthJ/1T3pw==
X-Received: by 2002:a05:600c:4e4c:b0:4b6:5dac:b61e with SMTP id 5b1f17b1804b1-4bb88938d2dmr315514635e9.32.1795591332789;
        Tue, 24 Nov 2026 23:22:12 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb853ca452sm484273305e9.15.2026.11.24.23.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:22:12 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 1/9] HID: asus: Use designated initializer for hid_device_id
Date: Wed, 25 Nov 2026 08:21:33 +0100
Message-ID:  <74526d9dd0fcf5a63fb1b6b0aff931a63f8a5e3a.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
References: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10632; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=cunnDZC1QeKcFkckLpFufJBkG6PzNl+fDk94jDCeHkg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBox/d4gQPPM7Bmww6Dd+ARj943cATNZq21BHa bIjMdpygfeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawaMfwAKCRCPgPtYfRL+ TtEAB/wJ411bmnzhy82BBntZ3hliSbpk1FuTY7N0Mj29dBwKpDEOV5qOi/zlBvktRH8Kbp52Qpm B9ZThlAHLGp25mI8aKd8VGkkU5S/UeJvJVZRoIjB7dD/mJx47mGCkI1eLv3ELLLfmW5aS+Ejlgw LoW5pWpiiu2pEPzN9by1/yoNj6wT9qHXR/dalPpjUjhTfZUYy0NKa7mQcFZ49pYrp/JJseuID/f JebnmKmiwHZG46RaqH8e30d3pvEmgvm/4MF4CcaH9aNQLhrdwXoAUXrb5ASvBXXgB7+/jz+HBjT VmyEz3F++wFcFxSa3r7erfGWmaArayqQayLhutuKgSK7ej/7
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct hid_device_id replacing .driver_data by an anonymous union.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/hid/hid-asus.c | 199 ++++++++++++++++++++++++-----------------
 1 file changed, 119 insertions(+), 80 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index dcb3d50f9288..57f5bb9e829e 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1902,97 +1902,136 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 }
 
 static const struct hid_device_id asus_devices[] = {
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD), I2C_KEYBOARD_QUIRKS},
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD),
-	  I2C_KEYBOARD_QUIRKS | QUIRK_FILTER_CAMERA_COMPANION },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1), QUIRK_USE_KBD_BACKLIGHT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3), QUIRK_G752_KEYBOARD },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD},
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_XGM_2022),
+	{
+		HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD),
+		.driver_data = I2C_KEYBOARD_QUIRKS
+	}, {
+		HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD),
+		.driver_data = I2C_KEYBOARD_QUIRKS | QUIRK_FILTER_CAMERA_COMPANION
+	}, {
+		HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD),
+		.driver_data = I2C_TOUCHPAD_QUIRKS,
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3),
+		.driver_data = QUIRK_G752_KEYBOARD
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK
+	}, {
+		HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD,
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD,
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_XGM_2022),
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_XGM_2023),
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD),
+		.driver_data = QUIRK_ROG_CLAYMORE_II_KEYBOARD
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD),
+		.driver_data = QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+			       USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
+		.driver_data = QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D),
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110),
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112),
+	}, {
+		HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
+				     USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD),
+		.driver_data = QUIRK_T100CHI,
+	}, {
+		HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE_MEDION_E1239T),
+		.driver_data = QUIRK_MEDION_E1239T,
 	},
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_XGM_2023),
-	},
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD),
-	  QUIRK_ROG_CLAYMORE_II_KEYBOARD },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD),
-	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
-	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD), QUIRK_T100CHI },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE_MEDION_E1239T),
-		QUIRK_MEDION_E1239T },
 	/*
 	 * Zenbook Duo detachable keyboards. The touchpad shows up as a
 	 * separate HID device with the same IDs, over USB and Bluetooth:
 	 * bind to the HID_GROUP_GENERIC group only, like the ROG Z13 Folio
 	 * below, so that hid-multitouch keeps handling it.
 	 */
-	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
-	{ HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
-	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
-	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
-	{ HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
-	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
-	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
-	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
-	{ HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
-	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
+	{
+		HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
+			   USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD
+	}, {
+		HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
+			   BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD
+	}, {
+		HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
+			   USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD
+	}, {
+		HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
+			   BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD
+	}, {
+		HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
+			   USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD
+	}, {
+		HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
+			   BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD
+	},
 	/*
 	 * Note bind to the HID_GROUP_GENERIC group, so that we only bind to the keyboard
 	 * part, while letting hid-multitouch.c handle the touchpad.
 	 */
-	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
-		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO),
-	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
-	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
-		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
-	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
-		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T302CHI_KEYBOARD) },
+	{
+		HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+			   USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO),
+		.driver_data = QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD
+	}, {
+		HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+			   USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD)
+	}, {
+		HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+			   USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T302CHI_KEYBOARD)
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
-- 
2.47.3

