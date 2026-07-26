Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF1368D4C;
	Sun, 26 Jul 2026 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047952; cv=none; b=aTvNH7/PGkyaHLXxx2QA2/Junmet+gd6ejbpF3uuosI2W61J5dUgTBEDpWN0L6ebuHUAUg11h2Ph+8rWcetJHso/aLrwiJRA4aE0A5hAt7LcZhg5lXsil7mtwqiRG2PTx2DLndjWiI+Rs1bFOueDRETXyAm/9/aOzbLx2z7ZuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047952; c=relaxed/simple;
	bh=Au2jGWBQN/i2YaPgSzikwkAxqaVP4qGTpVegc2n7t+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGqu8Hvebpqr0uQCEuw5icgKPBelGqW3LxhCN/9P7RvGgGnoCgw71CBLOfJ0uNqyIFYGqZJ8Pa68SSNP03Tla5ihS4wCrmZxbpuRF9+9mViM2LMg9Xqj9S5LwhBWq5pzMaEJz+tyZZsXxNQlz9fqRAxr/gymCCPQdszYn1BPJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=e9BgPkrL; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="e9BgPkrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785047950; x=1816583950;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yps4lBc/RYwlxTR0dmczc+YOvWPbhS0zT2kuXNnrCAk=;
  b=e9BgPkrLXaoFm/18P0fw42RsGOg39xtInIQpEUXbWYNS57/NritqWSBD
   kR8f5ROTrAGbiNkpt4GmH7/xbcRBC/0ZSDlhNgZHeIDFllYEYndnH1/C3
   juwJ7Cga+2RXXz0za7Yt9pFUk1+90TgKjqBON5IabBO+uBd/+6lyFnvfw
   ZCA4MUjZiqirjC348X9zC1bBm6MD/L741167yNPYoROv/JeYJbeflcyws
   kfZeXNNSLJ77ZHz8AWjK1egs078KlC2i8ODutu+Q55mINasOmTcDV8piR
   IVmsKxUuQK1ql2nzFOXnVtsrZTpXNKQpkiLNEXQFSsDDMsF3Dn/d6CPHm
   g==;
X-CSE-ConnectionGUID: KxE8CqjjQHCzMMKhtv0BlQ==
X-CSE-MsgGUID: rTfe17uqTyK1P/N0pc2ytQ==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24369554"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 06:39:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:21253]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.26:2525] with esmtp (Farcaster)
 id e83b54f7-fc3e-44c3-8f06-a32ce25d36a3; Sun, 26 Jul 2026 06:39:09 +0000 (UTC)
X-Farcaster-Flow-ID: e83b54f7-fc3e-44c3-8f06-a32ce25d36a3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 06:39:09 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 06:39:04 +0000
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
Subject: [PATCH v3 09/12] platform/x86: uniwill-wmi: use devm_blocking_notifier_chain_register()
Date: Sun, 26 Jul 2026 06:37:24 +0000
Message-ID: <20260726063727.19111-10-farbere@amazon.com>
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
devm_uniwill_wmi_unregister_notifier() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/platform/x86/uniwill/uniwill-wmi.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/uniwill/uniwill-wmi.c b/drivers/platform/x86/uniwill/uniwill-wmi.c
index afcbfa4f7552..2ffa29a829ee 100644
--- a/drivers/platform/x86/uniwill/uniwill-wmi.c
+++ b/drivers/platform/x86/uniwill/uniwill-wmi.c
@@ -26,22 +26,11 @@
 
 static BLOCKING_NOTIFIER_HEAD(uniwill_wmi_chain_head);
 
-static void devm_uniwill_wmi_unregister_notifier(void *data)
-{
-	struct notifier_block *nb = data;
-
-	blocking_notifier_chain_unregister(&uniwill_wmi_chain_head, nb);
-}
-
 int devm_uniwill_wmi_register_notifier(struct device *dev, struct notifier_block *nb)
 {
-	int ret;
-
-	ret = blocking_notifier_chain_register(&uniwill_wmi_chain_head, nb);
-	if (ret < 0)
-		return ret;
-
-	return devm_add_action_or_reset(dev, devm_uniwill_wmi_unregister_notifier, nb);
+	return devm_blocking_notifier_chain_register(dev,
+						     &uniwill_wmi_chain_head,
+						     nb);
 }
 
 static void uniwill_wmi_notify(struct wmi_device *wdev, union acpi_object *obj)
-- 
2.47.3

