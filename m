Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91F35C6A0
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021870; cv=none; b=RO1+eBsOYsirVKMO+WEFAkVdPbRma4qJzOtT1WAAU3BiajZQ199xuYOVJe7AwHzlD3T2f5sLaQK94sLo97ZF10wiuFsb6TjC6XunH6OhjauRMaz9EExCY+xdQO6/FiobkaECeD8iBZWk98TXG7p93/6dS7L9Yi1IMOF4WiFUA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021870; c=relaxed/simple;
	bh=hSbGWgxms9tUx7FH0Igo364YaVZlpeP02syqsSCE4xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SctNF8FzL6ZK8blBhzCtryF54YgpjkWC3Ga+kHgNAyhxEe8gSfIejzPUHQ9tiwYpIxBxpm3Qb4X2GlE8kovusajEGkLAZLZdOyIkUKZIQm+bJB4ODevSa0PlL0yaojUzeTmP9aSd6OnHt8a2dE/abBm5ov1TJAPrxiYkHzIJgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idiQZHPK; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idiQZHPK"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so17502335e9.1
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789021867; x=1789626667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3OGjAjtaTT5B8pzy8Vb69ZAyXXEb6PoUWeD9vf/kWrQ=;
        b=idiQZHPKxIaJyYNusAMaifoIwaJdaHyt1/MoaFQhRIBDdCp6ZN9c2u1PBe4cl4+nvw
         jIGMf8XpuNpL/A/eFNHGjL0LsRFdb0LI40ZE79LoJdOiVb6WbODv1vv1LkUI2/sR+psO
         vwBfFuUYQyMxt2VJS1BQoDWFFXOtOdoofsEPqjHJWMP275fqMwW+4I4gBfwqT3rN7SBK
         nVDo0klc7u2htaFgQGO+LyvR7WHCXrDXuNX2V9b5sFMFYvI2SJElVS/J731UANC3hCaG
         Pl1hkUIk/0ktlei8OeaC8tQTSIqCh8ucKpde/qp7O/dd2FXpAcYLcI06DSMQrR7fLhiA
         PGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021867; x=1789626667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3OGjAjtaTT5B8pzy8Vb69ZAyXXEb6PoUWeD9vf/kWrQ=;
        b=PcFItLAy1/r6Rt2dLJp8aI62PhhxFMqQp0Ir+zfs7LbPUcuoUtJXuBhgk4GPVS0T45
         8NUnKToRKyUYBa3r27Q2hAhoHvCxFOWOdmrIYdVgeNzaFUmuEVn5mK0RtE5WlTOxeF8v
         8gNTa7haiVXVKrXqc87oXUef5fOcuAS5k/mb0MXxqIYaC6Tqw7VMwlqabcNnQZH/oidM
         PbecHmWpgfm01Ma2ZsDfct5VTep1Jbn+EtlVnJzb2C5iTMOHudZH4BgqoiclRZZaMZTh
         j5hP3A9QURRwkKLd77PG8Z99/aXG3Zepw67GsDJ8DU0nEs+U5xov9r7OIn1Go0bCig4k
         zegA==
X-Gm-Message-State: AFuF++lfyL0BQNUO3uWABW7I/UBsTDLqlZY8Pbkcy/sVQrjtOU5Eatig
	fWwkRxqSuS6p+GPwH71vHT6j0AAl2+CueQMM6jvwnHrWFfjTfASgEzivkVGcmsOhZ+7XPg==
X-Gm-Gg: AYBFou11Zu+r4OOkvVv70kRMYScR+OTuEsoQWz85CwHrbKR4N/F7Ayjp6y5Kc0pA5xs
	/ZLTxJLKcEOikHvv0DgNqtPkGw0W+U8hVBV3HzXRcRz5+Oi54PGv1J6CpdsIYXVFHwuMxqV4cZi
	yLt+HspLvJ8/Jm2NIzW0Bl2OKBv+QtOCh+CgxAOATdS3sxSIb5VguRigG99fVgdft4bEeooPbDo
	QUbAww1U4dLXZt7w2HeM7cskPJELJKThInVal7IzqEVXWmUVSTCdSgvBNeCuukHwdDxchhVLg55
	radVKyLujjdopKFcw8FM+Uu9gdtAVq7+uEqhKNxiL0DzoYmS84iuxI4AAIQKQVy3STWDyzzztFx
	bIAypkt5SURVtljnULeq+owST+KcSZ5+A5l4LZh4kSNSp0SsD7csr+hePMuNn76Yuj0Yu/EHs49
	NSf7fR26gHAezW2lrUTtBzGD0f1Oaeqj0QoB4mpDJzu2sVn+aSkG1frePorkJQSBKySOLMeY3LZ
	enu19Jg7zTDTGed9GQJBube+Zx+UxtvKjw5degFavc=
X-Received: by 2002:a05:600c:c4b8:b0:49c:f13e:e52 with SMTP id 5b1f17b1804b1-49d26dcbc5emr29168255e9.15.1789021866489;
        Wed, 09 Sep 2026 23:31:06 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d26bfdb4asm47441825e9.11.2026.09.09.23.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:31:05 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] HID: i2c-hid: add reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard
Date: Thu, 10 Sep 2026 08:30:50 +0200
Message-ID: <20260910063051.4556-2-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063051.4556-1-okerixx@gmail.com>
References: <20260910063051.4556-1-okerixx@gmail.com>
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
index 8b4f4b02aec0..79eb464ba2f7 100644
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

