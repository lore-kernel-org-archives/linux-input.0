Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594625CC57
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280141; cv=none; b=jbNbgzMHUq0m/NDJdb8jmrWJJiJNrnsWpHOgE/QFOJPjb3VYa/iNH1yAUZ2hstOTThCEutnibmq9xoKwRvKTTjTGsfErZ8v5L/Y/QJ1n5yDYhGPpUcS+PhCrRMLoePIWvVFJU3FSdkug5oTkSP4rCiiXeavIoLt/eH5gPpymgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280141; c=relaxed/simple;
	bh=NVOJsEikwA/YYVkOJ9IbvLXVRTic8FHi3Biq2amtawk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGkAjxO6r31/t9Q6mevp/O039OjgN23nzdjz20ZXd8sOnSZ3+vvtPSIaUDE8GPflfCps9PKXeNiEPSVf+v2Ua5okSIWMz0BdW6L+qj7Bd/6lnraD/h11uHWS09+VxvVeK+WZHxFa38nsXt8+5Qe01q/Yu0MHFxhPH7H6xgTr5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHUCsFuV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHUCsFuV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so585130a91.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 19:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787280140; x=1787884940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qx5/KnGpeTJjpQVMweEzIC+HFIl9AM6R53rqQRtxK9E=;
        b=dHUCsFuVjLFzSbaiNB/Z7UGiATYvKMYSNWstFfVcBy3TNgYejDgsvVfDP+oNiYe0Al
         GUNV1wXHhus8O242ViSDNoGQHviMm5usHbSOvUb4kkTgmOKrP4K86V1V+SupgIpJHglT
         kv6nE1re5Q0o2ND15pxZyPk1ujkJKhrbkBrfLtdfIPPJByYIB7VGWTOw6gLsBi1c9nve
         r98AOilnqstqQ9XNxOk6dJt7nq9BuQlCRBAq1J1silLo6XmwJurO7X5I3nX459SatMJs
         vRz+EaQJzl1tzF4AQ6UzJ4b4S7+Kh0zzjM8pTLEOqo+9Jpu/EpUtn6fuPlK3Z0NGi7FK
         Wl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787280140; x=1787884940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qx5/KnGpeTJjpQVMweEzIC+HFIl9AM6R53rqQRtxK9E=;
        b=Rk0Wi76tAJwGTbcPq2T4e7+P/3qhXrNmOZemONtD+FuPxloskjjNbQ5fcwCvRU5rfx
         6gQTOEzbcnu8+PQQNwAMGebF8/GEsc8iy8sLYZC5AYAun2kl0fy6sSui2WBh4e9pCBXs
         oqjwTom/3jDcoWMx5seS3OpsgBYFImQSZd7Vrx+uqN0lS446Q/xSSzRfGb9tgcTGMaw/
         BkrEippRt28VQKITxNCzr2wo+knjepWrJPC/xlKH4VH+ja+/x6BzJO97UluGNO9+PAa/
         afs931Fuf9ahM2mN+5a1xALPX+RRYxQZUPrtQMTmsLPTYRI1JYZmNbxUVJjqiImAlB1S
         4lzQ==
X-Gm-Message-State: AFuF++mobpTGBCEYf6+p2OVpouGxwiKIBdxSNBF5/3ayi+3YwHnklGJF
	YWdt5gxaMn+Ru348k5dJ5wdeKWGYRou8ePEq+1B8787YGDsma9NaaPk=
X-Gm-Gg: AR+sD13OG40tFdp7IsMGj75bMHPjkrYhwFI9y/TRNPmPx/0EULkqNxern/reWZZ6ymG
	hYwPlhPpEriEJv51cIMNUE4iymTc589xOun5u0Ho5Ipo7fXPWi14S+0oQLMD/R9k7h7pbCNSbml
	d6DzOin2r7xIfZba29o/ljS/OJWCbBg/tUC5Gq4KIhLRjbmoRXf49f62nO5fsgMon2ukGWkZlBt
	Wp+A1v2/cKrrTw4ZzNmaFqDR/RbaE3Zl0fqKF514s+akCBpEVSpGpiJX04/7p91IpC+8ikoqKht
	Ibhdf9Gv0gd8+crN7qtIEMcYIjlL8XCAkjclKlEvPdUyudKJQdgaRutbfTs8UxR8UbONfCY4ece
	tNnG/tFYVYZbNJIBFIzhq5drqzhCmKGHRotpKrukBxaEPjnYqJRob5NrR+PzFaP9CpDCSI7xcnX
	sZzIiW8K1sIUR21WPp5+uYk7toqPncHI66ly19B1nIFyrCtcXFYkrGLp/G4K+ftdme3SofXwYUo
	g==
X-Received: by 2002:a17:90b:33c8:b0:38f:57f0:1f5d with SMTP id 98e67ed59e1d1-395c397f4ecmr4791742a91.15.1787280139848;
        Thu, 20 Aug 2026 19:42:19 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c47f7d78sm1088087a91.9.2026.08.20.19.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:42:19 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 21 Aug 2026 09:42:15 +0700
Message-ID: <20260821024215.55188-1-triet.hoang.dev@gmail.com>
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
 drivers/input/misc/88pm80x_onkey.c    | 4 ++--
 drivers/input/misc/nxp-bbnsm-pwrkey.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
index fee28e537898..d4f344e2bf5c 100644
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
+		   .pm = pm_sleep_ptr(&pm80x_onkey_pm_ops),
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
-- 
2.53.0

