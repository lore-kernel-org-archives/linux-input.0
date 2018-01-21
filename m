From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] Input: cyttsp4_core: Delete two error messages for a
 failed memory allocation in cyttsp4_probe()
Date: Sun, 21 Jan 2018 21:27:28 +0100
Message-ID: <2ca4b5f1-2b2f-19f4-d0ce-95586bb9d5cd@users.sourceforge.net>
References: <61183426-0b2a-4b93-933c-a2dfd487d92b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61183426-0b2a-4b93-933c-a2dfd487d92b@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ferruh Yigit <fery@cypress.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 21 Jan 2018 20:57:40 +0100

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/touchscreen/cyttsp4_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 727c3232517c..f0bf3cc20e9d 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -2037,14 +2037,12 @@ struct cyttsp4 *cyttsp4_probe(const struct cyttsp4_bus_ops *ops,
 
 	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
 	if (!cd) {
-		dev_err(dev, "%s: Error, kzalloc\n", __func__);
 		rc = -ENOMEM;
 		goto error_alloc_data;
 	}
 
 	cd->xfer_buf = kzalloc(xfer_buf_size, GFP_KERNEL);
 	if (!cd->xfer_buf) {
-		dev_err(dev, "%s: Error, kzalloc\n", __func__);
 		rc = -ENOMEM;
 		goto error_free_cd;
 	}
-- 
2.16.0
