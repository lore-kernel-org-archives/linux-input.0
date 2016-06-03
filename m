From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 3/7] Input: synaptics-rmi4: Add dribble and palm gesture parameters to devicetree
Date: Fri, 3 Jun 2016 11:40:28 -0700
Message-ID: <1464979228-2497-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt       |  5 +++++
 drivers/input/rmi4/rmi_2d_sensor.c                         | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
index f2c30c8..822df11 100644
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
@@ -37,6 +37,11 @@ Optional Properties:
 				disable reporing absolute position data.
 - syna,rezero-wait-ms: Time in miliseconds to wait after issuing a rezero
 				command.
+- syna,dribble: Control reporting of dribble packets. Values are 0 for
+		default, 1 for explicitly disable, 2 for explicitly enable.
+- syna,palm_detect: Control reporting of the palm detect gesture. Values
+			are 0 for default, 1 for explicitly disable, 2 for
+			explicitly enable.
 
 
 Example of a RMI4 I2C device with F11:
diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index e97bd7f..c41db3b 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -317,6 +317,20 @@ int rmi_2d_sensor_of_probe(struct device *dev,
 
 	pdata->rezero_wait = val;
 
+	retval = rmi_of_property_read_u32(dev, &val, "syna,dribble",
+						1);
+	if (retval)
+		return retval;
+
+	pdata->dribble = val;
+
+	retval = rmi_of_property_read_u32(dev, &val, "syna,palm_detect",
+						1);
+	if (retval)
+		return retval;
+
+	pdata->palm_detect = val;
+
 	return 0;
 }
 #else
-- 
2.5.0
