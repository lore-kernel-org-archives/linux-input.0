Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A031DF75A;
	Sun, 26 Jul 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061088; cv=none; b=U68Dr9t3L6E/EE8suKBHPmkoYJ57GehMN3oI3xshKZsTl7RLv0jiCiTKDGkexLvQscOye/CFAw2YNwtNCBKEtGmsAhWCXgHASRpnRvF61rThDxHRz1gjjiLiISPeaDVLcMK1iOZVjZ4qv5d5h/Zhfm3nfjLe7Vxgl2L1L/rEOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061088; c=relaxed/simple;
	bh=2sCMJcF/jCocaMKemz+wYTGzNVDJYYar2m0z6xYBIVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FndJfrb7XFuntMstG/mATR0r0UxAz4xMUZ2HxEPEgtrZDJT/vxlOgAMFuodrCZ2m1T2LXLh6SEF7myFbUQXoF3hliyMPjhZ8RM3sTyYy+hyZCmjPNlW9V7HMtLAOlUlcPMf6r7vF2ai8yXyzhF+tMOclZ3VY/J/SfteHRuQBoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iVPIPOdb; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iVPIPOdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785061087; x=1816597087;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=H0Zz7eGZyr6tCR/p+X6brzlZictdZSNSnyLXgYwWiFg=;
  b=iVPIPOdbuAYvvDd2lcGDhqTJN872jYwXFzmoC2d9tC5lRAMA7eEKN9e4
   aQLpuYBlTNRHzUMIuAhufN2twhG45Wl7Trp8SlfdrWygXoYh8NAbje9iI
   ZCPlQzqn7VpZLeSgtQAhE9gZLnDZmLcY9J1X2AAOPZyTCAt0+o8guRZoc
   E2QfhDzmaILLx1xuUm9aGplqkTlLsl8qTIglT5hb3R2dynPCm847BYe8C
   QB1nMW/yP8STXt0kaI6osnKav2a4zGByoh7SQnGlcnBio/uGRDiQf6d4B
   o1lLVKgt0ZL8jTVC+LNjEOUSiENmf6J1Zxwx1BqHN/zqbAHCeWYVrSoeh
   Q==;
X-CSE-ConnectionGUID: vud1WTq9R/C9GRtP7z26Uw==
X-CSE-MsgGUID: oEYc6VHOR6q1Em8qHCSR+w==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24158551"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 10:18:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:20197]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id ed4d1425-a443-45a0-8cd1-ce8b0d8c0c5d; Sun, 26 Jul 2026 10:18:03 +0000 (UTC)
X-Farcaster-Flow-ID: ed4d1425-a443-45a0-8cd1-ce8b0d8c0c5d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 10:18:03 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 10:17:58 +0000
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
	<frederic@kernel.org>, <kees@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v4 02/13] pwm: iqs620a: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 10:17:28 +0000
Message-ID: <20260726101739.33170-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726101739.33170-1-farbere@amazon.com>
References: <20260726101739.33170-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
iqs620_pwm_notifier_unregister() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/pwm/pwm-iqs620a.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 13e5e138c8e9..12f7b1415ed4 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -173,17 +173,7 @@ static const struct pwm_ops iqs620_pwm_ops = {
 	.get_state = iqs620_pwm_get_state,
 };
 
-static void iqs620_pwm_notifier_unregister(void *context)
-{
-	struct iqs620_pwm_private *iqs620_pwm = context;
-	int ret;
 
-	ret = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
-						 &iqs620_pwm->notifier);
-	if (ret)
-		dev_err(iqs620_pwm->dev,
-			"Failed to unregister notifier: %d\n", ret);
-}
 
 static int iqs620_pwm_probe(struct platform_device *pdev)
 {
@@ -218,19 +208,14 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
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

