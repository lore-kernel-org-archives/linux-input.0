From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 11/11] Input: synaptics-rmi4 - smbus: on resume, try 3 times if init fails
Date: Thu, 18 Aug 2016 11:24:49 +0200
Message-ID: <1471512289-10648-12-git-send-email-benjamin.tissoires@redhat.com>
References: <1471512289-10648-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38182 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbcHRJcx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2016 05:32:53 -0400
In-Reply-To: <1471512289-10648-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

In some rare cases, we can't retrieve the SMBus version and so we fail
binding the touchpad back. Instead of leaving a touchpad dead, try again
to reinitialize it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_smbus.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 023dbd5..a8e4af6 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -265,10 +265,29 @@ static int rmi_smb_reset(struct rmi_transport_dev *xport, u16 reset_addr)
 {
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
+	struct i2c_client *client = rmi_smb->client;
+	struct rmi_device_platform_data *pdata;
+	int tries, ret;
 
 	rmi_smb_clear_state(rmi_smb);
 
-	return rmi_smb_enable_smbus_mode(rmi_smb);
+	for (tries = 3; tries > 0; tries--) {
+		ret = rmi_smb_enable_smbus_mode(rmi_smb);
+		if (!ret)
+			break;
+
+		/* we failed enabling SMBus, try again later */
+		msleep(500);
+	}
+
+	if (ret < 0) {
+		dev_warn(&client->dev,
+			 "failed to enable SMBus mode, giving up.\n");
+		pdata = dev_get_platdata(&rmi_smb->client->dev);
+		rmi_transport_enable(pdata, false);
+	}
+
+	return ret;
 }
 
 static const struct rmi_transport_ops rmi_smb_ops = {
-- 
2.5.5

