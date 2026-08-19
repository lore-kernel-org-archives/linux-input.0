Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63B2D73B8
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787142831; cv=none; b=NcwndPzcsKS98dBD1f4SM4SwuurZcGNP/hPX5d9iHbyLWTd8gux9wBm8/6faM0upTDFzy06SnIJqt31IXVkR3vIebMnq4V3RAyPbrUbx81G5vvigJy+MgU+T4B7rw0h5mR0NZhLIB2x0Y3ix/yWjOeTYH0AaQIMbXWQu8oAucmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787142831; c=relaxed/simple;
	bh=3M4MvbJ0PG0fAzy2GYJO0lrIxr/WHWatGn66ZGJR9PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9BJgHj2KpagVNeTzmNUoE99cUvmT+o24UWtzd/xUThRuOmIP+EkiLqfNja5MfPY8sEsLUB5lSS174JiOOuxeLuj5SwCjo92hQuz7HAYAIvPBCbtecRdGSEsFx8FxFHMP18Vb9ox6pyVUj5gmh8+HcB38TgxOxIaTY5/Y2fpWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDf2EOhF; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDf2EOhF"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39db07589caso9387111fa.2
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787142824; x=1787747624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YFk5C0500ZjZAbxn5U6xUeScbsN60+wS54Wq9n+z/vg=;
        b=kDf2EOhFzrSaUM9T0AM6m/NuDxQF3FlgJkhvMPzWOBND0EWLu8nbsRmx2ZWd1OZAhe
         eBsHNCxEDf0Sp64w0L/3aacD4BgJ48Xouir5Ej8TtrqkFqOhOiJ48iyRoyZMtk0hSYCB
         Wkv6eF63LNRt2O5bdxaVws+CWJS86ZRL6ufzuioKbxejWApRuqKLaY/1LSCGwR7n2y+D
         1yGwyeIStE96iEChSAAI2bbD5XJICMLvdL0EuKKp+VCmsSC3LIwXM/mmxkeBfTCg8aoJ
         QumSiIQ4TCZDIWcIDRG5l5M/zDpjCFb+LyOmTW+c9dxSp+2cfO3cMOPKYTnKYKSBiscd
         9DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787142824; x=1787747624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YFk5C0500ZjZAbxn5U6xUeScbsN60+wS54Wq9n+z/vg=;
        b=o3AG4CH6EcsHAVTpFGMSdENYRC1CuWpN3VPHCOXKMxwQd2vHdp3mQ1DyClIqfQpMy1
         Of3vjbjha1I76UIS3nPC3A7A63gfY8caA6OBfEYklsFCTeoiac+Ws9FhAa8e/CRDuT6Z
         CAgn8Px7lmALzBfuK7NMQr7aUSgwhJYhWS0Y3W2GLrHN5Ci9bxG0DSunYYOvHIPxMVF0
         PRhKhMu6w63794go/cGW7GnSL6ytKsyVR9z1eG0yn3AL4g+mYwXsCyW9daC+K6IDGFa/
         C7+OkmewoyP1RZWNzbM75w2Oqafrx66jTXwcmZ7Ys/3mCldgR1l2QW/fDm+/ia9B/HSd
         8IQA==
X-Gm-Message-State: AOJu0Yz5rUnFBc6Ht9JdmTSZbdOwHLOXOuFl4Fyq6IiwRCW/fNn+Kelz
	SZr7bDLFUcMlegncuJ5As8ipjN1Bc91/vrzywakwVYQmU397Z9BgKFgO
X-Gm-Gg: AR+sD12gnOCFIeLOc5zPDXbFNhejnB7yy7QdJ+hLP2wl6HFtBNNqV7gFC/0f1Q8sQTg
	h9gHn/prKGq3SnFuBPavoYC2bwdWbM6P3l/YWo+VcX+7mAZXyUKxHomXFEXnXN2OrST2qoFlY2J
	WLsL5YyRDEJ5m/YLOfWnQui0SGmPqRiA4nYsgh5a63ovyuML+bfUsm7bzfewR0FEbdQ8ZopFMJF
	Q9nNO4aaq9aubnwfbqdUjHny54sZedNNe6EF/LjiBaJLNrHHR7fJCcUCKswn0WeM142PGBNPkfZ
	HP/ixrdO6kA9i/GfTYPEEkwh9YxvPggQF1aX6udvDBHIs3mVDhwx/GfSkZ3LXefFYuIqxNgL9SY
	HSVL00+OuJSOrDCDxTco7vrz+nHzoauP/CXmxctcNmq1YZ6+ANeEayFz/BpTM4dFb7foohoaDlM
	I9jVeDKrGTY/eZKJfnDjzqq4hnFCcCCFNdDvn4o6R44PD1oxpnRrORQAqDRZOrKtw=
