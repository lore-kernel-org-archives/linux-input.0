Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A33546CF
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787285360; cv=none; b=Ldn90oil3MlHh8v4Jq91HTCawLbpoB2h6mdj/tV7Fq1+JyiRO7aL/7A8X5B7zPonus4ZYu2Alpsi/TGuaklL9/czF/63oP/QbL7rG4eI/xqigd0ujP3HQ62f646lvPR7Ov8Ydbw/H9NS5JmsgKtmKueWaG+xYrvypGJzQ4VFLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787285360; c=relaxed/simple;
	bh=PcGNx992EdYK1LyIkTkLCSIHkNzubUCmgLAxDBJBKMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpUK44QOkqDfV7pldtsoSZZKpEUdNCU84LmGh10sXutfUxx5D1jGbPjrqkvkUbrsrUwldQymTojXBt4Ktp68F0XZCx/lMohgLui32h1KM6rglIGWy1lCnBDH1bKn+Y9yjVh1NZNK7OF4ZabER3dSfPi8SwApGXohZHcX+CNavOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpf+OVhf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpf+OVhf"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbb7926836eso427294a12.3
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 21:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787285359; x=1787890159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NL0QMLbb5CnWsto8yJ2XYwKTXgoQuJxGA8ecQsMppg=;
        b=Fpf+OVhf1kYXt1tVlZ9bRyGj+v2dMDJwSfchOFO4amGt77Isf4Bj5y70B1H4l0bC+S
         4CH1Wh2Qo2/BcEeOWVE2rvk0/tRd2d0k/Y6rrUPKYaqWTSiR4K0Oobuo4/CRqaO71Uup
         21MbyxP9PeQy2NnrYgp4ND5PWzFGp6YCp9PMwqwnEToluFSCdflL5RKN5H36AgplEJ0x
         ST6ZW8LV3b04cdx0Ra7Wmy82sGL56Ql09X+hWfe8+I7fj4lxXV8NcN5/reE4IDbPGYOi
         8HhW4WaKbVFX8EhJFCuaEt7vOnjPj02I8nuz/t2ov7JzXlYAeWUwSZjrXIcEgCooVzi6
         vIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787285359; x=1787890159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NL0QMLbb5CnWsto8yJ2XYwKTXgoQuJxGA8ecQsMppg=;
        b=WT6JIYQOy5awgquz6cn3EQoHNz6zX5FmPn71MG97vH6Vh+AEu5cSztUZc1MlTgOEQy
         1tag9EO8/oDVRAfCn4bJ1nY0lFYbHUZUQprIAXxGk8n5KcCWQeLHNLI705UtpybwPpcV
         +VNOyeQmCQ0WH6f0fEVcaONPcZR8nXfl+bwtuhb9kRUTwh42SA7Y/iYSE0rZ1rXBUXoI
         N0/rSOymNM508zSjLy25JX6bGMCvH23OuHDvqARgCmxH+YsIij/omS1Vtas3EP8iUzpD
         Voyy3pzcieus0fg1WEke86NxQ04ClDOb2eTYcrM+afDcsU7snGJ3kGXC6sOj3GZ0xJVH
         u/SQ==
X-Forwarded-Encrypted: i=1; AHgh+RodcHLn68gJebieBDux38k3wliVr2BzANCpSf8Crm4sTCX2egp9/+95mrPBCUhzj3rYgbMP1A/RKefH0Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nW79gjSRZblN5iJvE2FzM6iNV1dqKEYFXgEfAmLeiW2wn9SdCw
	a+AAcMgW9Qv4E64e4tlS211Mn8SvE1yFsiFkSt+LihStWoq+MK7n5zM=
X-Gm-Gg: AR+sD11r7pRzO+8eSxwidtK4+1+4DLxRzIFyVcnWrjRr9JMFm+gJBwMW8ER43CXBMOY
	nLBoiMahMgSdcx7PzMvvZD0XXl98FdRpEcmI5rLoDH/bZXZ8ZpRkYfYzoCsUuKpJaFs+ajtvFkA
	j0DYL/KjT5bLaq9tG0GJXDZqDoFWCGcsUefkuXEUo1KwWE20jlUromtrd4Blw4bz4x9WWps8mP5
	BsG+/kN0bve5b36Ouida+CbO5OLW/oKKzYldT8gCDy+TMIwFgB873ts3GAz8n4Jsld7K/h7zNEG
	pf3aggg1bvrZwO40SI4slOTnszgthR1R/WoXZ1IukT6s7S6gAmF357gHZ2b8i/kG8urtcpbcvgf
	P4D48fR+4QO3Qhwtv86cAotvLZoivsjiYDhFd30r+Ja1kGOO1m8Uru8jHHjEgGTNFugUwQbGGSI
	9aep1gwH1wrALv82qtqQNymiIeTktsFDIomKcIaI1A2Pfc4XSZDaimv+SlXyMxyjEoQhpNt3Y1L
	A==
