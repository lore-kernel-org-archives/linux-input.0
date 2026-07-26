Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5B2E7623;
	Sun, 26 Jul 2026 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048002; cv=none; b=r9+J3ABJnxtJuxmhLRes7yp8rv4YY3uZaotAHHGTf6QcB1B1cAufYMVJ0ZywWqAKiRMVKAp6D+p9aCL17AwxSpeBXbgFXdYECp3M85sldrhsPet4Bw6uNyZXG2lZ/ifqCrgJMYqtgQ8f94DTOgusfTZzRLAYznE6EwRyYQORwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048002; c=relaxed/simple;
	bh=2UZaQQlsQT8zkXST8gzvEPpdtHMmLewK9HtUHBtHHVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keEhMfna6NydTedk8Xn3WI1APROdYf0ecDGVThj0iJ6yTYn4PXLNn1f14fMHQWrrEWd9ntTvAKn1zgXNygS75akaK1D+HZAgSmtZDIMhH40I5BS/gCzuczwdn4bKPpJoWWpwpJieqnL73d8PfVCMnJ7DryEtn4AlA4hOIxh4g4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TkwayOkj; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TkwayOkj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785048001; x=1816584001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gDtBrheJbU+yqd7bADPibHx4zONzC4ypfh4Tdg/jZU=;
  b=TkwayOkjIxspvs0I2j39YvhWVSbB4O53nxs7gzzcsAD97cExoMlSm6nV
   JlFP8LyTY7UgLtnJYMnDkkoD/EWJQuoKpBQe9+i7KrZXJHEAsdb14jUe/
   plBM9ehjt7L7oy1Ah65KCgGkxEKsZInGgICwp2fYtbXhMf1gd7wKYZ8sh
   1jx7zDTXmN1/lXOuPU/2w7YlqA8PXfZG9mIcXFa2h3ot4la3qPHUMdGD8
   HMhzmQmJOogLkw/i9mZ8uviyPdHmiYelS4jBpB/eBdk4rmsZwr/Suc9LM
   FCfMsnt6MPyG+/rUFjImWRvdgQzLvZoGbAaQalXCXxuNG4SDAnUasnMPS
   g==;
X-CSE-ConnectionGUID: 7F48ttWeRt6wDIEtenPdNg==
X-CSE-MsgGUID: 5/1ZUr2NSgCJpRlIUZsx6A==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24132971"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:40:00 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:31900]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.20:2525] with esmtp (Farcaster)
 id 8511e2e9-454a-4f02-8900-82b185276e66; Sun, 26 Jul 2026 06:39:59 +0000 (UTC)
X-Farcaster-Flow-ID: 8511e2e9-454a-4f02-8900-82b185276e66
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:39:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:39:54 +0000
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
CC: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v3 10/12] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
Date: Sun, 26 Jul 2026 06:37:25 +0000
Message-ID: <20260726063727.19111-11-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the atomic_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_atomic_notifier_chain_register(), removing the
sprd_eic_unregister_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-eic-sprd.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 3b7ebcf12fe7..86eb9624d38a 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -601,13 +601,6 @@ static const struct irq_chip sprd_eic_irq = {
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-static void sprd_eic_unregister_notifier(void *data)
-{
-	struct notifier_block *nb = data;
-
-	atomic_notifier_chain_unregister(&sprd_eic_irq_notifier, nb);
-}
-
 static int sprd_eic_probe(struct platform_device *pdev)
 {
 	const struct sprd_eic_variant_data *pdata;
@@ -690,14 +683,8 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	}
 
 	sprd_eic->irq_nb.notifier_call = sprd_eic_irq_notify;
-	ret = atomic_notifier_chain_register(&sprd_eic_irq_notifier,
-					     &sprd_eic->irq_nb);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to register with the interrupt notifier");
-
-	return devm_add_action_or_reset(dev, sprd_eic_unregister_notifier,
-					&sprd_eic->irq_nb);
+	return devm_atomic_notifier_chain_register(dev, &sprd_eic_irq_notifier,
+						   &sprd_eic->irq_nb);
 }
 
 static const struct of_device_id sprd_eic_of_match[] = {
-- 
2.47.3

