Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA95B303A0D
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787285756; cv=none; b=Krjzz7VMoxiR/UOIjtE3ol0u3QMcOaPpjKGikEtLFYjeadjea3BddukvlRCai+ebfhnEC5kItMSex/HbhdDhmYHX3FICB40tRMXPRdP49n2ZNHXjUyeLFvXjy3487mUpiNBlEyJee3AfdPwk2afnjbP9cFumwB5znRb17I0hy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787285756; c=relaxed/simple;
	bh=UTxOTV4kGSTjvcoox5bHQqKXcAIatDrWgwwGyJBDBsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gn/dblOsVKJaL/I8ptkjjb6b5wTPanDZRco7CoXUHm3txNXPqzRJ6lSj2fRfXnAU/TtvYzvBHT69K6YBn/NJg5wg80PVqYytSjCNeZa/7Fwm/2xWsLs12D16Av1JxnrACW05dprh6Swo+/OsE8J7ceMlTum7naXv89Dt6BIp58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3vm4Srp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3vm4Srp"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caea3f742bso10318955ad.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 21:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787285751; x=1787890551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBJ4tQBYxm4RPSXn2bAnXHFKOJCVzuqbpkib1MQM3T8=;
        b=b3vm4Srpo30nu3mG9FwF+GJMuy6uhSt8bYChiN12bVFvqfCR72KYbK/L1NN8DKgF4p
         6zPlO/l41Y9qHnzQs8UX/8wjEWXOsiXTdfK+ULZmnfFp7R4u09tF56q5A7dABA6k8BLU
         d/oT6fReQjVvd8uqrlP97QHDpcTgtvFHgzsXTmcHdePA5gvoewIRewwkXzEtevW4Qkdq
         khjUge8nDU59MLB9iRhP8uKz47c78STFoukYnPwsk3nYH4bD0FPW/JW+eAS+exg+LVaQ
         ht0eE/NrdbWA042tODe3cabg1peG1exW4GO/dvs3fieDT0k0pKsoepimwVRjJ8ehRFLB
         c0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787285751; x=1787890551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OBJ4tQBYxm4RPSXn2bAnXHFKOJCVzuqbpkib1MQM3T8=;
        b=gPJ8bMVIxkGJ2odTkRPzuNAUpO++nAN6x1D2NHeWUhkHAzmywK8ZrCraJZwbq1NzvC
         q5vsiy/vy8Rwugutnd0XaCndoCEUyiEzAB+TmY8dShAtwm0DtU/rX+U0tyW+2wyF7kIV
         DXb49vFDRD2xCQytktU/dmEcypfU/5jlYEdXcu7RLeY8SCbtq68hQqsqJQrz0mH00wIT
         CkP408fS0bpasg1PDFXIuZPlfIVz9BvFeJXIYfnbVpwXwh5mLTNeWtfvhPcoEx3fkvlC
         iDFY0aPVaJHz/UTUtNeQ5PrPZAwOn6YgAQmMuMyMhc5yMbYEVezPa5XsxgjMBQgBMkR3
         O+Lw==
X-Forwarded-Encrypted: i=1; AHgh+RqcPtNB0WzTEXyMZDRffiYq/6nrgZYw6R2Zw5VX3XokH03G9oqD+OkVt+ZLTMQn1Y3lhxvQiGit6fmRZA==@vger.kernel.org
X-Gm-Message-State: AFuF++mSNTxv7Dhn9fk2+9CWCWC6PtOPOZ1jnxQHs5L/os5I4BZXuamN
	bueaJ1gdH5PSJkDWB/zIYEeU98G1OKXao355E7KaFBaritBw/oe4fV0=
X-Gm-Gg: AR+sD12/ehzSWva7lEcHEZgEyn6XHmsjV4JqtufGDxS9y5p9lsTV0xPdKp51RoZf0Ek
	JkaFTF+V9rx6Hz+LE3WKSSFZgsiB+Uvg/c+8qW+J/c78zuwpnCFLKufT10DXxLkfihcU/lENIjS
	2P/6avwORj24trmNxGTsASqZkB3fhosdnjw3jYMDV4LC118obnubOTJy7goCtR7/CkJcly3wK+E
	CYqyoaOIxMX5hVagniqD+qtLnVrgU8yvec1angrvO+PdDl3GKxPFlHj7nHdRVhZJ+OFOPer3tU+
	68g9oQ2lkruwZXF0bVGDBxw8yJ479B5cxAMLic+mh4GeFsY8o2nwpTdo86A6gi+niAL1jwGEddX
	+MBJrHGvz7LmsqQpcsilwTIK2KLHxH0fpjsZL/D9g8eOu/x9mvLbf0J3agXWkHVvXaNov9FwROP
	Vn9sLPLae6l4imptf3TpJIPVzpUUMregoUrEiQMfYnZu3hM5miOtmzpSatMSIZ4zDKkp9yUKTSY
	g==
