From: Vince Kim <vince.k.kim@gmail.com>
Subject: [PATCH] Input: cyttsp4 - Fix error on calculating memory size passed to krealloc.
Date: Tue, 31 Oct 2017 12:19:58 -0700
Message-ID: <1509477598-7010-1-git-send-email-vince.k.kim@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:56691 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbdJaTZQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Oct 2017 15:25:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Vince Kim <vince.k.kim@gmail.com>, Ferruh Yigit <fery@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

There are several places to perform subtraction to calculate buffer
size such as:

si->si_ofs.cydata_size = si->si_ofs.test_ofs - si->si_ofs.cydata_ofs;
...
p = krealloc(si->si_ptrs.cydata, si->si_ofs.cydata_size, GFP_KERNEL);

Actually, data types of above variables during subtraction are size_t, so it is
unsigned. That means if second operand(si->si_ofs.cydata_ofs) is
greater than the first operand(si->si_ofs.test_ofs), then resulting
si->si_ofs.cydata_size could result in an unsigned integer wrap which is
not desiarable.

The properway to correct this problem is to perform a test of both
operands to avoid having unsigned wrap.
---
 drivers/input/touchscreen/cyttsp4_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index beaf61c..eecc7f1 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -201,6 +201,11 @@ static int cyttsp4_si_get_cydata(struct cyttsp4 *cd)
 	void *p;
 	int rc;
 
+	if (si->si_ofs.test_ofs <= si->si_ofs.cydata_ofs)
+		dev_err(cd->dev, "%s: invalid offset  test_ofs:%zd, cydata_ofs:%zd \n", __func__, si->si_ofs.test_ofs, si->si_ofs.cydata_ofs);
+		return -EINVAL;
+	}
+
 	si->si_ofs.cydata_size = si->si_ofs.test_ofs - si->si_ofs.cydata_ofs;
 	dev_dbg(cd->dev, "%s: cydata size: %zd\n", __func__,
 			si->si_ofs.cydata_size);
@@ -270,6 +275,11 @@ static int cyttsp4_si_get_test_data(struct cyttsp4 *cd)
 	void *p;
 	int rc;
 
+	if (si->si_ofs.pcfg_ofs <= si->si_ofs.test_ofs)
+		dev_err(cd->dev, "%s: invalid offset  pcfg_ofs:%zd, test_ofs:%zd \n", __func__, si->si_ofs.pcfg_ofs, si->si_ofs.test_ofs);
+		return -EINVAL;
+	}
+
 	si->si_ofs.test_size = si->si_ofs.pcfg_ofs - si->si_ofs.test_ofs;
 
 	p = krealloc(si->si_ptrs.test, si->si_ofs.test_size, GFP_KERNEL);
@@ -321,6 +331,11 @@ static int cyttsp4_si_get_pcfg_data(struct cyttsp4 *cd)
 	void *p;
 	int rc;
 
+	if (si->si_ofs.opcfg_ofs <= si->si_ofs.pcfg_ofs)
+		dev_err(cd->dev, "%s: invalid offset  opcfg_ofs:%zd, pcfg_ofs:%zd \n", __func__, si->si_ofs.opcfg_ofs, si->si_ofs.pcfg_ofs);
+		return -EINVAL;
+	}
+
 	si->si_ofs.pcfg_size = si->si_ofs.opcfg_ofs - si->si_ofs.pcfg_ofs;
 
 	p = krealloc(si->si_ptrs.pcfg, si->si_ofs.pcfg_size, GFP_KERNEL);
@@ -367,6 +382,11 @@ static int cyttsp4_si_get_opcfg_data(struct cyttsp4 *cd)
 	void *p;
 	int rc;
 
+	if (si->si_ofs.ddata_ofs <= si->si_ofs.opcfg_ofs)
+		dev_err(cd->dev, "%s: invalid offset  ddata_ofs:%zd, opcfg_ofs:%zd \n", __func__, si->si_ofs.ddata_ofs, si->si_ofs.opcfg_ofs);
+		return -EINVAL;
+	}
+
 	si->si_ofs.opcfg_size = si->si_ofs.ddata_ofs - si->si_ofs.opcfg_ofs;
 
 	p = krealloc(si->si_ptrs.opcfg, si->si_ofs.opcfg_size, GFP_KERNEL);
-- 
2.7.4

