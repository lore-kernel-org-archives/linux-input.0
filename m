Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD8314B73;
	Sun, 26 Jul 2026 04:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785041933; cv=none; b=DJe52z8CshpmT2Z4mlX+aIbdP59wBagqaLmptH4/gd5yrnXj+qcmp16hcw02QHGuRKGF2g1RUk7iBEbvuME/+NMQlgB+Ala7R21s19j+EuxJ4A2cn0HMTrxwFbwC9Tt58N+NkWpRoJvQmz78329OmE+EMSJHlwziVyT+VGJQ3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785041933; c=relaxed/simple;
	bh=Mhbv/3L9S5GfOQUwCmKw84OjOJY1uPlxvUzN9T/VVYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWSLaCL7YTPXmncQECPtjqW/Yyg8Qq1IImrIp9wF3eMPE8SlJEJ1F6yLtEVtUjl8j0bNNpO9PSnoFYomn/OZlb7hQUjzG0kQ88JRQo4zc+vRb6wggcfRV0MULnQwr8cAnRHtqcXjP9zfN7Z9Hj8fMrLHzOzbhzM0AJEcY9yffgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FDYsUuqI; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FDYsUuqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785041932; x=1816577932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eYv5yeumoyEsHf7hVGI7yQF/urKfJTXlSOVtPH4d8GU=;
  b=FDYsUuqIxdgGj9AwF0JtK8Jkh19XJaac2BxBQGQguU3CLyE5wdYpSn/m
   XHFqlpdQGuzvDrfu7HxtDf+jprzrlBd2BY5dT4sdiWIw2hQQdoHXr/uwA
   YoX7xqKeSHMrdFXsV1wCmJt61kGGfzRHr8Dge0Pc+CekZYjkr2yZ9/MXC
   I4vKw73xJMUr0SgHtMrVK0CHa5ok3wEza5VeGw0KFQWhv7mzs50lBZTRF
   lxXeQ+1vvDVBD4uK0S1vZbT/RhexopD3FIKwM4mOkIKrf+mkIjZ+S/FBb
   3YbP/YmgVcw6KZqCaJRsoyBbDgZcMf7wWWFz35kpg2KraCt4Xl+KV/xK3
   w==;
X-CSE-ConnectionGUID: +XVSrFt1SYOgFiYe40HINw==
X-CSE-MsgGUID: 6TsZpPwQR8O6+uA8e0rMLA==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24381919"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:58:49 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:17618]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.176:2525] with esmtp (Farcaster)
 id 0e2ee202-4334-4c87-81cc-f902ea1d013c; Sun, 26 Jul 2026 04:58:49 +0000 (UTC)
X-Farcaster-Flow-ID: 0e2ee202-4334-4c87-81cc-f902ea1d013c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:58:48 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 04:58:43 +0000
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
Subject: [PATCH v2 05/12] gpio: adp5585: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:56:59 +0000
Message-ID: <20260726045706.8169-6-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726045706.8169-1-farbere@amazon.com>
References: <20260726045706.8169-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
adp5585_gpio_unreg_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

