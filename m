Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B01EB5FD
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040654; cv=none; b=e7JSkRgrylzS197RH8t03xHL1e1hCvPI47DeCAuTiCvM4/5l8Wr6E+4MHnTzfwiYAHixubTRDeOxc4dWT2piI32YFaHimx405USxTAmbmjk07tdlJnj+PfCb7+xZ+iXvzBx1DGPAdw5algWPaepew1pGWo3MpB1nkWrp56z27DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040654; c=relaxed/simple;
	bh=xxxEUVAd2/BuOXTvbRGK+hVcJSS4zsJMXPe+y52V/wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxKttsecudaqbuEWp/rR67WrnkjOJm3eLP7+D2D8MpLf5aY9QIOqZzubLtkg+NO9kXVMd4gSo8B/Dmp09DPq3w1/Coi6OLvaF9LRIdtYGb7fi08p7UnX1Xvv6AlAFnwrbv+/QMiLhGRhzL5cvnQ7OuQM0514euVhzI1QEbdjwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPV4SBtq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPV4SBtq"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327790c4e9so219390f8f.2
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 16:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040651; x=1769645451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIWlNze171mn5F258JGVcLkb0tt/mDnwBn/shv/FIbA=;
        b=iPV4SBtq8xLiyaw7PvEYe4D1VjxknBuMY1OyJbt5ZoBxM27keJdpZLroYnTuEJxV/7
         n2ruHmA+lL/JRNufFddtLFmbryQU9EFDPuLMdDex0K3SzLKklzzrYcH3p+L3sZxFTXd6
         w9oBf/4TAgSb6m1wOrKKhClcXXWxmBI3fY955Pr/LLbq8XeRNfFasTsrugFKg85aej28
         fOwLrGduCjb/5RHDDpsibF+Q7VtfBXTQxybRbS5I0uktFjP/med+TbdOa3XxWdVGnjv2
         Et4SUP5I19dJqVZ+lTNqMJam/U/Dgv3cfE89A21ScepGvT6606vdE9dUFrpMUvUsfCmN
         MOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040651; x=1769645451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIWlNze171mn5F258JGVcLkb0tt/mDnwBn/shv/FIbA=;
        b=f0rbP0OkTnN/kYMIfu4Y6Z5ttlOleKtnNT2OhbBkxWrxKtG0CBnXktxhvMS+32UP6o
         J4UquiIyJXWCQ0YMmyXjyfUJ8pcr25W2fif9xh/AGfV1tQObeuDRhscZ9OS3l5vPEPum
         hmJL4eY1Tu2nkUAAbXl1hqR7+87PN94fa3VzYOHfPg6RsbdxsfUAbQoTPEMGafT205eH
         1L1Mpjef9POzPrz4F50uiZFBqX5OldHpqHSyCHz/K8TRavwnbNXUoqb3lDD1tRhYFH2p
         dZzqcR3c1xsJa6sNTNTpXnTBWHFV8Hhlvs7NpS0eJf5sIN/p4dRVLPE5FCe66sSDAhvg
         aYhA==
X-Gm-Message-State: AOJu0YzocfkejvCqqyhNAhh+O7JcEC6NMcqxXFv+Eva2iCWLTIgNgyyq
	xv72kHInmrcU+nhRyHorY9HEN6+JBpBs2KZ6sGMiSbCSAbAwgAN1eIKIsx5dCg==
X-Gm-Gg: AZuq6aKScwDCc2QabKovlYZtcFzycE8V7S1Rb4b24RIrS1oJ5pzR+UHD+BDd1YNKNue
	6rjyn0ji7/zuejSpI3coFYRwY3wb4crNgt88ygN8/SJCUO8RPt5UIswLDZy/C4OK8oRjnvfzVTD
	fzZ1MVx8G0e1hXDYpLswllZSARhop0oPMnWlv7e4vwUOxC83QL6i863ZcgRUQv4MJ5H9u2TkRU6
	T3QXWzUX/r66A/RkTAJT9IOf/wVQbcUGZUewPuYXwaZGajv+JG/bNLgPaDSNgnFLdWdGNBLjdQl
	HlRJVhzVYltHPRSur54WNHxSyYF42WhAKoOXXFPTExYMXMYCvyiLTuI86Z+SYL5aG6qshuERWPl
	niEP7b6qTENsO758x063Jf74w1gFraWgnr1EkIEwmNNn2lIcrNPp/yzQTFctq4g9q9aOreRPGNH
	l3dIWYD6jjawoIbdQFn7fnVBx0
