Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083843624A9;
	Sun, 26 Jul 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061099; cv=none; b=GBC1pChxtblX5cJRPdAO+IymgflQAvqx6tOuR5hQk89Y1IIJvfE2gxzGbr8eDYnshhJPbXxPTXhCieIe1EDHTNOoFDVVp9u86xPLO+SNxugKgThD2UhP8minDEjt+OjuQCZGpq/z/C43aSFsiJUzJCanLRuKXRiAMf1eqsCtw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061099; c=relaxed/simple;
	bh=9PfWvLqDXrcdC3kOv3ATnsg7CA0fnLaQpLW74RfM8dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCZqPH+xjCvFzNYsTZThpatJB9g7KZWm+isfGWGRM3efqD9EpuyeIy7lvV8kxnzc2v3EQ66S/Uoed7rXbDIzVlW0eAn+ZWX2id8j+Q5xaNJawtn3VQGycLVMn89cEj/h45wnfSBqTh+KwfzyEUWF+lZfJYodPuvOLXIv1G9PPj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fyYh6f28; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fyYh6f28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785061098; x=1816597098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSf49JDCjdaWzi6oCVwehpdv6f6wYD7VNVODvHIligU=;
  b=fyYh6f28Nl34xWaIV62wzhiO/ppjAcKoOyLyothg7FZTT/yaT6wda+VF
   SKP/ysx5m/WwgtFXNnBPcpulZkzA7/1kVC0fj/QHf8mBqVnKTB7fGovRv
   aczLgvuIKBnuPUuvy8LW1zJXiPEVMmKKXWl+cvmMFmC0SY87rX2ukFBGh
   D4+/81nFjsbTdcE3nmrKB8wmhFhKGhxBh2GGtMqkq1YuieecOxlsq6YPi
   Ks7HGVF8AmuBdrzWZr4LqaojqOwL+Qs9/nv22VP6++lq+VWGYDxLaQ096
   /+8JLpy6oScgz+eZQcbnmJ3erBLW09Ea6gsOaYj2WSOtl2x+chIe2jBdt
   w==;
X-CSE-ConnectionGUID: SGbRDhB6QkiXwrIQ7v0YOA==
X-CSE-MsgGUID: 57yMo0hTSsqrC7yIZvS84A==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24374852"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 10:18:14 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:12372]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.7:2525] with esmtp (Farcaster)
 id b95827b5-74a2-4ee6-b9ff-9a322590f17d; Sun, 26 Jul 2026 10:18:14 +0000 (UTC)
X-Farcaster-Flow-ID: b95827b5-74a2-4ee6-b9ff-9a322590f17d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 10:18:14 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 10:18:08 +0000
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
Subject: [PATCH v4 04/13] iio: position: iqs624: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 10:17:30 +0000
Message-ID: <20260726101739.33170-5-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
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

