From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] staging: ste_rmi4: use module_i2c_driver to simplify the code
Date: Mon, 8 Oct 2012 22:15:44 +0800
Message-ID: <CAPgLHd_XxaAb-y=qnb0Wf97Uno-U-MUOW1S6J7__S-UzLSgD0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:33895 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab2JHOPp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Oct 2012 10:15:45 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so1943643qaa.19
        for <linux-input@vger.kernel.org>; Mon, 08 Oct 2012 07:15:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org, rydberg@euromail.se
Cc: yongjun_wei@trendmicro.com.cn, devel@driverdev.osuosl.org, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use the module_i2c_driver() macro to make the code smaller
and a bit simpler.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
index 277491a..37d19c6 100644
--- a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
+++ b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
@@ -1143,30 +1143,8 @@ static struct i2c_driver synaptics_rmi4_driver = {
 	.remove		=	__devexit_p(synaptics_rmi4_remove),
 	.id_table	=	synaptics_rmi4_id_table,
 };
-/**
- * synaptics_rmi4_init() - Initialize the touchscreen driver
- *
- * This function uses to initializes the synaptics
- * touchscreen driver and returns integer.
- */
-static int __init synaptics_rmi4_init(void)
-{
-	return i2c_add_driver(&synaptics_rmi4_driver);
-}
-/**
- * synaptics_rmi4_exit() - De-initialize the touchscreen driver
- *
- * This function uses to de-initialize the synaptics
- * touchscreen driver and returns none.
- */
-static void __exit synaptics_rmi4_exit(void)
-{
-	i2c_del_driver(&synaptics_rmi4_driver);
-}
-
 
-module_init(synaptics_rmi4_init);
-module_exit(synaptics_rmi4_exit);
+module_i2c_driver(synaptics_rmi4_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("naveen.gaddipati@stericsson.com, js.ha@stericsson.com");

