From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH v3 1/2] Input: synaptics-rmi4 - RMI4 can also use SMBUS version 3
Date: Sun,  5 Nov 2017 19:09:50 +0200
Message-ID: <20171105170951.20261-2-yiannis.marangos@gmail.com>
References: <20171105170951.20261-1-yiannis.marangos@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54378 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdKERKV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 5 Nov 2017 12:10:21 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so9938131wmr.3
        for <linux-input@vger.kernel.org>; Sun, 05 Nov 2017 09:10:20 -0800 (PST)
In-Reply-To: <20171105170951.20261-1-yiannis.marangos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>

Some synaptics devices such as LEN0073 use SMBUS version 3.

Signed-off-by: Yiannis Marangos <yiannis.marangos@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 225025a0940c..b6ccf39c6a7b 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -312,7 +312,7 @@ static int rmi_smb_probe(struct i2c_client *client,
 	rmi_smb->xport.dev = &client->dev;
 	rmi_smb->xport.pdata = *pdata;
 	rmi_smb->xport.pdata.irq = client->irq;
-	rmi_smb->xport.proto_name = "smb2";
+	rmi_smb->xport.proto_name = "smb";
 	rmi_smb->xport.ops = &rmi_smb_ops;
 
 	smbus_version = rmi_smb_get_version(rmi_smb);
@@ -322,7 +322,7 @@ static int rmi_smb_probe(struct i2c_client *client,
 	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
 		smbus_version);
 
-	if (smbus_version != 2) {
+	if (smbus_version != 2 && smbus_version != 3) {
 		dev_err(&client->dev, "Unrecognized SMB version %d\n",
 				smbus_version);
 		return -ENODEV;
-- 
2.14.3

