Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBB37F72C;
	Sun, 26 Jul 2026 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061155; cv=none; b=lGeBj0gbCM6Ay9g8t9e4L9d8ILL7CA5wuJKPRT0Ap9zEGRkaBfEMopshgBdvxQAOYQvH9ea0hmXhwmwcigjNBfoqaWvSCznShv2IGZIMUm3SIKhou6WDVYfZOl7P47X5lq8XC56hIH1pOM2tMZ0p9kguQUSBeNzWr1ZG3Phpqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061155; c=relaxed/simple;
	bh=R7glQaCw8XmvtueY79w5j3NBui/tJY9eTVae7aIYK88=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmPFLOJnSvAHSPNCu1MRMsi7W5v62zDz+SmM7gu6k3B/ESMmvorM6uGDnqOzvFj7NwwJ/N5A3nrtiOUCxxzGTw0Vw0ht6BEkAminWqRhVink2ghMLPlguzrO4IVHE4j7WJTU3+GPLLu3I6KkyeOSPRIreOrUH4cF36Ju2pManes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hcYnKKZz; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hcYnKKZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785061154; x=1816597154;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t4hLAXIaMx9asrwb8wQ/TmRFLN+o+upPzR7tl+iAJDA=;
  b=hcYnKKZz7tYURrj5KAEF5/t1qDBc8oJ5y0NJqbs7G1rX6rBbSR2yzges
   G5B9/qRMd8dXfekI+aDsnCTStG9bZBvGY1pnzQVVSupk6Usl6cV/Nd3vo
   Ox9ECbFvU/YKYWfOby/4AaR472nHJXrHkC+meA3m0lT/j0zyfAdInQ1lU
   0aeTD6EVU3D+xO6NLbPlP/kIeyy83APwtKHwUk4V7BpevTtk4AThIRvDR
   7gB5pZTYE8aR1VEgjtNqxRgTWInmsod/8gRTUzCTB4RBj3wpeCeZIFhB+
   +/7xQuIdJTUdUzGJ3ArLabGzK25PGgqWzoKIR5l+xse5AEepCNSzfx84Z
   w==;
X-CSE-ConnectionGUID: fFQIhla5SLaAB6jlfgBM1A==
X-CSE-MsgGUID: rWxUWqjiRA6j3awEXZ+BOA==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24391657"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 10:19:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:20205]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.59:2525] with esmtp (Farcaster)
 id f651a5d8-657d-4a76-9a92-dae5cfd42920; Sun, 26 Jul 2026 10:19:10 +0000 (UTC)
X-Farcaster-Flow-ID: f651a5d8-657d-4a76-9a92-dae5cfd42920
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 10:19:10 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 10:19:05 +0000
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
Subject: [PATCH v4 08/13] ACPI: APEI: GHES: remove unused ghes_{,un}register_vendor_record_notifier()
Date: Sun, 26 Jul 2026 10:17:34 +0000
Message-ID: <20260726101739.33170-9-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726101739.33170-1-farbere@amazon.com>
References: <20260726101739.33170-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Remove ghes_register_vendor_record_notifier() and
ghes_unregister_vendor_record_notifier() along with their
EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
remaining in-tree callers — all users go through
devm_ghes_register_vendor_record_notifier() instead.

Inline the register/unregister calls directly into
devm_ghes_register_vendor_record_notifier() and its destroy callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
Changes in v4:
- Split from the devm conversion patch into its own commit
  (Andy Shevchenko)

Changes in v2:
- New patch: remove unused ghes_register_vendor_record_notifier() and
  ghes_unregister_vendor_record_notifier() along with their
  EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
  in-tree callers (Jonathan Cameron)

 drivers/acpi/apei/ghes.c | 16 +++-------------
 include/acpi/ghes.h      | 16 ----------------
 2 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..4e092f71ca84 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -677,29 +677,19 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
 
-int ghes_register_vendor_record_notifier(struct notifier_block *nb)
+static void ghes_vendor_record_notifier_destroy(void *data)
 {
-	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
-}
-EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
+	struct notifier_block *nb = data;
 
-void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
-{
 	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
 }
-EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
-
-static void ghes_vendor_record_notifier_destroy(void *nb)
-{
-	ghes_unregister_vendor_record_notifier(nb);
-}
 
 int devm_ghes_register_vendor_record_notifier(struct device *dev,
 					      struct notifier_block *nb)
 {
 	int ret;
 
-	ret = ghes_register_vendor_record_notifier(nb);
+	ret = blocking_notifier_chain_register(&vendor_record_notify_list, nb);
 	if (ret)
 		return ret;
 
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8d7e5caef3f1..3cd13171c14f 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -55,22 +55,6 @@ enum {
 };
 
 #ifdef CONFIG_ACPI_APEI_GHES
-/**
- * ghes_register_vendor_record_notifier - register a notifier for vendor
- * records that the kernel would otherwise ignore.
- * @nb: pointer to the notifier_block structure of the event handler.
- *
- * return 0 : SUCCESS, non-zero : FAIL
- */
-int ghes_register_vendor_record_notifier(struct notifier_block *nb);
-
-/**
- * ghes_unregister_vendor_record_notifier - unregister the previously
- * registered vendor record notifier.
- * @nb: pointer to the notifier_block structure of the vendor record handler.
- */
-void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
-
 /**
  * devm_ghes_register_vendor_record_notifier - device-managed vendor
  * record notifier registration.
-- 
2.47.3