X-Received: by 2002:a2e:a989:0:b0:39f:75f5:907d with SMTP id 38308e7fff4ca-3a18973dc12mr7678431fa.2.1787142823884;
        Wed, 19 Aug 2026 05:33:43 -0700 (PDT)
Received: from archlinux ([89.232.117.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b47885abfdsm489672e87.19.2026.08.19.05.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:33:42 -0700 (PDT)
From: Ruzal Daminov <daminovruzal7@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruzal Daminov <daminovruzal7@gmail.com>
Subject: [PATCH v4] HID: multitouch: add support for Goodix GXTP7863 touchpad
Date: Wed, 19 Aug 2026 15:33:26 +0300
Message-ID: <20260819123326.3242-1-daminovruzal7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814171247.16707-1-daminovruzal7@gmail.com>
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Goodix GXTP7863 touchpad controller (VID: 0x27c6, PID: 0x01e0)
found on Honor MagicBook laptops (e.g. FMI-76 / X14 Plus)
was missing from the mt_devices[] table.

As a result, it was claimed by hid-generic, which erroneously mapped
the vendor telemetry collection (0xFF01) to an input node, translating
the 1-Hz heartbeat timestamp into an endless loop of phantom
KEY_BRIGHTNESSUP autorepeat events.

Fix this by:
 1. Adding I2C_DEVICE_ID_GOODIX_01E0 to hid-ids.h.
 2. Adding the device to mt_devices[] with MT_CLS_WIN_8 so hid-multitouch
    claims the touchpad and retains full Win8 PTP quirks.
 3. Filtering out the 0xFF01 vendor collection in mt_input_mapping()
    so the telemetry report is ignored and no phantom input node is
    created.

Tested on Honor MagicBook X14 Plus (FMI-76, AMD Ryzen 8845HS).

Signed-off-by: Ruzal Daminov <daminovruzal7@gmail.com>
---
v3 -> v4:
 - Retain MT_CLS_WIN_8 to preserve Win8 PTP quirks, while explicitly
   filtering out field->application == 0xff010001 in mt_input_mapping()
   to ignore the vendor telemetry collection.
v2 -> v3:
 - Use MT_CLS_DEFAULT to keep export_all_inputs false.
v1 -> v2:
 - Move entry to alphabetical order in the Goodix section.
 - Declare I2C_DEVICE_ID_GOODIX_01E0 in hid-ids.h.

 drivers/hid/hid-ids.h        |  1 +
 drivers/hid/hid-multitouch.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaacd2..60d9d524cd2e15 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -562,6 +562,7 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
 #define I2C_VENDOR_ID_GOODIX		0x27c6
+#define I2C_DEVICE_ID_GOODIX_01E0	0x01e0
 #define I2C_DEVICE_ID_GOODIX_01E8	0x01e8
 #define I2C_DEVICE_ID_GOODIX_01E9	0x01e9
 #define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index edb37b4c867e4b..d2ada08a6b01bf 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1543,6 +1543,12 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (ret != 0)
 		return ret;
 
+	/* Ignore Goodix FreeTouch vendor telemetry collection */
+	if (hdev->vendor == I2C_VENDOR_ID_GOODIX &&
+	    hdev->product == I2C_DEVICE_ID_GOODIX_01E0 &&
+	    field->application == 0xff010001)
+		return -1;
+
 	/* let hid-core decide for the others */
 	return 0;
 }
@@ -2460,6 +2466,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_BT_DEVICE(USB_VENDOR_ID_FRUCTEL,
 			USB_DEVICE_ID_GAMETEL_MT_MODE) },
 
+	/* Goodix GXTP7863 Touchpad */
+	{ .driver_data = MT_CLS_WIN_8,
+	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
+		     I2C_DEVICE_ID_GOODIX_01E0) },
+
 	/* Goodix GT7868Q devices */
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
 	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
-- 
2.45.2
