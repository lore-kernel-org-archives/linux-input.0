Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3923644C4;
	Sun, 26 Jul 2026 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047871; cv=none; b=C2s9vvibbYqQXlbJe9M5h9t1dgoK9fynUkVRFyY4/PU06Tx9SRfEXvR35QMlve0Wb3prH71LN+cydu5DTdC+3jBKg+N3rkwFJ8bf40RjiIBPq8/FYyFW3dt1ynn3rjtWzQbqkLUa/jmt+3Z7y9GM3ZTJ5jM0HEtCGWCPC+8rhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047871; c=relaxed/simple;
	bh=2sCMJcF/jCocaMKemz+wYTGzNVDJYYar2m0z6xYBIVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHs8h7IO7cSzcQEBzC+7hYbpXVbFopLSwzuoeWh+VzV9deqa5ndppvXaJR9IobNb3nbwJR44zl4R5vm2761DBszM4y2PrTAzdBfZULHKEhKq6fhcava/EfnKPFsPsySVHc+xuNLeEqYdd0EC5DPZhmtbpCzfE8Dfmu5bKllKIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vlhvzi8z; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vlhvzi8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785047870; x=1816583870;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=H0Zz7eGZyr6tCR/p+X6brzlZictdZSNSnyLXgYwWiFg=;
  b=Vlhvzi8z/RNqlfzSEJtaUTEB37B2vFpLh16lnaYlvtsr4Jf9hYPiePUU
   /bBT9wpw1LZsYt5OCZtrrY2hMPvU7iAHwhIBZaX4nifAX06ZXvj5RF9nP
   CZAaIoTN4zmmKEaxGZoh0ixftqvm8cDpQArRdP63Ho0JtQm4Gmn6CKEGR
   hPWcHRyp0Bj9ozHQOpVQiXqwftOfHK9L0N6ilfgGw9mpurH6K27n/0XDm
   gmkaZ5F3Ophnv/3K1eEmU1toQeHzP5JMpiZ7ZOF7XxsgrS1+ipmGM8Wez
   c0nJpP3kNbZ5Ml5Pkz8Pyf1wlRScFvadr5VZHLqW9iw3mwPLy2UjRTWDF
   Q==;
X-CSE-ConnectionGUID: 0x0zi94jSKyznK0r0zURiQ==
X-CSE-MsgGUID: xcCp+tPKTwuj0oo/8pfPVA==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24255977"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:37:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:10108]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.7:2525] with esmtp (Farcaster)
 id bca6f866-2fe5-45b5-b312-411524f77c2b; Sun, 26 Jul 2026 06:37:48 +0000 (UTC)
X-Farcaster-Flow-ID: bca6f866-2fe5-45b5-b312-411524f77c2b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:37:48 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:37:43 +0000
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
Subject: [PATCH v3 02/12] pwm: iqs620a: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 06:37:17 +0000
Message-ID: <20260726063727.19111-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726063727.19111-1-farbere@amazon.com>
References: <20260726063727.19111-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
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

