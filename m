From: Even Xu <even.xu@intel.com>
Subject: [PATCH 2/3] hid: intel-ish-hid: ipc: change timed_wait_for_timeout() to be a function
Date: Fri, 11 Nov 2016 09:40:23 +0800
Message-ID: <1478828423-31733-1-git-send-email-even.xu@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:28339 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935107AbcKKBkE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 20:40:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, srinivas.pandruvada@intel.com, Even Xu <even.xu@intel.com>

The macro timed_wait_for_timeout() only be used in one function, so move
this marco from header file and change it to a function in ipc.c, where
it is used.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c   | 62 ++++++++++++++++++++++++++++++++---
 drivers/hid/intel-ish-hid/ipc/utils.h | 43 ------------------------
 2 files changed, 57 insertions(+), 48 deletions(-)
 delete mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 522c0e1..8194c35 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -19,7 +19,6 @@
 #include <linux/jiffies.h>
 #include "client.h"
 #include "hw-ish.h"
-#include "utils.h"
 #include "hbm.h"
 
 /* For FW reset flow */
@@ -427,6 +426,59 @@ static int ipc_send_mng_msg(struct ishtp_device *dev, uint32_t msg_code,
 		sizeof(uint32_t) + size);
 }
 
+#define WAIT_FOR_FW_RDY			0x1
+#define WAIT_FOR_INPUT_RDY		0x2
+
+/**
+ * timed_wait_for_timeout() - wait special event with timeout
+ * @dev: ISHTP device pointer
+ * @condition: indicate the condition for waiting
+ * @timeinc: time slice for every wait cycle, in ms
+ * @timeout: time in ms for timeout
+ *
+ * This function will check special event to be ready in a loop, the loop
+ * period is specificd in timeinc. Wait timeout will causes failure.
+ *
+ * Return: 0 for success else failure code
+ */
+static int timed_wait_for_timeout(struct ishtp_device *dev, int condition,
+				unsigned int timeinc, unsigned int timeout)
+{
+	bool complete = false;
+	int ret;
+
+	do {
+		if (condition == WAIT_FOR_FW_RDY) {
+			complete = ishtp_fw_is_ready(dev);
+		} else if (condition == WAIT_FOR_INPUT_RDY) {
+			complete = ish_is_input_ready(dev);
+		} else {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (!complete) {
+			unsigned long left_time;
+
+			left_time = msleep_interruptible(timeinc);
+			timeout -= (timeinc - left_time);
+		}
+	} while (!complete && timeout > 0);
+
+	if (complete)
+		ret = 0;
+	else
+		ret = -EBUSY;
+
+out:
+	return ret;
+}
+
+#define TIME_SLICE_FOR_FW_RDY_MS		100
+#define TIME_SLICE_FOR_INPUT_RDY_MS		100
+#define TIMEOUT_FOR_FW_RDY_MS			2000
+#define TIMEOUT_FOR_INPUT_RDY_MS		2000
+
 /**
  * ish_fw_reset_handler() - FW reset handler
  * @dev: ishtp device pointer
@@ -456,8 +508,8 @@ static int ish_fw_reset_handler(struct ishtp_device *dev)
 	ishtp_reset_handler(dev);
 
 	if (!ish_is_input_ready(dev))
-		timed_wait_for_timeout(WAIT_FOR_SEND_SLICE,
-			ish_is_input_ready(dev), (2 * HZ));
+		timed_wait_for_timeout(dev, WAIT_FOR_INPUT_RDY,
+			TIME_SLICE_FOR_INPUT_RDY_MS, TIMEOUT_FOR_INPUT_RDY_MS);
 
 	/* ISH FW is dead */
 	if (!ish_is_input_ready(dev))
@@ -472,8 +524,8 @@ static int ish_fw_reset_handler(struct ishtp_device *dev)
 			 sizeof(uint32_t));
 
 	/* Wait for ISH FW'es ILUP and ISHTP_READY */
-	timed_wait_for_timeout(WAIT_FOR_SEND_SLICE, ishtp_fw_is_ready(dev),
-		(2 * HZ));
+	timed_wait_for_timeout(dev, WAIT_FOR_FW_RDY,
+			TIME_SLICE_FOR_FW_RDY_MS, TIMEOUT_FOR_FW_RDY_MS);
 	if (!ishtp_fw_is_ready(dev)) {
 		/* ISH FW is dead */
 		uint32_t	ish_status;
diff --git a/drivers/hid/intel-ish-hid/ipc/utils.h b/drivers/hid/intel-ish-hid/ipc/utils.h
deleted file mode 100644
index dc39dfe..0000000
--- a/drivers/hid/intel-ish-hid/ipc/utils.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Utility macros of ISH
- *
- * Copyright (c) 2014-2016, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- */
-#ifndef UTILS__H
-#define UTILS__H
-
-#define	WAIT_FOR_SEND_SLICE	(HZ / 10)
-#define	WAIT_FOR_CONNECT_SLICE	(HZ / 10)
-
-/*
- * Waits for specified event when a thread that triggers event
- * can't signal with timeout (use whenever we may hang)
- */
-#define	timed_wait_for_timeout(timeinc, condition, timeout)	\
-	do {							\
-		int	t = timeout;				\
-		do {						\
-			unsigned long	j;			\
-			int	done = 0;			\
-								\
-			for (j = jiffies, done = 0; !done; ) {	\
-				schedule_timeout(timeinc);	\
-				if (time_is_before_eq_jiffies(j + timeinc)) \
-					done = 1;		\
-			} \
-			t -= timeinc;				\
-			if (t <= 0)				\
-				break;				\
-		} while (!(condition));				\
-	} while (0)
-
-#endif /* UTILS__H */
-- 
2.7.4

