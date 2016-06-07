From: Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] Input: elan_i2c - +200 ms delay before setting to ABS mode
Date: Tue,  7 Jun 2016 21:34:09 +0800
Message-ID: <1465306449-28256-1-git-send-email-chiu@endlessm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, duson <dusonlin@emc.com.tw>, Charlie Mooney <charliemooney@chromium.org>, Michele Curti <michele.curti@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
List-Id: linux-input@vger.kernel.org

When performing a warm reboot from a system which does not correctly
support ELAN I2C touchpads, the touchpad will sometimes enter standard
mouse mode, cursor then never respond to touchpad event, and making the
driver discard the HID reports and flood dmesg with following error
messages.
"elan_i2c i2c-ELAN1000:00: invalid report id data (1)"

This change is from ELAN's correction. It needs 200ms delay before
set_mode() so that the mode setting will correctly take effect.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/input/mouse/elan_i2c_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 2f58985..95080f9 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -210,18 +210,20 @@ static int __elan_initialize(struct elan_tp_data *data)
 		return error;
 	}
 
-	data->mode |= ETP_ENABLE_ABS;
-	error = data->ops->set_mode(client, data->mode);
+	error = data->ops->sleep_control(client, false);
 	if (error) {
 		dev_err(&client->dev,
-			"failed to switch to absolute mode: %d\n", error);
+			"failed to wake device up: %d\n", error);
 		return error;
 	}
 
-	error = data->ops->sleep_control(client, false);
+	msleep(200);
+
+	data->mode |= ETP_ENABLE_ABS;
+	error = data->ops->set_mode(client, data->mode);
 	if (error) {
 		dev_err(&client->dev,
-			"failed to wake device up: %d\n", error);
+			"failed to switch to absolute mode: %d\n", error);
 		return error;
 	}
 
-- 
2.1.4
