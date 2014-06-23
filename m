From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/2] lib: int_sqrt: add int64_sqrt routine
Date: Mon, 23 Jun 2014 17:43:00 +0800
Message-ID: <1403516581-12560-2-git-send-email-21cnbao@gmail.com>
References: <1403516581-12560-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:48816 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbaFWJoX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jun 2014 05:44:23 -0400
Received: by mail-pb0-f42.google.com with SMTP id ma3so5652530pbc.15
        for <linux-input@vger.kernel.org>; Mon, 23 Jun 2014 02:44:22 -0700 (PDT)
In-Reply-To: <1403516581-12560-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, workgroup.linux@csr.com, Yibo Cai <yibo.cai@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Yibo Cai <yibo.cai@csr.com>

Get square root of a 64-bit digit on 32bit platforms. CSR SiRFSoC
touchscreen driver needs it.

Signed-off-by: Yibo Cai <yibo.cai@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 include/linux/kernel.h |  1 +
 lib/int_sqrt.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 4c52907..6e63081 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -418,6 +418,7 @@ struct pid;
 extern struct pid *session_of_pgrp(struct pid *pgrp);
 
 unsigned long int_sqrt(unsigned long);
+unsigned long long int64_sqrt(unsigned long long);
 
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 1ef4cc3..2aa9fcc 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -36,3 +36,30 @@ unsigned long int_sqrt(unsigned long x)
 	return y;
 }
 EXPORT_SYMBOL(int_sqrt);
+
+/*
+ * Square root of a 64-bit digit.
+ * Same as int_sqrt on 64-bit platforms where "long" equals "long long"
+ */
+unsigned long long int64_sqrt(unsigned long long x)
+{
+	unsigned long long m = 0, y = 0, b = 0;
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
-- 
1.9.3

