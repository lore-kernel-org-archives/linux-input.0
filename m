Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D51DF75A;
	Sun, 26 Jul 2026 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061083; cv=none; b=sjdr6QMwYK3uRSmvUZAEob+dbAHAT3KuHyBlEiusu6tEVFt41ZETD91h39ROdwUkKfCwSjgWq8APwm23kEpFGR4w6DsX438ygXtVYC9evwSvZ7LJtXNP6UAkMazvrUXk0Vool8m0lm6GtBpdFXXMscQnfS5+HKffs+WcAhi/M6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061083; c=relaxed/simple;
	bh=h2yvn3dvmOPBsOWRmAT4h8LitnjSDHXOALIXcmPRjvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZzBfeZF0MLM7c1ChJoE131bLnW0R386CGnN0uhKS3SF/HWtiAfsEJoHR4v+yQP+7Z90YHyTRPJn1xVXQC8beP78E0tR2tJ1q+N0S/ds+k92WSIQB668wrVI7RzfML4CP36IlPdldvo67TJvc8HBwI7vcanjLULLb7XjX+PTrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qNprRJMT; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qNprRJMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785061082; x=1816597082;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pZvnkEPOf8vQ2G1cI1HhnjEaK8GgabpCiw/+PbDxpl0=;
  b=qNprRJMTDPgKIS6C69JoaHn0AkbxmxmYQ4dcG0rNW4RZ4O5NZxMI0XE1
   ZzUHOt6H4LjpSYcxw0M8UzcmZsGfUAbqJnXUhlhp/S0zBWnRoIWzpDhxE
   t4F9aAn4iWTjOAOGPqOUTpqjjT/3/+nQFMRyXeyaOWIYVZkx63tSSk7fj
   25ZmkPwsXnOiQLpokJPeLd2gvPsEoWKphAtSKE5XuKTz2QuJLiRj6H/ia
   hjdQs2pk7qIahqpDgjLOoVotUdpJzBuTgtGCLmKd9PY1iLUN4J43BiI1J
   eduaPzqakAXyj+Q/smAXElCtOU5YWk7xTNnw8b+Va+n8niPVNuC2bB69l
   Q==;
X-CSE-ConnectionGUID: yApHP3iDQUqNSy7W7fWD5g==
X-CSE-MsgGUID: RnA320/eQYuVnbZovhbjqA==
X-IronPort-AV: E=Sophos;i="6.25,186,1779148800"; 
   d="scan'208";a="24169360"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 10:17:59 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:5552]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.152:2525] with esmtp (Farcaster)
 id 80cbfd9c-2224-45fc-900c-77c4bf92994c; Sun, 26 Jul 2026 10:17:58 +0000 (UTC)
X-Farcaster-Flow-ID: 80cbfd9c-2224-45fc-900c-77c4bf92994c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 26 Jul 2026 10:17:58 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 26 Jul 2026
 10:17:53 +0000
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
Subject: [PATCH v4 01/13] notifier: add device-managed registration APIs
Date: Sun, 26 Jul 2026 10:17:27 +0000
Message-ID: <20260726101739.33170-2-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add devm_atomic_notifier_chain_register() and
devm_blocking_notifier_chain_register() that automatically unregister
the notifier when the device is unbound.

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

A devm variant for raw notifier chains is intentionally not included
because raw notifiers require the caller to provide all locking. The
devres teardown callback has no way to acquire the caller's lock, and
devres_alloc() with GFP_KERNEL cannot be used if the caller's lock is a
spinlock.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
Changes in v3:
- Drop devm_raw_notifier_chain_register() since raw notifiers require
  caller-provided locking which is incompatible with the devres teardown
  callback (Sashiko)

Changes in v2:
- Drop 'extern' from new function prototypes (Bart Van Assche)
- Fix kerneldoc to use 'Return:' format (Bart Van Assche)
- Use <linux/device/devres.h> instead of <linux/device.h> (Andy Shevchenko)

 include/linux/notifier.h |   7 +++
 kernel/notifier.c        | 103 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 01b6c9d9956f..4eeae9741a6e 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -46,6 +46,7 @@
  * often but notifier_blocks will seldom be removed.
  */
 
+struct device;
 struct notifier_block;
 
 typedef	int (*notifier_fn_t)(struct notifier_block *nb,
@@ -145,8 +146,14 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 
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
 extern int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 2f9fe7c30287..c1a66fa0c331 100644
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
-- 
2.47.3

