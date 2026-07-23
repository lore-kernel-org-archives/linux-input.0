Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2CA39A078;
	Thu, 23 Jul 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829355; cv=none; b=ndtw50IW6W+H9KNwk/qorFXLhi8DNbQC6Y/xcjMzf9qqXXNyz+/d0R1at0FwGG8Ud65SV7aRgLk38lOAeFw2eBAO9N9nzYQIRSj+4KHWuAT9dSXHmrO1Hya9yXuqkw5GSO/SJ5xSMYlJ0MKLtPkpxbJR7tcz4H6F1DRWN8ev64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829355; c=relaxed/simple;
	bh=qeYq/lNmi48FXTC21/AbWZAG8WuXRvXPYr1b2QPu+uM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aqux+vZDWfsCGYjHaOYP1hUeHgWURBacrnxC73K1fZjhhTSx7L8ENSWcK57F9pkgrcRLM4MWZtH7aIYcSivltLUFLAMZU37F8uumToTnPBzf9eafTQhjm6P0RIwlCNPe1EORcw4hyPpgrzQYg6Py/SJ0IpC9zy5qzLeRjQ28BE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nUXN9wSv; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nUXN9wSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829351; x=1816365351;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9x3f6m8diHG399umtxY4yIvkUQf3FzhrH601C30qr+Q=;
  b=nUXN9wSvYVqDt5tKShuD5gO4KVgawb2oVZ3e0yblpyoyzv7/99i5OLVM
   mUiQ9zESovdkobit9Qfjanoc500Bc3LcBliYNdR4Awndbwh2R+TyXNqiC
   l1Aq2iHeHybkcc6Gm7rkEQHJ1sANaODGcfBX7y9w6oXpgHUX0RpST5aEr
   AC7x7a9hEt4cX/F2AD6+Gcr8PoYWWq1/tal7CEmsnVYeDRyRRrPs0T+FL
   azGKy3lHJX+Ga6E2LpwCN8VKobc8MuyLtfsUwddXlWxbIjyxrnjL9iYCv
   IpKZyjGYyv04yFCJsTcUvK8Ic/V+ArAcJFiZsJ7A3zw8pWsjaq54t3xcO
   g==;
X-CSE-ConnectionGUID: O06l1AmiR2Wq8b1OwDhnYA==
X-CSE-MsgGUID: qa3dS0/0TO2HCMLykl6TwQ==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24233903"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:55:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:30964]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.26:2525] with esmtp (Farcaster)
 id fa58f957-ab66-464c-b189-7d7ca9dc1d6e; Thu, 23 Jul 2026 17:55:39 +0000 (UTC)
X-Farcaster-Flow-ID: fa58f957-ab66-464c-b189-7d7ca9dc1d6e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:55:39 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:55:33 +0000
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
Subject: [PATCH 08/12] ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:55:09 +0000
Message-ID: <20260723175513.39849-4-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723175513.39849-1-farbere@amazon.com>
References: <20260723175513.39849-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
ghes_vendor_record_notifier_destroy() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/acpi/apei/ghes.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..3aa29dcd70da 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -689,21 +689,12 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
 
-static void ghes_vendor_record_notifier_destroy(void *nb)
-{
-	ghes_unregister_vendor_record_notifier(nb);
-}
-
 int devm_ghes_register_vendor_record_notifier(struct device *dev,
 					      struct notifier_block *nb)
 {
-	int ret;
-
-	ret = ghes_register_vendor_record_notifier(nb);
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

