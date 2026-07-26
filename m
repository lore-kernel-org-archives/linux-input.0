Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD53385A1;
	Sun, 26 Jul 2026 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785042027; cv=none; b=uFGlnt2xAMdesH5nhx6PNBMEzZkvdmj6o+Pr9+KMaCDMW6bDt3GAi1Gb7hNPyfhXSvixNazBQasBCbfxC0gYxxKJqAh4/sL6wKzvvMcPzsJfup64qJxhheCFXVH4rampZ9Ljg5ItaNmz37TUiFFup2N4pLluotmKffO1Z6RMHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785042027; c=relaxed/simple;
	bh=QqEarhJftKM/YXdcRRBd1O1s5G5Yujs3HuxyDWME+KU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLvST3QuBHxs/x5mGLnSoZhPzR6hfsP7F4gwjY5oVCr7mgdZuxtnVhqVBXf+9koBMygH7/XbWLgc2WI4DvoEW10LcgwNr2dD59VjfyT7IQ7x4M1iwAVE/OLDhxSNR54fGJkybNpZk7zFc9l823cc71EGpMZXKrRa2mAwa5GScsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ABQZHQbU; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ABQZHQbU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785042026; x=1816578026;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VLbKKfL72SmGem9Tq3suNFtCh+pVdnwceXhvH3BWTF0=;
  b=ABQZHQbUaO8ZbDDdU6ekGY4Nh/KCjimKkYr0Rt4BMkpG3MAGZfOV7P4X
   pJpcRdS9qXK20oJQnV7Vx8s1w88lyYEOfPoPSRzygZFb/7yeqYdXHFx4A
   I2ct4qUMC2LQDq+ewebA6b11O7eUxUM008RGbwik1lWbF7rdeA+tiSMbP
   Kj7MHznmCi7s+bKbrvhhsQt7ftDjXBUW5DhMUdclDD2ewjBqnrrwMbfDg
   QWV0XMq6F6efsTovXh0fywMBocSS5do0yUWkf7Y6hOHKRF/P2/pnHmIxb
   Qde3wMjrM29RJL7DBEjJTRCULecE0SkGbEL1HclTpOGEnN0/AcEQUMBTo
   g==;
X-CSE-ConnectionGUID: +vX2DiNaSDarBcRbHf065w==
X-CSE-MsgGUID: 0KbnkY5ST4e9X+5qtZp4MQ==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24355340"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 05:00:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:10878]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.7:2525] with esmtp (Farcaster)
 id da6c2d58-3831-456c-9bcf-d3a1af312e8d; Sun, 26 Jul 2026 05:00:25 +0000 (UTC)
X-Farcaster-Flow-ID: da6c2d58-3831-456c-9bcf-d3a1af312e8d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 05:00:25 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 05:00:20 +0000
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
Subject: [PATCH v2 11/12] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:57:05 +0000
Message-ID: <20260726045706.8169-12-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
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

