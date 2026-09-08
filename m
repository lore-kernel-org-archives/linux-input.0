Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F852BE39
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866316; cv=none; b=d4CvGVQou+R2Nqw+/lguyV0vz3Z42fADW1DDjashSTaKoWrNm1mcY0QzIpFymBVW5IMVb9Umbektjz7SgyKaZNdjRsM3X735gKt98LhGg1aD5S2RQmkyBoAQtf38KisQWIy9rJ5k78JztAEojR7ceu3D641mzLPsYaMMvfnKnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866316; c=relaxed/simple;
	bh=fIz/HrFxATsMpc2EUMqMUXZP+raGKK9br1Gr+ook9Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAlf3GzNzpkmjMDAur1S6I6hOxOtTWt73cMd10ZlVB6eA/UGMCrySpjg1EWfFxNU19zuiHHikn4P+Ev6w2CPIQaJtdl8VqY31UK63zCkOEgmX5oTKxqreIDTYDmcv5SrCux5lMeut3HPYGnDMczFYn96bUeAJP38Oa3bbkm5N0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcpMFY3n; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcpMFY3n"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-484374f54d0so2871926f8f.3
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 04:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788866306; x=1789471106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=97Pr2TsyamP85AaCa0QMFuoJcjdpS6Zemfk+b51bDo8=;
        b=FcpMFY3n5d5vhf3uGf7u2FLZkjp38xHhS+tNl+BF1w8pkWrEVehjA2MYDXYJsdAOxh
         cYr4D/SWqQrEzSPepk8V85l0Xe78K0TteLZBTXX5PDTQ+69+WnIOmmkGSGegxKzch5xk
         B96e7Jzr/++ojF3GAFDXpZl8fAHmjE0SQMJwTUFxhaRc5WeIdXFfXb9mC1YUNP7QsL2I
         OUp1a75iaNciA1csrLmsO2rfOc1gwZoJ6OLOH8sK7BmyEMGCg8fm2GEBHXNErgOAo2BR
         GCBGmnW/Cw2YOLNsLAYHlEr+f8yXuhhPU+2VOjoESveOpWRQsVlFQF76b6yNS1Q5kGMZ
         mCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788866306; x=1789471106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=97Pr2TsyamP85AaCa0QMFuoJcjdpS6Zemfk+b51bDo8=;
        b=TK4OtTv9MYeLoXGjOfM0+vv3uoWtgcr31L8nk78uRTCKG/YSAmqqdr3nbMqjNGkALh
         6t+ZHxbCK96YE3iiZRkqosZaBdpdMJjcFI3VXTjeXeCAXYCxvGfdehbbgKR+EHLW2A9F
         sXRrQvLaIDuCZyACQTe4Yh6YSma1RymFP6GhI03caZy0Fi2aIRknQ23B7MNIb/u5tb3a
         08+Ov/vNbq7nJgUF8nWQduUUbe9Xq+BHecUeJ4BzOrlfc0cLtXm10xJbTLInm9l7al88
         a53l6taHhOYPfhicL/mp8Y/emBuxvz3/Lu1Fm5vXGd+8kTqXAhSR3qvhkUrSXyTmik0M
         ECIg==
X-Gm-Message-State: AFuF++nOV1BxcfJHUtGfO4xBNx1xb+753xdfo5ryBR0nSDv5kNDFg7LS
	aWzgBdHOTEplBoIHTcVfkuiOZCZjSiDbCRWpJesU8dlba6U8eB7Jcy42
X-Gm-Gg: AYBFou1IHw0ItDCDT4rqRXTDcbfPw7cNBDT7VJWpVSBXn6BJ2jvo+CbbCEEZeMLJTbc
	iac2mZ8p5iCnfqzoRcAk5DiorlM6q3RgkbRkEe/9PpnM6wS8GWj+iT06jikxdn7sB5iZwoNkT/Z
	6Ex+fAdY7H/Ysu68M9VHfnbKImynnnkm8E8XMP8VpFtnpegow5+f5fRPRQTdw4vjdehOIWAlzn8
	F9Dz5aMm9Sh+d0fZ6hZ6SY2bUTEWIWEgrWgoiN2g6ixbBda1V72/MvJJYFvSs8UcK5bHlY+jIab
	w85NaSHNfZZ40QQ6pfDBH50ByKCWzW1tWAJrLACfIbdBV8MGchgzuc5e5/bLZ3SyrQJZe/r5L67
	OT99npvanqA3zI2DwCji6YqFiFgHcQ/41UnFPgdCl7zYl0BTUh3dMCn9wCU/moW1Gvm1K2X68ZM
	3v681PBnIJANBNvphQFsBxSbioa5T6vVVPrDTc0qf1UqrD+QkU6nY4jFn85ng+QmnY5AyQmsZ/h
	cDYLSGSyWxny1iQvwBTVkPjCImRfIH7CzKI6vbgqSMR
X-Received: by 2002:a05:6000:707:b0:485:8542:fee3 with SMTP id ffacd0b85a97d-4858708cab5mr62827597f8f.16.1788866305735;
        Tue, 08 Sep 2026 04:18:25 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm34422099f8f.3.2026.09.08.04.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:18:25 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] HID: i2c-hid: add reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard
Date: Tue,  8 Sep 2026 13:18:11 +0200
Message-ID: <20260908111812.43837-2-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908111812.43837-1-okerixx@gmail.com>
References: <20260908111812.43837-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ITE controller behind the keyboard of the Lenovo Yoga Slim 7x Gen 11
(048d:83db) carries out a reset but never raises the interrupt that
acknowledges it. i2c_hid_finish_hwreset() therefore waits out its full
one second timeout and logs "device did not ack reset within 1000 ms" on
every probe and every resume, before the keyboard comes up regardless.

Set I2C_HID_QUIRK_NO_IRQ_AFTER_RESET for it, as is already done for
several other ITE parts, so the reset is followed by a fixed 100 ms sleep
instead.

Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 drivers/hid/hid-ids.h              | 1 +
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b3aca5aa9176..2e9d0fc41ed0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -765,6 +765,7 @@
 #define I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720	0x837a
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA900	0x8396
 #define I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD	0x8987
+#define I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD	0x83db
 #define USB_DEVICE_ID_ITE8595		0x8595
 #define USB_DEVICE_ID_ITE_MEDION_E1239T	0xce50
 
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 0ff07fdab442..ad8d9f329404 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -126,6 +126,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
 	{ I2C_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_VOYO_WINPAD_A15,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
+	{ USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD,
+		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
 	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_3118,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
 	{ USB_VENDOR_ID_ALPS_JP, HID_ANY_ID,
-- 
2.55.0

