Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2E3955F9;
	Thu, 23 Jul 2026 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829226; cv=none; b=aLipzxp8Z5nZLPWA7bcAdgLPiriZrz/aMLhhxc/jEvQGakdmGXJFuzAY3WGMahighcyy2ahpi5lNQQeZyt7zp96zHWvLoXJf6zLsEl7nr1XZ36eAqQMJilHYAXC4X6TSyrUM3cJH6p7cy3KE7q10mlBi+3aHG32+fzv8csARqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829226; c=relaxed/simple;
	bh=a66Y3oLEysiBl5/7AfHP+V1BOUaIKY4i0GPOtBreEZc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEb3zmaj3u/Ba/tIoWcaxq+txYzkB5sFPdRhXrueAV9fBWZnl49J0jO3X9sRJf/GSMcvghhUAbTVr0ErelTNwiWoD5ocpeDt6SvdNm1MjZBA0Fgou1Eye2Vkvd4ZGPHDoHPGOqapHak49pF3PN80CQZ5thJudFVPVp0xr22FivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qGNAyIU/; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qGNAyIU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784829225; x=1816365225;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=86pgs+O++1D8f/sTwZk8VxCs7/S4TsCINGa8Z5Fi80A=;
  b=qGNAyIU/DdiStyoHokTFItWPnIzdUC25gzC2bjFsQGpNonuFrr+gF3AS
   c1//csGHzC6h6iNtiRyRrrjSBkkMu6AHVxzUtTEkRVgzHb83lEX3mWmmM
   BVELYfOhribZoY/02MGoVyypLGYG+vekTPr4eDylup1NRocdTfMYYd32u
   jhyDz/xlNG+FxWixtsHLKIQphIK/punXShAQO0IvvrskALB6bd5+7XA9H
   7Bvv0OthKs7QvU9IblibxqN4d3nQKQGx0Jh6nW/z8oyF4RIg4UYaC0FTP
   RJotYyfpi7lobyAROlKVuxocUV0Rgs9hS4dHO1fvVgd864UTNJ29IK/Sc
   A==;
X-CSE-ConnectionGUID: jL3cuFkKRrWHvvUD+rP/nw==
X-CSE-MsgGUID: IuNr95ODRjucgEDZS5ej5w==
X-IronPort-AV: E=Sophos;i="6.25,181,1779148800"; 
   d="scan'208";a="24266658"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 17:53:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:10062]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.59:2525] with esmtp (Farcaster)
 id 8c5df475-2015-43d0-93cc-07b73ec08c5f; Thu, 23 Jul 2026 17:53:41 +0000 (UTC)
X-Farcaster-Flow-ID: 8c5df475-2015-43d0-93cc-07b73ec08c5f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 17:53:41 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 23 Jul 2026
 17:53:36 +0000
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
Subject: [PATCH 01/12] notifier: add device-managed registration APIs
Date: Thu, 23 Jul 2026 17:53:14 +0000
Message-ID: <20260723175325.37397-2-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723175325.37397-1-farbere@amazon.com>
References: <20260723175325.37397-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add devm_atomic_notifier_chain_register(),
devm_blocking_notifier_chain_register(), and
devm_raw_notifier_chain_register() that automatically unregister the
notifier when the device is unbound.

Many drivers repeat the same boilerplate pattern:

  1. Register the notifier with *_notifier_chain_register()
  2. Check for error
  3. Register a devm action to unregister on teardown
  4. Implement a per-driver static unregister callback

With the new devm_*_notifier_chain_register() APIs, this reduces to a
single call with one error path, eliminating per-driver unregister
callbacks entirely.

The implementation follows the established devres pattern used by other
device-managed kernel APIs.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/notifier.h |  10 +++
 kernel/notifier.c        | 151 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 01b6c9d9956f..aa3745d7459b 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -46,6 +46,7 @@
  * often but notifier_blocks will seldom be removed.
  */
 
+struct device;
 struct notifier_block;
 
 typedef	int (*notifier_fn_t)(struct notifier_block *nb,
@@ -145,10 +146,19 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 
 extern int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 		struct notifier_block *nb);
+extern int devm_atomic_notifier_chain_register(struct device *dev,
+		struct atomic_notifier_head *nh,
+		struct notifier_block *nb);
 extern int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
 		struct notifier_block *nb);
+extern int devm_blocking_notifier_chain_register(struct device *dev,
+		struct blocking_notifier_head *nh,
+		struct notifier_block *nb);
 extern int raw_notifier_chain_register(struct raw_notifier_head *nh,
 		struct notifier_block *nb);
+extern int devm_raw_notifier_chain_register(struct device *dev,
+		struct raw_notifier_head *nh,
+		struct notifier_block *nb);
 extern int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
 		struct notifier_block *nb);
 
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 2f9fe7c30287..b811638aa878 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/device.h>
 #include <linux/kdebug.h>
 #include <linux/kprobes.h>
 #include <linux/export.h>
