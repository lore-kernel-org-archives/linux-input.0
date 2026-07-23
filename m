Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374C39733E;
	Thu, 23 Jul 2026 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829228; cv=none; b=f3mF51CIQL/9hWRZz34DdxGzW5ju7/91aRvWo0qcP0CW4khjZRNPrPcLoLasRZw7C7cSV1Q1Gdmp6bJW3hpjGCXtFwhgRL27PgNpuJUHZaCXwAFEBVUKnVQ17+RRQgGQQkNL3UW0yMFIWDWQPJyRPPOevqcw5yYrJ06W+0pFoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829228; c=relaxed/simple;
	bh=2sCMJcF/jCocaMKemz+wYTGzNVDJYYar2m0z6xYBIVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJXO+kqpaVDnFXZbS+2t4kWm9YzzMfy33BzDIWYziPMKOimqaKvRUEoORMAsmXVR2tz9pUKFYup+3vwXN62PLMlY4lhHOjmZ0kd3nEvDiXq/HOP9Zovi8rfu0UMRjrh3ynseOf4IaKbYm584qlFn3yGse3HfgvtC1pQht1O3X9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hCz/6qvV; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hCz/6qvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829227; x=1816365227;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=H0Zz7eGZyr6tCR/p+X6brzlZictdZSNSnyLXgYwWiFg=;
  b=hCz/6qvV0D0I6eI6iHkCMiVSyMQKsFX21upkJjoj9P4S13sBgisxsz9k
   +DbA8uK+CUAbY3A7rVNky4tREh7hNzCMKFr8MU9c3rDosnf5f3AnnYgb0
   iyHL84vjSFmSYCC0jAwGRClpITbo5Ky5pjeT2WcDsejz12t0qe5/oHYSy
   YnSMFJ/9d1A6HlWjOEjGB+4SZhmpuVPhUxCahXY3N8/tNhrjOZTYIIXV4
   9fOUkOhLCUgvE/AVORwVP66K5S4MHrR3JnoSKTQFI1JoEhO2dVyfYiTNQ
   ybIUZMEIySbotdUu2ZDx8u23+2QwqsvIHGs8YOCJ2cAibO8d7LKr/Rdfk
   A==;
X-CSE-ConnectionGUID: jmhfjCStQNGT6oivhI+cHA==
X-CSE-MsgGUID: eMJeR0UkR4Gb3ZXgBKd7uw==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24266669"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:53:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:7565]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.20:2525] with esmtp (Farcaster)
 id 70b5ea54-6ba6-452c-b9e1-d751fadb1b47; Thu, 23 Jul 2026 17:53:47 +0000 (UTC)
X-Farcaster-Flow-ID: 70b5ea54-6ba6-452c-b9e1-d751fadb1b47
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:53:46 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:53:41 +0000
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
	<farbere@amazon.com>, <jason@os.amperecomputing.com>, <pedro.pbg@usp.br>,
	<paulmck@kernel.org>, <frederic@kernel.org>, <kees@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH 02/12] pwm: iqs620a: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:53:15 +0000
Message-ID: <20260723175325.37397-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723175325.37397-1-farbere@amazon.com>
References: <20260723175325.37397-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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

