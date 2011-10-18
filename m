From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCHv2 2/7] input/cma3000_d0x: Check silicon version
Date: Tue, 18 Oct 2011 14:06:31 +0200
Message-ID: <1318939596-27330-3-git-send-email-ricardo.ribalda__25140.2229805992$1318939807$gmane$org@gmail.com>
References: <1318939596-27330-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53163 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194Ab1JRMGv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 08:06:51 -0400
In-Reply-To: <1318939596-27330-1-git-send-email-ricardo.ribalda@gmail.com>
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
index f2e87e3..3877cbe 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -26,6 +26,8 @@
 
 #include "cma3000_d0x.h"
 
+#define CMA3000_REV         0x10
+
 #define CMA3000_WHOAMI      0x00
 #define CMA3000_REVID       0x01
 #define CMA3000_CTRL        0x02
@@ -366,7 +368,11 @@ struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
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

