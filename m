Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85C2D12EE
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132395; cv=none; b=mwuqSe7dXIxR9+2JvAJbhgrAGDX2RbbJ3vr9Wpeu8h/HZSR457uc09CVlrFGfvvvgliQSwyr+p+aT2zR7FMo8HsviAfh73DBsvCv+NF92Ybkf/5c/ZCFDvA2BnDKiy9m/qRZRfifvOyNKJMmOiVq2Fse2bHY35MgNo5/JCDqZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132395; c=relaxed/simple;
	bh=hCqZ7RwFa/gPEvFeatcKnsvVinjTgoycW7sniKn31hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXZV7jDeKYvQRS9IrtWDyY0yaFZgMJQudrNbTJat09PNMATuQxa8bqKIluauSMmy8m3dNX352RaMrLHlKz9BU6uACAffBYTw9lfMm8CJxiPxp6Sc1ohPOvokSCCSfD3d+r/m7qhgEM0No0MCmwogmwrBvOrwRaF8vmeR2Ye1csw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6/i5hS8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6/i5hS8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso4863805e9.2
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787132388; x=1787737188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPcGv3CSquYpMoZ/72vtID6/1mp/Zp+LPk3DUuQ004U=;
        b=m6/i5hS8uPCiX3liIUURZ1kDD6A5vAVe9xZFWdGZKysHpYGKvee3DjlerbmZe3j9N6
         W8Zu2ik97rvJUjs7XIu7pc0P1VQkH/DCE2QzlVaxF96qRFyVh83FK3dXeDkIXzcvi4pH
         yN+uvjE8IPtGHMi2lQdwl4bzdfopJBak5+gkI3nyPqgWAOKLkRIruEVJodVJCKXHbItH
         rX0naIAgHqhnDEaKcT9ZDshiYJKA0jwmQ/93WrgocI8AViIZ3me4wv+/AfI7H4ouC4xr
         5+piS9Ef6UClyQ+kgFPiKndfXWJOws08wlCaASiSrd/t1yjbfbB/vSYCRWwSLHTpF3Nq
         Y2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787132388; x=1787737188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPcGv3CSquYpMoZ/72vtID6/1mp/Zp+LPk3DUuQ004U=;
        b=mHlEUq4j1EgtwhQfQH0vrrU9/swLW0fz5P9s3HFRPvpPOPILLB3e7fVarAhUD050RK
         7nCRo34It/JUXgT1vU+J1oDDHWBzb+848vnQtfQBcPr7MuBmhpHRYwZ5jISeqL2Q3ILJ
         jf8n1f+ZAgrzT6jVJqTqLYB/FyxKDcQ00HjiX+LVCx9yTgHMatMWJQbDkgNFZV7yWO/Q
         H2/0qY+1OpGzbjAq1Y3zo0uRycKaG/bQf81CVrnQeen4My4k18OTI33FljkMfdaxqrtl
         vJiOcBodUE3U+fuuk3NFFc97QzOzH1bsSIDLWOe35eYkzyYv6rnGra5b16aJB86ZId18
         IHfg==
X-Gm-Message-State: AOJu0Yz7q6/f70rwruhnBhnH1xZdPwytq/lKCUCw31+bObwz5LSbiW2V
	HMQFpkXo9Gcs3w/PbjwDgCYjgvBGC59EKKkLxVGgWb+krrOd/XApLISq
X-Gm-Gg: AR+sD12x2o1w8bZtCHIs3qf3kgq1tlWJTJzTubj/keWwUlY9pjlHOTuU5ZLKN6dBinw
	TX8OZQQInl58V6YydRP8ST3X/jCy786GFN4Y3eouzl+0emjN3+5U6+Inh9wF0XXgLIaEHqQplO1
	EjVTkRQjVs4hdIl7i9mkUJQ/OTBRfVM2L7QgacUHOSpNseShWA1/M5OJydatAKTAyQhROvWW8fd
	y8ZSTQvfIlbma91I/elwG3jhZLPEXVNs1mSMn1UwpmtpGuaD3QHGuzoN20N5+KEwat4LD++Cudm
	e7GR0b3WTAhtG5O8p2A1x2q01RTfSq9SfiGzah1+NI0JtthuE+Cl7c12UJ+ON5LZkTrpRID8A/p
	ttpG0bslWll6YKTDe09Jn++3oBDt0qwqJNUg9UqNgGaK1vYRTDoI9LR3KqY/t4Cv+PiGBltK57i
	7XsZNAEertmWRJ6YbinWWyHpubscv05Dq6NGHnZe0d/cEjtF+MmgHwHA==
X-Received: by 2002:a05:600c:4e8e:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-499aa17dd15mr52883605e9.2.1787132386261;
        Wed, 19 Aug 2026 02:39:46 -0700 (PDT)
Received: from DESKTOP-25PDM0G ([2a09:bac1:1e00:8::47:5ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9aa1594sm46161895e9.0.2026.08.19.02.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 02:39:45 -0700 (PDT)
From: Ruzal Daminov <daminovruzal7@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruzal Daminov <daminovruzal7@gmail.com>
Subject: [PATCH v3] HID: multitouch: add support for Goodix GXTP7863 touchpad
Date: Wed, 19 Aug 2026 12:39:38 +0300
Message-ID: <20260819093938.1387-1-daminovruzal7@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.4
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

Add the I2C_DEVICE_ID_GOODIX_01E0 definition to hid-ids.h and add the
device to mt_devices[] with MT_CLS_DEFAULT so hid-multitouch claims the
touchpad. Using MT_CLS_DEFAULT ensures export_all_inputs remains false
(unlike MT_CLS_WIN_8 classes), allowing mt_input_mapping() to ignore the
vendor telemetry collection (0xFF01) and eliminate the phantom input node.

Tested on Honor MagicBook X14 Plus (FMI-76, AMD Ryzen 8845HS).

Signed-off-by: Ruzal Daminov <daminovruzal7@gmail.com>
---
v2 -> v3:
 - Use MT_CLS_DEFAULT instead of MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU
   to ensure export_all_inputs remains false, allowing mt_input_mapping()
   to ignore the vendor telemetry collection (0xFF01) and eliminate
   the phantom input node.
v1 -> v2:
 - Move entry to alphabetical order in the Goodix section.
 - Declare I2C_DEVICE_ID_GOODIX_01E0 in hid-ids.h instead of hardcoding.

 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 5 +++++
 2 files changed, 6 insertions(+)

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
index edb37b4c867e4b..ca0b40e6b8a83d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2460,6 +2460,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_BT_DEVICE(USB_VENDOR_ID_FRUCTEL,
 			USB_DEVICE_ID_GAMETEL_MT_MODE) },
 
+	/* Goodix GXTP7863 Touchpad */
+	{ .driver_data = MT_CLS_DEFAULT,
+	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
+		     I2C_DEVICE_ID_GOODIX_01E0) },
+
 	/* Goodix GT7868Q devices */
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
 	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
-- 
2.45.2
