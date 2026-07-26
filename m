Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2D3264E3;
	Sun, 26 Jul 2026 04:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785041854; cv=none; b=kYT20ea0jYHpHmscvyDFUy0idSrBsJ7epzJ6r1mq5wJpfmA/UAbz2HmeGYEUz3DxeoMQwsp/dJVzj7Ei8lF7jbbXKfvLhhS3LlNG4pCIZ5Zwr0jq8NLVZkzrVj4UzP0hbwFO/2X1BXXBlEvWWesJy3pMxapXEqK/SoNkSKlfst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785041854; c=relaxed/simple;
	bh=+M9sI2R9j80yQvV/Q3lXYCnN2bX64b4KBLooYAZ8GDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqEeHNpiZDZq5uI6mirR427hGOSDS4MD/xvYkMFui1tiZO/eGUtlw1qoSH4xP869gcsnafS9aqnQ8evIt9+8JwClUYEmdRgpI/1R4QUKA7cwmoCu7haLodnILACuuOq7+6Z1ZZ3zPfgkV8k/NLP6RgtwrtlNCGe06BXp/5mlui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mKQa7kSN; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mKQa7kSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785041853; x=1816577853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N4HMI+Ypt3dUaeVDcWgB1HqH6rx98OF+47H18f4iarc=;
  b=mKQa7kSNhrYdZePDUIBUADpRbeDUOC1UlHjFq/jfOBtsXoJ8Aqb/wjUk
   eD8IxlCN76zVOnsjicJkg/tuOqqDJfCpx42hC+Axu3zcanC5ynr307xiE
   SghegOgPr/+DdJlR/KO2PitnpB1riFXZHdOSajafP086oQ5eQPYGO9JZO
   QzbdKHmPqCRW1/uL3g/MCS5C1854JdFj7ifuK9meXMGHPcwMJZ3w231SD
   GuMaRFGsk5xQIWPEioZm9+3sHCZ/iQVYmC+SBBWioDYNs7ctt0VsjMtxo
   Nr1maONoA3OIIh/ahncOqgqUFaDLdSa4Ci3qJJuc/4r5BdhFLPoJxmNyJ
   Q==;
X-CSE-ConnectionGUID: nR/EGw2+Sw27zNkVAwJMuQ==
X-CSE-MsgGUID: aO8O+AWlS2acUBU9QWSySQ==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24131141"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:57:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:17920]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.230:2525] with esmtp (Farcaster)
 id 2b0f4c96-a7d9-4075-bf29-45c4297417bd; Sun, 26 Jul 2026 04:57:32 +0000 (UTC)
X-Farcaster-Flow-ID: 2b0f4c96-a7d9-4075-bf29-45c4297417bd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:57:32 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 04:57:26 +0000
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
CC: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2 03/12] iio: light: iqs621-als: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:56:57 +0000
Message-ID: <20260726045706.8169-4-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
iqs621_als_notifier_unregister() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
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

