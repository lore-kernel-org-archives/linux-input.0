Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB737F31B;
	Sun, 26 Jul 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061093; cv=none; b=r1Sua9fZ915aB0bm0lyPMTt/DPOj9eWP0dmsJ6JMdSu0TYMEF+Q90OU+DbjWscu65TaLjQ4BMeLWesd2Ril/Qztc74c+58Q+BdYMWWvF6gdlRg3wgBh8JT50GmG3HRNi2UvsFWazO8JPA6IxNeF/JaXFPw15SZxGXH/yeXKG8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061093; c=relaxed/simple;
	bh=+M9sI2R9j80yQvV/Q3lXYCnN2bX64b4KBLooYAZ8GDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/AYIU19LTU+hmlDQlfNmp263n0Otgfxrgwi01axE5OEY9Dm0SMm2UBu5K92TjtjOaZrHu1RPgvOBno+zZzqbqcUbUKhkshJMLQ4tkCrZ7N9sYW9Di5U5bH//8fC6v097gyPZp0ED2Zq9/sjnXlF++Hc9oIWGENtYbzDw3hX4Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=BD1us1te; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="BD1us1te"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785061092; x=1816597092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N4HMI+Ypt3dUaeVDcWgB1HqH6rx98OF+47H18f4iarc=;
  b=BD1us1teMHoAr0CchdktLE1ryGswSyh5jxce4kcQnM96vsUNSXDOKZXl
   FRN15AFOilnmjzZpMb5TONiRTrw4ZlRmbnauRk4n9siRrQ1wWf8YWKXtb
   tOjJLR8N2dw4Ve50Lqae0FpzCbtkeyChZhSS9lwPeUKgh03ZWRSkAdVVT
   7DhE3i8YbfllYfDRoPtCSt099Y2Ovn1hEPitaGH5kSjAWhGYubRO+gLim
   UTcsYViTY3VhsDSHZS6KC9GzD/1UZFGvyLjmvloqr+yMiolUVmS1G+qiR
   bHD1lV2kf2OSHcdbrBYvjWPHbb5WhR9ukm0NIWRG4hsrVBQQmVBgl8X98
   w==;
X-CSE-ConnectionGUID: WK7NcrZPTHSr19Js4b2quQ==
X-CSE-MsgGUID: vnBjepY3SRyJ3OeEbpekWw==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24387506"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 10:18:09 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:4454]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.142:2525] with esmtp (Farcaster)
 id 65d22328-0a1a-4a77-8a63-f62ee7d490d0; Sun, 26 Jul 2026 10:18:09 +0000 (UTC)
X-Farcaster-Flow-ID: 65d22328-0a1a-4a77-8a63-f62ee7d490d0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 10:18:08 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 10:18:03 +0000
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
Subject: [PATCH v4 03/13] iio: light: iqs621-als: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 10:17:29 +0000
Message-ID: <20260726101739.33170-4-farbere@amazon.com>
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

