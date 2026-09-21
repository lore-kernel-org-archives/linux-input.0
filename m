Received: from e3i491.smtp2go.com (e3i491.smtp2go.com [158.120.85.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E914DA540
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013390; cv=none; b=GaSOdrSL1P18iVZfkn4fkPlPM/OlhSZ+KwqEFeltfGnLOqGcESbwIhyuXR9XqLG5FohMwaKZI2rOTXrNHqVGgYpiiLQPyvN7v6+EA4aDimbbLXhyg835ZuookPg/wOL5Nfbr29mSk1bONtuQn7yqAFJawIfNALV3cmtBTQmxqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013390; c=relaxed/simple;
	bh=MmGlw/FKtavcqD6RK9Oq+bIRNLn34GzZW7OjJjSNmZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9HpKmajPhLMsKf/6Epixw9SRTjPY+7S4/pOGiVGaMD4uR2ZKxwytENFYBg1G8WyVJ2UiC3DYLmeNeRcPLXMJlmg4JVMKlLox/A1Emw6DPQ5hSASA/QWaTmqAjP+L2ULQ2PEr0jr3KA30f12HeWQ/thSxqxPBdBoXkgzcVfRIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev; spf=pass smtp.mailfrom=em1020969.fkr.dev; arc=none smtp.client-ip=158.120.85.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1020969.fkr.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fkr.dev;
 i=@fkr.dev; q=dns/txt; s=s1020969; t=1790013162; h=from : subject : to
 : message-id : date : list-unsubscribe : list-unsubscribe-post;
 bh=Oit/fXpUixaMtBaz4wE+a3+fGATGvQuaNCHZFAv15vY=;
 b=Zeoqfdg940J45va+hXhwQc5SygYvyLg49sUHvgXcOo5sMQWgFSAy3GXYLkkXDHlGn6WwV
 mASTNDDUdBlSWrKFOfikDDX5QtBJpWzhc6XKE1FhFCKxdBLsRKXf6flBl5GWI5OT1HMAHf2
 y5JYi/L1zsWrPiDHsZj6FIApqi8nFWYMPWjKa5XO+Tzk9kYBpX+/j/aMCGKv0+T9ocPZr99
 TM4fOvpcvwiAdSeBacr5uDLN6bdhS8ddD469wXBMm0UGtoscmr0nkskJ9c9aZe+cmth15Co
 rbNMgbjx0MHjYBbCD2x/9bnK9t5KQzm/BcdY8M4qxMvv/jFQb0y4GiTPxhDw==
Received: from [10.244.246.9] (helo=fkr.dev)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128:X25519)
	(Exim 4.100)
	(envelope-from <florian.krischer@fkr.dev>)
	id 1x8iBy-4o5NDgriYu2-lIZH;
	Mon, 21 Sep 2026 17:52:38 +0000
DKIM-Signature: a=rsa-sha256; bh=Oit/fXpUixaMtBaz4wE+a3+fGATGvQuaNCHZFAv15vY=; c=relaxed/relaxed; d=fkr.dev; 
 =?utf-8?q?h=3DSubject=3ASubject=3ASender=3ATo=3ATo=3ACc=3ACc=3AFrom=3AFrom=3ADate=3ADate=3AMIME-Version=3AMIME-Versio?=
 =?utf-8?q?n=3AContent-Type=3AContent-Type=3AContent-Transfer-Encoding=3AContent-Transfer-Encoding=3AReply-To=3AIn-Rep?=
 =?utf-8?q?ly-To=3AIn-Reply-To=3AMessage-Id=3AMessage-Id=3AReferences=3AReferences=3AAutocrypt=3AOpenpgp=3B?=
 i=@fkr.dev; s=default; t=1790013157; v=1; x=1790445157;
 b=Y3U3KtvbA4p2z+6VZrnvYLHsaxTC3nTnneBrqE417KRO9YKmysecxJ/7vh9epFngHzIoXL2r
 2M2D5zspDUh2IY5maKtZHe3FXURT3+HhOl00oMfrBfud45dd5HWVHBmi/hodNjGRX3r3evkG3TY
 SX12nTPSL6WbWwNOhP9+MIPV/i4bHztNg6QfLG7HjFl/2mU207ad6B1agwJvDhuQRCYRk1HZXmk
 AtzTwwV3eAmeskfRWwXVAEwo03fPp9IxZR86YmluXppRERTm5lbdvx+5r6IIBsn9aks2QgIlii1
 i/OJ6evWkaZYC126Mh/zmxBLUQEw3+kmHJeETzRQPsAqw==
Received: by fkr.dev (envelope-sender <florian.krischer@fkr.dev>) with
 ESMTPS id a3a8de78; Mon, 21 Sep 2026 17:52:37 +0000
From: Florian Krischer <florian.krischer@fkr.dev>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Krischer <florian.krischer@fkr.dev>
Subject: [PATCH v10 fixup 1/2] mfd: asus-transformer-ec: use 8-byte event
 reads on SL101
Date: Mon, 21 Sep 2026 19:52:36 +0200
Message-ID: <20260921175234.3137985-2-florian.krischer@fkr.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721095233.420823-1-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1020969m:1020969amTSgpp:1020969szvVW0a6mP
X-smtpcorp-track: 3wp7BOkHQ2Gc.1xsZHnFCm4R-.FUIyfwqL8ZO

The SL101 embedded controller exposes the event window at 0x6a through
8-byte reads. This matches the downstream ASUS SL101 driver, which uses
an 8-byte SMBus I2C block read for command responses and events.

The generic 32-byte event read used by v10 prevents the physical SL101
keyboard from completing PS/2 initialization.

Use a variant-specific event read length for the SL101 in both the
clear-buffer and interrupt paths. Keep the 32-byte entry size for other
variants.

Tested on an ASUS Eee Pad Slider SL101 with EC firmware SL101-0202.
With the matching serio fixup, the built-in keyboard completes atkbd
initialization and works.

Signed-off-by: Florian Krischer <florian.krischer@fkr.dev>
---
 drivers/mfd/asus-transformer-ec.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/mfd/asus-transformer-ec.c
+++ b/drivers/mfd/asus-transformer-ec.c
@@ -229,8 +229,18 @@
 	return ret;
 }

