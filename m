Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE131ED7C;
	Sun, 26 Jul 2026 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785041862; cv=none; b=DBRsfeuaDxxE2+x5UAJSVQkas4vSTW41rRCzZHipSr55Q5Mi5jgziJIpBdj+aasMz5u2YW7x/KVObPhnsdHqCvWUjeuZtw3gz0FWT6mr149FEmsZqzZVFgj2wVLhHw/SJskJENwZCJ8wsLZ+A6g0pIaK08ww7eBRweQeiDRa3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785041862; c=relaxed/simple;
	bh=9PfWvLqDXrcdC3kOv3ATnsg7CA0fnLaQpLW74RfM8dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZoUczyU4mgC2mdmbtskZsFieAV2nc4j0D0w+mrtc9gA0lB/+gVyvwQU+FdRYvLuHoqUf5nRoGg7H5HY8czyBgf7ZfqhJn+Yo24mp7YOeRBC/gCjoEYCfjfp9LISWG5wH3nVMq89qN1ys1qcaIh2pwGrqO/zYXkA+7uDp3oVNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=thxhP/dz; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="thxhP/dz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785041861; x=1816577861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSf49JDCjdaWzi6oCVwehpdv6f6wYD7VNVODvHIligU=;
  b=thxhP/dznR6a2TQEJ+fD7Qb6SE/CG8MCImepjHZA5B7C47TECYM5kVmY
   D54PiV0y92Vj6oaa2FRnaJyDrZI1kKvi5f0vSE1yGqVucVhPnNDD/V6Do
   aVrREQkpJqqkM4fc1LEU7RJETOAFrH7ut+MEZiRrft4ult8nQe80NDZnO
   HkkIgr4W9ky1aiuVKcWh1n3bRQsX0kA9lbgBMAF9E2qUBKGWhuK94Fz87
   XzrkDPZ5Lh1iFXpid/tNqvj/7GT8k88MWSxQKuiUZWiMrjZmGLaBcIQO4
   exNXAEmL0z2c97/k8UyYmcWmuSVvFCtzYzMkGKENcMOE4IqOzAijaQ/YJ
   g==;
X-CSE-ConnectionGUID: D3785LsiQMG5/Wdh7PKG0w==
X-CSE-MsgGUID: sUHp7LnLS9O0sCEaBj5s7A==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24367740"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:57:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:4969]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.59:2525] with esmtp (Farcaster)
 id ce60ba90-e289-4e2e-8d5e-fd8ce340b207; Sun, 26 Jul 2026 04:57:38 +0000 (UTC)
X-Farcaster-Flow-ID: ce60ba90-e289-4e2e-8d5e-fd8ce340b207
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:57:37 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 04:57:32 +0000
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
Subject: [PATCH v2 04/12] iio: position: iqs624: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:56:58 +0000
Message-ID: <20260726045706.8169-5-farbere@amazon.com>
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
iqs624_pos_notifier_unregister() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/position/iqs624-pos.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
index 8239239c6ee2..d2aa2df71457 100644
--- a/drivers/iio/position/iqs624-pos.c
+++ b/drivers/iio/position/iqs624-pos.c
@@ -96,19 +96,6 @@ static int iqs624_pos_notifier(struct notifier_block *notifier,
 	return ret;
 }
 
-static void iqs624_pos_notifier_unregister(void *context)
-{
-	struct iqs624_pos_private *iqs624_pos = context;
-	struct iio_dev *indio_dev = iqs624_pos->indio_dev;
-	int ret;
-
-	ret = blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
-						 &iqs624_pos->notifier);
-	if (ret)
-		dev_err(indio_dev->dev.parent,
-			"Failed to unregister notifier: %d\n", ret);
-}
-
 static int iqs624_pos_angle_get(struct iqs62x_core *iqs62x, unsigned int *val)
 {
 	int ret;
@@ -255,19 +242,14 @@ static int iqs624_pos_probe(struct platform_device *pdev)
 	mutex_init(&iqs624_pos->lock);
 
 	iqs624_pos->notifier.notifier_call = iqs624_pos_notifier;
-	ret = blocking_notifier_chain_register(&iqs624_pos->iqs62x->nh,
-					       &iqs624_pos->notifier);
+	ret = devm_blocking_notifier_chain_register(&pdev->dev,
+						    &iqs624_pos->iqs62x->nh,
+						    &iqs624_pos->notifier);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       iqs624_pos_notifier_unregister,
-				       iqs624_pos);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-- 
2.47.3

