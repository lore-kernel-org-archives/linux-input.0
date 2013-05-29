From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] HID: holtek-mouse: use module_hid_driver() to simplify
 the code
Date: Wed, 29 May 2013 18:09:22 +0800
Message-ID: <CAPgLHd-B1fsT0fAbJZq2KZEZW4wOogC=_cBKiS67Mp4PXtkDbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:52310 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965230Ab3E2KJY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 May 2013 06:09:24 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so3177682bkc.16
        for <linux-input@vger.kernel.org>; Wed, 29 May 2013 03:09:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, chr.ohm@gmx.net
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_hid_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/hid/hid-holtek-mouse.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hid/hid-holtek-mouse.c b/drivers/hid/hid-holtek-mouse.c
index 6a23ee6..7e6db3c 100644
--- a/drivers/hid/hid-holtek-mouse.c
+++ b/drivers/hid/hid-holtek-mouse.c
@@ -73,16 +73,5 @@ static struct hid_driver holtek_mouse_driver = {
 	.report_fixup = holtek_mouse_report_fixup,
 };
 
-static int __init holtek_mouse_init(void)
-{
-	return hid_register_driver(&holtek_mouse_driver);
-}
-
-static void __exit holtek_mouse_exit(void)
-{
-	hid_unregister_driver(&holtek_mouse_driver);
-}
-
-module_exit(holtek_mouse_exit);
-module_init(holtek_mouse_init);
+module_hid_driver(holtek_mouse_driver);
 MODULE_LICENSE("GPL");

