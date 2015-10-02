From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 08/18] Input: goldfish - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:19 +0200
Message-ID: <1443793229-22363-9-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46980 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481AbbJBNlD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Oct 2015 09:41:03 -0400
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org

The invoked function already returns zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warning:

drivers/input/keyboard/goldfish_events.c:174:1-6: WARNING: end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/keyboard/goldfish_events.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
index 907e4e278fce..6dfdb574bd01 100644
--- a/drivers/input/keyboard/goldfish_events.c
+++ b/drivers/input/keyboard/goldfish_events.c
@@ -171,11 +171,7 @@ static int events_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	error = input_register_device(input_dev);
-	if (error)
-		return error;
-
-	return 0;
+	return input_register_device(input_dev);
 }
 
 static struct platform_driver events_driver = {
-- 
2.4.3

