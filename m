From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/2 v2] lib: int_sqrt: add int64_sqrt routine
Date: Thu,  3 Jul 2014 20:34:30 +0800
Message-ID: <1404390870-24062-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:57720 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaGCMeq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jul 2014 08:34:46 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so155653pde.17
        for <linux-input@vger.kernel.org>; Thu, 03 Jul 2014 05:34:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, workgroup.linux@csr.com, Yibo Cai <yibo.cai@csr.com>, Peter Meerwald <pmeerw@pmeerw.net>, Barry Song <Baohua.Song@csr.com>

From: Yibo Cai <yibo.cai@csr.com>

Get square root of a 64-bit digit on 32bit platforms. CSR SiRFSoC
touchscreen driver needs it.

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Signed-off-by: Yibo Cai <yibo.cai@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2:
 use CONFIG_64BIT MARCO
 don't init for b, m

 include/linux/kernel.h |  8 ++++++++
 lib/int_sqrt.c         | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 4c52907..a536c0c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -418,6 +418,14 @@ struct pid;
 extern struct pid *session_of_pgrp(struct pid *pgrp);
 
 unsigned long int_sqrt(unsigned long);
+#ifdef CONFIG_64BIT
+static inline unsigned long long int64_sqrt(unsigned long long x)
+{
+	return int_sqrt(x);
+}
+#else
+unsigned long long int64_sqrt(unsigned long long);
+#endif
 
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 1ef4cc3..b86cccb 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -36,3 +36,28 @@ unsigned long int_sqrt(unsigned long x)
 	return y;
 }
 EXPORT_SYMBOL(int_sqrt);
+
+#ifndef CONFIG_64BIT
+unsigned long long int64_sqrt(unsigned long long x)
+{
+	unsigned long long b, m, y = 0;
+
+	if (x <= 1)
+		return x;
+
+	m = 1ULL << (BITS_PER_LONG_LONG - 2);
+	while (m != 0) {
+		b = y + m;
+		y >>= 1;
+
+		if (x >= b) {
+			x -= b;
+			y += m;
+		}
+		m >>= 2;
+	}
+
+	return y;
+}
+EXPORT_SYMBOL(int64_sqrt);
+#endif
-- 
1.9.3

