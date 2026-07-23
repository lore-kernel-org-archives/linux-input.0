Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A582D12EE;
	Thu, 23 Jul 2026 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829329; cv=none; b=lQGUiWltsjvs8mTglEsXs4kSnISs1joa2pM2iSpnMnJ4v5lpBHxhDxceAv6ukMSROui60zP1VRVcdWhlKikiW+mrQ8xGc6qhku3IU21pnuR8g+NymmsQv+AgDTVKXgvF0+dCO+CV74XqWmcYLFbN0yszXSJX/NBiPh7YT9jn0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829329; c=relaxed/simple;
	bh=pCCUO6JOWdcQVbImUjQX6hlFOQvlNXyRHo3sfyYkviA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sHcOwrCh+jBZcWM6ASBGaeuStNjK2TjWV+/bT+eHRF4xAGxeTEWeOnnnif0zmtUFK1ZHdXNHXAMEUvoC1S3JlauZYJSsIAX3H3h1xxqCXolGL+1V6E05Q8BOzCiYWryr5yEmUmtcX63PU0yftezUeOs20xYWDgQwtwAM7t+p9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fRU3zDO6; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fRU3zDO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829327; x=1816365327;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Hp9f6tIRgT0suTvhMA27AYmbAsFpEPJVOMsmC/1oKA=;
  b=fRU3zDO6P7b869mtU2f4yRKFmmespi4HA9JU/38LhG3P+JtdzHLd8ucu
   sV8mldR445JOHqm0CQoWaQ6iClUCc0fbCikhqNUNRjJ8MfRJvH8mrX4sD
   zQuHmj/ob7tFvpM/EX7c8lSNDr57DYPy6N/gkrHoo1drukflU4eoFonu6
   muclyzKggAfVZ4BVUPdd0fDyvWQzm8IlJJ3tDeTpiGgEHqlQ517b+JDIH
   nYb8Yh9/PLiPx4zlDVKA8b6FDNIZVipPRVjRxZw6zI1S+KWrWTqmn9HEA
   qaIpGoa3JCR3piav2xnpKAq48l+/zNCE7kTAxpfDKpm5zw8ndJmZOO7Ao
   w==;
X-CSE-ConnectionGUID: UsTBgKs1SPSshebc6mNtYQ==
X-CSE-MsgGUID: nsTf7wJXRluTb7dqCJXxrg==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24227981"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:55:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:26670]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.176:2525] with esmtp (Farcaster)
 id 46212030-b61f-4fc0-97f3-53aa3f3132a7; Thu, 23 Jul 2026 17:55:23 +0000 (UTC)
X-Farcaster-Flow-ID: 46212030-b61f-4fc0-97f3-53aa3f3132a7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:55:23 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:55:17 +0000
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
Subject: [PATCH 05/12] gpio: adp5585: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:55:06 +0000
Message-ID: <20260723175513.39849-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
adp5585_gpio_unreg_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/gpio/gpio-adp5585.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index 6f10fc646008..7c04a7e86c8f 100644
--- a/drivers/gpio/gpio-adp5585.c
+++ b/drivers/gpio/gpio-adp5585.c
@@ -390,16 +390,6 @@ static const struct irq_chip adp5585_irq_chip = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static void adp5585_gpio_unreg_notifier(void *data)
-{
-	struct adp5585_gpio_dev *adp5585_gpio = data;
-	struct device *dev = adp5585_gpio->gpio_chip.parent;
-	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
-
-	blocking_notifier_chain_unregister(&adp5585->event_notifier,
-					   &adp5585_gpio->nb);
-}
-
 static int adp5585_gpio_probe(struct platform_device *pdev)
 {
 	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
@@ -450,13 +440,9 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 		girq->threaded = true;
 
 		adp5585_gpio->nb.notifier_call = adp5585_gpio_key_event;
-		ret = blocking_notifier_chain_register(&adp5585->event_notifier,
-						       &adp5585_gpio->nb);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, adp5585_gpio_unreg_notifier,
-					       adp5585_gpio);
+		ret = devm_blocking_notifier_chain_register(dev,
+							    &adp5585->event_notifier,
+							    &adp5585_gpio->nb);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3

