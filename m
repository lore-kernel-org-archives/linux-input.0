From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v2 3/8] Input: synaptics-rmi4: Add dribble and palm gesture parameters to device tree
Date: Fri, 24 Jun 2016 17:18:37 -0700
Message-ID: <1466813917-15841-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:10148 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbcFYASt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2016 20:18:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt          |  4 ++++
 drivers/input/rmi4/rmi_2d_sensor.c                            | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
index f2c30c8..86cb8e3 100644
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
@@ -37,6 +37,10 @@ Optional Properties:
 				disable reporing absolute position data.
 - syna,rezero-wait-ms: Time in miliseconds to wait after issuing a rezero
 				command.
+- syna,dribble-enable: Enable reporting of dribble packets in the firmware.
+- syna,dribble-disable: Disable reporting of dribble packets in the firmware.
+- syna,palm-detect-enable: Enable reporting the palm detect gesture in the firmware.
+- syna,palm-detect-disable: Disable reporting the palm detect gesture in the firmware.
 
 
 Example of a RMI4 I2C device with F11:
diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index e97bd7f..ee26e35 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -317,6 +317,17 @@ int rmi_2d_sensor_of_probe(struct device *dev,
 
 	pdata->rezero_wait = val;
 
+	if (of_property_read_bool(dev->of_node, "syna,dribble-enable"))
+		pdata->dribble = RMI_REG_STATE_ON;
+	else if (of_property_read_bool(dev->of_node, "syna,dribble-disable"))
+		pdata->dribble = RMI_REG_STATE_OFF;
+
+	if (of_property_read_bool(dev->of_node, "syna,palm-detect-enable"))
+		pdata->palm_detect = RMI_REG_STATE_ON;
+	else if (of_property_read_bool(dev->of_node,
+				"syna,palm-detect-disable"))
+		pdata->palm_detect = RMI_REG_STATE_OFF;
+
 	return 0;
 }
 #else
-- 
2.5.0

