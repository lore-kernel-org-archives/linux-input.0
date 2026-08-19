Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B94322FE
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130943; cv=none; b=G9lUxZYZkRJbuBRj2S8t4UoZxEB3STBa3nhKh/zCd3ZBRnZPamDXQQcBHX+94kiL0sFcx+o8CtIRGGx034efo/+djtXUq5G6c0wVLNeyMOnhKTSMOCYB6WYYnmU81Vyut67VwRCpXQwc4kMPiF+2YumFn+yoKcgjYa/pgsbAqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130943; c=relaxed/simple;
	bh=wS3D8ghMmA94kYYSDtV7f0pXQ4ZjEA3o+UOLBWEKbcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzxdCmqiy61s4+g7Gnph/w2H0F2d0GCotkNOa29pHqPxIRnmy5lRT7J/i3O6gtleu6ePYPWcjRFJppEBVgXTL8tnP8feptXokHRlfj9Ep6lGJtRkfxO/zbReV6iOO2bNFpcbhlbYnJc0m6IWCdvEmTx/EJ6migdKY9pm/kABzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCrUkexP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCrUkexP"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47fecbb7000so385654f8f.2
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787130923; x=1787735723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/f3fLLRk/UB8YUt2TyxZgsai0W+sJze6V6Gv0jqwYM=;
        b=YCrUkexPPqDgBx80YHsivYV5T1vHj6Gv4sNpYcLW8yWLFUSCTfokNaJuINcix5t/Tn
         jeHoY7GUFUaPVMgi7QTR18+Jqbo9V1m/lmGPs1JdXi2k11WI/PvpL6Uw2XnvxDl5ImoV
         c7BTdjfClx5pV9CI1dvbhKSTCQrhdFKbj2YxMwJcRLaSujhEE+AblPRFw2tL7WCRRD5B
         M+5Yv78gZgFLxKLjkjCBLyTtNeMfnudmRk76Bx9OdIjQZGHEAJnzEB9/P7BtWvjhZY40
         cQGxBab4sUvlPLTdzz/FWAjLhqpJvimRUEEKMKXWUaeEGtdbvp0uMeN0L2MdnnObEmCH
         yktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787130923; x=1787735723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/f3fLLRk/UB8YUt2TyxZgsai0W+sJze6V6Gv0jqwYM=;
        b=ijL+LjnFjwK/mIEa0+/Z5OV4M0YIT/O/JD6o/6jyDunR8opxUhzNzk81A+/aYTgNS9
         sA9D9M7dtmrMyCF80RREw+2u/7MjMZY/Jca8lFozGQfjuxQrkW/4eww05u5vWGpJNNre
         HfajhY3n52Nvn6IKiCFXSck8KK5CiIAlnFHsymB8Muxt+sdQ9W0GZSCxE6YmvMLv2iKl
         NaiQmhKZ8rSXkNBqrJfZ6fTaBBr4zygX89ICo+Iyp31FQaOggwsx36uUtjC4Z3eqWsbW
         JgxfxTVQfoYmED0HwBIA83vYk9HtWhMT0EzpR1UbikYVuObZpFiT5pXLDsw/NE1e8euq
         iSfQ==
X-Gm-Message-State: AOJu0YzNo0N4aWviY2g+ZEAFTwTW5a38+TKUV2mvPCh5lbx282Pue/4U
	Zknf0TFZfFphu/BqIWsmFPhVhajNLEh2mjXuJYEKA4sNiwMY4+jGrmEw
X-Gm-Gg: AR+sD13oRh2Vq69mJ3TVcX4LKAqzOZeUHK9yMQE5C5Gx9jQgFjCJ6VgT6EWbooTCeLh
	39K2AYkbrvx+TjllVFyOL4179LJsXr6JrBj1Kl/W43P9pdk48w2Ihke4x/FcoJ8FujsI9mquG5z
	mz9p+hvWv0xUCraSDtqLHrhz+z7gquQIy/DnWEgLD+E7A5tqGfSa06oG77OPiKDsNj4PLBuqmd/
	eFyYDW3GPeqFu5EF9KIyMhoa7kF5UyT1P1toJVnm2UtzE0WX3GrrN+AbIvO0pWAJpWqohWgV7XW
	AMiySjpPwy59nUqs1JlRKGrBhK/Q6rmEDhCqVa8WPmgiP9DSIBmUa4PrVzPWctVZjtRbfiuaJsx
	XkGGTta/TZYtmYgP2ypQienXQ7RXyyffm5TTGwFHHGhnWuU1zoc4l0YVXzrIJkPnmIHtQGpNCNG
	YsNR4tSvaVO58wlhp0Vfc+B4bjCIK0iQ+y21TbMtFISJs60MsIbud09Q==
X-Received: by 2002:a05:6000:41e9:b0:481:57ef:9221 with SMTP id ffacd0b85a97d-482b1fee9ffmr5558589f8f.22.1787130923243;
        Wed, 19 Aug 2026 02:15:23 -0700 (PDT)
Received: from DESKTOP-25PDM0G ([2a09:bac1:1e20:8::3a3:5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm3825358f8f.26.2026.08.19.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 02:15:22 -0700 (PDT)
From: Ruzal Daminov <daminovruzal7@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruzal Daminov <daminovruzal7@gmail.com>
Subject: [PATCH v2] HID: multitouch: add support for Goodix GXTP7863 touchpad
Date: Wed, 19 Aug 2026 12:15:15 +0300
Message-ID: <20260819091515.332-1-daminovruzal7@gmail.com>
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
device to mt_devices[] with MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU so
hid-multitouch claims the touchpad, eliminating the phantom input node.

Tested on Honor MagicBook X14 Plus (FMI-76, AMD Ryzen 8845HS).

Signed-off-by: Ruzal Daminov <daminovruzal7@gmail.com>
---
v1 -> v2:
 - Move entry to alphabetical order in the Goodix section.
 - Declare I2C_DEVICE_ID_GOODIX_01E0 in hid-ids.h instead of hardcoding.
 - Use MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU matching sibling GT7868Q devices.

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
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
+	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
+		     I2C_DEVICE_ID_GOODIX_01E0) },
+
 	/* Goodix GT7868Q devices */
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
 	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
-- 
2.45.2
