Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0539A7EF;
	Thu, 23 Jul 2026 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829242; cv=none; b=YKh5YVA6scIX3PScAB+ibkukfxJegc+hrFKDBrkd5iOn7jal61GgKjzDknK/T4Jiqegs+UtrY0qkfjA7lpoJsCQzi2Ve1dTt819yTiIZPtTs21S0QTs5qYlMCLk+GQcFXVd4nqhxeER2sOL0bEUYIaV+XYauXMg+Pdkx9WjzJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829242; c=relaxed/simple;
	bh=RSr8FlkU84+VocbpgXROHP1N6eIKfBDgO16QrCdJHMI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdsXvcyA/NC0ZI3DkbaFGTmeqLZ2URZJWQY4eHZvqS6Nkwhv0CKylmkVQ1BkKcljqpkPt1y0+oalnH6IXvR69bCsCyNJVTc6Bqz5BB5PJvYeXXsmEwKIa895dPRgxNW5w/BEAwW1JixiP209DfUTDvPD+Jg4CzRD2nRk6w85WlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=W5/btFfU; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="W5/btFfU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829241; x=1816365241;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=AppKvnUIIDaEqD6OfufIdgEnM7UnHhbTloqTejwyZ+s=;
  b=W5/btFfUUZiW9zw+jw+mA0LgGrM76HXqofj4cs4I0cwBZ83p/Wt4B+Ca
   Prm4PK/P/HYCzD6ygsp6z2WE7qxDaBXQ+10okZDUVvKZ6CNFOP5IBJyoK
   FGL2En/nRZKDQmUMFDWVothbnr4ZsWBJOK1puvdm1GWZj+QAjwlVLwn8I
   6AT1vs9Ixpoi9DT3kEzw+/dS8tz75D7ZJBh2yPNyjHoYoWmyb5Bcb6DRa
   aI/DOjsmK1jYxPcOjdiqZYm01VTto7hXyb5jAm/yvcPw4xB9hDMfvDjmA
   BOocbtnnQcn+1N2PBZrklNyU7D+XbU+KAY0ZU2E8fguf1b6rZKQjQz4mV
   A==;
X-CSE-ConnectionGUID: rHWCnnVhRhyGHsNf1arnsA==
X-CSE-MsgGUID: u0pYaU6yQVeweabPrCx6pA==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24120691"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:53:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:5544]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id c75d2ba4-7d36-4f3e-868f-701cfca9d68d; Thu, 23 Jul 2026 17:53:57 +0000 (UTC)
X-Farcaster-Flow-ID: c75d2ba4-7d36-4f3e-868f-701cfca9d68d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:53:57 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:53:52 +0000
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
Subject: [PATCH 04/12] iio: position: iqs624: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:53:17 +0000
Message-ID: <20260723175325.37397-5-farbere@amazon.com>
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
iqs624_pos_notifier_unregister() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
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

