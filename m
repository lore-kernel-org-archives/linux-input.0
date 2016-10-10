From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 8/8] Input: elan_i2c - add Host Notify support
Date: Mon, 10 Oct 2016 18:42:35 +0200
Message-ID: <1476117755-8113-9-git-send-email-benjamin.tissoires@redhat.com>
References: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476117755-8113-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, KT Liao <kt.liao@emc.com.tw>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Thinkpad series 13 uses Host Notify to report the interrupt.
Add elan_smb_alert() to handle those interrupts and disable the irq
handling on this case.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v4 (was submitted on linux-input with the .alert callback)
---
 drivers/input/mouse/elan_i2c_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 6f16eb4..4aaac5d 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1040,6 +1040,21 @@ static int elan_probe(struct i2c_client *client,
 						I2C_FUNC_SMBUS_BLOCK_DATA |
 						I2C_FUNC_SMBUS_I2C_BLOCK)) {
 		transport_ops = &elan_smbus_ops;
+
+		if (!irq) {
+			if (!i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_HOST_NOTIFY)) {
+				dev_err(dev, "no Host Notify support\n");
+				return -ENODEV;
+			}
+
+			irq = i2c_smbus_host_notify_to_irq(client);
+			if (irq < 0) {
+				dev_err(dev,
+					"Unable to request a Host Notify IRQ.\n");
+				return irq;
+			}
+		}
 	} else {
 		dev_err(dev, "not a supported I2C/SMBus adapter\n");
 		return -EIO;
-- 
2.7.4
