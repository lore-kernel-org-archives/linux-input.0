From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH 1/2] Input: synaptics-rmi4 - RMI4 can also use SMBUS version 3
Date: Thu,  5 Oct 2017 20:43:14 +0300
Message-ID: <20171005174315.2863-2-yiannis.marangos@gmail.com>
References: <20171005174315.2863-1-yiannis.marangos@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52172 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdJERoR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 13:44:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so3684630wme.0
        for <linux-input@vger.kernel.org>; Thu, 05 Oct 2017 10:44:16 -0700 (PDT)
In-Reply-To: <20171005174315.2863-1-yiannis.marangos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>

Some synaptics devices such as LEN0073 they use SMBUS version 3.
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
2.14.1