X-Received: by 2002:a05:6a00:368f:b0:846:8b22:4933 with SMTP id d2e1a72fcca58-851fa1ad69bmr5052274b3a.17.1787285358771;
        Thu, 20 Aug 2026 21:09:18 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3389e83sm2339233b3a.16.2026.08.20.21.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 21:09:18 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: sashiko-bot@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	triet.hoang.dev@gmail.com
Subject: [PATCH v2] input: touchscreen: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 21 Aug 2026 11:09:05 +0700
Message-ID: <20260821040905.104590-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821025514.31AE01F000E9@smtp.kernel.org>
References: <20260821025514.31AE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations
from the resume and suspend callbacks.
Also reduces kernel size when CONFIG_PM
or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Remove DEFINE_SIMPLE_DEV_PM_OPS, use only EXPORT_SIMPLE_DEV_PM_OPS for ad7879_pm_ops
---
 drivers/input/touchscreen/ad7879-i2c.c | 2 +-
 drivers/input/touchscreen/ad7879-spi.c | 2 +-
 drivers/input/touchscreen/ad7879.c     | 7 +++----
 drivers/input/touchscreen/cyttsp5.c    | 8 ++++----
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
index c1ccdf86b74c..7ee5c0abd551 100644
--- a/drivers/input/touchscreen/ad7879-i2c.c
+++ b/drivers/input/touchscreen/ad7879-i2c.c
@@ -60,7 +60,7 @@ static struct i2c_driver ad7879_i2c_driver = {
 	.driver = {
 		.name		= "ad7879",
 		.dev_groups	= ad7879_groups,
-		.pm		= &ad7879_pm_ops,
+		.pm		= pm_sleep_ptr(&ad7879_pm_ops),
 		.of_match_table	= of_match_ptr(ad7879_i2c_dt_ids),
 	},
 	.probe		= ad7879_i2c_probe,
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 064968fe57cf..66dcd4aa4711 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -58,7 +58,7 @@ static struct spi_driver ad7879_spi_driver = {
 	.driver = {
 		.name		= "ad7879",
 		.dev_groups	= ad7879_groups,
-		.pm		= &ad7879_pm_ops,
+		.pm		= pm_sleep_ptr(&ad7879_pm_ops),
 		.of_match_table	= of_match_ptr(ad7879_spi_dt_ids),
 	},
 	.probe		= ad7879_spi_probe,
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 31d2a3029d5f..10f8574f478e 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -301,7 +301,7 @@ static void ad7879_close(struct input_dev *input)
 		__ad7879_disable(ts);
 }
 
-static int __maybe_unused ad7879_suspend(struct device *dev)
+static int ad7879_suspend(struct device *dev)
 {
 	struct ad7879 *ts = dev_get_drvdata(dev);
 
@@ -315,7 +315,7 @@ static int __maybe_unused ad7879_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused ad7879_resume(struct device *dev)
+static int ad7879_resume(struct device *dev)
 {
 	struct ad7879 *ts = dev_get_drvdata(dev);
 
@@ -329,8 +329,7 @@ static int __maybe_unused ad7879_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
-EXPORT_SYMBOL(ad7879_pm_ops);
+EXPORT_SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
 
 static void ad7879_toggle(struct ad7879 *ts, bool disable)
 {
diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 9266c07314be..7b0613156fc1 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -942,7 +942,7 @@ static const struct i2c_device_id cyttsp5_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cyttsp5_i2c_id);
 
-static int __maybe_unused cyttsp5_suspend(struct device *dev)
+static int cyttsp5_suspend(struct device *dev)
 {
 	struct cyttsp5 *ts = dev_get_drvdata(dev);
 
@@ -952,7 +952,7 @@ static int __maybe_unused cyttsp5_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cyttsp5_resume(struct device *dev)
+static int cyttsp5_resume(struct device *dev)
 {
 	struct cyttsp5 *ts = dev_get_drvdata(dev);
 
@@ -962,13 +962,13 @@ static int __maybe_unused cyttsp5_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cyttsp5_pm, cyttsp5_suspend, cyttsp5_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cyttsp5_pm, cyttsp5_suspend, cyttsp5_resume);
 
 static struct i2c_driver cyttsp5_i2c_driver = {
 	.driver = {
 		.name = CYTTSP5_NAME,
 		.of_match_table = cyttsp5_of_match,
-		.pm = &cyttsp5_pm,
+		.pm = pm_sleep_ptr(&cyttsp5_pm),
 	},
 	.probe = cyttsp5_i2c_probe,
 	.id_table = cyttsp5_i2c_id,
-- 
2.53.0

