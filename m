Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096933939B3
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212280; cv=none; b=Dfm4Qo0dsFz3jIwTUaaGU7a3yxbCIMblCdLi5l9fQTJQqTlreroEoqqpwZe7eTrjWxw/mEW8pP0GpcJUPTIHCmsFNqt18AZvhh+dToZ3K0GG0NKjPBnCRCZ0/6a7Am6UkOMDTk1qSlgoYD0YXvVxgydpSiNlI/zg4QnGAZ6Gfog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212280; c=relaxed/simple;
	bh=R9blW7WU+/KPJy2Kw6RAoVOj6pvSxTERJYTY2MhFFwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IQJ3kY72oz6/qJrNBYPtn2zmu6NwvKeXJQiMfYHMk6TjGlZA9W0I0w6UaFl50LibXR69T9NUmxaPT2XlXtD05cAOp+N3khfF+4MdLTGvRns6Y3q9DgJzxuD25EXAaB1etddrNdiL9OuyQXjYOxg0gVtqzaINgpQwCRgzBE/1vaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirque.corp-partner.google.com; spf=pass smtp.mailfrom=cirque.corp-partner.google.com; dkim=pass (2048-bit key) header.d=cirque-corp-partner-google-com.20251104.gappssmtp.com header.i=@cirque-corp-partner-google-com.20251104.gappssmtp.com header.b=Ufba6maO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirque.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirque.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirque-corp-partner-google-com.20251104.gappssmtp.com header.i=@cirque-corp-partner-google-com.20251104.gappssmtp.com header.b="Ufba6maO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so38468405ad.0
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 21:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cirque-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1785212275; x=1785817075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yd9sQF9Oi6Er+YrvfB4CqNGV3pN/oiBL+0EmLj0srbg=;
        b=Ufba6maOfdEo215azTDwePbXjg40tC3owFVfKVZgEP1oJUOo6REfK3fml2simtfd3F
         Q4tUJHjSOBmBk5HM8opnIqw8bZQbgHBeXV0VKhGE4wRiUUCsoG244EA/uYkzTXrAgpc6
         UqPbaX189hXEXW5SohCdb6ofb2Qfe4aJLTba0UanVzpqtEUeQeNQhjsUWY1sm8+C3guf
         DttxmXfILNK4IzfDv1hLjuSJrFWNfKsVWOD8YQtdGJotwrhc1aZU3F9AtuKpUsJMuhuB
         QxTQ1fJgfGAXcavy53WxicuKY0ynCg0jrMD26+ZHLAYKHE7LklmCVt4Kk3932iBo1FbZ
         VWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785212275; x=1785817075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yd9sQF9Oi6Er+YrvfB4CqNGV3pN/oiBL+0EmLj0srbg=;
        b=hWkg4WM53vdGdIzBF1XanyyLyCHYPxJlJsGi4onhTiLwmTF0Vp3xZFExCwr9XoRS+Q
         0iUt0Kc9yvCjhorrWCrspyDGHejdvWl/kwaKKZMXBUP6j1M4K5iY9j26NkDkClOtuu+p
         DUsiUI6jeBhYjJnc/1kAqwC/8Q7HTgsP0IOLdyIrSVUIC7Sf5JRhnyIfVpOtOY3V4iaA
         28ys4SgM/v6KtKrPQp/uU9qztGVWyoaJbxulpaM0jL1aMbB0KH/lkpoCGEPP6+SvaHlW
         K5dGg5BQIj7r8CcAuPyEa4FK674v/p7HSanJIKw/IGSBXayT8ODwkIvj+S71Nctfx0ee
         f1ig==
X-Forwarded-Encrypted: i=1; AHgh+RqwrwNrgt2ZtrUqCZ65nJXgOBYRX5L7fzeBABFAwi1xTj36R766ZRY8erciNaTs07v4QBd4A9jrTUtZrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5XM9iueoZqGZljiDQqr1sQyV7eSTUefZBoXPBxv3cCbUBExT
	n/S9s35/MlxtItuDk+Ja1iYTjXVRUXkaDBgDMILPlj6vbxuHPsFIlbBD30s52BlLwds=
X-Gm-Gg: AR+sD11EKM0tzZrgGlKtW8UnNcYYHATvzZhQJygD2CHOPpcRU0gx6k/dn+U1TTIJQ5b
	ax/WIprNnK4TM0gFFV4J+QMzbIVNoxW3RWnOZLHcqIP7GZ4XpNA1RcmAXEIL63Yajk0tmVWkln5
	jKWhMQN0f6YVmUGsnAX/DOZrHf/ZoPbx8f7puXbykUZZG4TaUDVffzxUW0P/ZpCHUXuDDU4jduJ
	hSs00WCTVYhtvV/hmDescT3KPuOuYh1dOVuyP4ROctMc4klJQ/dYGq0Z+JwJ8NSqx8BT2tw5H3m
	1Wg5Pt+nbePnrcr77f/2+HPvYUHvqv9rDbw7hUjXaKtZrDEug1MEXuk/h/Qo3+GEtxXfMJPdm3K
	Y+MPo60a7Om3wvXE+e6ERvJFIMj0PHtRs/Mgrmb00UcqooeJXvNwoLtZFKe4e5Nnt+2veKrcrBA
	==
X-Received: by 2002:a05:6a20:258f:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3c8ab0e60abmr828309637.27.1785212275411;
        Mon, 27 Jul 2026 21:17:55 -0700 (PDT)
Received: from Armorhide.. ([2601:680:ce01:1ab0:20a8:986b:7e0:ab39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a8421sm55676149c88.10.2026.07.27.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 21:17:54 -0700 (PDT)
From: Vadim Klishko <vadim@cirque.corp-partner.google.com>
X-Google-Original-From: Vadim Klishko <vadim@cirque.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vadim Klishko <vadim@cirque.com>
Subject: [PATCH v3] HID: i2c-hid: Add a quirk for a Cirque I2C device.
Date: Mon, 27 Jul 2026 22:17:18 -0600
Message-Id: <20260728041718.32954-1-vadim@cirque.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cirque touchpads with PID D0C1 generate an error when probed
by the I2C HID driver, resulting in no hidraw device created.
Adding I2C_HID_QUIRK_NO_IRQ_AFTER_RESET fixes the issue.

Signed-off-by: Vadim Klishko <vadim@cirque.com>
---
v3: Resending as a standalone thread to fix a Patchwork issue. No code changes.
v2: https://lore.kernel.org/all/20260708003108.20288-1-vadim@cirque.com/
v1: https://lore.kernel.org/all/20260703144726.14808-1-vadim@cirque.com/

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

