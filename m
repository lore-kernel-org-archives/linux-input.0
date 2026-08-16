Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870213CF21E;
	Sun, 16 Aug 2026 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860504; cv=none; b=R3cZmD0CgDnVSzVYQ8i9gSq996QORkMjOXN3xqFt3VFwuQuIU4aGkGix9qnulb47SPP/HIz66hsuK4yA3Er9tdh9K8pPL4Qt8Ci6nhJQM5kVLtDMgYu2bm1bRkArhBDqBGy9xlzHJHy6kNvzCvJcmdzsH8x3rOHB3b/aP50XveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860504; c=relaxed/simple;
	bh=4Ym9Mohy3QYKQZvhJ0IfqkGDiLp2LT92TjB7oRlEOkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbZqYJMV76ahTtdpVO1FsQN4ZCTdrk07i9B9jwLE+G7OwVcSvjhfafuSzDuoI4cZVhp1iwiqXqIca7OCAZJQPY6mkZSkNgCvpfFg2vcMeR/CSmrpzsjb4WvEHdphdxGausqqkZsh9QfNiKG/Rgdl6C33V1HYVobOcESd7177WXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XS2QnERA; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XS2QnERA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860503; x=1818396503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qayjjBZP/+V4G1veIJz/I2y/nXssS2V4J9zDtPx1Dn4=;
  b=XS2QnERALIAxMZ43Aetxqchq0sd0TFzY+/4bMuOCBD8qyXuLd02mz4US
   AUaDVWYhGjDTte0cmhQnbpux2MA/DfaEybKVB1/quPvol3YUnUNlwWr5m
   ykWoUTcfX+P7F8tcikXBwAp8Jt2nEi9puhoOCI0qDCy2RKFea6xULbjCl
   lfHiwNHQKiZ7pD5AV8WymhWY5wHWK2Pn7MlhSZ+MSpQHppZLPW0ced6kr
   hqRk8J2XH916x8vA7XktRzS672MFYZpzHAzVt0UU28JWoSQEjkeMx/XrC
   4vdt/K5/V1WSlxqrN3SeBcd4hVn/x8TUZeN/TYaRd9yexgyQQYIakj4rK
   g==;
X-CSE-ConnectionGUID: Nb8KjsDkQY+FPy6n+4s1xg==
X-CSE-MsgGUID: A/umW3Y1SKaYfL65DGTwow==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="26109167"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:08:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:22643]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.125:2525] with esmtp (Farcaster)
 id 89796839-0fac-40fc-bede-0c7ec630d35e; Sun, 16 Aug 2026 06:08:22 +0000 (UTC)
X-Farcaster-Flow-ID: 89796839-0fac-40fc-bede-0c7ec630d35e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:08:22 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:08:17 +0000
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
Subject: [PATCH v5 09/13] ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
Date: Sun, 16 Aug 2026 06:06:08 +0000
Message-ID: <20260816060648.4030-10-farbere@amazon.com>
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
ghes_vendor_record_notifier_destroy() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
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

