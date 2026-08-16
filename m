Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E213CF678;
	Sun, 16 Aug 2026 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860450; cv=none; b=Xb71yxfgAaJwWWFCJdq3N4GcAqFIU0gKG1Fzmcl5SfPQbY2J4Uh1Y6FnqHGSRMpNvcSJbRZeUVxp8HsqdqH0zOAhdhgTaQSUDoCki9fMLg7WPYsgJm1v8uKqHYhbNPgOoeTyVeL44GpRqIKxKdB2PIFiZIMEX8Mrr2fzUuLc2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860450; c=relaxed/simple;
	bh=+M9sI2R9j80yQvV/Q3lXYCnN2bX64b4KBLooYAZ8GDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgWpmdu/maDtJudYEnIv0V6Nxc1O5qdR0kVdjZr/q2piQdbpmeDJPzvJKt9RsDwJzaxyDm2a5SHs3ifXjt6uXeSZWu4NxuqsMDQLW5fRb5fLTeBIquT+lRFupFiFB2KZ0vph7pAwwH24UedI9aJjiLaopyoJOsfOTnpEsE/oY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KYumBiu/; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KYumBiu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860448; x=1818396448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N4HMI+Ypt3dUaeVDcWgB1HqH6rx98OF+47H18f4iarc=;
  b=KYumBiu/zYmIoOmpntjxInzb3OBjxd+yl8r/Bib2RPGe/Az4dyOO8otL
   NA++xwpxc4R6jI2qDk5476RGEtwj7HqmPOdHQx5L6C56GOYzRHfUU6jRA
   Dab80kZ7BIQtHPHnjzdiB1zFprFqurU+PU9h17jUHSpVvagD6RJaY5/f+
   i2+t92QLmhcOeCrmhq3RzRmhsCsM4Sl39lkM5JUYv2R91sUXS5XImWpQR
   sE13rin+HkYci0Zuc2M/aW0mANCaEqv17+wyG0Z2YfJpv9+E6ExpOsasH
   z4IdYtN3mtfdsgNTIHU3VDiegvRBaOTfT/YkFc4c7fcHuTjl1HqAXR4XT
   A==;
X-CSE-ConnectionGUID: BmVXNLWRTbalcQahshfXnA==
X-CSE-MsgGUID: kc+IRWDPSdex09l/OrDvKg==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="25841129"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:07:15 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:4979]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.160:2525] with esmtp (Farcaster)
 id a7f05c62-8188-49ff-8569-c0187274809f; Sun, 16 Aug 2026 06:07:15 +0000 (UTC)
X-Farcaster-Flow-ID: a7f05c62-8188-49ff-8569-c0187274809f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:07:15 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:07:09 +0000
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
Subject: [PATCH v5 03/13] iio: light: iqs621-als: use devm_blocking_notifier_chain_register()
Date: Sun, 16 Aug 2026 06:06:02 +0000
Message-ID: <20260816060648.4030-4-farbere@amazon.com>
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

