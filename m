Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9E390229
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 05:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735605; cv=none; b=ZnnSrJIq40a8qVjpOmuoEcvatUQKlSAGQDbdJZ9CdM4SUoM303ah/9RocLIs+3ZmrulQ7vXuF1RkotVsZgCME3wGGQKlxDJXEkVZUA4N8L5ILc2Mf/zWlQmpHLYZ5+Vnp7tA3EXcrXZJ2U9lFOFHunp9utK9l5x2Y7mLkDs1RUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735605; c=relaxed/simple;
	bh=CEAvbppTHkOWGeSIsutgaKGrdMgluE1ZZ8Eu6tsd/Ck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tK8refdJGfq0Hg4PPzSUbrgeKuraIMV6ubPT+khXPsucvKWFLV3kTMSLnm5hNaZG9kPy7ogA4ZuyNcgc4lxWEKnlirZoUKX13wNDIHhUrzALyrf+x5qrkUG45hV62LXzAxTyWispPcghO0b62bjMYiuKfPKyJhywwRocGtNlNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAz13un7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAz13un7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so14869295e9.2
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 22:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785735602; x=1786340402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oc1rdx0ZcfYUk5xHv5HVHhYRleOebJmZFBrc3lIgAEs=;
        b=ZAz13un73raWB7lq6aKbdIC8CfgqdQl5SfdHbAqYcZjNbHGvKmN1S/z+WXPJ9raC33
         RsHTU4B1Xao0snqCIedONNaj434/SjXMUngHrEL/uH23pJTLJOdhyMnQVyvkFHtiL9Ky
         xSix00GxnkkL1BRraESWh6H0IOmU1dWI8IPgEwJFUApYID1P0WBP4vPoeA0veKLfCS77
         TkM5KL8issUiLUYdP6Mcb+g6P1AUCRVLC4Fd3d7YywE/wCZWBnCH/2anK9l13ZZhP3bM
         J9+JIWSok8xlw1jfgTsPMFF+cT4LuvBG86vX3LZn98gZtS9cOIIpAYcv/TuxPVCfwpH8
         xqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785735602; x=1786340402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Oc1rdx0ZcfYUk5xHv5HVHhYRleOebJmZFBrc3lIgAEs=;
        b=NQ6yyxuV8xd8+hnu0WQJIFG/upHK/n7ZQAIDNlFWLOjr4r5tBmGMTcjUuxwcno+7x0
         Ru4gi9Mg0kve2nZSPVYwOCz2vSU1yg/2dOU4f1XdoMQgGdqdCqnSMLXUeTPB/IlvWcgs
         ycLiE3rQg47z8RqhMqbT1TrBBuEykPS4CJy7Jnp7PvvYcvtKJ4o20wnTjYylaBmy4hQ7
         xn3G3mokz0HGVJKEVJiTCymuSdTn731cAkEya2jTvuwBB/X6oSMpSs5C3VHsWKFXVxwg
         TrXa73eCXm0FDw8T0aQmhVwV6OmMK+MpmUGw4U3k5c3uZZ//zpoOgbeJpCtUXYBDmlv+
         Kcbg==
X-Forwarded-Encrypted: i=1; AHgh+Roe7yjndOaAhtcIh/FzDXz8bRYQfzqngqjzkEiYw6lsy2myaJcKiIMRCv+6Hu6HpzZunNlgVitD848bHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKf31ytEwhWkxEeaVbUGSFZMmPG0iR7bGdC+moPvTdC1jRxKgH
	DVYeK3r8bpeJUyBpdC0BEH7u6X8eMkWUG2bpTVydTuZlEA8kz5Kc4Wn8
X-Gm-Gg: AR+sD13HNnib3DG6tWsyn7E7z7Gr3F4RavapP1jjJfSUnoV9HQqg2qw5751Xsop9L4b
	Re+idCskw8kJnUSWYd5n0YnZNlSAyKLKVyFEEyJJ0t/ySdqD9UePEENpXTySQYqMZ2d4dxMGzXo
	zNg3waIi0X2aWcGKqzT4w8Kiq0vclh1paBSikINUzS503oCqs1asK5OAfqX6R1ElPOhv2naQytm
	605z4R08jDb6SMNjd9oIXiwqnIHPxiqRbEgCi7s3UCFWsneXdyhnTnXcUgfD4uLGZfwiveLCpy9
	axpoHoJkPfEf7h2bxA0Y94LXPC/17h8AYJY0V4S4pTUck+VK/Lxf6+Sz0KGeOyl4yxEgjb8BTdZ
	JMRRskf0I5cDlYiUz6vM7lIWMb/PAT/2cYoJAsvYYOAENNDH4rUb/WVQ7d4FV7Kv/3S7kbPwCUt
	lPPWPiHMnuhaQ7mukZzdx8GnEVrH5FUDlA4XeFrGc59Rq9M9btMix0rU9nwVBw+uQgLjFm48sY7
	k3UY+Yd
X-Received: by 2002:a05:600c:840f:b0:497:ff73:68d5 with SMTP id 5b1f17b1804b1-4980c6071c5mr157379795e9.0.1785735601424;
        Sun, 02 Aug 2026 22:40:01 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807bad893sm164022325e9.3.2026.08.02.22.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:39:59 -0700 (PDT)
From: Aaron Ma <mapengyu@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: quirks: Add ALWAYS_POLL quirk for Beitong BTP-KP20D dongle
Date: Mon,  3 Aug 2026 13:39:32 +0800
Message-ID: <20260803053932.5897-1-mapengyu@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BTP-KP20D dongle in Direct/HID mode (20dd:5159) re-enumerates every
few seconds because usbhid never submits its interrupt-IN URB: no HID
driver binds to the vendor-specific report descriptor, so the device is
never opened, and the firmware treats the idle endpoint as a lost link.

Add HID_QUIRK_ALWAYS_POLL to keep the interrupt-IN URB submitted from
probe time.

Signed-off-by: Aaron Ma <mapengyu@gmail.com>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaacd..2bb4952d0b0c1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -263,6 +263,9 @@
 #define USB_VENDOR_ID_BAANTO		0x2453
 #define USB_DEVICE_ID_BAANTO_MT_190W2	0x0100
 
+#define USB_VENDOR_ID_BEITONG		0x20dd
+#define USB_DEVICE_ID_BEITONG_KP20D	0x5159
+
 #define USB_VENDOR_ID_BELKIN		0x050d
 #define USB_DEVICE_ID_FLIP_KVM		0x3201
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 57d8efdd9b890..63283eb853f0f 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -45,6 +45,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS682), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS692), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_BEITONG, USB_DEVICE_ID_BEITONG_KP20D), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE2), HID_QUIRK_ALWAYS_POLL },
-- 
2.53.0

