Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0473CF692;
	Sun, 16 Aug 2026 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860556; cv=none; b=sssv16tv0gvj0gc12otY5115/hzzTz1vOkoAjuhWMXMkaUTAOJTFsVd0TGuDPm9uFP1PxJo5Ps7jdvF7pS2EGhIUkHdg+XWfb7rJMqs3yEkTmxZe1mxGNg4HDQTz3rkEhcw3Assabd3S5ntPSi4CmqPPHrDm8PAVdlR4j4i4x0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860556; c=relaxed/simple;
	bh=nET7mdkuxv67WiLFiVTjYxDb0PTAF1dVj6Wn3LdZfEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnIojfysH3g/g9VgEDSOtV8a7CJfU9EHW57m2vXJMHU64VNMryEM6M37Ir0g4/pU32sg8iFl/5J2diyah62e32jHFO/f14jv371gvwWbdjhT4od4Nrm++kohHrvBBoyBafxlsaFIfi7cy2i45CBn96/O26ULt2twyJg6kW7pDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=pC6KDAI5; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="pC6KDAI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860554; x=1818396554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kbgy0STkJuqC3yffNjoxCaNm4x0iowu7ya0lQymx16w=;
  b=pC6KDAI5+KpNX2kTy2zi+eC/aK/2rdn1AlxJwO4fkZ+V/11vx5zeh9yq
   fTQi8xhxjcY7FGFqCJSYb5hywkgYG/AitCvWvz3A+0gZuk/ciAwkwWjlS
   5A2krbvJ21WTjkYLFWz92j45tKhmXNxmsXXYaZNcZf+a1/wcHU2CV+7yQ
   NraI46Jrv/idifGdXJQNfBrRFufhFUI7/AhRmpQWrfrRFsPSJExv0nwWD
   1+V1uwmD2DAMjsiNxeuavBKOdjms69RyTSj1Tc5PFB1//u+qjtxXhCwUT
   L48XUf3IucBhA+B9AFFlOA09MaK5FeRiZddwGhPGZqMymz97y6a7NIovH
   Q==;
X-CSE-ConnectionGUID: AMC0h8hNSA+u+lDxXNezrA==
X-CSE-MsgGUID: yHb4Q1mLR5S/9sExcyP2Ig==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="25957866"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:09:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:7480]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.140:2525] with esmtp (Farcaster)
 id a54270dd-e0c6-44b2-a7f0-80c9b196d125; Sun, 16 Aug 2026 06:09:14 +0000 (UTC)
X-Farcaster-Flow-ID: a54270dd-e0c6-44b2-a7f0-80c9b196d125
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:09:13 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:09:08 +0000
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
	<frederic@kernel.org>, <kees@kernel.org>, <saket.dumbre@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 12/13] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
Date: Sun, 16 Aug 2026 06:06:11 +0000
Message-ID: <20260816060648.4030-13-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816060648.4030-1-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
gpio_unbind_unregister_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

