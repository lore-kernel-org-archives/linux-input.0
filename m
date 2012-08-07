From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] Input: omap4-keypad - don't leak in omap4_keypad_probe()
Date: Tue, 7 Aug 2012 20:16:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208072014140.3227@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1010ds2-suoe.0.fullrate.dk ([90.184.90.115]:10847 "EHLO
	swampdragon.chaosbits.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2HGSQ5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Aug 2012 14:16:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>, JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>

If omap4_keypad_parse_dt() does not return 0 (zero) in
omap4_keypad_probe() we will leak the memory we allocated for
'keypad_data' with kzalloc() when we return and the variable goes out
of scope.
Fix the leak by jumping to the 'err_free_keypad' label where we
properly free the allocated memory, instead of returning directly.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/input/keyboard/omap4-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Compile tested only.

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index c05f98c..9c2ac87 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -281,7 +281,7 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 	} else {
 		error = omap4_keypad_parse_dt(&pdev->dev, keypad_data);
 		if (error)
-			return error;
+			goto err_free_keypad;
 	}
 
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
-- 
1.7.11.4


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

