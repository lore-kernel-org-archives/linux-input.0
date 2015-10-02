From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 05/18] Input: retu-pwrbutton - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:16 +0200
Message-ID: <1443793229-22363-6-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46961 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785AbbJBNk4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Oct 2015 09:40:56 -0400
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Fabio Estevam <fabio.estevam@freescale.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The invoked function already returns zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warning:

drivers/input/misc/retu-pwrbutton.c:72:1-6: WARNING: end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/misc/retu-pwrbutton.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/misc/retu-pwrbutton.c b/drivers/input/misc/retu-pwrbutton.c
index 30b459b6b344..55ce68a6dcbf 100644
--- a/drivers/input/misc/retu-pwrbutton.c
+++ b/drivers/input/misc/retu-pwrbutton.c
@@ -69,11 +69,7 @@ static int retu_pwrbutton_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = input_register_device(idev);
-	if (error)
-		return error;
-
-	return 0;
+	return input_register_device(idev);
 }
 
 static int retu_pwrbutton_remove(struct platform_device *pdev)
-- 
2.4.3

