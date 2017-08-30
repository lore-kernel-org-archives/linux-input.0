From: edvard.holst@gmail.com
Subject: [PATCH] Input: synaptics - Lenovo Thinkpad X1 Carbon G5 (2017) with Elantech trackpoints should use RMI.
Date: Wed, 30 Aug 2017 07:54:23 +0000 (UTC)
Message-ID: <20170830075351.24981-1-edvard.holst@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:44805 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750839AbdH3H7o (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Aug 2017 03:59:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Edvard Holst <edvard.holst@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Eric Biggers <ebiggers@google.com>, Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org

From: Edvard Holst <edvard.holst@gmail.com>

Lenovo use two different trackpoints in the fifth generation Thinkpad X1 Carbon. Both are accessible over SMBUS/RMI but the pnpIDs are missing. This patch is for the Elantech trackpoint specifically which also reports SMB version 3 so rmi_smbus needs to be updated in order to handle it.

For the record, I was not the first one to come up with this patch as it has been floating around the internet for a while now. However, I have spent significant time with testing and my efforts to find the original author of the patch have been unsuccessful.
Signed-off-by: Edvard Holst <edvard.holst@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 drivers/input/rmi4/rmi_smbus.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 16c30460ef04..d44f1395c379 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -173,6 +173,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
 	"LEN200f", /* T450s */
+    "LEN0073", /* X1 Carbon G5 (Elantech) */
 	NULL
 };
 
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 225025a0940c..2939a2f72019 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -322,7 +322,7 @@ static int rmi_smb_probe(struct i2c_client *client,
 	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
 		smbus_version);
 
-	if (smbus_version != 2) {
+	if (smbus_version != 2 && smbus_version != 3) {
 		dev_err(&client->dev, "Unrecognized SMB version %d\n",
 				smbus_version);
 		return -ENODEV;
-- 
2.13.5

