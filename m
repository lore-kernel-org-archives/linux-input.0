Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06716364028;
	Sun, 26 Jul 2026 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047931; cv=none; b=cNs2XcwgDLPzHg5Q/neTiANaYXBKr6F7mC5XJwpD6UU8K35jTZisYdOPxPLAdJZjG1+cjkny/8Dnt6uCumRcyqIrHeRyE4z3BIp/+UjBNrGsxfgv6CMVnnCbV7qEiiytWrbPWN2kG2hY3h8CMGMdDhJByF5gmO1wbPyyp3PQq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047931; c=relaxed/simple;
	bh=Mhbv/3L9S5GfOQUwCmKw84OjOJY1uPlxvUzN9T/VVYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYahx/NFB+qkbo+yA4M9nJkAke/DA/h5f//bit/VFxCzw9VNpiQkR3rGuS4dQeBJGJYBt5Cifgpuyi2dF6dFZW0MFIF6ZNIM6qhQiP3yp/o25PEQBnORk03+6bs0A2yzMTfSCNaYbmyeh7mD+jgyYDlKyh1X/Gj/wMPHmSJgsw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=RuLYhokB; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="RuLYhokB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785047930; x=1816583930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eYv5yeumoyEsHf7hVGI7yQF/urKfJTXlSOVtPH4d8GU=;
  b=RuLYhokBzAFJ6ijjvIn/uK4UEaC1GWnVE2LO6ogowzvtfnNsaOaw89V/
   VQRgo9f0v38aUHKbeoavnyo43xwfGq3wEwVekWYzfmQyyCyDwHtI6Aqxn
   SyjtPp6OR+8Vz+hik1AqlVv2CM5Gsm1U7YSM3evOzu9eXKZXGLnDxtazm
   E92AlFGheUMSUFFM4pHMNa55yZfRzOw8Nie27RepaX87OTeGCnR17hWjD
   3uWhFVgw+BV51gMLkn9ISmQQGj6Lu3wZOnPZPd2zbtUqoMf9KGjWKROaG
   iBoRq/EEXbFSWY32tPK8/yZ8/1h4qFT+iV2zWbyt+Sa7kXfyFnaabdn/A
   w==;
X-CSE-ConnectionGUID: Kc/HMPusRBGvYHlO4W7mTw==
X-CSE-MsgGUID: TVjg341lTd+uMirYMeEvyA==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24386209"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:38:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:26691]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.152:2525] with esmtp (Farcaster)
 id 4cbbd4a3-3907-4e30-88fa-e885645d1854; Sun, 26 Jul 2026 06:38:49 +0000 (UTC)
X-Farcaster-Flow-ID: 4cbbd4a3-3907-4e30-88fa-e885645d1854
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:38:48 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:38:43 +0000
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
Subject: [PATCH v3 05/12] gpio: adp5585: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 06:37:20 +0000
Message-ID: <20260726063727.19111-6-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
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

