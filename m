From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] lib/kstrtox.c break if overflow is detected
Date: Wed, 21 Jan 2015 11:19:25 -0800
Message-ID: <1421867965-75187-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51546 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbbAUTUC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jan 2015 14:20:02 -0500
Received: by mail-we0-f174.google.com with SMTP id x3so11423915wes.5
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2015 11:20:01 -0800 (PST)
In-Reply-To: <aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org, levex@linux.com, felipe.contreras@gmail.com, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com

From: Anshul Garg <aksgarg1989@gmail.com>

1. While converting string representation to integer
break the loop if overflow is detected.
2. Clean kstrtoll function

Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
---
 lib/kstrtox.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index ec8da78..8cbe5ca 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -70,8 +70,10 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
 		 * it in the max base we support (16)
 		 */
 		if (unlikely(res & (~0ull << 60))) {
-			if (res > div_u64(ULLONG_MAX - val, base))
+			if (res > div_u64(ULLONG_MAX - val, base)) {
 				overflow = 1;
+				break;
+			}
 		}
 		res = res * base + val;
 		rv++;
@@ -146,23 +148,19 @@ EXPORT_SYMBOL(kstrtoull);
 int kstrtoll(const char *s, unsigned int base, long long *res)
 {
 	unsigned long long tmp;
-	int rv;
+	int rv, sign = 1;
 
 	if (s[0] == '-') {
-		rv = _kstrtoull(s + 1, base, &tmp);
-		if (rv < 0)
-			return rv;
-		if ((long long)(-tmp) >= 0)
-			return -ERANGE;
-		*res = -tmp;
-	} else {
-		rv = kstrtoull(s, base, &tmp);
-		if (rv < 0)
-			return rv;
-		if ((long long)tmp < 0)
-			return -ERANGE;
-		*res = tmp;
+		sign = -1;
+		s++;
 	}
+
+	rv = kstrtoull(s, base, &tmp);
+	if (rv < 0)
+		return rv;
+	if ((long long)tmp < 0)
+		return -ERANGE;
+	*res = sign * tmp;
 	return 0;
 }
 EXPORT_SYMBOL(kstrtoll);
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

