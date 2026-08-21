Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D7175A9C
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280297; cv=none; b=stpGLBZIyxFp+imb3fgRigBd6x6Xf+PG9Fva9D29/MScCPzc7blwImI6AkJwfdAvhCXfY22uKwLbAnhCOrhpi2yNg6sKhq7HmMmsrcH4rpUE6hDgMz56TlIQupllpknkLaxwyA939nQaM6VtvWLNo0DlgFt50f/jCE240viPDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280297; c=relaxed/simple;
	bh=vRA2sJEUXoiFLYGZ0GF8NQIPMYJHCWwrvydMdhrV+vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJRI72d1u3NLJsLUcD0LQXtd1vT3kqP65JQkFu47ndnTkfmu7urqDbOaCn/ZFmJQXtSia3MBd/oprfKTOzSjQEhJNOk1dV0othaGkVAvWoWmGhbp/5Bu9oZytCga/D1ga9Ow/4sffOT9xyMIUaq7k8koAmEtCuiw1PdxxY//VSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afL9Vme7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afL9Vme7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso9463125ad.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787280295; x=1787885095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OB4m8MucU/Imj+UQ+hoiF9fZmikX5fEf4VhM2HKdKj0=;
        b=afL9Vme7aNV09k2P6BV7CmNvP/cWE8JkHUU6wiwj1I+LWLU8mzOJLMxz8Gx6ZmojaF
         gpP+iomRJRHuVMmggvQcrdQKrBUgSwPXxV4gxnQo7rxeB1TGAhO4G1mjLuYX3KOpHk2U
         VP7rZK/FNFdTg1XhacxjId+7gWZL+2H+TZ1wFpoRv7FyBdhBnM4X/1BZH4F7L6fN1NNL
         2DA2M3T5DDdRQSiAy66vZtpnF6PqCSreE7yhG2e6+EtABBt/1ETYS0uFUjkgKo+Enkm7
         7MLacCKCfXAlv3pbni05OBoxQT+4h2yoghUdgxDCxjJzJFv+TG0tbA9691hIyL5tJx/v
         w2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787280295; x=1787885095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OB4m8MucU/Imj+UQ+hoiF9fZmikX5fEf4VhM2HKdKj0=;
        b=rkCK/C5vaPh8wzguXcgxLV8fLLY+vGhTj24+ygiGfc0dPWEviI/CmQbBfF0iGCvRwV
         wbe7GYxk721AApyWfDm5CPFTZ30l4V2iaAwRdSAy7NEHp5eZgTgXYoovIrSEUihFaW0v
         1W6y339DtRO2hEPHF8Da8PbfsgBFWmz2/2W2ZBwqWDvN5rovPf2WkT6XvQ6yT9B/gtSY
         E2N8O9skChtvmXECj+C8CoNit/t3KRYN1lk1x/GvJ0m/pIoYDr9XQ7QhI51NB3uTx80Y
         kbP2nvgBMrd2eywpMgVwg200OTL5y9AvGY0ilZjyW/zyfTKqpSFqxSlBedyHRFy3M1bo
         0YKg==
X-Forwarded-Encrypted: i=1; AHgh+RqR1eiQQsoP7Fg57NbOIrt0LQYv8Gy9y6CaopgIOk8EwN8bbAjVcoydNYU5ZUw28SCF82G3CFriJPQcDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0zxcvlDJKzTcWwHcivG9OI1WFbb/jmybMP0z1TXS7jnF24ul
	qbP2HgY46ZexDLFL+bJXOOalim1expA5AAJOa0LPCP0O8JyoLblEzrc=
X-Gm-Gg: AR+sD11DJQ8r9oL9RExHyOTCCwjVGUxrln5cnJB1JCEUupTf2F7wrsAib7Jvg/C9SI+
	uUqII/gOGm+Q0lpVqAOz8Ph9IZTgWXmH9DtUBQm3p2ixEH10ER3u2umJ6MGubZ3KYK6CwOe/KI2
	dw4u2mSQ9eMUAz+F3qkC7Mbnm/ArXlRCNTacbGfSpjU6jyA4eQqzHvXrbaFEcbpl1D42jORblzd
	CX/PLt6YRtDH6bI4L2knneEyIopCeDA0ZKn71y23FUmkQe192IDeI1+QZtEbyTTKZ81XfT0LjIf
	C8sQ10d3idR08TpOUvKsDgGroMiISuElBYeyhsu+wSKadBuEe9gUK1zcBYMawAFPYA2lOYNea3F
	JZIPYMeCy3DzXxWkGfyva9Gx49REbSACXH0nDKtIEmGy1JNRVaZFqhCnWPdz1N3iiWfa8zpLMLX
	/COZdkRXpz+MHczCED2YTaj2KY6cR7sLdTdC+uRDqpdzMlkfzXW0CQ8bM8NwkOXgDS5lrMCccBE
	w==
X-Received: by 2002:a17:902:ebcd:b0:2ca:481:de45 with SMTP id d9443c01a7336-2d64afa4e37mr61339485ad.6.1787280295229;
        Thu, 20 Aug 2026 19:44:55 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36edbbsm12878315ad.39.2026.08.20.19.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:44:54 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: michael.hennerich@analog.com,
	linusw@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] input: touchscreen: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 21 Aug 2026 09:44:50 +0700
Message-ID: <20260821024450.57369-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
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
 drivers/input/touchscreen/ad7879-i2c.c | 2 +-
 drivers/input/touchscreen/ad7879-spi.c | 2 +-
 drivers/input/touchscreen/ad7879.c     | 8 ++++----
 drivers/input/touchscreen/cyttsp5.c    | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

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
index 31d2a3029d5f..f686f028d4bc 100644
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
 
@@ -329,8 +329,8 @@ static int __maybe_unused ad7879_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
-EXPORT_SYMBOL(ad7879_pm_ops);
+DEFINE_SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
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

