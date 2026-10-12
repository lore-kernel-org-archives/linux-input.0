Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D9494834
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817448; cv=none; b=VV53XPjpX1o3zb6T9n19TbsFsxncm3e0IuSjHq25xEo7qpaOl2UZpo97sE9Jc+iwvQogM+EfHpw/n4YFgDtH8XEMNOoaCn6WkosgERJL9bePJ0sqZGxWQwFO/X8EJBUKmaUTZq0fMGXFABJXJaKEKjp++W/xKCfKA0KD2xbeNCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817448; c=relaxed/simple;
	bh=H9V8PNkfJ5sW8/jSQUrOuBSl7Cz74i70YCcDktWR95I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1iTBVm6Ur5pN03m1M1Un4LbMKDu/YKe2jTcPFrg0E5ne8BWFDaUZgZKsffZjCGqo+BDlE2BzTxedInONwKuT48MWUgxprfIYZ1tTu+qqIRMtCtTzst7wONEkFZBtzOLXdCJD7Ke5IHLqjXxkymeJyP+mtOmr2TE8mfuLNxXlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtDQ8gBs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtDQ8gBs"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso2588750f8f.0
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817446; x=1792422246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h/nvV2cklHSmRo+LXEn+M2vsUBu+RuTvY4bWwWcFK2s=;
        b=GtDQ8gBsJ9gD9Re77yG6s3DvyZgNclTzIa6ItH9WeA9o9ZcDq6vfkQC8/oyW9Kefjp
         rKJgSf1T8bd6zFvorCZd0NOgalkyDCwm6LWu/m45y/sWtDlZ4jUrpYaoZTXxxobQ+qog
         n+pOYUheJZCTzrRpVuBuQ5h2B8ZzAWczpqns7hJbO/HM1tPsFd1+XXkZlC+SEBpFXCWk
         1GpFog40Q3hInVzpZj31jhnuzKtaWRnyyFvTvooe5256pg0qw3a808MAEdfN7N8DYeoi
         MGCBphO2+lCvg4vv6yfxsvrKGIkvV8IlGep1oLyiDnulXVRF6AZyrqg3OqieXIf+P3Be
         c+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817446; x=1792422246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h/nvV2cklHSmRo+LXEn+M2vsUBu+RuTvY4bWwWcFK2s=;
        b=z/hkTZoWkqOVWQGHkQ+vJkVSVKOoOjK/fYwW+I3lvnGaqd3ptSx4KtaOjBcc0fJv0I
         p8DMR5FQsGTGiNKr16/4MGni/Kix+WjueAmljroLnxohYSRbDMqnWqT1UiC8SytXcU8w
         c06FEdb0HJiB58mNpwbm8kZ9Abps/iPnio5EsKbOcJPX2nWZ5ZaRsVAHnOockqzXBn/p
         I8k5ycl65+a17IB4lSmm8Sof2Q96Vy878lAFtfhMe3UosmQRa3mKmjFA+oKyS1UZjKfl
         OeyvroBgL8RhNYbeDgTf1meY5yllzj0eThaYsWftXWAeBiF/uAo/crRwOlM+Dw7PEf7l
         jC8w==
X-Gm-Message-State: AFq9FYLjRpQrFe/Tvy8SR+NRnvsWrStIYHfl4z6fCYED8Ph+v3J92M2C
	35l1lBB6TNtGnhaR3AnRtOsHabwrarWEgk0wdAfUFBw315hflxKbkSGO
X-Gm-Gg: AYBFou111bd/KkAdgVcBOOx0pe3cKkWnHS1VcnsrBXH/LG/UBKM5TtboT8cw9NZPzPS
	CR4z3xrA+JoSFCbfY6ZU8iGhwxvuynay/IqkIM8RYtlM2Qtfh6T3hNMYwaLv1WIivOg9u3inUIA
	esu4uYaoKKt36+q5RuKJ6tY5S3gzS0LXE1eag5g18j1V5WlKVE54CgZrE1TyPubz51LIFwEanpi
	keK2zg3XEDEVjGtrCsTwLb4MiFY45sTpBoABsE0IVpro2cC5j0XNiJtKeBxEAEPjohmunSA7ugL
	PDpsP6QHrRRDgTvVhFh0CWzftdI1HB1ltNE+OobV8yZTufDr5Jww0m5s3rFXe9C6FuVeimAAv+F
	xMz/YXEa9cZom8J2snetpUbpxWabTc1w2j6qPrvFug3y1iAXPxKGRxQRepHB2SPX8HqHSwXRyOH
	5gXMRyH1ap5gFuN70cr6nyPrfO8O9H6xusJdNbCar2GwB5huZsRNHKHEesZUDIz1um7ihuHHcYc
	OWOzVbC6qwfEdj3pvmOGXVJjRYk2nN+F3Mu4VvO
X-Received: by 2002:a05:600c:8b02:b0:4a1:6d2d:d8bb with SMTP id 5b1f17b1804b1-4a18e4a00dfmr199483155e9.12.1791817445597;
        Mon, 12 Oct 2026 08:04:05 -0700 (PDT)
Received: from omarchy-pc.home ([2a02:1210:1420:2d00:f162:21b0:b215:be1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c198134sm294214765e9.15.2026.10.12.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:04:03 -0700 (PDT)
From: Gabor Tanz <gabor.tanz@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: quirks: Always poll the Anne Pro 2 with product ID a292
Date: Mon, 12 Oct 2026 17:03:57 +0200
Message-ID: <20261012150357.685671-1-gabor.tanz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wired Anne Pro 2 identifying as 04d9:a292 stops delivering keyboard
input after a period of inactivity. Unplugging and reconnecting the
keyboard restores input.

Keeping ObinsKit running prevents the problem. A read-only userspace
reader that keeps USB HID interface 1 open also prevents it, as does
usbhid.quirks=0x04d9:0xa292:0x00000400 without either application running.

Commit ca28aff0e1dc ("HID: quirks: Always poll Obins Anne Pro 2
keyboard") added HID_QUIRK_ALWAYS_POLL for product ID a293.
The variant identifying as 04d9:a292 exhibits the same symptom.
Apply the quirk to this product ID as well.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gabor Tanz <gabor.tanz@gmail.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index cb7f16d75..3b19b742d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -747,6 +747,7 @@
 #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081	0xa081
 #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2	0xa0c2
 #define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096	0xa096
+#define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A292	0xa292
 #define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A293	0xa293
 
 #define USB_VENDOR_ID_IMATION		0x0718
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 96a36c5ba..d15a587f1 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -102,6 +102,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A292), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A293), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A), HID_QUIRK_MULTI_INPUT },

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.55.0

