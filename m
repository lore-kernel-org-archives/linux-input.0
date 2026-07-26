Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E137F72C;
	Sun, 26 Jul 2026 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061159; cv=none; b=I1cjAF6tKV8qn4nZUNV9dbnYyv9H5FTXGtA8q+EHGBbHB7Hmltsoerl2lxDWXCTTwGgf3RTwLQBDWGJ9dmspINjO+rTbAGWdkRClCIrYfkK32FkUtwDc7MrtM9nXAY6qKVq9WmDgsX22K9tyAPz0Y7pGFMazu1iH0jtOYsM7YUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061159; c=relaxed/simple;
	bh=voN2OjUOoYWlj/LzkBFrfkrMFdIHJcPzaVEfy6dcpD8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoNg+Uv/nWxNh5d79ZLf6HOJba75pbL0RpPA2/+SeXfimUU1dV1giTXKWrIMF2DalSfheLqq5uKDak1iwPITDs7x1iEczcZgWPm3/6R0CsLK6V5RxURYv+1vd/C7WPT5vhUsQkxqLN9Mqla56YLFjnk/XIM6EjOV2px2Ig4L7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=e2isUuNo; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="e2isUuNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785061158; x=1816597158;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=y3KmkkhL829ieEmRmIkbSa96a0Hw37IksB5mzWqTxHA=;
  b=e2isUuNoihb9CCjnATDgH0wXQ803su/hG+rbko3vr7bNEzKOBHZ5nlHV
   ZxVBLtq9CqHuh5CCpcdyPy96IqH95BCZRBv3qGZouwvOPDzH//nMEaYpB
   i9uRHWbXhFJQzBBE6o/kntrrub45uo2d94wVKVwZO/uxpAjHIMTSzgMvx
   fQDbQ/DExkp7mHdyw/YCmtEM5X9/+0K8KHNKH4qviPpkQYYEXK2yprbjP
   Xtkr+8pagsxFLDP/eikOWzzEI7Dnx93P3hC5l6oUKy8v6wamhoR/LSWI9
   TAcBLbPgPBDUJC1g79OW0AvBupUJ7fmdImfC4ZR8DtiSdWGJbFXO4Tyiz
   A==;
X-CSE-ConnectionGUID: yUfCg3bDSbaS8G2fquVhdA==
X-CSE-MsgGUID: +Mi/FaLERZqx5MnSC6M1kw==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="23868370"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 10:19:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:12332]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.59:2525] with esmtp (Farcaster)
 id 9aca8efb-b9a9-47ac-a645-2321e1349979; Sun, 26 Jul 2026 10:19:15 +0000 (UTC)
X-Farcaster-Flow-ID: 9aca8efb-b9a9-47ac-a645-2321e1349979
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 10:19:15 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 10:19:10 +0000
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
Subject: [PATCH v4 09/13] ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 10:17:35 +0000
Message-ID: <20260726101739.33170-10-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
ghes_vendor_record_notifier_destroy() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
Changes in v4:
- Split removal of unused code into a separate preceding patch
  (Andy Shevchenko)

 drivers/acpi/apei/ghes.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 4e092f71ca84..4419d430b7fd 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -677,23 +677,12 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
 
-static void ghes_vendor_record_notifier_destroy(void *data)
-{
-	struct notifier_block *nb = data;
-
-	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
-}
-
 int devm_ghes_register_vendor_record_notifier(struct device *dev,
 					      struct notifier_block *nb)
 {
-	int ret;
-
-	ret = blocking_notifier_chain_register(&vendor_record_notify_list, nb);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
+	return devm_blocking_notifier_chain_register(dev,
+						     &vendor_record_notify_list,
+						     nb);
 }
 EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
 
-- 
2.47.3

