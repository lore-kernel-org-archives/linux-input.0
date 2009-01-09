From: akpm@linux-foundation.org
Subject: [patch 14/17] input: fix function arg list
Date: Fri, 09 Jan 2009 12:19:52 -0800
Message-ID: <200901092019.n09KJq1t017301@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55709 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753137AbZAIUgi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jan 2009 15:36:38 -0500
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
@@ -1644,7 +1644,7 @@ static const struct file_operations inpu
 	.open = input_open_file,
 };
 
-static void __init input_init_abs_bypass()
+static void __init input_init_abs_bypass(void)
 {
 	const unsigned int *p;
 	for (p = input_abs_bypass_init_data; *p; p++)
_
