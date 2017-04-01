From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: psmouse - fix cleaning up SMBus companions
Date: Sat, 1 Apr 2017 11:42:54 -0700
Message-ID: <20170401184254.GA13949@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35910 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbdDASm5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 14:42:57 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org

When trying to destroy platform data after destruction of SMbus companion,
we need to make sure that we are actually dealing with an SMB companion
device, and not some random I2C client device.

Fixes: 8eb92e5c9133 ("Input: psmouse - add support for SMBus companions")
Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-smbus.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index d0cf2fde173e..c7ac24d119c1 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -61,24 +61,29 @@ static void psmouse_smbus_check_adapter(struct i2c_adapter *adapter)
 
 static void psmouse_smbus_detach_i2c_client(struct i2c_client *client)
 {
-	struct psmouse_smbus_dev *smbdev;
+	struct psmouse_smbus_dev *smbdev, *tmp;
 
 	mutex_lock(&psmouse_smbus_mutex);
 
-	list_for_each_entry(smbdev, &psmouse_smbus_list, node) {
-		if (smbdev->client == client) {
+	list_for_each_entry_safe(smbdev, tmp, &psmouse_smbus_list, node) {
+		if (smbdev->client != client)
+			continue;
+
+		kfree(client->dev.platform_data);
+		client->dev.platform_data = NULL;
+
+		if (!smbdev->dead) {
 			psmouse_dbg(smbdev->psmouse,
 				    "Marking SMBus companion %s as gone\n",
 				    dev_name(&smbdev->client->dev));
-			smbdev->client = NULL;
 			smbdev->dead = true;
 			serio_rescan(smbdev->psmouse->ps2dev.serio);
+		} else {
+			list_del(&smbdev->node);
+			kfree(smbdev);
 		}
 	}
 
-	kfree(client->dev.platform_data);
-	client->dev.platform_data = NULL;
-
 	mutex_unlock(&psmouse_smbus_mutex);
 }
 
@@ -162,17 +167,20 @@ static void psmouse_smbus_disconnect(struct psmouse *psmouse)
 	struct psmouse_smbus_dev *smbdev = psmouse->private;
 
 	mutex_lock(&psmouse_smbus_mutex);
-	list_del(&smbdev->node);
-	mutex_unlock(&psmouse_smbus_mutex);
 
-	if (smbdev->client) {
+	if (smbdev->dead) {
+		list_del(&smbdev->node);
+		kfree(smbdev);
+	} else {
+		smbdev->dead = true;
 		psmouse_dbg(smbdev->psmouse,
 			    "posting removal request for SMBus companion %s\n",
 			    dev_name(&smbdev->client->dev));
 		psmouse_smbus_schedule_remove(smbdev->client);
 	}
 
-	kfree(smbdev);
+	mutex_unlock(&psmouse_smbus_mutex);
+
 	psmouse->private = NULL;
 }
 
-- 
2.12.2.564.g063fe858b8-goog


-- 
Dmitry
