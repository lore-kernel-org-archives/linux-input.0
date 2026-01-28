Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250530E827
	for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615488; cv=none; b=Jrt98xZObuE8ZbwkHC75vggwPHNINtSsX1z5cuQdGaDOXDMkK8xGzpNPpPlweEjtjxQ6O7PXlcHBXLlzTFYtbExES0RcFdSDZ4oc2S32LYNvtwI7gtZ4CqHVOg3KJom4yK4CBLEqn1mQpT/nI1r0ClKPbH9Oa48haUDiSY5KI3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615488; c=relaxed/simple;
	bh=JDOblUMv3CRigfo3XzUT9pA2bSBe1pUX+IfX4UM2YmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIh26ZwtASkkuBH4mXiD9Jfkqgz/Wjw6/xGDSdv5mbbxuzHy4F6WljVIwNC9Z45ZXHFT+aYD45n5sFmYtctAsoExE/HulRRongIn4MSYbLP6JgkipKvUJHduscyjJ5LhMpTfn6rQteIyhvSkoI1Bl0Si9sEgPao0Mr3XZb7+KwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=KRa7ZL4s; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="KRa7ZL4s"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6581af9c94aso52996a12.1
        for <linux-input@vger.kernel.org>; Wed, 28 Jan 2026 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1769615484; x=1770220284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jy/mJos/LokpB1A73skiAstLSnipJqyWtRQg1NLBe6o=;
        b=KRa7ZL4sIsqGlZ2RPUCqXlsembvEEXhaCRo1UKHJl2Dtv7IBpPa9WnUd0L2QMW0t2L
         9nLHl2bvAJwNC1kFgn9viySVa4tM7bzTJ3K9aCrue+ej4UuLkEkosMNQSuXIl9bu8iyQ
         cUoXVNg0UxAzYEhaZq7ZEFrCXIR3H0awH8nobrteaEPTbmjgSEegB+f2os9dv1ob7dLY
         9Y4xdANncLpgoJ02tbS9xsjUTXkwlWbzGPyTrTHE4Elm7nrr1+VUA6Ma28eDac14P27c
         tellhGD3VzR1eKX5M9QOHbhLdRuJbhF1kNp9aS1AU9c/eAT12Gbv+jfbyAjA+us6UgWW
         8iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769615484; x=1770220284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jy/mJos/LokpB1A73skiAstLSnipJqyWtRQg1NLBe6o=;
        b=eSYf352ri5gkNBllvHw2Z90hbCKmeWpztfzfpE0uZOruhqqGkWLwHLHfby8OQRGPcJ
         DNQMkRo+tcumBXRRGlNjzO+cbvqc0VT9GtdhtS6Y1TsEd+kQ6xGNIgOyhkHEw8fillOb
         /xsuKk4G7GOqNZ6W2OFR6b8cIEDFcGHe5P/zElPFuRDFQDEu1bBQ4iT2Zyv9ULP38IyY
         KKIPDiwP+37L3q/oaLod7AnmHJNDWsSM6K/3k/KITxyfUs01vCrf3TXC6y//Fbhof4Ui
         W5gvGZmlx9KchVHwEMbivoTX9ze92zyD6pXEqSNgjwx15v+lII1PnIoWob6UCE/3h8EQ
         Nt3w==
X-Gm-Message-State: AOJu0YxRAJ2JmqnG7I+gVCptYrswMgjuqqix4DsjwHapZfHsp61YLHex
	J2Kcw+vyKLlNgPCP6hEoUrsfJNdFOdxnS5NW67T4o18Mlas0I5zUFoIZAtXXqWk6lg4=
