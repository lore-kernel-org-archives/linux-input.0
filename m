Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212B36998A;
	Sun, 26 Jul 2026 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048011; cv=none; b=rEtVy3dJuHB02R4bJb8IwX5Wfwofgf4Xn9SEJVO9Sl0j0KF0cfqg3xgliuZochE0vSWwD/eiViTyebCoY01uiktOyV5yqtvHyaq6NMmgNxdOT9v1ff0jhK5OdPFAgNCbe1i8xLrMylwv3h3StJok77jcoH0I1a5+1XlFw7eINiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048011; c=relaxed/simple;
	bh=dJ68QbooWHZBKQDn5xlKP/a7N1o1WPC7m/Nz/t4kin4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVk1JwBkis1bjEIfz4kZd34KHuEHu1jGd0GZDoQzdOjWZVTcUAN8YovzUpHHSewMY5Jgq0OVVJy0XLb5oy/YcbdDlH9i82xaN/VA+tIHCN1plDxf/e3mi08/WgAnqOo1LPIwAO+VahEoZ2A/8t36okWLzX6kLEYrtFY2wCCLXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lppOrWc2; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lppOrWc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785048010; x=1816584010;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1PjrX0TYQgXkSpJZuPaWlzS4502XZn4rTZl60p1SQXk=;
  b=lppOrWc2Dfv8JLTWpnlvi7nGbMqCcCPMNWg/DIMoPJg5DWvc5E21Qo3E
   coeO1fPMezFzgdjiceDzmzC7gkCEL3crcBxr6ObhqyPqZla+3BKN9mDI7
   XBch0z5mqKPqnl8P9HPLx4gwpP9VFxmIE/2HK71vHGs5dBNcsI7bZePfA
   0uk3h9EkO0wL7wkB1QNkHrdN18WyPH3rD5s74rslXyz4RxP9x0bN4SG37
   JbX8WbnnbYXds2hXhcsG7F3LAQ1w2NQDV2Bf0W1p5YTfx04ZJzP1681lk
   2B6udMs1JafNdwqFTQn2Se2+pgj8n037PZPL0brIkA+z7lkCdfu9sITwR
   g==;
X-CSE-ConnectionGUID: NHEVld4iSjWQxVjxvcKtDg==
X-CSE-MsgGUID: hJ7BKbGESPiWqqSINZIzCA==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24381954"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:40:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:9010]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.115:2525] with esmtp (Farcaster)
 id f4fe1e6f-f478-4186-b491-0d1c57155143; Sun, 26 Jul 2026 06:40:09 +0000 (UTC)
X-Farcaster-Flow-ID: f4fe1e6f-f478-4186-b491-0d1c57155143
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:40:09 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:40:04 +0000
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
Subject: [PATCH v3 12/12] reboot: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 06:37:27 +0000
Message-ID: <20260726063727.19111-13-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
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

