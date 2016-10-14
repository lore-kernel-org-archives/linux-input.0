From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] Input: fsl-imx25-tcq - fix module autoload when registered via OF
Date: Fri, 14 Oct 2016 13:00:18 -0300
Message-ID: <1476460819-12809-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:57384
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932281AbcJNQAe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Oct 2016 12:00:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Juergen Borleis <jbe@pengutronix.de>, linux-input@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Denis Carikli <denis@eukrea.com>

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/input/touchscreen/fsl-imx25-tcq.ko | grep alias

After this patch:

$ modinfo drivers/input/touchscreen/fsl-imx25-tcq.ko | grep alias
alias:          of:N*T*Cfsl,imx25-tcqC*
alias:          of:N*T*Cfsl,imx25-tcq

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/fsl-imx25-tcq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
index fe9877a6af9e..d50ee490c9cc 100644
--- a/drivers/input/touchscreen/fsl-imx25-tcq.c
+++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
@@ -55,6 +55,7 @@ static const struct of_device_id mx25_tcq_ids[] = {
 	{ .compatible = "fsl,imx25-tcq", },
 	{ /* Sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, mx25_tcq_ids);
 
 #define TSC_4WIRE_PRE_INDEX 0
 #define TSC_4WIRE_X_INDEX 1
-- 
2.7.4

