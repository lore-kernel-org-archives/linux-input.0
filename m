Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2DA314B63;
	Sun, 26 Jul 2026 04:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785041943; cv=none; b=BWPt3xWtBWNdH1eiriCFkwdI1haAt1kdSTnWtn1CqQrKIfvIg+yhe74EBV8b/T8V8VP6z+JZ0EQHLISYfgakKhLbJ4oZ6rqxO0BeO0xm6fqMS1lGxUydNDbOCcYHQZB9rK4CEfQX2ct5xo2Qc6GMRaVmoE49eVe7bkY7R0u3QAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785041943; c=relaxed/simple;
	bh=p93Xi3+QWz5mgIAvFsvL+CuDQRRWZfvIYi36hn3w7nM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnDrYcM9mgW7KnCMz98W6vv2g4P15iu0hrS2JZqsVrtrPFo1cyD6KZoL06Y/zx9sUJPD8KxMpaDCqPwpYNNj5Vzg94MWpvqDXB7ekHrGGB6jEV8Ff1UdEa8j0xoTAJguOYWUbFLsK/Bdk6q8iZKExLAwHwa/0zEStGBvdnfoHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PNP2BID4; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PNP2BID4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785041942; x=1816577942;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=laxFIxBck+pB02Yt8Wa+X7jWUZA4HD2OilknNa+X+9w=;
  b=PNP2BID4TZgNOhXxZlZOoYtBcVhLS+bKMdS5Uwx0lyVfbetekG7A2P+S
   hi4ZNxA/2JEeqMS2FD1kmH7kSd3fG8dohrogC/kpYgkJz/PKl/fZnsR40
   hcIxdkYXGltNKScZ1k8s+IOys0m4bMdRzn+bYZLI0/75BKOxSBwoRJ9rL
   PJJTaMAPQdKaTyJlUkJb6zfBBr/OFGb49h91N2+3QYYSiyU8HXApcYt0D
   KIOzHKsZDTaaP3DwTBq02D5fFXw9Bl57NlS1gUBSmRylFLW7eT/rgtAc1
   0lLijan9iuHVxTWOylvA30Bp/KnFPmgShMLEa2LACPM44LwKSGRLIOHoX
   w==;
X-CSE-ConnectionGUID: MzS3F04YSkCEvhDSyULbUg==
X-CSE-MsgGUID: iKK+oMKASHW+IpmLBv3keA==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24254384"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:58:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:2502]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.152:2525] with esmtp (Farcaster)
 id a4d659f6-ef4d-4a10-aac8-ade40c56908b; Sun, 26 Jul 2026 04:58:59 +0000 (UTC)
X-Farcaster-Flow-ID: a4d659f6-ef4d-4a10-aac8-ade40c56908b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:58:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 04:58:53 +0000
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
Subject: [PATCH v2 07/12] Input: adp5585: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:57:01 +0000
Message-ID: <20260726045706.8169-8-farbere@amazon.com>
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
adp5585_keys_unreg_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/adp5585-keys.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/input/keyboard/adp5585-keys.c b/drivers/input/keyboard/adp5585-keys.c
index 017c95029180..0be4cc234c21 100644
--- a/drivers/input/keyboard/adp5585-keys.c
+++ b/drivers/input/keyboard/adp5585-keys.c
@@ -254,15 +254,6 @@ static int adp5585_keys_ev_handle(struct notifier_block *nb, unsigned long key,
 	return NOTIFY_STOP;
 }
 
-static void adp5585_keys_unreg_notifier(void *data)
-{
-	struct adp5585_kpad *kpad = data;
-	struct adp5585_dev *adp5585 = dev_get_drvdata(kpad->dev->parent);
-
-	blocking_notifier_chain_unregister(&adp5585->event_notifier,
-					   &kpad->nb);
-}
-
 static int adp5585_keys_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -318,12 +309,9 @@ static int adp5585_keys_probe(struct platform_device *pdev)
 		return error;
 
 	kpad->nb.notifier_call = adp5585_keys_ev_handle;
-	error = blocking_notifier_chain_register(&adp5585->event_notifier,
-						 &kpad->nb);
-	if (error)
-		return error;
-
-	error = devm_add_action_or_reset(dev, adp5585_keys_unreg_notifier, kpad);
+	error = devm_blocking_notifier_chain_register(dev,
+						      &adp5585->event_notifier,
+						      &kpad->nb);
 	if (error)
 		return error;
 
-- 
2.47.3

