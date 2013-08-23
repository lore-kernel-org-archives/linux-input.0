From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] HID: use module_hid_driver() to simplify the code
Date: Fri, 23 Aug 2013 11:06:19 +0800
Message-ID: <CAPgLHd9pb+49BC7BOOSrgkOWMQJQ76GcEGStt-UeaqGqtYfpFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:47807 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab3HWDGU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Aug 2013 23:06:20 -0400
Received: by mail-bk0-f43.google.com with SMTP id mz13so33707bkb.16
        for <linux-input@vger.kernel.org>; Thu, 22 Aug 2013 20:06:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_hid_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/hid/hid-xinmo.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hid/hid-xinmo.c b/drivers/hid/hid-xinmo.c
index 6153e50..7df5227 100644
--- a/drivers/hid/hid-xinmo.c
+++ b/drivers/hid/hid-xinmo.c
@@ -57,16 +57,5 @@ static struct hid_driver xinmo_driver = {
 	.event = xinmo_event
 };
 
-static int __init xinmo_init(void)
-{
-	return hid_register_driver(&xinmo_driver);
-}
-
-static void __exit xinmo_exit(void)
-{
-	hid_unregister_driver(&xinmo_driver);
-}
-
-module_init(xinmo_init);
-module_exit(xinmo_exit);
+module_hid_driver(xinmo_driver);
 MODULE_LICENSE("GPL");

