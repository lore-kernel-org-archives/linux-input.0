From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] HID: steelseries: use module_hid_driver() to simplify
 the code
Date: Fri, 15 Mar 2013 23:07:02 +0800
Message-ID: <CAPgLHd_6y1mr1moejftWGgrpO=vGxQUZ5Dz2v022kaFHdF-pVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:57550 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab3COPHE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Mar 2013 11:07:04 -0400
Received: by mail-bk0-f47.google.com with SMTP id jc3so1533974bkc.20
        for <linux-input@vger.kernel.org>; Fri, 15 Mar 2013 08:07:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_hid_driver() makes the code simpler by eliminating
boilerplate code..

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/hid/hid-steelseries.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 98e66ac..9b0efb0 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -377,16 +377,5 @@ static struct hid_driver steelseries_srws1_driver = {
 	.report_fixup = steelseries_srws1_report_fixup
 };
 
-static int __init steelseries_srws1_init(void)
-{
-	return hid_register_driver(&steelseries_srws1_driver);
-}
-
-static void __exit steelseries_srws1_exit(void)
-{
-	hid_unregister_driver(&steelseries_srws1_driver);
-}
-
-module_init(steelseries_srws1_init);
-module_exit(steelseries_srws1_exit);
+module_hid_driver(steelseries_srws1_driver);
 MODULE_LICENSE("GPL");

