Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B43CD8CA;
	Sun, 16 Aug 2026 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860445; cv=none; b=IBXJOQpBB2ievUTk5pFReNUU2QnkW8bN7H01gKIghiNJksCbdFMwWB2GNqRSZSHiNlBBpdTbJetqwg7sRFhmcULMW65X2Khtr5DBNpcZXZPAGUC1rY9Y/G7XLI7+NYcl4W7AGm0FV9TOMDFYSn+TiGGzEFXLhb5iv/yUlQW48l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860445; c=relaxed/simple;
	bh=9PfWvLqDXrcdC3kOv3ATnsg7CA0fnLaQpLW74RfM8dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NouxSkHUc7ztXPzbTtUr1DyTYuH6fu7NNn4004H+XrdnPqZjN6Uzs+Oc3zuh0ZCOJEB5cz5o2qHWGwc+/RP/MVzPDzBvRrm8vu5GsznXmRcnCvlyHcQ1MJOp7q8x8QhuH9TJQmalsegBEqCuEhtVhFf77srfXKJIcB+dFEnpdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ow49hdbc; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ow49hdbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860444; x=1818396444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSf49JDCjdaWzi6oCVwehpdv6f6wYD7VNVODvHIligU=;
  b=ow49hdbc+koJdDKKz0/sahWSBF3Xa9af2jUJvFnySCwV/U4dH8LcjJBY
   jY/T+sgIhtgUOkJNTQWySwZ6B6JXcgaR2okVb8lbR6E784uAqBZ2KB96J
   qntwLGKE8FrIklQnRMvhgCRhq2gTZahulQCg0WaMRdxH9Ukt5pwpnxOdQ
   Hx1+CnlQc23HEUMDZKzPMW1j+HwpNUhxBQ8cqHo0MywUziqKPQow481Cq
   KBHygyNP7VWaQwa9VHMywB+GWZ1kj1mVI8Z5D75YMXuk0JzBYUV9wW5lg
   +e+oLwgYNWUfI1RsbsSBYZWqs8QEhAmneDE67NqkaqrXE230cMKpbc6m4
   g==;
X-CSE-ConnectionGUID: 2lNGy+HqS6y7RsPfvt0AYA==
X-CSE-MsgGUID: uUcTDP1UToi73fwlPtmkCQ==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="26109130"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:07:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:11127]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.154:2525] with esmtp (Farcaster)
 id 5e989c0f-bf7d-4b33-a569-88160ba3abc0; Sun, 16 Aug 2026 06:07:21 +0000 (UTC)
X-Farcaster-Flow-ID: 5e989c0f-bf7d-4b33-a569-88160ba3abc0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:07:20 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:07:15 +0000
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
CC: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 04/13] iio: position: iqs624: use devm_blocking_notifier_chain_register()
Date: Sun, 16 Aug 2026 06:06:03 +0000
Message-ID: <20260816060648.4030-5-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
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

