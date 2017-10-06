From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH v2 1/2] Input: synaptics-rmi4 - RMI4 can also use SMBUS version 3
Date: Fri,  6 Oct 2017 17:06:29 +0300
Message-ID: <20171006140630.6398-2-yiannis.marangos@gmail.com>
References: <20171006140630.6398-1-yiannis.marangos@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33413 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdJFOGi (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Oct 2017 10:06:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id z96so10067147wrb.0
        for <linux-input@vger.kernel.org>; Fri, 06 Oct 2017 07:06:37 -0700 (PDT)
In-Reply-To: <20171006140630.6398-1-yiannis.marangos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>

Some synaptics devices such as LEN0073 use SMBUS version 3.
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
2.14.2

