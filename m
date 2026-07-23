Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491B3A6EF0;
	Thu, 23 Jul 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829420; cv=none; b=Ktz4VppVXj6LLXFWC8v1bWrMKxGuvva+Tcnbojspf/2fUFAZMZNi9P2lrMmL7i4nUir5mW+fUGsINeVYFUVprP4N3XA5fNcdHdWjODQ7Dnz/P3MsiKmfpvhARZr2h77w3Lpb2Y+fImGqzcFGo6ChTKjwVdGx5D1IK68D6LSWJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829420; c=relaxed/simple;
	bh=oR16xQ0l2QZ1HctK5sTlhQ03S1oe8xRZ47h7iuZrD8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhLcqfAFtrB1JLEZSp30OhmnFfQL8tnMtJFUMz7L9kHn0HECrlsJIyZVxrhmmuz+A1vr7xaTShdc5IiEFhoih90K4zXdOf8SixP9KbU1KSRULnoZiURV4UTJKvss6hBxUxBzkxhcQUL7AF1MXQHsD7AHH3G45IK/WoOZUQ+Vc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZYpmudVO; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZYpmudVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829418; x=1816365418;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=jqAtat0tnNZsJMQ+mPgx7+6Yqu2gEeC9PKKRqoqiiYY=;
  b=ZYpmudVOjoikVBzB2Zb+G2cSBBsxdugumqxEp+xhobfQ4Iv2yLyiFJYk
   n7JILy553+8KN+23mlZZ62bOwkzvBPApoiMOHVRSAPv3ZFZrl4uYkMgyI
   CXvns7hB2FJdpBH7bkPFrMhj6O5rA+kArTvMJhpFjcI9CfflA/DjSnAjY
   ywXwT0l8IymwUrgxpc0CyptIFjUy0dIVcr2rSNXRtgcwxq0ET9j+/rYKt
   GeXpT3TSOF3zUyaQAtiGbJzVAYpDg68tvcwnEjHuTFRFNJnl6QgjH/zo/
   9UDRHrJcqcAGePJsXdzXSs2LNcsd2JiKehJGGorQixQAnt1eGN5Vzppgz
   w==;
X-CSE-ConnectionGUID: FwsnzNEUSw+MAZyytE0dZA==
X-CSE-MsgGUID: f6oujNIJQ9SQHeJzPcBjjg==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24038526"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:56:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:23766]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.176:2525] with esmtp (Farcaster)
 id 073ee108-1999-4093-947b-2bc7a319785e; Thu, 23 Jul 2026 17:56:52 +0000 (UTC)
X-Farcaster-Flow-ID: 073ee108-1999-4093-947b-2bc7a319785e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:56:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:56:47 +0000
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
Subject: [PATCH 12/12] reboot: use devm_blocking_notifier_chain_register()
Date: Thu, 23 Jul 2026 17:56:32 +0000
Message-ID: <20260723175632.44812-3-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723175632.44812-1-farbere@amazon.com>
References: <20260723175632.44812-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
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

