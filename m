Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3656359A6A
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448631; cv=none; b=lhqmjS8NcrYk+iQ2pRJ/MXgX8x+quISxIQoNpfTedLfDsGMqLo4MVBUKbUjtL/m6EKNajOi0EftwQLQcsHQ1mG9Dgjg41F21YRDrw5n3h+lbSCL1P+tyZe2dLoFW3v3FlEAsk+u6Ct0jFNk8L0BX6dztwlR8TFuLXIMl3qLLxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448631; c=relaxed/simple;
	bh=aHRIOIA82B5UmiYNaDuGLIuutpMS1GzM+k8Df5VuVF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGaMj5azytJFJmh4HrpFoj7rl2gi4G1o1f0J8KnYUiBNcVs1We2LowPYV0DPQrMdC4UMrGw8hJsrUsVwggNPy1D6ZeHykezqI70Yy4YmSCK28mJCDVGlwhZ/IZlGUg/PG8HZKlwfBXYBKeVSgCOLNHNmY2ejpfdPGP+Dvx4k1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=0K9B4Lfb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="0K9B4Lfb"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65fb991d7e7so6158114a12.1
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1772448628; x=1773053428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CDK4BH+OoJnVpsxs1bAWWhwEzUlZ60d996yFctMRUA=;
        b=0K9B4LfbBsNqMeXrxpFxGOwU4vpOH+u4RbdDMFuLT8xd8qzPEzj58dIku2Yihw/Uqf
         zfnSFTr4ir4RppBO9SmQjH8Mw/EzPUEpeGkTSvzGW6SRdHA0MtE/MjlenRLlphFuwpmf
         dYDdvCf4WfthHVF9iOLY08BzXnb0cwrzJ2j/GRMVXgMoQtvWnTuNddVy9jK5JRMxcpTI
         R0B7L0AAvH4lhebqsqISamERauouaoTi8+/7RMQWX8XhPwG6WWe94IFlM3Go2XeGGtAM
         UeprBRqS41KSgVc5FZU8OPteNRZDJlbtLjtZMwH4HIr4HENGmEGCEN9jpz2UW2TsNd/0
         AOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772448628; x=1773053428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0CDK4BH+OoJnVpsxs1bAWWhwEzUlZ60d996yFctMRUA=;
        b=SmdwGxJgtuSJXoidfvegcvuOv4+kstTBbc6ySkhMY3aJdOjX0CcejaWDOQosdMoCFa
         fbv5ZWXD7ijmDtqgUncJAgfLSWOTBWrRGxi2RTtpHejeaOY9Jjb7XrA3b8lvIYyn5lLB
         dzkbenkR2JjmcfXVHhjmU5KRHYN6s4xCSBQw1783rMBCjwh21WVwNzUL8lZJ3+YBIh3V
         xLdJMr/MmjSsJp/sOVk1PjCfmDBpmc8KTv2GsGCAlwsRPDRfvUIQjLBHbK/AP5zNtKZp
         bLsMfMi/h4Jrl5zOFPvwsCf5PaKjrJwjZXeRBVvWFZooa0f2w4SIFEyl44C2cqx1rKAN
         T5Lg==
X-Gm-Message-State: AOJu0YxBEpTYWAzbP+WR00kdDoMl7bkX+GI+OH7OfHyj2KAxVRdfqmvX
	x27IObyAzENJadoiHoWPYkYNa/iD/2qLaA41A1Qw7kkMYotZwH5yFPM4WT81bQ+nJ5CFyppuul9
	vA0CU
X-Gm-Gg: ATEYQzynrgAn9TXZKzSYwkFx8OAg6Ii9HM5ieIW/Zs34Ca1Qsmr/tvUjhmNLaOcV8oD
	qkhxUpE7Iy5lOOkjTZlSBTwCefP/IVuos4dRtsFuQG0BDxRL1us+qxeicGW4tltL5qkMzRwMOUZ
	N3UBjcgx6zOYKQMhyVUA1QfWgRCASFZ/2qDOyIAtc/AAAFtBu91Iul9xEQy1RGxt+6iTrzG9mzB
	mJ21a+PKJAsXqR+HdYR/s/LPcJIokEUuLNAUx0DvsVp9e1wqHlkTha2Kf9QJNcT73ncRV8/X+rK
	nLWNM8Vqu0n4V7tRNfrc5fIaTjmc2puHidQT4xOBmuwzdjmZjrhrZEeEGCdAXNcFoTUBEctvps6
	B9M/04humwM/hp5z2od9olqsannrBMvpxohrcnUT4vR4e13S83TDW3SBS6HXEi2mAb0SY1zz2ju
	5vg/SFp/Y8jvp/CIN15fyVOlQPV+cmSINLoyI+2N2e9+gjfkWP7ThC9jeThgKqOtpFVG0ciDQLa
	zjnZddB3w==
X-Received: by 2002:a05:6402:270a:b0:65c:1483:a716 with SMTP id 4fb4d7f45d1cf-65fde4d2c45mr7809332a12.29.1772448628107;
        Mon, 02 Mar 2026 02:50:28 -0800 (PST)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabbd98bcsm3511769a12.0.2026.03.02.02.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:50:27 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 02 Mar 2026 11:50:25 +0100
Subject: [PATCH v4 1/4] Input: aw86927 - respect vibration magnitude levels
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-aw86938-driver-v4-1-92c865df9cca@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772448626; l=1926;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=aHRIOIA82B5UmiYNaDuGLIuutpMS1GzM+k8Df5VuVF8=;
 b=QMUHIQaI7C7oB7r2/diS3hfpVF30i0LI3lK0cwpYVvIDTd0cQRED/RbflRKKga8SAU/4jkimw
 eC1wRcjWk1rAAPeFM+vtN7HNuSZC0ScZYhdrByBcr5bMHIou20tHfAp
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Previously the gain value was hardcoded. Take the magnitude passed via
the input API and configure the gain register accordingly.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/input/misc/aw86927.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 8ad361239cfe3a888628b15e4dbdeed0c9ca3d1a..7f8cadda7c456d7b5448d1e23edf6e3f2918ba32 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -180,7 +180,7 @@ struct aw86927_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
-	bool running;
+	__u16 level;
 };
 
 static const struct regmap_config aw86927_regmap_config = {
@@ -325,11 +325,12 @@ static int aw86927_haptics_play(struct input_dev *dev, void *data, struct ff_eff
 	if (!level)
 		level = effect->u.rumble.weak_magnitude;
 
-	/* If already running, don't restart playback */
-	if (haptics->running && level)
+	/* If level does not change, don't restart playback */
+	if (haptics->level == level)
 		return 0;
 
-	haptics->running = level;
+	haptics->level = level;
+
 	schedule_work(&haptics->play_work);
 
 	return 0;
@@ -376,8 +377,7 @@ static int aw86927_play_sine(struct aw86927_data *haptics)
 	if (err)
 		return err;
 
-	/* set gain to value lower than 0x80 to avoid distorted playback */
-	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG, 0x7c);
+	err = regmap_write(haptics->regmap, AW86927_PLAYCFG2_REG, haptics->level * 0x80 / 0xffff);
 	if (err)
 		return err;
 
@@ -409,7 +409,7 @@ static void aw86927_haptics_play_work(struct work_struct *work)
 	struct device *dev = &haptics->client->dev;
 	int err;
 
-	if (haptics->running)
+	if (haptics->level)
 		err = aw86927_play_sine(haptics);
 	else
 		err = aw86927_stop(haptics);

-- 
2.43.0

