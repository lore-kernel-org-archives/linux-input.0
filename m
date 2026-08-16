Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215F3CF1F0;
	Sun, 16 Aug 2026 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860496; cv=none; b=A0Q+kHUjGb0FM92HrBPTRr1LbC3XXiHW1EwE5dw6KleWG/nwr04u0c78x7ASh87xccCjzhv0K2C3w6H7cjxZ1nRs59fMxKNP2KEJ7BRUTmDHhQw+yTQMiicGrJ/8uBASikoVk88BMyU1lbIC6OXmSAbSSkS6td+UEsPqw0pbnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860496; c=relaxed/simple;
	bh=p93Xi3+QWz5mgIAvFsvL+CuDQRRWZfvIYi36hn3w7nM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3hP5v+NuftgD1gwxAxicX6GJzZaOGzW+V5KdwmZ7a4Fdqbu/yMsGPqCJBRfguU0JNxQHf2MuplVDMiX7XCxJBV5HEckhNeX2x3fHc3Hw2TGKJZBfmUhH9/A/AHTqALyErGbQDCrVJFUkJJPIEuAV46ckkz1tKD3/hWi2UlI5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=agGiAILJ; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="agGiAILJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860495; x=1818396495;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=laxFIxBck+pB02Yt8Wa+X7jWUZA4HD2OilknNa+X+9w=;
  b=agGiAILJn+tCXrWxQX4lc6OkXH98btBcSnWq2VEY6eCtT+Qqcc88Fd1r
   b7roKLGWBNL41S51YIsd2HdefM5p9GAE98itikbNGdEnj9Ihljzy1Sp+O
   VOqJB8EboJqZniPd6ZQMkosOBZ6qvXzAqlGPiXHDSOQGnzsnSu2savwg9
   OGmgPIND4pMlg0HQXhaS3z/RJvQYkxaM6MDtY8tuizSCQfGG4K5RPAALd
   aRA4i7Ok0MjnRZTXM5/FQcg0LPiVHURNi+jl1h5Q42tdzqfWrxP/TFYv5
   C8SUr1lLe40ge1cevbE0Zc5Up/jjJI++fAW45NOjgmDIIf6V9DZJQT1T+
   g==;
X-CSE-ConnectionGUID: TxkVuImuTIOleey4cYiXoQ==
X-CSE-MsgGUID: xWzDYiqhQkmKkIGEcv9ZPg==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="25880990"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:08:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:17912]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.154:2525] with esmtp (Farcaster)
 id 25df7501-f3eb-4c75-9c04-b91d6c78fe87; Sun, 16 Aug 2026 06:08:11 +0000 (UTC)
X-Farcaster-Flow-ID: 25df7501-f3eb-4c75-9c04-b91d6c78fe87
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:08:11 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:08:06 +0000
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
Subject: [PATCH v5 07/13] Input: adp5585: use devm_blocking_notifier_chain_register()
Date: Sun, 16 Aug 2026 06:06:06 +0000
Message-ID: <20260816060648.4030-8-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
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

