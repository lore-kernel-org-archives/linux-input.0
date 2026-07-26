Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3362FE056;
	Sun, 26 Jul 2026 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785042024; cv=none; b=m1kXRVXW4e77KXsmjpperalkbB9uDtl28ittPF85f3H5SOGdBpgbok+ftrQFB9suhLy34wLxDej99BGsf3XleiARaghFbKu9rO1OcWMv+UGVw2d9Qx70dj3l8QlfKiaJgVO1Httr4jNdUnQX6A8Qx3LSwzzgH70J+745a8I5dvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785042024; c=relaxed/simple;
	bh=2UZaQQlsQT8zkXST8gzvEPpdtHMmLewK9HtUHBtHHVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IR/lrYGiQ7IFlNMCgzXf6T4wAc4b1k2jCvQvd1sLsYRso/Y8T2T3FzqEvCXwtxTpeKste0xkq1JDIs7/XBAtuXdPRNAMbt3AiwlCE4OBpxK9dC4TwQTEH41R12/FoZcuthmvn3PxhDFkWRDsmGhKU8IsfWlYr5WdPgn4+KsnnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=O3PNHVm6; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="O3PNHVm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785042023; x=1816578023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gDtBrheJbU+yqd7bADPibHx4zONzC4ypfh4Tdg/jZU=;
  b=O3PNHVm6AeJKOzVd2Jtdd02BCZllhnZhsai7PhFy4AprsQTdi/nI+aNO
   IlruHVEDdN4UBnumDx7sj5TYc4ChFYbrGR++6RgQpXBC7B/VO34A7LPXS
   TAyWLrVS28iC/qy6ypmds0B+oeGxmy4MC5ud8DdnjKBNR8j29Nie6zhzZ
   wLU45Mt+eRE2zXfrXljlld/QI7N05nH/m+1eqg5jWdX//ZzKQ4n9X4SMG
   T+XedynfzfN70HEFUeFvzPVSXOMgVDbGrUHGbX40IDExTyKKJQDa1jr64
   +Npay8/vPd9eRRq/LD3cziwHFUeHCTc+wicVUyx576qQ3GS8cZroG9dXP
   g==;
X-CSE-ConnectionGUID: JY2gEHw6TYu/vNxHn/5W0g==
X-CSE-MsgGUID: l6Mb/+umT5Krsnn578Qe0g==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="23860999"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 05:00:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:18461]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.26:2525] with esmtp (Farcaster)
 id 75024a1c-51b7-4efe-8f1a-30be72258a13; Sun, 26 Jul 2026 05:00:20 +0000 (UTC)
X-Farcaster-Flow-ID: 75024a1c-51b7-4efe-8f1a-30be72258a13
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 05:00:20 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 05:00:15 +0000
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
Subject: [PATCH v2 10/12] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:57:04 +0000
Message-ID: <20260726045706.8169-11-farbere@amazon.com>
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

