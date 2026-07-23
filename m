Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590C361959;
	Thu, 23 Jul 2026 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829236; cv=none; b=Jwt4N5ETOXTCno7Du0b4cy35fC2QwZAjy9W2Q1pjXnb5bwScMEUaZvoUsSbshePLGUc0aE/U4jZ9GEAw4KQbtm8k7Fbt0U7qsdBQh10bZ6vtcl5sC4P1+a+la7hAX+SGwO2GKjGMu8MhqfapBvAtOHViTpi26FnbLvG1e9Banjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829236; c=relaxed/simple;
	bh=S1AIrfgIepQ9oig7DadTWDRxLpojq2tmRA20HF9LKSo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvgmcR03daY6yVeoBAxHZelInE0PtrqbhU1DW37cmsguU/m0Z/nqou/n393/VbUHHOzM3I7DN5nyD7MLhRd7vVFhlcaqx9SklxI7xzk4O59eGKbqu1xDzqX3t712wHdNDrHT+xZqsBOGTScqhkDO8WcyRfJXO6YK3qccG/sTGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YWHx+SXV; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YWHx+SXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829235; x=1816365235;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=E1cTVCT+wa+SsSrPQumpgMNi0+ROk0z5CUNoWC/xw7I=;
  b=YWHx+SXVJtww413wCC1OlF9urSrbF9Co29stWhGKwVx1O9l1P4VwXtNN
   sOejNSKTsOjxirv6vfn4hYMN5b4odLbDrTeVQ+t8ZBc+sIn7LBMQVjoB7
   BFquonxknW7MF/YpUChFv6i3+9ZBxexuRmOp+T9uq1PxEXSn44QUlnHbR
   0rOM1WkoMpFbzUsLEPk8lRAYoHLlMF26yK3U1JUScz/s/D5Zt1jyUcjm/
   t89okbl6Yd8s8K9AvmghHFy5wRGUXWlWCtGaB5XEfAan+h35cLd4/kNIV
   HfK/D6PSRg0kdc4+H6tNXrpyVBEVzqBpKRMbyGA/jU0sFMIJigKfsPzqD
   A==;
X-CSE-ConnectionGUID: XPVC4WuISw2ng1gWkWcR2w==
X-CSE-MsgGUID: Afsie3KkTw2fHMYZcY7EZA==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24242007"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:53:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:14932]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.26:2525] with esmtp (Farcaster)
 id c1490c2c-2dfd-4c51-a119-58b87ecb07fe; Thu, 23 Jul 2026 17:53:52 +0000 (UTC)
X-Farcaster-Flow-ID: c1490c2c-2dfd-4c51-a119-58b87ecb07fe
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:53:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:53:46 +0000
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
Subject: [PATCH 03/12] iio: light: iqs621-als: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:53:16 +0000
Message-ID: <20260723175325.37397-4-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723175325.37397-1-farbere@amazon.com>
References: <20260723175325.37397-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
iqs621_als_notifier_unregister() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/iio/light/iqs621-als.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index cd5843e3e2c3..f9d215ef1970 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -179,19 +179,6 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
 	return NOTIFY_OK;
 }
 
-static void iqs621_als_notifier_unregister(void *context)
-{
-	struct iqs621_als_private *iqs621_als = context;
-	struct iio_dev *indio_dev = iqs621_als->indio_dev;
-	int ret;
-
-	ret = blocking_notifier_chain_unregister(&iqs621_als->iqs62x->nh,
-						 &iqs621_als->notifier);
-	if (ret)
-		dev_err(indio_dev->dev.parent,
-			"Failed to unregister notifier: %d\n", ret);
-}
-
 static int iqs621_als_read_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val, int *val2, long mask)
@@ -563,19 +550,14 @@ static int iqs621_als_probe(struct platform_device *pdev)
 	mutex_init(&iqs621_als->lock);
 
 	iqs621_als->notifier.notifier_call = iqs621_als_notifier;
-	ret = blocking_notifier_chain_register(&iqs621_als->iqs62x->nh,
-					       &iqs621_als->notifier);
+	ret = devm_blocking_notifier_chain_register(&pdev->dev,
+						    &iqs621_als->iqs62x->nh,
+						    &iqs621_als->notifier);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       iqs621_als_notifier_unregister,
-				       iqs621_als);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-- 
2.47.3

