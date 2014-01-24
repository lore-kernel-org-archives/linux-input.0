From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: [PATCH 12/15] Input: synaptics-rmi4 - don't immediately set page on probe
Date: Thu, 23 Jan 2014 16:00:20 -0800
Message-ID: <1390521623-6491-13-git-send-email-courtney.cavin@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:19839 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752734AbaAXAAB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 19:00:01 -0500
In-Reply-To: <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cheiny@synaptics.com

Since at the point of I2C probe, we cannot know if the voltage
regulators are on, wait until the physical driver requests a read before
setting the page.

Cc: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
---
 drivers/input/rmi4/rmi_i2c.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 377d4cc..50ed5fd 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -209,15 +209,8 @@ static int rmi_i2c_probe(struct i2c_client *client,
 	rmi_i2c->xport.proto_name = "i2c";
 	rmi_i2c->xport.ops = &rmi_i2c_ops;
 
-	/*
-	 * Setting the page to zero will (a) make sure the PSR is in a
-	 * known state, and (b) make sure we can talk to the device.
-	 */
-	retval = rmi_set_page(rmi_i2c, 0);
-	if (retval) {
-		dev_err(&client->dev, "Failed to set page select to 0.\n");
-		return retval;
-	}
+	/* make sure we set the page on the first write */
+	rmi_i2c->page = -1;
 
 	retval = rmi_register_transport_device(&rmi_i2c->xport);
 	if (retval) {
-- 
1.8.1.5

