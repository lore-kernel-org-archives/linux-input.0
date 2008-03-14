From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH] Input: fix cobalt_btns build error
Date: Fri, 14 Mar 2008 23:22:52 +0900
Message-ID: <20080314232252.b2c112d2.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo30.po.2iij.NET ([210.128.50.53]:15327 "EHLO mo30.po.2iij.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbYCNOX0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Mar 2008 10:23:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: yoichi_yuasa@tripeaks.co.jp, linux-input@vger.kernel.org


Fix cobalt_btns build error.

drivers/input/misc/cobalt_btns.c: In function 'cobalt_buttons_probe':
drivers/input/misc/cobalt_btns.c:109: warning: dereferencing 'void *' pointer
drivers/input/misc/cobalt_btns.c:109: error: invalid use of void expression
make[3]: *** [drivers/input/misc/cobalt_btns.o] Error 1
make[2]: *** [drivers/input/misc] Error 2
make[1]: *** [drivers/input] Error 2
make: *** [drivers] Error 2

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/input/misc/cobalt_btns.c linux/drivers/input/misc/cobalt_btns.c
--- linux-orig/drivers/input/misc/cobalt_btns.c	2008-03-14 22:44:02.563995073 +0900
+++ linux/drivers/input/misc/cobalt_btns.c	2008-03-14 23:10:12.844238925 +0900
@@ -106,7 +106,7 @@ static int __devinit cobalt_buttons_prob
 	input_set_capability(input, EV_MSC, MSC_SCAN);
 	__set_bit(EV_KEY, input->evbit);
 	for (i = 0; i < input->keycodemax; i++)
-		__set_bit(input->keycode[i], input->keybit);
+		__set_bit(((unsigned short *)input->keycode)[i], input->keybit);
 	__clear_bit(KEY_RESERVED, input->keybit);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
