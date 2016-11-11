From: Even Xu <even.xu@intel.com>
Subject: [PATCH 1/3] hid: intel-ish-hid: ipc: remove unused macro
Date: Fri, 11 Nov 2016 09:40:13 +0800
Message-ID: <1478828413-31687-1-git-send-email-even.xu@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:25512 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935107AbcKKBjy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 20:39:54 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, srinivas.pandruvada@intel.com, Even Xu <even.xu@intel.com>

The macro timed_wait_for() in utils.h isn't used in current ipc
driver, so remove it for avoiding confusion.

Signed-off-by: Even Xu <even.xu@intel.com>
---
 drivers/hid/intel-ish-hid/ipc/utils.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/utils.h b/drivers/hid/intel-ish-hid/ipc/utils.h
index 5a82123..dc39dfe 100644
--- a/drivers/hid/intel-ish-hid/ipc/utils.h
+++ b/drivers/hid/intel-ish-hid/ipc/utils.h
@@ -19,27 +19,6 @@
 #define	WAIT_FOR_CONNECT_SLICE	(HZ / 10)
 
 /*
- * Waits for specified event when a thread that triggers event can't signal
- * Also, waits *at_least* `timeinc` after condition is satisfied
- */
-#define	timed_wait_for(timeinc, condition)			\
-	do {							\
-		int completed = 0;				\
-		do {						\
-			unsigned long	j;			\
-			int	done = 0;			\
-								\
-			completed = (condition);		\
-			for (j = jiffies, done = 0; !done; ) {	\
-				schedule_timeout(timeinc);	\
-				if (time_is_before_eq_jiffies(j + timeinc)) \
-					done = 1;		\
-			}					\
-		} while (!(completed));				\
-	} while (0)
-
-
-/*
  * Waits for specified event when a thread that triggers event
  * can't signal with timeout (use whenever we may hang)
  */
-- 
2.7.4

