Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC093CF678;
	Sun, 16 Aug 2026 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860561; cv=none; b=MaraZ4xUdUh5uvgR5zYQXjNgaWx7HXPeB9EUwKDhMeR8MAzDSZPSMBwzKZUTmyALm8gP2cB1sC5Lj78l2nAnkxPYg0RJyH8fgQMvLRxabbAa12J2IEUuEV1X+7jW6lAtsSyOsFAYrk4ZO3kRHXJLUZxlYeh0D0lv3hgqbN9884Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860561; c=relaxed/simple;
	bh=dJ68QbooWHZBKQDn5xlKP/a7N1o1WPC7m/Nz/t4kin4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0w/nRXAo6D3/HkgnHzhL60NSxcm4T9aiLN4DDeH9awvVGKMgUn5cB8Uzxg0MNddFNBxoxFsRI8wdnS78BUEb+5hQegFRCjjdgUBpo4mt1UnzKQGJ/E18+V6G/R8u6LzTE08iBKF8YAIxgyjam8npPLNlyE9/gOY3G/QpoZVYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sWpe8zWS; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sWpe8zWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860560; x=1818396560;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1PjrX0TYQgXkSpJZuPaWlzS4502XZn4rTZl60p1SQXk=;
  b=sWpe8zWSbEq56ev69QcObSdu5UVjFexOuYfO9Py2fMbT9XRKrhnjKQle
   APtHWAywDKVU+u4vrAl9oPfFJFyuZy5UNsdGkztLeq/xMfAzos5qXKYUT
   eK0mQGbbEKmkCSb1PN7Y6mxV1T2h99ED0LHXPwMdyauA1+E+gzAVtzxR1
   36r+Jt6ga3mChTDLVeH0JWx2MnTXzi8cHmGPHHVizSzJmpuQQVJA7kRCq
   RKuCcBx+rle01jjulSOy9i7vbFy6J/QxDG+GGBTe/Ne6hTjMy71ScDX5Q
   LO85+94Fcf9BV5sTRb4e30u0ljAFNZkMX156C20+hm7O/JziltoNOkj7l
   g==;
X-CSE-ConnectionGUID: zBwooBneTzmajzsATjRFFA==
X-CSE-MsgGUID: n9OZJxeVTTmMsYFsrooapQ==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="25877454"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:09:19 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:21019]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.154:2525] with esmtp (Farcaster)
 id 2206ea0c-d638-4fc5-b838-c3e6de24189b; Sun, 16 Aug 2026 06:09:19 +0000 (UTC)
X-Farcaster-Flow-ID: 2206ea0c-d638-4fc5-b838-c3e6de24189b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:09:19 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:09:13 +0000
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
Subject: [PATCH v5 13/13] reboot: use devm_blocking_notifier_chain_register()
Date: Sun, 16 Aug 2026 06:06:12 +0000
Message-ID: <20260816060648.4030-14-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the manual devres_alloc() + register_reboot_notifier() pattern
with a single call to devm_blocking_notifier_chain_register(), removing
the devm_unregister_reboot_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
Changes in v3:
- Fix commit message to accurately describe the old code as using
  devres_alloc() + register_reboot_notifier() (Sashiko)

 kernel/reboot.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 695c33e75efd..557609419989 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -136,30 +136,10 @@ int unregister_reboot_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_reboot_notifier);
 
-static void devm_unregister_reboot_notifier(struct device *dev, void *res)
-{
-	WARN_ON(unregister_reboot_notifier(*(struct notifier_block **)res));
-}
-
 int devm_register_reboot_notifier(struct device *dev, struct notifier_block *nb)
 {
-	struct notifier_block **rcnb;
-	int ret;
-
-	rcnb = devres_alloc(devm_unregister_reboot_notifier,
-			    sizeof(*rcnb), GFP_KERNEL);
-	if (!rcnb)
-		return -ENOMEM;
-
-	ret = register_reboot_notifier(nb);
-	if (!ret) {
-		*rcnb = nb;
-		devres_add(dev, rcnb);
-	} else {
-		devres_free(rcnb);
-	}
-
-	return ret;
+	return devm_blocking_notifier_chain_register(dev,
+						     &reboot_notifier_list, nb);
 }
 EXPORT_SYMBOL(devm_register_reboot_notifier);
 
-- 
2.47.3

