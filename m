From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: [PATCH 3/4] apanel: detach on shutdown
Date: Mon, 03 Dec 2007 14:18:10 -0800
Message-ID: <20071203221900.829441891@linux-foundation.org>
References: <20071203221807.077325020@linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45672 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752574AbXLCWVI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Dec 2007 17:21:08 -0500
Content-Disposition: inline; filename=fujitsu-apanel-shutdown.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

Need to stop any device polling on shutdown. Without this, the
laptop can sometimes not turn off.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

--- a/drivers/input/misc/apanel.c	2007-11-20 06:11:34.000000000 -0800
+++ b/drivers/input/misc/apanel.c	2007-11-20 06:14:18.000000000 -0800
@@ -193,12 +193,18 @@ static int apanel_attach_adapter(struct 
 	return i2c_probe(adap, &addr_data, apanel_probe);
 }
 
+static void apanel_shutdown(struct i2c_client *client)
+{
+	apanel_detach_client(client);
+}
+
 static struct i2c_driver apanel_driver = {
 	.driver = {
 		.name = APANEL,
 	},
 	.attach_adapter = &apanel_attach_adapter,
 	.detach_client  = &apanel_detach_client,
+	.shutdown	= &apanel_shutdown,
 };
 
 static struct apanel apanel = {

-- 

