Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACA38F24C;
	Thu, 23 Jul 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829406; cv=none; b=ekJJzIo0snQCdXY9hD+Ku1JYxYud+eoj3k6HbRKUnqITn9lGEMVVmIGw1pBGtUt5kmp65lJNNxnIhwTLNW51mbpSO0OQlEp25+dFiBwjm/y6CAj55Ry8TXTrA0N9pcx2aFCc8MjiCZGiv4KmS4YbaPBI3CBuFB9XakG9GeHjqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829406; c=relaxed/simple;
	bh=7G+YhUX2XasrcWHG0xk9OORQEV2ZNIuZ9LM8H2grL4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HEt5iu0aLE4G894gIJ0FdsRdfFmbSzXODs1WQ8FLKk6hicPxBfRDkrk1u9JK8E+UdN9ED7t3lKC05rjNJs6aSrRemXYI1pLcmghRijlwCtmuyJxA4gxlQUObcMbyRd40shsJDDlpLYg8HdUSTWH0kwF1dQ7QF165S86gE3SSRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=swTtP2uB; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="swTtP2uB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829403; x=1816365403;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bs8Ptspm5pj5fO9AbjeCvglXwh6p6jzvErGbPjC/3bM=;
  b=swTtP2uBdVDlOvt2nFsJesxfHlVOmX/AI9R0Q9am4vOQzXlZmNeimBKi
   fisT/dw/HpHt7ARp6CPrs6PnFMRG1YBt61DqiDaxm30Fl4klXAf0k4mjR
   YEm8loIDD7ya7vcMf7kosH6YTpCKcjhk04nH5EnuAtTuavEL5uHuENOcd
   r9hqnI7MxjMEQ5swyYB+xPpfTg34uiFzAqt7UGLlCsrqcmvZzzaVc7tSF
   EJReB3v4Hm1eOThJU8TZSUOvztXnXNqzMGSFh+yvNcomCeNhpoirYxAOZ
   XWmpkVN4cHeiV47ITmPNme9y2XPfJoGi33IzL89M4Vwy5EcdjQIX1qLbl
   w==;
X-CSE-ConnectionGUID: Q2uz1lAxTiK28/M3zgMWuA==
X-CSE-MsgGUID: 21q/U0KMSemeQE4wMELNKQ==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="23748366"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:56:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:17648]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id 2e1bebd1-057c-4d6b-995a-9d7dc9550f03; Thu, 23 Jul 2026 17:56:42 +0000 (UTC)
X-Farcaster-Flow-ID: 2e1bebd1-057c-4d6b-995a-9d7dc9550f03
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:56:42 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:56:36 +0000
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
Subject: [PATCH 10/12] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:56:30 +0000
Message-ID: <20260723175632.44812-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
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

Replace the atomic_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_atomic_notifier_chain_register(), removing the
sprd_eic_unregister_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
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

