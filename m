Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A91360EC3;
	Sun, 26 Jul 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061205; cv=none; b=rzmYMUlP61t7nn/esmG2L9fFT7BGiYV0Do45kl2eFPvhRblTnUXN3BQHPqZfLjNOtISxCiCPP1IpiWoVtaD97LWmbdiKMhBsiyGODVUkBSEQ/Ke+dEVCS6POVj1KnLyR76g6HnPTyUos9wNAURaWrAG1pxQGDmxAP/DTexdzC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061205; c=relaxed/simple;
	bh=2UZaQQlsQT8zkXST8gzvEPpdtHMmLewK9HtUHBtHHVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G68+Xouy2q0pZhQk092tnuu2hnqnl6acSW/V3wUaOcW3pQmrXUsZWoUs7OsmR1V7A3hGo4X7nCrJD/YXN7xXnIa935lyH1V0MxkKeoSiLV+xNk1VDxMCwB2GK/esbokc8P0/IfcCUDZh9An1MNctqx4F2O/uanXT5hQ/OtR0UFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hVaHH6an; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hVaHH6an"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785061204; x=1816597204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gDtBrheJbU+yqd7bADPibHx4zONzC4ypfh4Tdg/jZU=;
  b=hVaHH6an4K7N4FexxPcVMjJb8x25q3oFOBxFRtKGeqOozxWBXLfWadGZ
   OlenkZJuSiA7zXInx8uXjHuAqJraA6xYq0t6CMcBEEIIc2jZPE68k/Iwx
   fwvzz/bsBS1DEvFt9ocy9WOnPDzHLilpbhfenuLGjQ5LtEpEAzbJdQiVJ
   RaKzhpzHdjXvzScRtlatv0SAC2gkXBlyOzbWeWAyc0pXPfJnM8jkQF0wd
   iAU92RfpKV80DIrW8ahM5wZ2S0X8zY0eK5yeSRh2tkfj/DNlsfFwFsAt3
   pgsd+Z2SDUZDHE11WBJEehCOtwuXKjkZym47a3FOid7YtaPnECPwQ7Jz+
   w==;
X-CSE-ConnectionGUID: XZJ5TU3yRZOoFnnINGAifw==
X-CSE-MsgGUID: OfIW23dTTUedLWtRtpCrFw==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24261768"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 10:20:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:10096]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.230:2525] with esmtp (Farcaster)
 id f5a0ddb1-d3ca-41aa-aabc-0cd8f64eaf0c; Sun, 26 Jul 2026 10:20:01 +0000 (UTC)
X-Farcaster-Flow-ID: f5a0ddb1-d3ca-41aa-aabc-0cd8f64eaf0c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 10:20:01 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 10:19:55 +0000
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
Subject: [PATCH v4 11/13] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
Date: Sun, 26 Jul 2026 10:17:37 +0000
Message-ID: <20260726101739.33170-12-farbere@amazon.com>
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

