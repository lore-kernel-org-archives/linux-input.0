Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C537FF7F;
	Sun, 26 Jul 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061213; cv=none; b=ZWtSosrTuMPtiEaHwH7NjvTXbc1WqAUz9HnBbtJvZeJhkzAXaahGv4MyUIZnlfsOytI/rslb2sCiSx6JCMikZOjz9EtZacFBOVaNO+TxPrrVA12MhipYVBqo1lGWqWENZBp5d0clojtIj6f8gqzb8DbOCQg+8DBtz17DxYhruUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061213; c=relaxed/simple;
	bh=dJ68QbooWHZBKQDn5xlKP/a7N1o1WPC7m/Nz/t4kin4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJqWjdksqNOGQDOuAEqp49qmqvFpT8NAH3XQEZbRM2TCwXe+r20SHTYSlBqOpqg7vd8A5OawkvappA79e774rRuDe3baG4tLZH8OQiFhy04DMww7KcOJRapBUkHqCBF0R2Jz5eee4Oc/aak1kTfDHZFTH1iBN6eOXm1ej+ghewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VDz9Ou/q; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VDz9Ou/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785061212; x=1816597212;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1PjrX0TYQgXkSpJZuPaWlzS4502XZn4rTZl60p1SQXk=;
  b=VDz9Ou/qD2OhLsvTgz/UAJNsSmUUzZHLUvNlQ4muJzitRQp2CgvNOmix
   ij1nZj8mpq2PYI9oBWu9ZSRNYKv/ExSxj60o2T5CGlcDs4lXKe6yzp3gi
   v0RltmuhkT1pSn/7Z1LwuxORWdlElszeyMm5kTnQAO8CCSWXk2w1SOCZI
   TtCw4db26O+VIB3y//js1TEiVxywEBpr5bR6Iy8Z20MW9d4HSkfH3eB2S
   pe7WVagMXPRo9dk8kcl6pcCA/xU3fx4QsRVRAHinI9pyknf+X944jURUQ
   jmay2yiVHVq8N/ecHz0FfUzMhyL0vMmY69zoLm8JhaivYhSjW0CubAkc4
   Q==;
X-CSE-ConnectionGUID: pJ9FbLfKS3CWZ/9Dp/ky1w==
X-CSE-MsgGUID: f+M/g5v9QHivYv9W/FeiNQ==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24261773"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 10:20:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:3757]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.59:2525] with esmtp (Farcaster)
 id f9571028-cbe6-4f91-98d5-a41659b630fa; Sun, 26 Jul 2026 10:20:11 +0000 (UTC)
X-Farcaster-Flow-ID: f9571028-cbe6-4f91-98d5-a41659b630fa
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 10:20:11 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 10:20:06 +0000
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
Subject: [PATCH v4 13/13] reboot: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 10:17:39 +0000
Message-ID: <20260726101739.33170-14-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
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

