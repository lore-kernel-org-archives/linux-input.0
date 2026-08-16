Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFE2EC0A4;
	Sun, 16 Aug 2026 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860433; cv=none; b=fHT2T0mEgKjSJKEE/Z/PWCrQgMJ3hAIlFQqC4crZtwocVba/K66zVa43QE6cxcJOYrdy4yk7wlo2YxnKT2Jd9QMg/YwR66FLOvrNvpnPdgFvnB2V5ZmMHTs7MWCP1z3uzD3Jr4lovKQWMxWabXG4CLX7TNm+A/Ofqdn93kP207s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860433; c=relaxed/simple;
	bh=eT80AA69sFszNFV6/owB1x4sJqsuZ6srRNzVe/2fwYM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOBResqCy4o5hTCKAexO2BoTFGUDL8bfDi7YC4R0uOjqF6yyAr0164P7djGdXiGY6N/7m1fcog7Wq/crnJI+94W/tfHFZCoG0npJhdDZxzFBGA+xFDvarEqLg/3U43nEYonRZTI9hdp9hp8YrQq2LWo1AIBxe8vGdcgCQB9ieRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VMFWg+II; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VMFWg+II"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860432; x=1818396432;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KYdzPlEap2Vb1YY1dr9VK03d8Yysb4PGF8NRIqnsbIY=;
  b=VMFWg+IIS03dxsFUkW9K3WEqw+Ph/2tnDkojsdxR0NpgUHt0/2xRIUBS
   LOrcRoKwIRvqbzdbwOvvMSCQjASP19DRQd5+hYQciIg6LBCnuXdRzik8D
   TEcvbVTlr/FzCexY4kck28PZJuoKpBFjtHC8x6aGl+PnwGRgX+7eUmoaL
   U30KD9cSXv14/qfA66vDlWnGnSCHN94KuTR+6FO1qPb+24kh3GDJ3X3Fc
   audyaNNHupXEoEsSIdAJl8ARmeoRfNkQrFQRy/QoT68FWRTtMqKkF0Hsx
   bFvWW12zAvv1FAFd4ljI3zDy6wpxHNMRuHGk5pOdWd4ErWQTJuPongCMZ
   A==;
X-CSE-ConnectionGUID: HkjcQDNbR9CnvnYPyWIqbw==
X-CSE-MsgGUID: 41xUfDj0QfGZKBNJaI0gQQ==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="25957794"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:07:10 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:10359]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.160:2525] with esmtp (Farcaster)
 id 93e3ab7f-ed5f-4b86-9c05-8ae387facc24; Sun, 16 Aug 2026 06:07:10 +0000 (UTC)
X-Farcaster-Flow-ID: 93e3ab7f-ed5f-4b86-9c05-8ae387facc24
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:07:09 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:07:04 +0000
From: Eliav Farber <farbere@amazon.com>
To: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<lenb@kernel.org>, <laurent.pinchart@ideasonboard.com>, <linusw@kernel.org>,
	<brgl@kernel.org>, <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
	<zhang.lyra@gmail.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <dmitry.torokhov@gmail.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>, <W_Armin@gmx.de>,
	<ukleinek@kernel.org>, <fabio.m.de.francesco@linux.intel.com>,
	<kaihengf@nvidia.com>, <ankita@nvidia.com>, <leitao@debian.org>,
	<farbere@amazon.com>, <pedro.pbg@usp.br>, <paulmck@kernel.org>,
	<frederic@kernel.org>, <kees@kernel.org>, <saket.dumbre@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: [PATCH v5 02/13] pwm: iqs620a: use devm_blocking_notifier_chain_register()
Date: Sun, 16 Aug 2026 06:06:01 +0000
Message-ID: <20260816060648.4030-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816060648.4030-1-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
iqs620_pwm_notifier_unregister() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
Changes in v5:
- Remove extra blank line left after deleting the unregister callback
  (Uwe Kleine-König)

 drivers/pwm/pwm-iqs620a.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 13e5e138c8e9..6c6caee65b8f 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -173,18 +173,6 @@ static const struct pwm_ops iqs620_pwm_ops = {
 	.get_state = iqs620_pwm_get_state,
 };
 
-static void iqs620_pwm_notifier_unregister(void *context)
-{
-	struct iqs620_pwm_private *iqs620_pwm = context;
-	int ret;
-
-	ret = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
-						 &iqs620_pwm->notifier);
-	if (ret)
-		dev_err(iqs620_pwm->dev,
-			"Failed to unregister notifier: %d\n", ret);
-}
-
 static int iqs620_pwm_probe(struct platform_device *pdev)
 {
 	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
@@ -218,19 +206,14 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 	mutex_init(&iqs620_pwm->lock);
 
 	iqs620_pwm->notifier.notifier_call = iqs620_pwm_notifier;
-	ret = blocking_notifier_chain_register(&iqs620_pwm->iqs62x->nh,
-					       &iqs620_pwm->notifier);
+	ret = devm_blocking_notifier_chain_register(&pdev->dev,
+						    &iqs620_pwm->iqs62x->nh,
+						    &iqs620_pwm->notifier);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       iqs620_pwm_notifier_unregister,
-				       iqs620_pwm);
-	if (ret)
-		return ret;
-
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to add device: %d\n", ret);
-- 
2.47.3

