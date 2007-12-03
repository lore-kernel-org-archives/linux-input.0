From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: [PATCH 2/4] apanel: change name of LED
Date: Mon, 03 Dec 2007 14:18:09 -0800
Message-ID: <20071203221900.645119544@linux-foundation.org>
References: <20071203221807.077325020@linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48325 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752580AbXLCWVJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Dec 2007 17:21:09 -0500
Content-Disposition: inline; filename=fujitsu-apanel-led-name.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

Make name of LED match the current usage precedent in wistron buttons.
Note: If the LED developers want a different convention, they can just change
both drivers.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

--- a/drivers/input/misc/apanel.c	2007-11-20 06:10:18.000000000 -0800
+++ b/drivers/input/misc/apanel.c	2007-11-20 06:11:34.000000000 -0800
@@ -219,7 +219,7 @@ static struct apanel apanel = {
 
 	},
 	.mail_led = {
-		.name = APANEL ":mail",
+		.name = "mail:blue",
 		.brightness_set = mail_led_set,
 	},
 };

-- 

