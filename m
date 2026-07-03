Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A53D45F8
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090069; cv=none; b=Zn634T5JIcd9n74kC55Py3WH+s7BHZwwWdnJ8gNbWPtH91jrbqqljBnZSrrAk7IMR166deidzlpjlJTvXUuoPIkRLklV9CL3gEVIe/rmPxOT+l60rnCLZRHTjp23JvxuEzOyY2cjHDOgwQSO9WYVV5pfK30YvH9oTCktHsmFmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090069; c=relaxed/simple;
	bh=Pr/t5CKKqjZ2u7bSEGWUEE5BqBi2ctCZoxC/EVseXfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mncyPhUrVbQWeNcYRyLW2d7rQIYieE0VH7cojRavjffQk80VD37QwYkEZRSA0QUmr4OicBSm1rfSbjTkB4nIih1mzJErM9LxoYu//P0L63l1Gb+Z7o4/wyliX76NNm37ar7nacp8AFR4qzQD+oIZOoSxZzR5eqdV6rHRG5+TQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirque.corp-partner.google.com; spf=pass smtp.mailfrom=cirque.corp-partner.google.com; dkim=pass (2048-bit key) header.d=cirque-corp-partner-google-com.20251104.gappssmtp.com header.i=@cirque-corp-partner-google-com.20251104.gappssmtp.com header.b=xY2LmFzD; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirque.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirque.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirque-corp-partner-google-com.20251104.gappssmtp.com header.i=@cirque-corp-partner-google-com.20251104.gappssmtp.com header.b="xY2LmFzD"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2c9e8da469fso3261085ad.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cirque-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1783090066; x=1783694866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zewTOSj27HCMVvbGtl/CSvKs//H0h0bxW8ITTMyrog=;
        b=xY2LmFzDHJ2t182ud4ZT0B8SIMPv+yTs81YpO8ei6q3JKLgoRMdHqbVarGtM0pB+OB
         BXezjHj4F77bT30m8K/FWMRw2rPHjuHwHyuDGB7AMx6LcIQQD6v51i103AUZNroIoSxz
         ErgIS0ljVWhSNVs5ClhQxeRYuZouJDK453M5VCwV/1B22qZ7dwA1FnTRdF+YeVrLJkBd
         dF2qSiECNodnrHLiFQuQjXjsGYjqEl3NuXlNT93OMJTwLOLEdIFecuVZRMmzK4KHPOjO
         RDWEnVY6ngIf1OorLaDAjYHNFs/d5ixerXkc994gZciIdfi+NhiNpCFkhsXdNI4JH6gn
         VpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783090066; x=1783694866;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4zewTOSj27HCMVvbGtl/CSvKs//H0h0bxW8ITTMyrog=;
        b=X4isfXMc0MNJuA1BIqwb0kN44LE5dBEjZ0hZJ3Y1Hu0wiZaezsTFAQmtvzMhqwvPLZ
         aHyImn75vDQntpybledBgh4hkQ6q9hLeApBpFIGC0JLhOs/dQlISb2/+1xzyIv79x7cw
         dvsHic4GjpwfD87BIkuQth4kjLHTtT84HiO/5eODCwcVQVW/Mncr/x6iMQyv/TL01WN2
         wN6zPStOIzFtdeQgjPo6JiFziTpwRfpAt6+pfPPDmEEB3jBGjhSeCwxwmYRMDqDR4Gz6
         c7JK3IDCEWmKPd92gRR/6BVz7Ye4bsLFi7SesIOArWRMJYrNE69TXXEnFbEDFo7f97nr
         65Ww==
X-Gm-Message-State: AOJu0YxNDvojOe4kyei2JDy/5XmPWXerPv/5j6s975dr70Pk0YPkJa/I
	ytInvTcSXIco6CxiUx88Xxcmb/WKl8RzObjbTAgCJXaWowqdwKE5KOEcpauYDPsm3Uw=
X-Gm-Gg: AfdE7ck2os0QUNUxkGivlBtdYupYaJvueG3gOIkm8E+6OQPreGK+Rb07YyjASlKGu7W
	QrIQ05tr9yhjehz/6U66lSgVdROr2SuYYScOSDSx6um/Sm9JEhok9cUgWpnqFx0Pq8KAIVsdT4D
	/rn1t3ZhknCS7yY+uklr6BVFrMgPgLU8pZ5EDaQ4/qYq4WMpO6xIAS40HmW/7kRDbQwXKUQvjei
	T31eh6DPibdsFaHIEy2v/zk4149MqP9PsCKO1tPLDtl1Vj5kHfpaSlcZhIE4dIrQAL16JhLw7/E
	MrYz9JXowBPqT3OMdA5ro1miAp1S1RXr1JfYPGmdKAexN99BTUKkVnV0saa8XsNvPfk3k53KrQq
	kneOng2yGsDESUjVtyutZNZagoYrpAWo1jaIL2amW0vBl5r2tz9m5Wu8F0gB2KM8rSBTzf+/uf9
	HG0YZ9nuJ7lA==
X-Received: by 2002:a17:902:ef48:b0:2c2:62ee:5a0d with SMTP id d9443c01a7336-2ca9114e600mr104007235ad.14.1783090066112;
        Fri, 03 Jul 2026 07:47:46 -0700 (PDT)
Received: from Armorhide.. ([2601:680:ce01:1ab0:8a12:eaca:af3b:aa7d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa65asm21610833c88.6.2026.07.03.07.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:47:45 -0700 (PDT)
From: Vadim Klishko <vadim@cirque.corp-partner.google.com>
X-Google-Original-From: Vadim Klishko <vadim@cirque.com>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vadim Klishko <vadim@cirque.com>
Subject: [PATCH] Add a quirk for a Cirque I2C device.
Date: Fri,  3 Jul 2026 08:47:26 -0600
Message-Id: <20260703144726.14808-1-vadim@cirque.com>
X-Mailer: git-send-email 2.34.1
Reply-To: vadim@cirque.com
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cirque touchpads with PID D0C1 generate an error when probed
by the I2C HID driver, resulting in no hidraw device created.

Signed-off-by: Vadim Klishko <vadim@cirque.com>
---
 drivers/hid/hid-ids.h              | 1 +
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaac..496589277bd5 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -334,6 +334,7 @@
 
 #define I2C_VENDOR_ID_CIRQUE           0x0488
 #define I2C_PRODUCT_ID_CIRQUE_1063     0x1063
+#define I2C_PRODUCT_ID_CIRQUE_D0C1     0xD0C1
 
 #define USB_VENDOR_ID_CJTOUCH		0x24b8
 #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020	0x0020
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 3adb16366e93..63004bcbfa71 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -136,6 +136,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_BAD_INPUT_SIZE },
 	{ I2C_VENDOR_ID_CIRQUE, I2C_PRODUCT_ID_CIRQUE_1063,
 		I2C_HID_QUIRK_NO_SLEEP_ON_SUSPEND },
+	{ I2C_VENDOR_ID_CIRQUE, I2C_PRODUCT_ID_CIRQUE_D0C1,
+		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
 	/*
 	 * Without additional power on command, at least some QTEC devices send garbage
 	 */
-- 
2.34.1