X-Received: by 2002:a17:902:ec86:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2d64ae3ac9emr65627755ad.2.1787285750869;
        Thu, 20 Aug 2026 21:15:50 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3a2713sm13756045ad.58.2026.08.20.21.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 21:15:50 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: sashiko-bot@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	triet.hoang.dev@gmail.com
Subject: [PATCH v2] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 21 Aug 2026 11:15:46 +0700
Message-ID: <20260821041546.110119-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821025021.9F9891F000E9@smtp.kernel.org>
References: <20260821025021.9F9891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_ptr/pm_sleep_ptr().

This lets us drop the __maybe_unused annotations
from the resume callbacks and reduces kernel size
when CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Use pm_ptr() for pm80x_onkey_pm_ops
- Remove #ifdef CONFIG_PM
---

 drivers/input/misc/88pm80x_onkey.c    | 4 ++--
 drivers/input/misc/nxp-bbnsm-pwrkey.c | 8 ++++----
 include/linux/mfd/88pm80x.h           | 2 --
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
index fee28e537898..3d8fe0b4ed50 100644
--- a/drivers/input/misc/88pm80x_onkey.c
+++ b/drivers/input/misc/88pm80x_onkey.c
@@ -47,7 +47,7 @@ static irqreturn_t pm80x_onkey_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
 			 pm80x_dev_resume);
 
 static int pm80x_onkey_probe(struct platform_device *pdev)
@@ -138,7 +138,7 @@ static void pm80x_onkey_remove(struct platform_device *pdev)
 static struct platform_driver pm80x_onkey_driver = {
 	.driver = {
 		   .name = "88pm80x-onkey",
-		   .pm = &pm80x_onkey_pm_ops,
+		   .pm = pm_ptr(&pm80x_onkey_pm_ops),
 		   },
 	.probe = pm80x_onkey_probe,
 	.remove = pm80x_onkey_remove,
diff --git a/drivers/input/misc/nxp-bbnsm-pwrkey.c b/drivers/input/misc/nxp-bbnsm-pwrkey.c
index 0c7b8f8ef4a5..6af6e0f6395f 100644
--- a/drivers/input/misc/nxp-bbnsm-pwrkey.c
+++ b/drivers/input/misc/nxp-bbnsm-pwrkey.c
@@ -193,7 +193,7 @@ static void bbnsm_pwrkey_remove(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, false);
 }
 
-static int __maybe_unused bbnsm_pwrkey_suspend(struct device *dev)
+static int bbnsm_pwrkey_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct bbnsm_pwrkey *bbnsm = platform_get_drvdata(pdev);
@@ -203,7 +203,7 @@ static int __maybe_unused bbnsm_pwrkey_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused bbnsm_pwrkey_resume(struct device *dev)
+static int bbnsm_pwrkey_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct bbnsm_pwrkey *bbnsm = platform_get_drvdata(pdev);
@@ -213,7 +213,7 @@ static int __maybe_unused bbnsm_pwrkey_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(bbnsm_pwrkey_pm_ops, bbnsm_pwrkey_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(bbnsm_pwrkey_pm_ops, bbnsm_pwrkey_suspend,
 		bbnsm_pwrkey_resume);
 
 static const struct of_device_id bbnsm_pwrkey_ids[] = {
@@ -225,7 +225,7 @@ MODULE_DEVICE_TABLE(of, bbnsm_pwrkey_ids);
 static struct platform_driver bbnsm_pwrkey_driver = {
 	.driver = {
 		.name = "bbnsm_pwrkey",
-		.pm = &bbnsm_pwrkey_pm_ops,
+		.pm = pm_sleep_ptr(&bbnsm_pwrkey_pm_ops),
 		.of_match_table = bbnsm_pwrkey_ids,
 	},
 	.probe = bbnsm_pwrkey_probe,
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 551ef1c367d6..be1b0d961e01 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -339,7 +339,6 @@ static inline void pm80x_free_irq(struct pm80x_chip *pm80x, int irq, void *data)
 	free_irq(regmap_irq_get_virq(pm80x->irq_data, irq), data);
 }
 
-#ifdef CONFIG_PM
 static inline int pm80x_dev_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -363,7 +362,6 @@ static inline int pm80x_dev_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 extern int pm80x_init(struct i2c_client *client);
 extern int pm80x_deinit(void);
-- 
2.53.0

