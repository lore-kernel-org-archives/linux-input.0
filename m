From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] Input: cyttsp4_core: Adjust 13 checks for null pointers
Date: Sun, 21 Jan 2018 21:30:19 +0100
Message-ID: <6c4f8970-11bd-fe4c-1041-48a006b98b15@users.sourceforge.net>
References: <61183426-0b2a-4b93-933c-a2dfd487d92b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:51440 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeAUUaY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 15:30:24 -0500
In-Reply-To: <61183426-0b2a-4b93-933c-a2dfd487d92b@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ferruh Yigit <fery@cypress.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 21:15:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/cyttsp4_core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 35f48b66ff36..32a4a45554fe 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -213,7 +213,7 @@ static int cyttsp4_si_get_cydata(struct cyttsp4 *cd)
 			si->si_ofs.cydata_size);
 
 	p = krealloc(si->si_ptrs.cydata, si->si_ofs.cydata_size, GFP_KERNEL);
-	if (p == NULL) {
+	if (!p) {
 		dev_err(cd->dev, "%s: failed to allocate cydata memory\n",
 			__func__);
 		return -ENOMEM;
@@ -288,7 +288,7 @@ static int cyttsp4_si_get_test_data(struct cyttsp4 *cd)
 	si->si_ofs.test_size = si->si_ofs.pcfg_ofs - si->si_ofs.test_ofs;
 
 	p = krealloc(si->si_ptrs.test, si->si_ofs.test_size, GFP_KERNEL);
-	if (p == NULL) {
+	if (!p) {
 		dev_err(cd->dev, "%s: failed to allocate test memory\n",
 			__func__);
 		return -ENOMEM;
@@ -347,7 +347,7 @@ static int cyttsp4_si_get_pcfg_data(struct cyttsp4 *cd)
 	si->si_ofs.pcfg_size = si->si_ofs.opcfg_ofs - si->si_ofs.pcfg_ofs;
 
 	p = krealloc(si->si_ptrs.pcfg, si->si_ofs.pcfg_size, GFP_KERNEL);
-	if (p == NULL) {
+	if (!p) {
 		dev_err(cd->dev, "%s: failed to allocate pcfg memory\n",
 			__func__);
 		return -ENOMEM;
@@ -399,7 +399,7 @@ static int cyttsp4_si_get_opcfg_data(struct cyttsp4 *cd)
 	si->si_ofs.opcfg_size = si->si_ofs.ddata_ofs - si->si_ofs.opcfg_ofs;
 
 	p = krealloc(si->si_ptrs.opcfg, si->si_ofs.opcfg_size, GFP_KERNEL);
-	if (p == NULL) {
+	if (!p) {
 		dev_err(cd->dev, "%s: failed to allocate opcfg memory\n",
 			__func__);
 		return -ENOMEM;
@@ -488,7 +488,7 @@ static int cyttsp4_si_get_ddata(struct cyttsp4 *cd)
 	si->si_ofs.ddata_size = si->si_ofs.mdata_ofs - si->si_ofs.ddata_ofs;
 
 	p = krealloc(si->si_ptrs.ddata, si->si_ofs.ddata_size, GFP_KERNEL);
-	if (p == NULL) {
+	if (!p) {
 		dev_err(cd->dev, "%s: fail alloc ddata memory\n", __func__);
 		return -ENOMEM;
 	}
@@ -515,7 +515,7 @@ static int cyttsp4_si_get_mdata(struct cyttsp4 *cd)
 	si->si_ofs.mdata_size = si->si_ofs.map_sz - si->si_ofs.mdata_ofs;
 
 	p = krealloc(si->si_ptrs.mdata, si->si_ofs.mdata_size, GFP_KERNEL);
-	if (p == NULL) {
+	if (!p) {
 		dev_err(cd->dev, "%s: fail alloc mdata memory\n", __func__);
 		return -ENOMEM;
 	}
@@ -548,16 +548,16 @@ static int cyttsp4_si_get_btn_data(struct cyttsp4 *cd)
 
 		p = krealloc(si->btn, si->si_ofs.btn_keys_size,
 				GFP_KERNEL|__GFP_ZERO);
-		if (p == NULL) {
+		if (!p) {
 			dev_err(cd->dev, "%s: %s\n", __func__,
 				"fail alloc btn_keys memory");
 			return -ENOMEM;
 		}
 		si->btn = p;
 
-		if (cd->cpdata->sett[CY_IC_GRPNUM_BTN_KEYS] == NULL)
+		if (!cd->cpdata->sett[CY_IC_GRPNUM_BTN_KEYS])
 			num_defined_keys = 0;
-		else if (cd->cpdata->sett[CY_IC_GRPNUM_BTN_KEYS]->data == NULL)
+		else if (!cd->cpdata->sett[CY_IC_GRPNUM_BTN_KEYS]->data)
 			num_defined_keys = 0;
 		else
 			num_defined_keys = cd->cpdata->sett
@@ -592,19 +592,19 @@ static int cyttsp4_si_get_op_data_ptrs(struct cyttsp4 *cd)
 	void *p;
 
 	p = krealloc(si->xy_mode, si->si_ofs.mode_size, GFP_KERNEL|__GFP_ZERO);
-	if (p == NULL)
+	if (!p)
 		return -ENOMEM;
 	si->xy_mode = p;
 
 	p = krealloc(si->xy_data, si->si_ofs.data_size, GFP_KERNEL|__GFP_ZERO);
-	if (p == NULL)
+	if (!p)
 		return -ENOMEM;
 	si->xy_data = p;
 
 	p = krealloc(si->btn_rec_data,
 			si->si_ofs.btn_rec_size * si->si_ofs.num_btns,
 			GFP_KERNEL|__GFP_ZERO);
-	if (p == NULL)
+	if (!p)
 		return -ENOMEM;
 	si->btn_rec_data = p;
 
@@ -1977,7 +1977,7 @@ static int cyttsp4_mt_probe(struct cyttsp4 *cd)
 	dev_vdbg(dev, "%s: Create the input device and register it\n",
 		__func__);
 	md->input = input_allocate_device();
-	if (md->input == NULL) {
+	if (!md->input) {
 		dev_err(dev, "%s: Error, failed to allocate input device\n",
 			__func__);
 		rc = -ENOSYS;
-- 
2.16.0

