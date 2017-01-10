From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 07/10] Input: synaptics-rmi4 - smbus: on resume, try 3 times if init fails
Date: Tue, 10 Jan 2017 17:11:25 +0100
Message-ID: <20170110161128.7441-8-benjamin.tissoires@redhat.com>
References: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>
Cc: Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In some rare cases, we can't retrieve the SMBus version and so we fail
binding the touchpad back. Instead of leaving a touchpad dead, try again
to reinitialize it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_smbus.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 3ebb2829..cbab388 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -265,10 +265,27 @@ static int rmi_smb_reset(struct rmi_transport_dev *xport, u16 reset_addr)
 {
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
+	struct i2c_client *client = rmi_smb->client;
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
+		serio_activate(rmi_smb->serio_parent);
+	}
+
+	return ret;
 }
 
 static const struct rmi_transport_ops rmi_smb_ops = {
-- 
2.9.3