X-Received: by 2002:a05:6000:410f:b0:435:8f1b:bb32 with SMTP id ffacd0b85a97d-4358f1bbdb5mr9078862f8f.32.1769040650521;
        Wed, 21 Jan 2026 16:10:50 -0800 (PST)
Received: from unknown.tail46804.ts.net ([78.209.83.30])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43569926ffcsm39024752f8f.18.2026.01.21.16.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:10:50 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: linux-input@vger.kernel.org
Cc: hdegoede@redhat.com,
	dmitry.torokhov@gmail.com,
	Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH v3] Input: novatek-nvt-ts - drop wake_type check
Date: Thu, 22 Jan 2026 01:10:40 +0100
Message-ID: <20260122001040.76869-1-morf3089@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121-fervent-wren-1730d5@quoll>
References: <20260121-fervent-wren-1730d5@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wake_type parameter from touchscreen registers is not used for
anything functional - the driver only validates that it matches a
hardcoded expected value per chip variant. This causes probe to fail
on touchscreens that report a different wake_type despite being
otherwise compatible.

Drop the wake_type check and the associated chip data member to allow
the existing compatibles to work with more touchscreen variants.

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
Changes in v3:
- Completely reworked per Hans de Goede's suggestion: instead of adding
  a new compatible for the e7t variant, simply drop the wake_type check
  entirely since it serves no functional purpose
- Dropped dt-bindings patch (no longer needed)

Changes in v2:
- Removed Closes: tag referencing downstream repository

 drivers/input/touchscreen/novatek-nvt-ts.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
index 44b58e0dc1ad..3e6e2ee0ba8f 100644
--- a/drivers/input/touchscreen/novatek-nvt-ts.c
+++ b/drivers/input/touchscreen/novatek-nvt-ts.c
@@ -27,7 +27,6 @@
 #define NVT_TS_PARAMS_MAX_TOUCH		0x09
 #define NVT_TS_PARAMS_MAX_BUTTONS	0x0a
 #define NVT_TS_PARAMS_IRQ_TYPE		0x0b
-#define NVT_TS_PARAMS_WAKE_TYPE		0x0c
 #define NVT_TS_PARAMS_CHIP_ID		0x0e
 #define NVT_TS_PARAMS_SIZE		0x0f
 
@@ -49,7 +48,6 @@ static const int nvt_ts_irq_type[4] = {
 };
 
 struct nvt_ts_i2c_chip_data {
-	u8 wake_type;
 	u8 chip_id;
 };
 
@@ -261,7 +259,6 @@ static int nvt_ts_probe(struct i2c_client *client)
 	if (width > NVT_TS_MAX_SIZE || height >= NVT_TS_MAX_SIZE ||
 	    data->max_touches > NVT_TS_MAX_TOUCHES ||
 	    irq_type >= ARRAY_SIZE(nvt_ts_irq_type) ||
-	    data->buf[NVT_TS_PARAMS_WAKE_TYPE] != chip->wake_type ||
 	    data->buf[NVT_TS_PARAMS_CHIP_ID] != chip->chip_id) {
 		dev_err(dev, "Unsupported touchscreen parameters: %*ph\n",
 			NVT_TS_PARAMS_SIZE, data->buf);
@@ -314,12 +311,10 @@ static int nvt_ts_probe(struct i2c_client *client)
 }
 
 static const struct nvt_ts_i2c_chip_data nvt_nt11205_ts_data = {
-	.wake_type = 0x05,
 	.chip_id = 0x05,
 };
 
 static const struct nvt_ts_i2c_chip_data nvt_nt36672a_ts_data = {
-	.wake_type = 0x01,
 	.chip_id = 0x08,
 };
 
-- 
2.52.0

