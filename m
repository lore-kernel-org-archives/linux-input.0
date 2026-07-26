Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B2366806;
	Sun, 26 Jul 2026 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047942; cv=none; b=PRRxDKisKFQchV4BMfrFudzW1/2psUUSfszmh0iZHpv9CRBlmRXMJmSae9BJA+d8aOclZmlTjNX5yIgk9R/+MouzVfpV9LocF8G84MYMjaK22lh19u/LTPZfNoBaR9A54GiIie5+Zo+WWYZcpGIq/NLb2BtXQaxlUEe09yB2k/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047942; c=relaxed/simple;
	bh=p93Xi3+QWz5mgIAvFsvL+CuDQRRWZfvIYi36hn3w7nM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrYeiRp4IoyY/aVZKgn5MOMHDmk4Cx2qf7iU3V+5QTxx2fRFNsByLbO/djo1jc6J/XqNVOmpOlTA6eIRX+2psxZCe2Iwh+krkA58MOzDoEGJSCAu3Mlrmn5gn0MeUnxyPdpsxbK5N92/8/U9iiy5DT39ESIsJljDZ095g0EecLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EZ6Sq7Z3; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EZ6Sq7Z3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785047940; x=1816583940;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=laxFIxBck+pB02Yt8Wa+X7jWUZA4HD2OilknNa+X+9w=;
  b=EZ6Sq7Z3OuVEc4SSu6dhx/GRaqiBvs7W/qp7B6RkXLk+ZyQxK/rTfsjb
   YkCIkx7LoAa+K7G+Tg5JUzpK7Skf/UJBHHspiNN+ng2M4o/Fp9htiaUkY
   qDdPWj7QzXoi6WUkOy9o/yyhkMA7hfyQMHmU3KZndwYZUZcfZW5x6C5UI
   XrAjKSBOPqS7sPNdGuQk9I3dkvB/RQLdbPDK5iZk2FqkueRTGdK8/7LA0
   4JeqR8JCn+FcHMJXrVRpidDcGfjpOYblR4OmE5B7A3tqVZg9PLIGBvJHw
   EWv0EixhvSnRMLZwNKQinYSso1Mg6RPQ5nPQMaSHJqFCVcVZiM3yxfeLG
   Q==;
X-CSE-ConnectionGUID: Wz5DiFX1RqapYprgpSvEcQ==
X-CSE-MsgGUID: jEEs96dYRceiFOtDBqZa/w==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24255996"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:38:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:12835]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id cfa9dba5-9f70-4ad3-8c85-6d13315391cb; Sun, 26 Jul 2026 06:38:59 +0000 (UTC)
X-Farcaster-Flow-ID: cfa9dba5-9f70-4ad3-8c85-6d13315391cb
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:38:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:38:53 +0000
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
Subject: [PATCH v3 07/12] Input: adp5585: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 06:37:22 +0000
Message-ID: <20260726063727.19111-8-farbere@amazon.com>
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