X-Gm-Gg: AZuq6aKMmoC5m+c3cRDDLbIMmeWtP1aWIUpGNHVdG7qD6gEjBfrQDTgTg7+miMuN+f8
	9m9gAt5iOFe3mTmxmrMoRLFCEvmp+xquOW1Y/0k2uGtLbFqvknHut1R2tv7d0PHSJGVcOpDAF8B
	/8zdQmDiL/zMnsJd9xlsYi8+4pMdJsm6uV37st3HR9bbN3ywE9JObbzGwh8sbmM8UIpS6MimGQS
	AxP99KNkinibclT7k2ub+kYu6lns9zEHJmScRvHDSCGfjrG6oGr0993gfo32D+gioG5lr/ocg+6
	GT4aKiwh6gSTOk69CTIn/EfoQQ4rMaqWq4oAje8W8qH5/0CW8v2njlD4E6SXdsS8Xhap+3Qhxsq
	YPDBmqmJcHZQq8FV8M4Q/6zD/dFdJuODrXN9XpRnOeISWjw4R+3iNm7tng90P7ML1o27PKZ+dwQ
	dw1QyDZFVuB5daAaML4sCs7ULzeKMARAeutZKuSEvKAk4xRmA83hmhsPQh2RUsXC276TMR
X-Received: by 2002:a05:6402:51cb:b0:64b:3225:b771 with SMTP id 4fb4d7f45d1cf-658a6018e43mr3846931a12.6.1769615484396;
        Wed, 28 Jan 2026 07:51:24 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b469eb9fsm1727223a12.28.2026.01.28.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:51:23 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Wed, 28 Jan 2026 16:51:14 +0100
Subject: [PATCH v2 2/3] Input: aw86938 - add driver for Awinic AW86938
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-aw86938-driver-v2-2-b51ee086aaf5@fairphone.com>
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
In-Reply-To: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769615481; l=4691;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=JDOblUMv3CRigfo3XzUT9pA2bSBe1pUX+IfX4UM2YmQ=;
 b=et6GkIyi92KWoO/S/6DS/Hfau2CUkKGZJ27uF0md++Mep35qYbak3CGWu/+wZv+bAGxYGHu6C
 oc3J2ZgvRkbALztNnXMctfqhvGhlQY79UhWlQzfTOLAEMwx1Lewgql0
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add support for the I2C-connected Awinic AW86938 LRA haptic driver.

The AW86938 has a similar but slightly different register layout. In
particular, the boost mode register values.
The AW86938 also has some extra features that aren't implemented
in this driver yet.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/input/misc/aw86927.c | 65 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 8ad361239cfe3a888628b15e4dbdeed0c9ca3d1a..28ec6e42fd452a0edf1e1b9a9614e2723c6d9f93 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -43,6 +43,12 @@
 #define AW86927_PLAYCFG1_BST_VOUT_VREFSET_MASK	GENMASK(6, 0)
 #define AW86927_PLAYCFG1_BST_8500MV		0x50
 
+#define AW86938_PLAYCFG1_REG			0x06
+#define AW86938_PLAYCFG1_BST_MODE_MASK		GENMASK(5, 5)
+#define AW86938_PLAYCFG1_BST_MODE_BYPASS	0
+#define AW86938_PLAYCFG1_BST_VOUT_VREFSET_MASK	GENMASK(4, 0)
+#define AW86938_PLAYCFG1_BST_7000MV		0x11
+
 #define AW86927_PLAYCFG2_REG			0x07
 
 #define AW86927_PLAYCFG3_REG			0x08
@@ -140,6 +146,7 @@
 #define AW86927_CHIPIDH_REG			0x57
 #define AW86927_CHIPIDL_REG			0x58
 #define AW86927_CHIPID				0x9270
+#define AW86938_CHIPID				0x9380
 
 #define AW86927_TMCFG_REG			0x5b
 #define AW86927_TMCFG_UNLOCK			0x7d
@@ -173,7 +180,13 @@ enum aw86927_work_mode {
 	AW86927_RAM_MODE,
 };
 
