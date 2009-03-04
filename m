From: akpm@linux-foundation.org
Subject: [patch 14/22] input: fix function arg list
Date: Wed, 04 Mar 2009 11:59:03 -0800
Message-ID: <200903041959.n24Jx3cF028447@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54169 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756234AbZCDT7o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2009 14:59:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, randy.dunlap@oracle.com, dmitry.torokhov@gmail.com, rydberg@euromail.se

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix function args build warning:

mmotm-2008-1230-1605/drivers/input/input.c:1661: warning: function declaration isn't a prototype

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/input/input.c~es-input-allow-certain-ev_abs-events-to-bypass-all-filtering-fix drivers/input/input.c
--- a/drivers/input/input.c~es-input-allow-certain-ev_abs-events-to-bypass-all-filtering-fix
+++ a/drivers/input/input.c
@@ -1649,7 +1649,7 @@ static const struct file_operations inpu
 	.open = input_open_file,
 };
 
-static void __init input_init_abs_bypass()
+static void __init input_init_abs_bypass(void)
 {
 	const unsigned int *p;
 	for (p = input_abs_bypass_init_data; *p; p++)
_
