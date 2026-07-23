Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330D397323;
	Thu, 23 Jul 2026 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829411; cv=none; b=lOkmQqsXWYKq3U8uu9ndRu8Nqq2Q7Av9B0u0DCL2K8aesephwZX4tP7dFUBXI+M/Q1QC1YUX7USIYm327jO/sfqJfAZ97CzBLh8lf1eyV+5391U+rmbrKFaxhAyYzlQ/7EfrM8ikBGIdvX7sBUncl+Wym1fiKlAls2zjSz/0jls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829411; c=relaxed/simple;
	bh=QqEarhJftKM/YXdcRRBd1O1s5G5Yujs3HuxyDWME+KU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwyMwy9xZNmPjL/0ypoFEaH+xXgwV8UZncjdKSNXc5bq5PpJNMb79GOdxb9cx1cWhnhnr4otyBzpgfz3FHe6F9r6nNdoyFm2357kiWD0HGbFjfCONda5lXh05MnEBuXg8c63klmEPwJ67Bfvbaqgx7JQkwSH1ut87BCSYuADYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ONr6gzR1; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ONr6gzR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829408; x=1816365408;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VLbKKfL72SmGem9Tq3suNFtCh+pVdnwceXhvH3BWTF0=;
  b=ONr6gzR1wXDBcNMYrg6kuYr0UcCOgFUj14IIf3oYokCiruGHkBsTY2P1
   l9/+jZjsuuZCypugeQpdlzD56xa6kfNyhRaYjq6S5rWWrwKDgmFGTdywo
   fYM07J8RpJYyHKm6HxDo0abqeP/CjVvqf9vM0ybKMKcyjKv9gMx2DCaWl
   uGPqsMzKfWYfilrhks+Utnuxn+6htyUNBcXYH7gIAs6W11Z6SPzGK0fXy
   ldP43G+QCmFG45/sLYyY8JqR+S/egFrx9sWgQTId+9uEtEIZevVkPotyg
   EtS5rjza4agVaG4ZN5IYV5K05+bmzC2a44cl0RjwIIUMWMN53b/af8h+W
   A==;
X-CSE-ConnectionGUID: JpuzYfLqQTyAxXpw5kuuMQ==
X-CSE-MsgGUID: eR2bE3hNT1Sae1scSMj/TQ==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24233979"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:56:47 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:26902]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.176:2525] with esmtp (Farcaster)
 id cf73cbc5-542f-4c41-8e2d-55e311332c90; Thu, 23 Jul 2026 17:56:47 +0000 (UTC)
X-Farcaster-Flow-ID: cf73cbc5-542f-4c41-8e2d-55e311332c90
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:56:47 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:56:41 +0000
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
Subject: [PATCH 11/12] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:56:31 +0000
Message-ID: <20260723175632.44812-2-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723175632.44812-1-farbere@amazon.com>
References: <20260723175632.44812-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
gpio_unbind_unregister_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/gpio/gpiolib-kunit.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib-kunit.c b/drivers/gpio/gpiolib-kunit.c
index 380b68f879e5..8ce9acc89e29 100644
--- a/drivers/gpio/gpiolib-kunit.c
+++ b/drivers/gpio/gpiolib-kunit.c
@@ -237,13 +237,6 @@ static int gpio_unbind_notify(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_OK;
 }
 
-static void gpio_unbind_unregister_notifier(void *data)
-{
-	struct notifier_block *nb = data;
-
-	blocking_notifier_chain_unregister(&gpio_unbind_notifier, nb);
-}
-
 static int gpio_unbind_consumer_probe(struct platform_device *pdev)
 {
 	struct gpio_unbind_consumer_drvdata *data;
@@ -261,11 +254,8 @@ static int gpio_unbind_consumer_probe(struct platform_device *pdev)
 		return PTR_ERR(data->desc);
 
 	data->nb.notifier_call = gpio_unbind_notify;
-	ret = blocking_notifier_chain_register(&gpio_unbind_notifier, &data->nb);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, gpio_unbind_unregister_notifier, &data->nb);
+	ret = devm_blocking_notifier_chain_register(dev, &gpio_unbind_notifier,
+						    &data->nb);
 	if (ret)
 		return ret;
 
-- 
2.47.3

