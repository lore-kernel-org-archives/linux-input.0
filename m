From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 147/493] Input: remove use of __devexit_p in Retu driver
Date: Mon, 19 Nov 2012 13:21:36 -0500
Message-ID: <1353349642-3677-147-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41654 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab2KSSiA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Nov 2012 13:38:00 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> 
Cc: linux-input@vger.kernel.org 
---
 drivers/input/misc/retu-pwrbutton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/retu-pwrbutton.c b/drivers/input/misc/retu-pwrbutton.c
index 3767f43..4500027 100644
--- a/drivers/input/misc/retu-pwrbutton.c
+++ b/drivers/input/misc/retu-pwrbutton.c
@@ -83,7 +83,7 @@ static int __devexit retu_pwrbutton_remove(struct platform_device *pdev)
 
 static struct platform_driver retu_pwrbutton_driver = {
 	.probe		= retu_pwrbutton_probe,
-	.remove		= __devexit_p(retu_pwrbutton_remove),
+	.remove		= retu_pwrbutton_remove,
 	.driver		= {
 		.name	= "retu-pwrbutton",
 		.owner	= THIS_MODULE,
-- 
1.8.0

