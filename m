Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED037883C
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642005; cv=none; b=gxtrVs/ZDB5N7dyhK4tm8p4RQ5jfRTOw6dmfzBuLeCerMgR3Kly+Ipzp/XVw6UEEszXucLgK2GRwfq4DUTWr3wkUFAY4m/IDFXIcVVt5nIUR812kz7uolKo7bcywaLnVWGHJbmhRr1FVSU4VmFDI/zkRv3qep8YYn8xwL9yWWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642005; c=relaxed/simple;
	bh=2MqgsiRu4SRq1htjq5DiLUsuIvgBT+11Ub0TtpH3sPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lq3G+LGNVzr+jgicZzCfUA3WGBwQrnYfuJMXhCUUX+0I1B7Y8qoURtAMZzAYfZGiV2FfTUh7VlWnzKUCQ2yYeANvm5NNRhF3c7uNnGrgqVa2FY3dLfOixb3xaFfySvy7QMIH7tlXLSykAu5Z7uU0bodDuO2jjhjEVeXTqJA9VYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=1hG/0QwN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="1hG/0QwN"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-653780e9eb3so5847646a12.1
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 05:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1770642003; x=1771246803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yEgGITR3Iw+P+BTT1l9QWyFZSeI02eVwBTOG7R5WJw=;
        b=1hG/0QwN3XEhHIv10ykVGJ9gPNHsnWtdvfw0GMrVd1rEuy5kiBZ/LXtZHhQrDY1yGN
         k25q7f2QiBeKwPrWTCv5v1RTT7Izh1FvKbH1O2n91jUjML+HCcb4rBtOufW0//i60JWc
         WsWwjoz9CxrurHZ33R4Xmyps2Xr76bbDxq0Z0Y+fEKxOg/mmSwIK7SBBppKluaLpI5fU
         i7cbDqWnZWfMWrPcELDIIgCf/8QncMi3fFIblG/Z7kWzzh0faMYcNxHcY6QbVVg9e6mA
         D0jckoJ/C9db4t8QGFipRVHL5ByILIuxlv0yDSsUZ6lRb7L03Qrp1jQKIhiii3BfL5Jt
         JdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642003; x=1771246803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+yEgGITR3Iw+P+BTT1l9QWyFZSeI02eVwBTOG7R5WJw=;
        b=e82vUj+YufU4s0JxoAuG6tS9rpTGE57my/fscjXSWMoxNsYxFBhQ9nXJewWmqgKviq
         yu1z9/D/GGJQrlknaqU4EGU3uJQiJLy0MuwEV0/LTzOnmdn3W6dpGCW9yeJfm22j46Or
         g0QpzINaZxqKpSW3RKkFlnX9oj3JSukB/i9LKQ9DervLrNDkEHAjn+Iy2QMG2Dy0EKVe
         sfEEx7ep7jLSPm6QXAQXyYZLW5hMnRCO6zDtOXUrf4uC30Et01yLw62th9/ptIwGvt+p
         MlqNayQbcVQPdkfLLdoGLAbHwtAD5ZHYjCXjwCQdIVnx/NTe6t/ievtPSH8Ea8LcOBPj
         H+Xw==
X-Gm-Message-State: AOJu0YxHsOrsjkIUamnQqsC4iJi6i2ogOZTPqFArE/uhIXiX+uRyq9Hi
	7BndKC1eTk5SIre0UMXk1UKNaSP25tdcdTqfzoOFp4i69vKaeuDqZBiFI6UFwA3g40w=
X-Gm-Gg: AZuq6aJ0/Fvn5CPacr9n0kGmUOKzQ0QaebDlPR8JwxkSIRu9JOZNKrDHPI3iP2XaooT
	8EM+l0Z89NDFY86xuJggXT16Fqo/ktEzijCgAOWDZ5UitxkZ+VR/ieW+nwHpCnRd4d4yzUdx1uT
	5Tg/BLIcqXmQeRr4Crd1t2wQHgk8U4KM7egZaZj5ItKZtnn0IVgo/553kE3+ekfO5DwsHpF85Xx
	y/tA9EEp5QCq+JxOh8XFhfWVsSHukyIhjW9sLDxZncqWo36etWyKdXSxoeZoc7ZsZFD3N+QmEEQ
	bqXe+fq8xDZAeNJKoFcOTF5wpDt/57VDz/YvGD3FV38h8obl9k2ttDR5nNUUQUV9u2gbDdVHsZE
	B5XHiOeK0Rk3kPsfXAxL7TWMVnM9nHa+NlYL8iQLP+xl7dQGTT9uOzRqXMZFNEV6EIwxc4m3Pl2
	WDYtz4dMfSd3lwRV/ceBaLlB9XAWPnX6X7GGWChll0Dff93hG6aK/GbegTELnSAGtIzDhXWA==
X-Received: by 2002:a05:6402:1e89:b0:658:cb40:6701 with SMTP id 4fb4d7f45d1cf-659841192eemr5828339a12.7.1770642000378;
        Mon, 09 Feb 2026 05:00:00 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65983ec70fdsm2803040a12.15.2026.02.09.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:00:00 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 09 Feb 2026 13:59:46 +0100
Subject: [PATCH v3 2/3] Input: aw86938 - add driver for Awinic AW86938
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-aw86938-driver-v3-2-5c79cff30492@fairphone.com>
References: <20260209-aw86938-driver-v3-0-5c79cff30492@fairphone.com>
In-Reply-To: <20260209-aw86938-driver-v3-0-5c79cff30492@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770641998; l=3891;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=2MqgsiRu4SRq1htjq5DiLUsuIvgBT+11Ub0TtpH3sPE=;
 b=evzCf87pr98l/d97pYvX4ouuFjxeOCODD+LjbBZaspFprJPW13NKrek5EZ7d9yFILvRclPidi
 1CDfGB6AxKFCxGjemeGUjOn38YttuuU59mh9vA05xe8h9GUBhocUQwo
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add support for the I2C-connected Awinic AW86938 LRA haptic driver.

The AW86938 has a similar but slightly different register layout. In
particular, the boost mode register values.
The AW86938 also has some extra features that aren't implemented
in this driver yet.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/input/misc/aw86927.c | 54 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 8ad361239cfe3a888628b15e4dbdeed0c9ca3d1a..678526ef2bb7da654734e8f53ad8442c556f209b 100644
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