+enum aw86927_model {
+	AW86927,
+	AW86938,
+};
+
 struct aw86927_data {
+	enum aw86927_model model;
 	struct work_struct play_work;
 	struct device *dev;
 	struct input_dev *input_dev;
@@ -377,7 +390,7 @@ static int aw86927_play_sine(struct aw86927_data *haptics)
 		return err;
 
 	/* set gain to value lower than 0x80 to avoid distorted playback */
-	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG, 0x7c);
+	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG, 0x45);
 	if (err)
 		return err;
 
@@ -565,13 +578,26 @@ static int aw86927_haptic_init(struct aw86927_data *haptics)
 	if (err)
 		return err;
 
-	err = regmap_update_bits(haptics->regmap,
-				 AW86927_PLAYCFG1_REG,
-				 AW86927_PLAYCFG1_BST_VOUT_VREFSET_MASK,
-				 FIELD_PREP(AW86927_PLAYCFG1_BST_VOUT_VREFSET_MASK,
-					    AW86927_PLAYCFG1_BST_8500MV));
-	if (err)
-		return err;
+	switch (haptics->model) {
+	case AW86927:
+		err = regmap_update_bits(haptics->regmap,
+				AW86927_PLAYCFG1_REG,
+				AW86927_PLAYCFG1_BST_VOUT_VREFSET_MASK,
+				FIELD_PREP(AW86927_PLAYCFG1_BST_VOUT_VREFSET_MASK,
+					AW86927_PLAYCFG1_BST_8500MV));
+		if (err)
+			return err;
+		break;
+	case AW86938:
+		err = regmap_update_bits(haptics->regmap,
+				AW86938_PLAYCFG1_REG,
+				AW86938_PLAYCFG1_BST_VOUT_VREFSET_MASK,
+				FIELD_PREP(AW86938_PLAYCFG1_BST_VOUT_VREFSET_MASK,
+					AW86938_PLAYCFG1_BST_7000MV));
+		if (err)
+			return err;
+		break;
+	}
 
 	err = regmap_update_bits(haptics->regmap,
 				 AW86927_PLAYCFG3_REG,
@@ -599,6 +625,9 @@ static int aw86927_ram_init(struct aw86927_data *haptics)
 				 FIELD_PREP(AW86927_SYSCTRL3_EN_RAMINIT_MASK,
 					    AW86927_SYSCTRL3_EN_RAMINIT_ON));
 
+	/* AW86938 wants a 1ms delay here */
+	usleep_range(1000, 1500);
+
 	/* Set base address for the start of the SRAM waveforms */
 	err = regmap_write(haptics->regmap,
 			   AW86927_BASEADDRH_REG, AW86927_BASEADDRH_VAL);
@@ -717,9 +746,19 @@ static int aw86927_detect(struct aw86927_data *haptics)
 
 	chip_id = be16_to_cpu(read_buf);
 
-	if (chip_id != AW86927_CHIPID) {
-		dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
-		return -ENODEV;
+	switch (haptics->model) {
+	case AW86927:
+		if (chip_id != AW86927_CHIPID) {
+			dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
+			return -ENODEV;
+		}
+		break;
+	case AW86938:
+		if (chip_id != AW86938_CHIPID) {
+			dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
+			return -ENODEV;
+		}
+		break;
 	}
 
 	return 0;
@@ -736,6 +775,7 @@ static int aw86927_probe(struct i2c_client *client)
 
 	haptics->dev = &client->dev;
 	haptics->client = client;
+	haptics->model = (enum aw86927_model)device_get_match_data(&client->dev);
 
 	i2c_set_clientdata(client, haptics);
 
@@ -825,7 +865,8 @@ static int aw86927_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id aw86927_of_id[] = {
-	{ .compatible = "awinic,aw86927" },
+	{ .compatible = "awinic,aw86927", .data = (void *)AW86927 },
+	{ .compatible = "awinic,aw86938", .data = (void *)AW86938 },
 	{ /* sentinel */ }
 };
 

-- 
2.43.0

