Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718612566D3;
	Sun, 26 Jul 2026 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785041846; cv=none; b=CtmycL7L+Zevcca7AF05eLJKivstusfLtRf0LIx6vLV8V4dQGntNbi4kz6A85ylvn0eLysMlqECbEsJYe7Cf7KEgApNqvm0U5xZqqc48B357e4Yv1NDKUnZYGTPulffsLYpEPzf8gt+ToWk0DtX3qH9ADkn7DLQKxUTEIMOsDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785041846; c=relaxed/simple;
	bh=izAv4uOn3uJdJapmBxvPp8CVA283++fDY8hELZSRu/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6PY72kjLVm8tU3blAaYaaDZ3BjXK3HCzLkequHF7Pi66cmgdoiOlsQ63KFLaV8my7ByVwov60qA0FSDNgZfGV1abc7uDPhDpo4OEHcv1EIqH8A1fpOER2/n0NI40FZbFr82tuT5LQvNOUwSguetK8V+i+reC3c8ofWVBza2Es8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rUwyomAk; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rUwyomAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785041845; x=1816577845;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=DufpqjNxQ2ewcaXERrtkzhvF8eYJHtlsG9NQ6Zq3iU8=;
  b=rUwyomAkM4the1iktvHmNwfGVLBoVzIVeceFNUfro81xh65s6GThBsCe
   33BGwcwBmpbS9VifRfddpnHRnZbvl/HEzId2PjMbzeiyqZ8s7Nty+2hr4
   UT5lj7P6T2M1b1BpNQ67p56BumQ/PKZa7yTBBvsj0zt+UOrhQjfcWyHpz
   KDEwN3rDJ72K22j2UN5pT70RxV/aoqR5FdoSCAxza2VfBdxmNuLWThC7S
   IL+kUpBgTgnVUtfySJPf4SNzqb9NL74xkZD/O42QA8AISMfxFmjUM3CP+
   RbwvErSEHAXHYyugwsMKkMtq1hck2F6jxAYusIlgKvMxzppCgw8ewLux4
   g==;
X-CSE-ConnectionGUID: oRx8CPTOQBuw5oz/w6qmhg==
X-CSE-MsgGUID: In2qfLr8S9+KxQ1Lj2bcaw==
X-IronPort-AV: E=Sophos;i="6.25,185,1779148800"; 
   d="scan'208";a="24131124"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 04:57:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:2152]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.59:2525] with esmtp (Farcaster)
 id 87ec2ee3-e79f-49b4-8700-661bf291b0d1; Sun, 26 Jul 2026 04:57:22 +0000 (UTC)
X-Farcaster-Flow-ID: 87ec2ee3-e79f-49b4-8700-661bf291b0d1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 04:57:21 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 04:57:16 +0000
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
Subject: [PATCH v2 01/12] notifier: add device-managed registration APIs
Date: Sun, 26 Jul 2026 04:56:55 +0000
Message-ID: <20260726045706.8169-2-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
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
Changes in v2:
- Drop 'extern' from new function prototypes (Bart Van Assche)
- Fix kerneldoc to use 'Return:' format (Bart Van Assche)
- Use <linux/device/devres.h> instead of <linux/device.h> (Andy Shevchenko)

 include/linux/notifier.h |  10 +++
 kernel/notifier.c        | 154 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 01b6c9d9956f..ccac9382478c 100644
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
+int devm_atomic_notifier_chain_register(struct device *dev,
+		struct atomic_notifier_head *nh,
+		struct notifier_block *nb);
 extern int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
 		struct notifier_block *nb);
+int devm_blocking_notifier_chain_register(struct device *dev,
+		struct blocking_notifier_head *nh,
+		struct notifier_block *nb);
 extern int raw_notifier_chain_register(struct raw_notifier_head *nh,
 		struct notifier_block *nb);
+int devm_raw_notifier_chain_register(struct device *dev,
+		struct raw_notifier_head *nh,
+		struct notifier_block *nb);
 extern int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
 		struct notifier_block *nb);
 
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 2f9fe7c30287..d8c82b237586 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/device/devres.h>
 #include <linux/kdebug.h>
 #include <linux/kprobes.h>
 #include <linux/export.h>
@@ -197,6 +198,56 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
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
+ *	Return:
+ *	0 on success, negative errno on error.
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
@@ -349,6 +400,58 @@ int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
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
+ *	Return:
+ *	0 on success, negative errno on error.
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
@@ -430,6 +533,57 @@ int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
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
+ *	Return:
+ *	0 on success, negative errno on error.
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

