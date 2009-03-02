From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: [PATCH 1/2] ktime: add ktime_compare
Date: Mon,  2 Mar 2009 23:42:51 +0100
Message-ID: <1236033772-20329-1-git-send-email-marcin.slusarz@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:50109 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbZCBWnC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 17:43:02 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-input@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>

add ktime_compare as an analogy to timeval_compare/timespec_compare

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
---
 include/linux/ktime.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index ce59832..4590f95 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -130,6 +130,20 @@ static inline ktime_t timeval_to_ktime(struct timeval tv)
 /* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
 #define ktime_to_ns(kt)			((kt).tv64)
 
+/*
+ * lhs < rhs:  return <0
+ * lhs == rhs: return 0
+ * lhs > rhs:  return >0
+ */
+static inline int ktime_compare(ktime_t lhs, ktime_t rhs)
+{
+	if (lhs.tv64 < rhs.tv64)
+		return -1;
+	if (lhs.tv64 > rhs.tv64)
+		return 1;
+	return 0;
+}
+
 #else
 
 /*
@@ -275,6 +289,20 @@ static inline s64 ktime_to_ns(const ktime_t kt)
 	return (s64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec;
 }
 
+/*
+ * lhs < rhs:  return <0
+ * lhs == rhs: return 0
+ * lhs > rhs:  return >0
+ */
+static inline int ktime_compare(ktime_t lhs, ktime_t rhs)
+{
+	if (lhs.sec < rhs.sec)
+		return -1;
+	if (lhs.sec > rhs.sec)
+		return 1;
+	return lhs.nsec - rhs.nsec;
+}
+
 #endif
 
 /**
-- 
1.6.0.6

