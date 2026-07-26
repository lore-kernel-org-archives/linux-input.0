Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F430648C;
	Sun, 26 Jul 2026 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785042032; cv=none; b=rviYueRHd7FEFkko4hEYxR28zdLGnc0Ixvv5gjY29zr2S4xx03pKWec2mfFAKOEMYkqIzx2VYiC9JPcC2ae1KGwv2HVCq+oYQ1yHZE0m/55Eas1aIrN1xksUmfnYOXpZGZurcvU99pwxvjY+dmnre0nYYHxoGsMcvqSeK6pKC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785042032; c=relaxed/simple;
	bh=oR16xQ0l2QZ1HctK5sTlhQ03S1oe8xRZ47h7iuZrD8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StZwWzg1Yp9RyuwRd5AznlR3qjg6FiZj5DM49jKQ+SlE9Cik4dUQZIMh7YL3u4x9KFwfmXhhiDSw4UVLkGR2iVaNbfPDZq8EXtZnOxHjm8ic1AIesKa/Z6Di+nW61KGvTc0vyBMcMUVgKtYl1lMkkJNNux7z2AmdkLKj2AVvS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FIioPsDe; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FIioPsDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785042031; x=1816578031;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=jqAtat0tnNZsJMQ+mPgx7+6Yqu2gEeC9PKKRqoqiiYY=;
  b=FIioPsDeUIrpHqhuO5kIwzRkvwdSc7YfEggkL8vlakQfQR2c+9SDRYOq
   83XjJWQKXVKyoFOdXuXueCNM6kT7iCL5YzkG7xIMSjbZwlO2YbRhwqKZM
   ALwBzPQWvm7Tqi1RkltqsuVctjLo2TJFtEnF2WupZa3AWKuiBbMPljGh0
   f7oNryu/HM5Z3I5kVw8fFOZSi/czaUW6u8/tll+vy9H/+COBSKhk7dfY2
   TNarWWx6Y0Ti5XG5S83bP7yDFwO6BtL4gtIMbpXbJcM3O4hJ4EzNMEhCA
   psez1i3yGFyzkeJiZ8iXwlmZPOjm+ONa4dto2QKD9qZseGImSOvnts7aQ
   g==;
X-CSE-ConnectionGUID: 57VgV9L0RlmfgFlDGV6xbA==
X-CSE-MsgGUID: dYv4NfI+Q9GHvmKlCqLAsQ==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24367779"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 05:00:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:25469]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.176:2525] with esmtp (Farcaster)
 id 84412c6e-bcce-493b-8b22-3d84f02b5570; Sun, 26 Jul 2026 05:00:31 +0000 (UTC)
X-Farcaster-Flow-ID: 84412c6e-bcce-493b-8b22-3d84f02b5570
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 05:00:30 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 05:00:25 +0000
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
Subject: [PATCH v2 12/12] reboot: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 04:57:06 +0000
Message-ID: <20260726045706.8169-13-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
devm_unregister_reboot_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
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

