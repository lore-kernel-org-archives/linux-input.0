From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCHv3 2/7] input/cma3000_d0x: Check silicon version
Date: Tue, 18 Oct 2011 17:48:01 +0200
Message-ID: <1318952886-835-3-git-send-email-ricardo.ribalda__11367.9933747791$1318953025$gmane$org@gmail.com>
References: <1318952886-835-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36602 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932722Ab1JRPsT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 11:48:19 -0400
In-Reply-To: <1318952886-835-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, jic23@cam.ac.uk, hemanthv@ti
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Improve probing of the cma3000 chip, by checking the revision of the
device.

---

v2: Fixes suggested by Jonathan Cameron
	-Remove WhoamI pr_info

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/input/misc/cma3000_d0x.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
index 604a32f..18ac912 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -27,6 +27,8 @@
 
 #include "cma3000_d0x.h"
 
+#define CMA3000_REV         0x10
+
 #define CMA3000_WHOAMI      0x00
 #define CMA3000_REVID       0x01
 #define CMA3000_CTRL        0x02
@@ -418,7 +420,11 @@ struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
 		error = rev;
 		goto err_free_mem;
 	}
-
+	if (rev != CMA3000_REV) {
+		error = -EINVAL;
+		pr_err("CMA3000 Accelerometer: Unknown Revision %x\n", rev);
+		goto err_free_mem;
+	}
 	pr_info("CMA3000 Accelerometer: Revision %x\n", rev);
 
 	error = request_threaded_irq(irq, NULL, cma3000_thread_irq,
-- 
1.7.7

