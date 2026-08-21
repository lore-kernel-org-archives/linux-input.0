Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDAC2F8E8F
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279999; cv=none; b=kzzGcFnDHgRFH6x/1GwNgKSZNds9X00uZbikH558zQzKAiCGRIVsDAjpbqAwBNpUqMAardsPch9xIwe6s7IwALeiFdpppXP8p7Y2AXyV844wPy/9Of0lrc/Bdxi6ldhEZYjuiH2PU8FiivZxnvQEQUtpgpbxYaAQHxx/R5z5Lls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279999; c=relaxed/simple;
	bh=HE4yGj2yzR7i3hY2ECb74e0CHgrH2ZdPXoa4VBpgUSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9a8mv+zmXR0f+WsWPsZ74486JI0n/XHBgII+i2+EHIJZ0+QAMUP/9ybR7OwYt0EjhuxevrNAsWsrjxs5toiT1GiJaFew1Gb9IJ+naB6recAiwegrtgxmyd22VMg2h6cyz4IpiDxSi9e/D+BqYekqD2V1L7yxnuKFLUcFRSeoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbZ6UJqR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbZ6UJqR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848743155bcso152505b3a.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 19:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787279998; x=1787884798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbtpPhjBOt68lCtkFvblCddC1916ShOnlAarOKi5cWI=;
        b=lbZ6UJqRKNSCp0S0078PiISieyPwf6GQyLKPy7ANKGZVAHU1lTOWPIWHWzbJg2Lvb4
         tVCuSgf1HcGYk+GVhRa+oEG/CplczWmdxryl665jb7qVXINPO9R1T8PMuKO0nNwvXe3B
         XS/PX/qkghQRQ/qrcSQ2bVZzCfzJFEf+Nq3hYC9gWKdeXs6pn5y2CRgda6vmL5eJaP6U
         ZuSndehfX9em5TbL2Q9atQMeQ7oFkhbjCXZT5s2ODUtzzYdjJYCd3uLXGHV5T7IlSs7/
         OkhikIn1UNqp4V2D98LSGfXdSS0AFxTNvCNE/P/dV+g6ZuG+VlUbViPBNTQjnLerDkoc
         sV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787279998; x=1787884798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbtpPhjBOt68lCtkFvblCddC1916ShOnlAarOKi5cWI=;
        b=hR8bWX/WIza+zB6cdoIg4UZjt99ClIoalmQTEvgc9JfRMuqMpxqRNMrGfLhX27usUb
         KGwl4cIA2w+Qige6XHLNk+5xPjOb5ZR2NXcTmjO3uFueTlKBLOk7XF5vmJHrBdyvz2k1
         jOYdcVZ2mNAQ5qoTQoy7dJmxqg7/FTkUktgGZdx6bp5aO/1AIMkfGvDEbNA+ORXnwmfa
         TCC1iiaLQYEdDsCXhTi8aXhSczOZZEU5lNi1esjxw65Q/fZrdQvlpEX4NIRMir5CyZhl
         55sFY7+R745vZlckp0gyXph2+Wlqsj3OxX0DcDr8i6a4YXi0yjuHndeI+sg6uOrGigyA
         hK4g==
X-Gm-Message-State: AFuF++k+fXgfuQdNGldI++vUG4VDyiFy1rgG1OwMaW180UrpWr6+YAYf
	3gMBsMC5xSfCnbhtG6TDJ2kwmxk7xo0e0REdigzCZ1+fRbx+CYE1rsQ=
X-Gm-Gg: AR+sD10bXBMnypbMO64f2RTM9G/ALRmPaDj/bzKYFkW/ANXr/YD6ILjkDQU4pQT19qC
	24876NJteWdZaXZZnlbw1/aa+GZR6XWqBXQt5GRx8ZHTsJRa0XeSpOoA0id2E9SvSNzUFvX/Ryk
	utv3v48EFLgZIN7Yz3+6G2eyFcIN9CciS8kHaHgPdwnDf1wH57ZCp1Fb/mQ4ov7QawCSQXu3cR8
	6V+bSuAGaHfyYFceeMlIJP5iync/l83uD7AiKFkwziECAg93sYfl1CiAU6mGFTB7N9/O7msf4AV
	eQx8p+gm2lOJ3+VJ3rHapdrKHAFY9kRufC6pkyp9yBKFXUvH1EEOwE+0C731AhCX14LvBsuBeST
	hassXAF4htuxkNMNhkepPk9AeSQY2DlSzaS8Q/NeKg7bCucUwYHe64XCSQhZipn5HOFhhve5/NS
	zLF1vEl7hA8e8GVs8tiezDbcasVpaD2r/eCmkDRepkAcFisuD+Z0zyHZze/3bO/Pbdrc3L6XRaw
	g==
X-Received: by 2002:a05:6a00:a91:b0:845:ba94:a56 with SMTP id d2e1a72fcca58-851f987d3a0mr4634028b3a.5.1787279997742;
        Thu, 20 Aug 2026 19:39:57 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3617434sm2281487b3a.29.2026.08.20.19.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:39:56 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] input: keyboard: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 21 Aug 2026 09:39:51 +0700
Message-ID: <20260821023951.53199-1-triet.hoang.dev@gmail.com>
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
from the resume callbacks and reduces kernel size
when CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/input/keyboard/imx-sm-bbm-key.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/imx-sm-bbm-key.c b/drivers/input/keyboard/imx-sm-bbm-key.c
index 96486bd23d60..7fbbd44878be 100644
--- a/drivers/input/keyboard/imx-sm-bbm-key.c
+++ b/drivers/input/keyboard/imx-sm-bbm-key.c
@@ -187,7 +187,7 @@ static int scmi_imx_bbm_key_probe(struct scmi_device *sdev)
 	return ret;
 }
 
-static int __maybe_unused scmi_imx_bbm_key_suspend(struct device *dev)
+static int scmi_imx_bbm_key_suspend(struct device *dev)
 {
 	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
 
@@ -196,12 +196,12 @@ static int __maybe_unused scmi_imx_bbm_key_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused scmi_imx_bbm_key_resume(struct device *dev)
+static int scmi_imx_bbm_key_resume(struct device *dev)
 {
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(scmi_imx_bbm_pm_key_ops, scmi_imx_bbm_key_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(scmi_imx_bbm_pm_key_ops, scmi_imx_bbm_key_suspend,
 			 scmi_imx_bbm_key_resume);
 
 static const struct scmi_device_id scmi_id_table[] = {
@@ -212,7 +212,7 @@ MODULE_DEVICE_TABLE(scmi, scmi_id_table);
 
 static struct scmi_driver scmi_imx_bbm_key_driver = {
 	.driver = {
-		.pm = &scmi_imx_bbm_pm_key_ops,
+		.pm = pm_sleep_ptr(&scmi_imx_bbm_pm_key_ops),
 	},
 	.name = "scmi-imx-bbm-key",
 	.probe = scmi_imx_bbm_key_probe,
-- 
2.53.0

