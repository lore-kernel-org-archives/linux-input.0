Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466281;
	b=yAgsM13gbxlwDzZtCGyuEKVYIInzrnQ3cjQf5NECJeV4IpgFYMZyZ47vzuVYoRSG5i8U
	 1a/bhTC4B/wZodLFbCrOz1uc4vt+ENC+7Ahtg2doKmfCWj5JapL0VSj+i+G84AXSo5YN1
	 7V1VmMQ6sNsQ86JV26z9y+pKaGsOMsnApIhKou6//2jY8B8CdLwgjPtP6WGwc/p4ym8fQ
	 tQXPGN4KNOnErm6ZK4lKFRA+UCj7133zS/uI7mSQH1KVPSa/GhtUTDiD6uT7IPOS1r/uf
	 sudfrCoKZKBCSAkOGwfT/H3Jw1hbWbDmp53lCxn5LumXHW/eo3OmEZxlpq4Neg3XnMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IwK/Lw/zT89xRbIKZypcZKCrOD63qKhf8jUHRky3Gw4=;
	b=zKHcrYDJeL94xp9OM/u+2u8R3nlauwkbfnDwoUoF+bMDwCr1FKHWM1TZK3EQEOBfoxx3
	 ZqvNeU4Hl22kr/xlMDmD9yhMuBfPne5EONIRC8xnKYmUB0tAtN/MFdMeVw4yjCzG+tf1D
	 6GbxgVvRUWdiT57f2V8IxYxxZ3XiAAFy+hkZbCJz36vi/Y82zdDarWDYFkR5v24Q6KP4F
	 nhpnPm2Zq4/lTPNVDsedutfso1JUjlKkcAIEpAYeRGgxH3nG/f7XoiXNdK81uBXRNZomb
	 W7uHg2XjN8vzHd4JM+CSK25bPZsnyTbw9+r5R9caM7coqpRlOqJsA/6NmLGrtw6yoow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AY44++V0;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F0860A382B
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74F0860A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AY44++V0
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3249082eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466281; x=1795071081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IwK/Lw/zT89xRbIKZypcZKCrOD63qKhf8jUHRky3Gw4=;
        b=AY44++V0KqZlmgX61uk4ifRltVwOaOhN/jLkLt4NZ4SqVLoUsQyijPsMiXEi1CH9LI
         6qnJuSbVv4m30P5Aktvux6xGWFqdsz3d1jDOtNs7d8hUIVF1NY8dR7rRBX+e86dTd4Py
         2DNeaMDjSWT3zO7TbK/JWHbwBDe6E9C7VCmc9S4Hd3EVtLMCFMqTDLJhTq1yNv4q16bu
         NKSl0OMR4I0JLTSwZ0WKLqVDkTLAlvrFjDtha9XiFqXUXinIhhdbWO7Zm9VySGyNwKFR
         csHsbjK5tIBFTLBxzrkj9JWhshEllyo+cNV69X3usTLOVNeleLdadLdDxlICkBmc2g+I
         3ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466281; x=1795071081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IwK/Lw/zT89xRbIKZypcZKCrOD63qKhf8jUHRky3Gw4=;
        b=xt70r3pIVj/2JifvYtUA4HsWVOO4pcmAzANe4UlfkXojISaMGAUboWZY7KUBGuEeND
         TSvoriqhPT0GLoflqCUyvoghYn77d9U/6t7fNXcThHOpIZzayt5/3LrmizrTZpzEAl0c
         0OWQP54/JcFjdmCFb5wtLKRJ38nG/91TGm9LmH8su5+83u7IrdtnMPSQ7es8sDr1KeCi
         diD0DrFHX8JVlesGgnaIzuBR+pwgUhm9DhXItVzmQOxP1tQn99aDeGWwY5H5tbFNVSxy
         6LAZ7hwG6hsPnw1hgv7EoH9jAHXw0MwneiabXJecMFzIb2mTv66mZzSq++BzrDcZIzrj
         YoVQ==
X-Forwarded-Encrypted: i=1; AL+hErG2vmAGPNLLPaRzjH8qe7lFgRLRL0hKFv4Q/KNwv51avQO5Ps69gWlBePD3NJiKhXnoGZX+KQA+LSUirw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8g24CSfC1fWpOx8nZcKa0B1JMA43Yc/Gr2HPGWnk2Z17rNJefz
	5Q7V8/Df9WD9B3OCUvN7ri/3f+YBoJAPiSx2BEnSQp/VsAdx1lYQ0UlA
