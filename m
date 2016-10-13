From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 17/18] Input: synaptics-rmi4 - smbus: on resume, try 3 times if init fails
Date: Thu, 13 Oct 2016 17:51:11 +0200
Message-ID: <1476373872-18027-18-git-send-email-benjamin.tissoires@redhat.com>
References: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476373872-18027-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In some rare cases, we can't retrieve the SMBus version and so we fail
binding the touchpad back. Instead of leaving a touchpad dead, try again
to reinitialize it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

no changes in v2
---
 drivers/input/rmi4/rmi_smbus.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 8d7ffe4..b2d5932 100644
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
2.7.4