+static size_t asus_ec_read_size(const struct asus_ec_data *ddata)
+{
+	/* SL101 firmware exposes an 8-byte event window at 0x6a. */
+	if (ddata->info->variant == ASUSEC_SL101_DOCK)
+		return 8;
+
+	return ASUSEC_ENTRY_SIZE;
+}
+
 static void asus_ec_clear_buffer(struct asus_ec_data *ddata)
 {
+	size_t read_size = asus_ec_read_size(ddata);
 	int ret, retry = ASUSEC_RSP_BUFFER_SIZE;

 	/*
@@ -239,8 +249,8 @@
 	 */
 	while (retry--) {
 		ret = i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_BUF,
-						    ASUSEC_ENTRY_SIZE, ddata->ec_buf);
-		if (ret < ASUSEC_ENTRY_SIZE)
+						    read_size, ddata->ec_buf);
+		if (ret < read_size)
 			continue;

 		if (ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK)
@@ -318,12 +328,13 @@
 static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
 {
 	struct asus_ec_data *ddata = dev_id;
+	size_t read_size = asus_ec_read_size(ddata);
 	unsigned long notify_action;
 	int ret;

 	ret = i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_BUF,
-					    ASUSEC_ENTRY_SIZE, ddata->ec_buf);
-	if (ret < ASUSEC_ENTRY_SIZE)
+					    read_size, ddata->ec_buf);
+	if (ret < read_size)
 		return IRQ_NONE;

 	/* Check status byte with ASUSEC_OBF_MASK if data is valid */
--