@@ -197,6 +198,55 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
 
+struct atomic_notifier_chain_devres {
+	struct atomic_notifier_head *nh;
+	struct notifier_block *nb;
+};
+
+static void devm_atomic_notifier_chain_unregister(struct device *dev, void *res)
+{
+	struct atomic_notifier_chain_devres *dr = res;
+
+	atomic_notifier_chain_unregister(dr->nh, dr->nb);
+}
+
+/**
+ *	devm_atomic_notifier_chain_register - Device-managed atomic notifier registration
+ *	@dev: Device to tie the notifier lifetime to
+ *	@nh: Pointer to head of the atomic notifier chain
+ *	@n: New entry in notifier chain
+ *
+ *	Adds a notifier to an atomic notifier chain and registers a cleanup
+ *	action to automatically unregister it when @dev is unbound.
+ *
+ *	Returns 0 on success, negative errno on error.
+ */
+int devm_atomic_notifier_chain_register(struct device *dev,
+					struct atomic_notifier_head *nh,
+					struct notifier_block *n)
+{
+	struct atomic_notifier_chain_devres *dr;
+	int ret;
+
+	dr = devres_alloc(devm_atomic_notifier_chain_unregister,
+			  sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = atomic_notifier_chain_register(nh, n);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	dr->nh = nh;
+	dr->nb = n;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_atomic_notifier_chain_register);
+
 /**
  *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
  *	@nh: Pointer to head of the atomic notifier chain
@@ -349,6 +399,57 @@ int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(blocking_notifier_call_chain_robust);
 
+struct blocking_notifier_chain_devres {
+	struct blocking_notifier_head *nh;
+	struct notifier_block *nb;
+};
+
+static void devm_blocking_notifier_chain_unregister(struct device *dev,
+						    void *res)
+{
+	struct blocking_notifier_chain_devres *dr = res;
+
+	blocking_notifier_chain_unregister(dr->nh, dr->nb);
+}
+
+/**
+ *	devm_blocking_notifier_chain_register - Device-managed blocking notifier registration
+ *	@dev: Device to tie the notifier lifetime to
+ *	@nh: Pointer to head of the blocking notifier chain
+ *	@n: New entry in notifier chain
+ *
+ *	Adds a notifier to a blocking notifier chain and registers a cleanup
+ *	action to automatically unregister it when @dev is unbound.
+ *	Must be called in process context.
+ *
+ *	Returns 0 on success, negative errno on error.
+ */
+int devm_blocking_notifier_chain_register(struct device *dev,
+					  struct blocking_notifier_head *nh,
+					  struct notifier_block *n)
+{
+	struct blocking_notifier_chain_devres *dr;
+	int ret;
+
+	dr = devres_alloc(devm_blocking_notifier_chain_unregister,
+			  sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = blocking_notifier_chain_register(nh, n);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	dr->nh = nh;
+	dr->nb = n;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_blocking_notifier_chain_register);
+
 /**
  *	blocking_notifier_call_chain - Call functions in a blocking notifier chain
  *	@nh: Pointer to head of the blocking notifier chain
@@ -430,6 +531,56 @@ int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(raw_notifier_call_chain_robust);
 
+struct raw_notifier_chain_devres {
+	struct raw_notifier_head *nh;
+	struct notifier_block *nb;
+};
+
+static void devm_raw_notifier_chain_unregister(struct device *dev, void *res)
+{
+	struct raw_notifier_chain_devres *dr = res;
+
+	raw_notifier_chain_unregister(dr->nh, dr->nb);
+}
+
+/**
+ *	devm_raw_notifier_chain_register - Device-managed raw notifier registration
+ *	@dev: Device to tie the notifier lifetime to
+ *	@nh: Pointer to head of the raw notifier chain
+ *	@n: New entry in notifier chain
+ *
+ *	Adds a notifier to a raw notifier chain and registers a cleanup
+ *	action to automatically unregister it when @dev is unbound.
+ *	All locking must be provided by the caller.
+ *
+ *	Returns 0 on success, negative errno on error.
+ */
+int devm_raw_notifier_chain_register(struct device *dev,
+				     struct raw_notifier_head *nh,
+				     struct notifier_block *n)
+{
+	struct raw_notifier_chain_devres *dr;
+	int ret;
+
+	dr = devres_alloc(devm_raw_notifier_chain_unregister,
+			  sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = raw_notifier_chain_register(nh, n);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	dr->nh = nh;
+	dr->nb = n;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_raw_notifier_chain_register);
+
 /**
  *	raw_notifier_call_chain - Call functions in a raw notifier chain
  *	@nh: Pointer to head of the raw notifier chain
-- 
2.47.3

