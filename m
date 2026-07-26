Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322DD32695F;
	Sun, 26 Jul 2026 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785041946; cv=none; b=i153Er0KA7s/DcABzsjLuVlyvzSebGEItPmE4i3zeElrDdPEgjMiyQTz/MiLdNVb8AbjwxRsOdBLCP3gY+TgQOHA5nqxrVJr3qGWPNGBCi26qmaQ7lD2mfUK8xqbBcb+iB8EQxSDoTH/Us7j2i4fDqJFQyv0n/2VjQbQP4STz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785041946; c=relaxed/simple;
	bh=fSZIb+raVdLjV67KGBoqEaChUzENEm5vu6jQIP61KOU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcwR5BjTUCkAvRISnjOuAF8/O3loDBh03rgZfWvKhxrnOBz5GZnyqi5LGKVJTbpxIuttIf5Dr2LVDlXewz2r4Iq3d0zCFVhaCtotIb4kBsvwd8gSZJV9J6ttKWuDfHYG32/C9slnzjQ1g6+Ne1o/gMuXwfmnxjHdSAsHrKRerC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=N3DZKfH2; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="N3DZKfH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785041945; x=1816577945;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WAd8DnV6AdWlN3+7vgWElP+0WFUeO2QzxuybPI6d7C8=;
  b=N3DZKfH2CR8eZqY5/Z9QJJ873YvxvbQelv4/7dNB+gmGLPXztM7ex4M/
   xjcS+Ko9aXs4k1z40icrx/inQYADEKoUtd2Nkb57KBWkG4jxcr92mFwGy
   cummcipMTXj2iUaFZhZZ9G3MGk3BJQ3YrApnnsErwnkokue38P+ajFEBo
   Mm528W1FXI2rfDZuYYT3AVFi0pkHT19KVMbIEHw+oN2lbsojW4cwH2/+J
   V8QBgSamAGnwXui1a0ky7NN0i2UaJZjhhWDK0d0M7TYEVeBm76XYgyCqY
   1f2ZGZmzpna41ijGBYZhKLEPyTXafpypyvqTa6M0eNm9HB2A5cCa/ihc3
   w==;
X-CSE-ConnectionGUID: 0tn7sZG/Thyfg3Ihez4tZA==
X-CSE-MsgGUID: x14Ow+UORNioml1n0Fom+Q==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24355332"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:59:04 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:25713]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.26:2525] with esmtp (Farcaster)
 id a607b782-96c3-46d2-98ca-ddc5daa0f97d; Sun, 26 Jul 2026 04:59:04 +0000 (UTC)
X-Farcaster-Flow-ID: a607b782-96c3-46d2-98ca-ddc5daa0f97d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:59:04 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 04:58:59 +0000
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
Subject: [PATCH v2 08/12] ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:57:02 +0000
Message-ID: <20260726045706.8169-9-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726045706.8169-1-farbere@amazon.com>
References: <20260726045706.8169-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
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
Changes in v2:
- Also remove unused ghes_register_vendor_record_notifier() and
  ghes_unregister_vendor_record_notifier() along with their
  EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
  in-tree callers (Jonathan Cameron)

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

