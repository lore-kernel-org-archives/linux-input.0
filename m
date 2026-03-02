Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1569359A6A
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448633; cv=none; b=cpQQjgbq05VHDn8SCMZq5lkzXIJD+nGNB9GqO5CRmV3W3Ezqew5UICvzMEl6hkjM2TJqFy8N/r2gvpLZtCgUoKLTMmYRRHrExqX2xlu4j4MGSAIcPy+yQ7/o6TB5rQRvRhOxdUKgjHtC1b93c8oxdCRkfKoHuBBmzhm0AdjWlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448633; c=relaxed/simple;
	bh=3WJk29Oc6ASs5QbTykgT/4YsAbA7z1k86z1JB86Wapc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfhjFbsq0tAMAkXl8U4R/cTREOZN/CSAy53C6EtvCyM0PDreeOt54hSE5xqlaow5dn8QRUOTfJK6qfl86Sv5pfTx/CFMRXaeMvhstbufNZQeETeXEw9u/s3sByR++4CpDVIDNcur09Bjqg/5e+Cpet0UzTPdUY5XF/gUYE3EvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=tGevLxj7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="tGevLxj7"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65f9763e8d1so8268251a12.1
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 02:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1772448630; x=1773053430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fb2xAImtJ+lQV4+0+mQF2V3ooZDMtzcy+tKq3+ul2r4=;
        b=tGevLxj7jVrB5i0jAOwS33nlQ26ydkSQ3r6n0C2AnxAQ0TRRh5Yyag8DpHNcCSpfEy
         w+Iowob9KqME29GRS5KQ49/86KM04pCBsFfEqGHoqubeNhuhYI4E5tTaJQ/3whGUJ58e
         urT02IaMIVkv9wMX1QXWrQZYUa1JZen7LLUVsYPG3FBnE+R5ET+UfFW5UCFxNuU/hodc
         0unVGp4ui2KQuCWlvYMn79uA1dINBuqT+EzPLlJG0cZJ4KkljUJr+TQzd/KWi2kBEDlf
         2nMQZ3tUbDPfZXGFfP4N6qfAT9eaD+mgSNQT+ue8MJPBWC1UMULxGsBYalqtyMGZ10tm
         zJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772448630; x=1773053430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fb2xAImtJ+lQV4+0+mQF2V3ooZDMtzcy+tKq3+ul2r4=;
        b=ot9cdlFx0wolzNn+3fS7ACdz337/0tGLmRnTvYGaBcXtBC666Iq5Iem6RMGebb2pM5
         70WxQYDJsi+LLxw7zamQzuzVxNGB1VmU4KnGwt3cSgepUlV+4PGblm9z2+du/2t8/UHr
         yv/4i5VrTv02ibgbWkahOWNqHsfhTZ25N6q2LvOH8th+ecxjKzQkgwu+2dD6Mf7orLcQ
         kkaN8j0tDQFlQ9nBfxVmxqXb5GfD567nx8TaEiWdEihC4Fi/vLG9Tio9/MMw5IJp5q4e
         TRqqQCZG2Fqy0kSS3zaEFNIU4RJTIQhRO9COuzjBssYXlNgOSV18sFPWQGnHtv6NGvL6
         htAQ==
X-Gm-Message-State: AOJu0Yyj/M/pMk/moS8iAol4naynkxRkF/XqHsQSlV6jHnotSNlirlX+
	dNE8eIv0M/xYKCKG1cehqnVX8gnwEROoGbY/13h1oJJ+KsElXW2YTyWnXLUcveP+s4o=
X-Gm-Gg: ATEYQzz5O3JY8vu23kXGk1HpxEozEI4azyTgEOxARhmdaBXbF2OsP5pqVKEiUj6hK+p
	5rZ3h5ow5DMiAn2SyTRtfcA57WUGhnKP/JAd12ebw//BXuBfWvJnYOrcK1imDz8nQHzRa+BA13E
	0c5caZHKRIH5/j42tnV8eXh8BUHZFwTMmfNLuXtVbSKebZMDIal60EPluXF01cxyJS1Pa4QaSDW
	6MRZ6AaRgs7xn3zeyuMR/3/QURTi4IIgPXUCQJifly0lyrnUUujZhdvR6ftOnGGKYsN4m/kFc3z
	ME2Ks9GrQxnyu2wOjsuCl8LeHgMzgRVMx5PJ+T77GQr+7illIQxBpGfV8ZWb5rJIJdl4WY0WFaC
	b/9H0UeT7WzhHkieHR/R6eraFqw9ie1W3E206bVg2teY4hlzosCsr2aM4dFMZ/m6YLVCPHvNrbX
	V2A/cfh8H+Wr79/f8BAtbtmZTrN6Pe83LXNq8OOC2eulNE+T3uQSQU7C7ckbh0XxkbewWBrZgnV
	1vAqc9k93/DRf8H7bJo
X-Received: by 2002:a05:6402:2111:b0:65f:71ed:7ab9 with SMTP id 4fb4d7f45d1cf-65fddceee18mr7094753a12.22.1772448630129;
        Mon, 02 Mar 2026 02:50:30 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabbd98bcsm3511769a12.0.2026.03.02.02.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:50:29 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 02 Mar 2026 11:50:27 +0100
Subject: [PATCH v4 3/4] Input: aw86938 - add driver for Awinic AW86938
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-aw86938-driver-v4-3-92c865df9cca@fairphone.com>
References: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
In-Reply-To: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772448626; l=3554;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=3WJk29Oc6ASs5QbTykgT/4YsAbA7z1k86z1JB86Wapc=;
 b=yAD7qSNA38IhaULQIDUEm3f5FzrrD8mZ4sgoaUHU2Gy4KL2uEAbON2sQr6KXtKOD0RIZAKcPP
 bVXbNLa119tAlVNZMP/fC22naYzwoWIMI9shRJmKAv/5XMd4mX3lClC
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add support for the I2C-connected Awinic AW86938 LRA haptic driver.

The AW86938 has a similar but slightly different register layout. In
particular, the boost mode register values.
The AW86938 also has some extra features that aren't implemented
in this driver yet.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/input/misc/aw86927.c | 52 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 7f8cadda7c456d7b5448d1e23edf6e3f2918ba32..e59b958fac1a1144307cb216560f522485ad26e9 100644
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
@@ -717,7 +746,14 @@ static int aw86927_detect(struct aw86927_data *haptics)
 
 	chip_id = be16_to_cpu(read_buf);
 
-	if (chip_id != AW86927_CHIPID) {
+	switch (chip_id) {
+	case AW86927_CHIPID:
+		haptics->model = AW86927;
+		break;
+	case AW86938_CHIPID:
+		haptics->model = AW86938;
+		break;
+	default:
 		dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
 		return -ENODEV;
 	}

-- 
2.43.0

