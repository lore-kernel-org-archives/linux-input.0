Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631B36A372;
	Sun, 26 Jul 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047886; cv=none; b=IFCpEqSxMyWFHsj8vzIha5gqAB+ohtf387bPGegdh/GJxsElJkP5IduMaLFlEUmEgVK5Zzdj104Y08VBDdV5m6ZhWHlRjHWlvxFklRvtvoNxc0l+VUDXG9Pq/2Txpuni1e4rPtMo5KI14bbmpcltlLf0Ky1kZIk1E57ewyQx7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047886; c=relaxed/simple;
	bh=9PfWvLqDXrcdC3kOv3ATnsg7CA0fnLaQpLW74RfM8dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLwvyGdPk06FpjqAMBckLEz7uftol2Ijdzxt+HFLR11qLDVJDcfhzGB2o5TFlmlP+qTbPLvF8I8BC3sY9G137Lg+cJWTZwewQAGTFij4mzeirLurLB3eZOPZQ68R4ZX8rIQqLO8DWf9iTR4lFSDCg/vh9NCz2kVfENG5vpAXYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tc17ND+j; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tc17ND+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785047882; x=1816583882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSf49JDCjdaWzi6oCVwehpdv6f6wYD7VNVODvHIligU=;
  b=tc17ND+jr/n1AtxR0+VYFRDf++AcOtNLtHoDpDgQ2z2TKcmKV3vmGcvZ
   T4jfSGOR1tn47fDOU4WRSnvxVhTR88I6THktz6Bs2JMz4CbfP/OZ7df6y
   LuNd03tdv3bdx6Dx4VgjUrOB+BK0+lnk4nRswX163Xoy60cz9VwgoH1qU
   ODJ0USmBU1PlBEqxnRJS5Y0XNYJxe1mYuSSMSrmTrEsZVsBddl/O816fH
   WbS7VGAEGXIjmWj0W1v7nNu+V4CVLF9Mh4GmENEV2YLqP7Abcjbl4TBQN
   q3IU5+s5Nxemo8UehFBhFU3WyM2o4BB6iJ1FvVQ17P9bqdsjb5TxsQYm8
   Q==;
X-CSE-ConnectionGUID: pvEAWXjGTxO5mSEbzNenDg==
X-CSE-MsgGUID: 1QnbgifiTwKsP+jrhUum1w==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24235195"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:37:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:28336]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.20:2525] with esmtp (Farcaster)
 id ae5ba881-bdae-4b64-9056-c8349404662d; Sun, 26 Jul 2026 06:37:59 +0000 (UTC)
X-Farcaster-Flow-ID: ae5ba881-bdae-4b64-9056-c8349404662d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:37:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:37:53 +0000
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
Subject: [PATCH v3 04/12] iio: position: iqs624: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 06:37:19 +0000
Message-ID: <20260726063727.19111-5-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
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

