Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79D5293E0
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859181; cv=none; b=eCM7SlJANkFr5//1LUpkVhMmDXgKtX2LrHnFICEkVnQ98z8dKKNTCKXpC0FLCDu/pzHdUbP0A/xQGoxuOA3STCF/ihNAS1tBuJn2O8ifDyrXMR5ojGEySKwUdKE2q+v8L0CqbeZJ4D9xPoCkkpnB/LS8Z1dnXrvC8iNrxezSdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859181; c=relaxed/simple;
	bh=heTE+AXphS60cWUC6FOFG7hyAUshpcINZu9nRa/71mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aApnSYw0XoAN9s2/dj/PqwEosRscTjYV6R1pnn42fQJutW889zRFBApzlzzJlbDaR3JmNIzU/GVk9lT4Ulr7ugpt6cn6GcdWJSbhXES1kh4eABHlkrgW5F/HXup6TKtWlNCj/mEcieXcE12dq5enukgsB8GJCA52E+2Rfc/v7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkbRzfz4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkbRzfz4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4843f205a5bso2646481f8f.1
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788859178; x=1789463978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L31na+RhIpfJ96Fuxsfu8L8TgoTwtkWhyGWhs8Vz64g=;
        b=KkbRzfz4BlTpqdfDKAeRBNMkt8SV9ka88hD5AIHs1GxcuB1GSHjEegixEKHU0VFdFp
         Cc7RIXFZGPRmsMkTcEfuP4Id4dtPrmFqVdl+cg1xjS3fYQOj02+9UTv1gvIR7eYZ6QCb
         TEZvsvs6jHi57+hnr4Ua4rJJu8EazLQY5OXQCH79MKk/27WSF3yM2RAMXxQ0mxPmCWBs
         SkgrekoKqBxYOkO+lLRVp57Xkwsj9wQYQ0+vjWJpnjGp0ivjxsWWBC5K62xmJBz12qal
         RN23i8PXvMq6SFIvoJ0eibm+9/6I1JRzFu5JSZprylYWHrsP6ToTc3ixbvWiWamMHXWg
         liFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859178; x=1789463978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L31na+RhIpfJ96Fuxsfu8L8TgoTwtkWhyGWhs8Vz64g=;
        b=GIHXVK/zauYII/3wYStRpHTLPbw9woBxCqhnBMW2WiISucNpUm4PJ6yffgsElILbhN
         l/47+/VSjmNXe9YWZPrqlsLPDEINOMcEYRSNuNwaTu0uGb/DQx7+wADXLkZmZxauunNc
         nkeXgq0RRCUj1EgmToTIPoWWFZNH4GA7jzrtfkF0fjzvPl7WjkO3yrZpyAMAx6QFilMI
         kTRsUnScMPlMNdbt6w/sLYZXHZ1eT0ykegHBravsOmH/ovR2tNRjO1dYRQpKnUFGWTQA
         +yInJonfDFWQQ8YD64q5M4IVuV2KXvucZRCfQLdHAEFHBjtEMuj5w+FEpzrMUar6m2DX
         HR4Q==
X-Gm-Message-State: AFuF++nH8UXrPN3leerpwHKLKClnCHqIHTKl5qY0HaZIiA4szqLTVXKG
	z9bwwnVYZqUBYwxUZjZBAKX1Asi0JL9g5T/9RZ8JhK5VcOfC7rsrsBcR
X-Gm-Gg: AYBFou0G30VSpAhGwoTNLeFIAxL7r8A0gDPQqwJ67RQV9eoUBWsRg6d2ypPT3RsEn9k
	gWDxr95OHQ3ZHjoJXAy84v4c3Fo0vfcmlo97azzfYTUVwwvGY85GunolW1WzUUfWzIi8v8Vn32n
	UYJJ+Vfc8Exvd71d60YJCx0nPOFU0Lf9dUCo3NKMYa94xIul/tFdn4cB4b+OLxsTlx2ll10rjzw
	z2ter6PHkVrHOit1TwKBjb05MVMLdAZU2LbaGkUp5AUd4Rkee7yAmGwfbtv5VMhL1rxzDMbLm61
	rE+Q/JWORDUJylguoAXpwhwW5JYTDO7m8h6VlxtS1p5lnDyevRwMZSwRLGnEHJID6Jt9EzvQ8Mh
	s/TbhTHNCnz1D2FBQldhJubD6FFInJvC2HUpRxAwTT4tDwX/sM+TsvvqWM3IZzeNLxyLLYbOVKb
	3kBpEWw1Y6SGLvOMh6JmeTd6NTMzExx8sGelW9sviIcAFqTHG9mDmjj8L8Hu90bv2oOiNsDH+ah
	jSnK3ZrPksffViHdai+rHb9/tZtD56Q
X-Received: by 2002:a05:6000:1ac8:b0:485:8926:531d with SMTP id ffacd0b85a97d-48589265336mr26148216f8f.4.1788859178335;
        Tue, 08 Sep 2026 02:19:38 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-485885bfe14sm35321836f8f.35.2026.09.08.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:19:37 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: i2c-hid: add reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard
Date: Tue,  8 Sep 2026 11:19:26 +0200
Message-ID: <20260908091926.5773-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
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

base-commit: 5e036ce12de91c6fd674dad33b169c6150be2a7a
