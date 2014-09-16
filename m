From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 15/22] Input: edt-ft5x06 - Replace strnicmp with strncasecmp
Date: Tue, 16 Sep 2014 22:51:29 +0200
Message-ID: <1410900696-6481-16-git-send-email-linux@rasmusvillemoes.dk>
References: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:50734 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbaIPUwQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Sep 2014 16:52:16 -0400
Received: by mail-lb0-f173.google.com with SMTP id w7so591946lbi.32
        for <linux-input@vger.kernel.org>; Tue, 16 Sep 2014 13:52:14 -0700 (PDT)
In-Reply-To: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The kernel used to contain two functions for length-delimited,
case-insensitive string comparison, strnicmp with correct semantics
and a slightly buggy strncasecmp. The latter is the POSIX name, so
strnicmp was renamed to strncasecmp, and strnicmp made into a wrapper
for the new strncasecmp to avoid breaking existing users.

To allow the compat wrapper strnicmp to be removed at some point in
the future, and to avoid the extra indirection cost, do
s/strnicmp/strncasecmp/g.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/input/touchscreen/edt-ft5x06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 8857d5b..ee3434f 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -812,7 +812,7 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	/* if we find something consistent, stay with that assumption
 	 * at least M09 won't send 3 bytes here
 	 */
-	if (!(strnicmp(rdbuf + 1, "EP0", 3))) {
+	if (!(strncasecmp(rdbuf + 1, "EP0", 3))) {
 		tsdata->version = M06;
 
 		/* remove last '$' end marker */
-- 
2.0.4

