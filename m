From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/2] Input: da9063 - fix module autoload when registered via OF
Date: Fri, 14 Oct 2016 13:00:19 -0300
Message-ID: <1476460819-12809-2-git-send-email-javier@osg.samsung.com>
References: <1476460819-12809-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:57390
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932353AbcJNQAh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Oct 2016 12:00:37 -0400
In-Reply-To: <1476460819-12809-1-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Support Opensource <support.opensource@diasemi.com>, linux-input@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/input/misc/da9063_onkey.ko | grep alias
alias:          platform:da9063-onkey

After this patch:

$ modinfo drivers/input/misc/da9063_onkey.ko | grep alias
alias:          platform:da9063-onkey
alias:          of:N*T*Cdlg,da9062-onkeyC*
alias:          of:N*T*Cdlg,da9062-onkey
alias:          of:N*T*Cdlg,da9063-onkeyC*
alias:          of:N*T*Cdlg,da9063-onkey

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/misc/da9063_onkey.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index bb863e062b03..f0d0543562df 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -87,6 +87,7 @@ static const struct of_device_id da9063_compatible_reg_id_table[] = {
 	{ .compatible = "dlg,da9062-onkey", .data = &da9062_regs },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, da9063_compatible_reg_id_table);
 
 static void da9063_poll_on(struct work_struct *work)
 {
-- 
2.7.4

