Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144A3CB550;
	Sun, 16 Aug 2026 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860429; cv=none; b=HIJqwomNFu46Mx6E2XndHx+4i5s0Qs2BkOKyfqhqTZzXfpdjga4Dk6bpLG2xCy5TCN2Qxe6mP3UbaHUubNcalDTsrCwf1/CLiKB6cKu9yi6jTXHBS+EebkNrvgpb2bWEAepNnPhg+Wa2WkF+zCjVEyuDeBAwgwFv0JDzWF0wBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860429; c=relaxed/simple;
	bh=sXPTWHNlPBkHKDT7AuZLb05HsjnI6TVDYudXzM2Ns5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewJVXhmdSjGgBmMnB/BEjhgiKBIwTc23u+YoDsoldJGzAtTG3DYXThUONAc03yAEfuycCCrlheS6/4gy89X8MOgzACjn3J5aXpIztmc7RGVGocPW+3x4mPuU6SGHerytybmYN4exn0nvD0eKcgqRxh91JE94rhlzs8ApRIVDyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=DzwprpBZ; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="DzwprpBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860427; x=1818396427;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OpkJVVFbsg4IP85fQpO6w/uLcrscuY7nj88/MbhVBhc=;
  b=DzwprpBZjyFGdAlhMiPewA+lzh/uN8EPbndbVVWUjdxZg3RH4Fl3mig1
   Yn5Xbgy8w+SavfGUEXdNr8Ht6oFRwd7zOnBN3UH8M2ZBgnxECJLISW8sZ
   O+sZyLSdPy2KLusG8ugTxythGVL7EvmMBf8T7/Y3t5CZC/w6JgofeMtqR
   eyclxEK/ka8gLo1gN+wyjCFp5ZvoLPs8mRXSRwWJWaW61EHGrL89hwMLU
   XYoC26HbfiSz5yNDqkDNPBv4xST1gld70aI02q6bg4p47cbxTDuXuwW92
   NW6fjd4+e92sx/GLEIm4C14/jpv0+tYmR4nvBw+y+nPXIA6BWyVSdo0z8
   w==;
X-CSE-ConnectionGUID: sqiQs5hURyGOVQlP1PmhNQ==
X-CSE-MsgGUID: 3Rlz7WPbT0Cv85JBg50/8g==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="26059434"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:07:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:3092]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.125:2525] with esmtp (Farcaster)
 id 7aa01fe4-cc91-4b4f-a91d-08f6e2ba5676; Sun, 16 Aug 2026 06:07:04 +0000 (UTC)
X-Farcaster-Flow-ID: 7aa01fe4-cc91-4b4f-a91d-08f6e2ba5676
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:07:04 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:06:59 +0000
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
Subject: [PATCH v5 01/13] notifier: add device-managed registration APIs
Date: Sun, 16 Aug 2026 06:06:00 +0000
Message-ID: <20260816060648.4030-2-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816060648.4030-1-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
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
Changes in v5:
- Rename notifier_block parameter from 'n' to 'nb' to match the devres
  struct field name (Uwe Kleine-König)

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
index 2f9fe7c30287..0c39627ea69c 100644
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
+ *	@nb: New entry in notifier chain
+ *
+ *	Adds a notifier to an atomic notifier chain and registers a cleanup
+ *	action to automatically unregister it when @dev is unbound.
+ *
+ *	Return:
+ *	0 on success, negative errno on error.
+ */
+int devm_atomic_notifier_chain_register(struct device *dev,
+					struct atomic_notifier_head *nh,
+					struct notifier_block *nb)
+{
+	struct atomic_notifier_chain_devres *dr;
+	int ret;
+
+	dr = devres_alloc(devm_atomic_notifier_chain_unregister,
+			  sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = atomic_notifier_chain_register(nh, nb);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	dr->nh = nh;
+	dr->nb = nb;
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
+ *	@nb: New entry in notifier chain
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
+					  struct notifier_block *nb)
+{
+	struct blocking_notifier_chain_devres *dr;
+	int ret;
+
+	dr = devres_alloc(devm_blocking_notifier_chain_unregister,
+			  sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = blocking_notifier_chain_register(nh, nb);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	dr->nh = nh;
+	dr->nb = nb;
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

