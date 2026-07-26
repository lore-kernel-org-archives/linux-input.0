Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5463803C5;
	Sun, 26 Jul 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061208; cv=none; b=YNJpwgkhKOLO+wxyt0Kxg19Zj+VvAmx5Tm8ItNbYSa4aRwtmAFEZGCg7gqGWQpADqwu71PO+k8OETUX3ChLq5VbMxK8FZ8/aMZPIsiyOobObC2XV34ycSgLx76mpQxgFV9wgg40mZ6ml8iWC7UaKU8QZN2xwuA/EOG8bUPsYxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061208; c=relaxed/simple;
	bh=QqEarhJftKM/YXdcRRBd1O1s5G5Yujs3HuxyDWME+KU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raVh2mOqoBjijay8FmLBD1mEmVz8qwwr+GJB0kZHc4aH32RrVy3vqxgHyik/LRnKK2W1PqFLisSx1CwqA9Chh1Ra3dLMT6rXThBjqBqHGPklxD8O1p5Z/SoCLfFZrTnqHt9Mj2LnNb2dAay8MKZi3lfUoogHxtdWatQl8quDsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kQhNUCzZ; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kQhNUCzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785061207; x=1816597207;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VLbKKfL72SmGem9Tq3suNFtCh+pVdnwceXhvH3BWTF0=;
  b=kQhNUCzZ5wmU+MaVyHli7NAcJ0XF6CDGE1IceonOxtSNNNJLVgjbIrel
   X6ZQRLQOJcFj9krNMj1dwof4ZlQXbAuOYvdJbrbcT6v1tIQQ8OVkFnzgt
   8ogTlNw8ok+NutS83BvO3veQ8xYaA1NWcScEB5gH09nWY+8Vu9UAQP3k1
   IaAMW0+R6nrVX+VyO2rlKfJcvJ2uTl2UnwOq1eloyohx3r8oXTpm4Wk5p
   uhHJCMGIJCkErRM9Ihu5T9rSz0WGEgttzlzSBbn/qfICvDwvH/3SKAefv
   E3IEmEtcXFpO9F5iPKC3ulTP1BAxWzGaejzcFxQEn6mbHBy4UXSax67iC
   A==;
X-CSE-ConnectionGUID: WsSiTeVgQla95YjnY1+DzQ==
X-CSE-MsgGUID: eFCkThZtQFq9Lf1alPpZwQ==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24362916"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 10:20:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:15781]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id 62c11dd1-650a-460d-b100-daf13f82c4b0; Sun, 26 Jul 2026 10:20:06 +0000 (UTC)
X-Farcaster-Flow-ID: 62c11dd1-650a-460d-b100-daf13f82c4b0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 10:20:06 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 10:20:00 +0000
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
Subject: [PATCH v4 12/13] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 10:17:38 +0000
Message-ID: <20260726101739.33170-13-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
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

