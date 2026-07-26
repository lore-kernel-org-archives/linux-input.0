Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA7372049;
	Sun, 26 Jul 2026 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047946; cv=none; b=UBdFxtYSWJMLyojAsfL4cZRYz3AliNxn3HgUlmmnNKpG2xise5zX8PPrzIz3oYMroVEZg6Uql6zBYPkNyreRlvNekqKnYkjTkM2VrYXUOjhHASzB6w+F6p8Li79K2v17hV9UPJj+MxKetB2SqHo4weniAj2179wrGyn4DnW/Wbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047946; c=relaxed/simple;
	bh=arCYIHtW+EACPqbt42QDCOfXZ6K79QH0i6W5PDHNqnw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHZVp4hqBvvHWbW9mBL8Zgf+z7v0wNcEA3OiyBWknCacvhYHGDQpdbBf3OUUAbIRiP3iDsfKJHzFn8QsBzxvkBwafNr5hEUkQTofbnMdaVyPkhwYHrwvIBp1bvlFrpDv2U/8KtjzDZCY4jd6JAlFuf6okl+UkJ+g9DdB/qQG1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=j8YPaDak; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="j8YPaDak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785047944; x=1816583944;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bV5tYqUJGpQcRSk9NuL5cjMFWpKCMqlO8eDtztnxII0=;
  b=j8YPaDakPXLXDrhZa02RBzUKkj6ApKaUiOHNN8eRFn8TmDuhUhKd4Yaf
   itM7kJvwa0lxv2o5yCVBP40HlasDTMDJLG+8hoqIBR0hehl9p3xeHRRTK
   W8OgsX4GEIT6yFiv9a9iUzEFA1I2n6QDRGxaeXqdL048NBmtoOJjhmUXN
   aELEffrEN1ZgbjJj/V9DscYqK+zRY7Af2J1jLiHxsruspZD3DyqUH6gGy
   sHup9mwfYlIfhax745/ZMcc+hejtN0VqfWrath2cJKCGv+CyUWcLq/idF
   Iq6JsSDSfDqMb4jTm7hxFr/tBk5xe5b4wk1CiIyPieDH3sR4dpEeORxKv
   Q==;
X-CSE-ConnectionGUID: v494JIZGScip59EZDbnjqw==
X-CSE-MsgGUID: jMCQIgiiTB6W2lCekTu6/g==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24256009"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:39:04 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:17190]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.7:2525] with esmtp (Farcaster)
 id f4149369-6172-4a75-9a6f-1238a9a214a9; Sun, 26 Jul 2026 06:39:04 +0000 (UTC)
X-Farcaster-Flow-ID: f4149369-6172-4a75-9a6f-1238a9a214a9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:39:04 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:38:58 +0000
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
Subject: [PATCH v3 08/12] ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 06:37:23 +0000
Message-ID: <20260726063727.19111-9-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
ghes_vendor_record_notifier_destroy() callback.

Since ghes_register_vendor_record_notifier() and
ghes_unregister_vendor_record_notifier() have no remaining in-tree
users, remove them along with their EXPORT_SYMBOL_GPL()s and
declarations in ghes.h.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/acpi/apei/ghes.c | 27 +++------------------------
 include/acpi/ghes.h      | 16 ----------------
 2 files changed, 3 insertions(+), 40 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..4419d430b7fd 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -677,33 +677,12 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
 
-int ghes_register_vendor_record_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
-}
-EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
-
-void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
-{
-	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
-}
-EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
-
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