X-Gm-Gg: AYBFou3HcgF/hMLFXSEeuF1lvxzQ6G7Dtkz7Hhw9HStC6NjqQky0/t9/R09an3Qmh4j
	cfi2zjxjRvgxGrtKBfmpmXZMqv8VHmyj71SqhaCNBdsjWigGKFlPvwCR6yIrp+Dn11iGF8ClMxh
	IGg/zQKRnhp5FIePX7+PxTC2HqjJ+kNd4pBeeJ7Ay9fpI2bbr9Vtx3fG+1LzMkEiA1kCESKQYag
	BbfIC9MIrqbQVRrzxA21Ceh9rXEUn5O6duvyNKmSo0rpVEDeXE6M1uAXjX2A9GbIGA7zJ8lOwr2
	m16J6gvoASHxyPtmwqP7dVFUq7irZi1lqYOVq0rfH0vrZOrJJjGjrw7Mh6vEbo79AEejXAyfmEH
	j2yaE8HA9Fwf8SOSGnHaQ/kH3Edlw/OmxM8M/9dEypVf/Otd3viT0tI2LmtwTVEyCW//ai2E9NT
	nk3DwxlzVDoiCauM24z2IfB2me3Vsii52baOqdoAfI1Q2I5FZbk0IUQJcMOuzADItu1QqlMyfWl
	zcXBn4QUUh1zpb75pz9b6gRgRR/A6lTMu9KYjpxRCvpGE3S0pFi2cybbTF+s4bOa5S3SkwISKEn
	10x7EHkL7R48yixkTtqp7iOIzfzj1xk1NNDBQzMQZp2q6ws958Ryf4v5AiJJaEV6v6VpiEIGzxp
	D+odK6s9RWjXCxdEm
X-Received: by 2002:a05:7300:681c:b0:36a:18e2:64c with SMTP id 5a478bee46e88-37685d72786mr5325491eec.11.1794466280392;
        Wed, 11 Nov 2026 22:51:20 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm24547205eec.27.2026.11.11.22.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:51:19 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jaewon Kim <jaewon02.kim@samsung.com>,
	Hyunhee Kim <hyunhee.kim@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: regulator-haptic - drop platform data support
Date: Wed, 11 Nov 2026 22:51:14 -0800
Message-ID: <20261112065115.1803973-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112065115.1803973-1-dmitry.torokhov@gmail.com>
References: <20261112065115.1803973-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users configure regulator-haptic devices via Device Tree, and there
are no in-tree board files providing platform data. Remove platform data
support, call regulator_haptic_parse_dt() directly from the probe
routine, and remove the unused header file.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/regulator-haptic.c         | 20 ++++----------
 .../linux/platform_data/regulator-haptic.h    | 26 -------------------
 2 files changed, 5 insertions(+), 41 deletions(-)
 delete mode 100644 include/linux/platform_data/regulator-haptic.h

diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index b1aa3488ed6c..d99f716ef44b 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -10,7 +10,6 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_data/regulator-haptic.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -112,8 +111,8 @@ static void regulator_haptic_close(struct input_dev *input)
 	regulator_haptic_set_voltage(haptic, 0);
 }
 
-static int __maybe_unused
-regulator_haptic_parse_dt(struct device *dev, struct regulator_haptic *haptic)
+static int regulator_haptic_parse_dt(struct device *dev,
+				     struct regulator_haptic *haptic)
 {
 	struct device_node *node;
 	int error;
@@ -141,7 +140,6 @@ regulator_haptic_parse_dt(struct device *dev, struct regulator_haptic *haptic)
 
 static int regulator_haptic_probe(struct platform_device *pdev)
 {
-	const struct regulator_haptic_data *pdata = dev_get_platdata(&pdev->dev);
 	struct regulator_haptic *haptic;
 	struct input_dev *input_dev;
 	int error;
@@ -155,17 +153,9 @@ static int regulator_haptic_probe(struct platform_device *pdev)
 	mutex_init(&haptic->mutex);
 	INIT_WORK(&haptic->work, regulator_haptic_work);
 
-	if (pdata) {
-		haptic->max_volt = pdata->max_volt;
-		haptic->min_volt = pdata->min_volt;
-	} else if (IS_ENABLED(CONFIG_OF)) {
-		error = regulator_haptic_parse_dt(&pdev->dev, haptic);
-		if (error)
-			return error;
-	} else {
-		dev_err(&pdev->dev, "Missing platform data\n");
-		return -EINVAL;
-	}
+	error = regulator_haptic_parse_dt(&pdev->dev, haptic);
+	if (error)
+		return error;
 
 	haptic->regulator = devm_regulator_get_exclusive(&pdev->dev, "haptic");
 	if (IS_ERR(haptic->regulator)) {
diff --git a/include/linux/platform_data/regulator-haptic.h b/include/linux/platform_data/regulator-haptic.h
deleted file mode 100644
index 4213e1b01316..000000000000
--- a/include/linux/platform_data/regulator-haptic.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Regulator Haptic Platform Data
- *
- * Copyright (c) 2014 Samsung Electronics Co., Ltd.
- * Author: Jaewon Kim <jaewon02.kim@samsung.com>
- * Author: Hyunhee Kim <hyunhee.kim@samsung.com>
- */
-
-#ifndef _REGULATOR_HAPTIC_H
-#define _REGULATOR_HAPTIC_H
-
-/*
- * struct regulator_haptic_data - Platform device data
- *
- * @max_volt: maximum voltage value supplied to the haptic motor.
- *		<The unit of the voltage is a micro>
- * @min_volt: minimum voltage value supplied to the haptic motor.
- *		<The unit of the voltage is a micro>
- */
-struct regulator_haptic_data {
-	unsigned int max_volt;
-	unsigned int min_volt;
-};
-
-#endif /* _REGULATOR_HAPTIC_H */
-- 
2.56.0.567.gdb80ae8cd5-goog

