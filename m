From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 2/3] cap1106: support for active-high interrupt option
Date: Sat, 20 Sep 2014 20:01:08 -0700
Message-ID: <1411268469-21283-3-git-send-email-mranostay@gmail.com>
References: <1411268469-21283-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411268469-21283-1-git-send-email-mranostay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: galak@codeaurora.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, zonque@gmail.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-input@vger.kernel.org

Some applications need to use the active-high push-pull interrupt
option. This allows it be enabled in the device tree child node.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/input/keyboard/cap1106.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/keyboard/cap1106.c b/drivers/input/keyboard/cap1106.c
index b9c43b5..33e2590 100644
--- a/drivers/input/keyboard/cap1106.c
+++ b/drivers/input/keyboard/cap1106.c
@@ -234,6 +234,12 @@ static int cap1106_i2c_probe(struct i2c_client *i2c_client,
 			dev_err(dev, "Invalid sensor-gain value %d\n", gain32);
 	}
 
+	if (of_property_read_bool(node, "microchip,active-high")) {
+		error = regmap_write(priv->regmap, CAP1106_REG_CONFIG2, 0);
+		if (error)
+			return error;
+	}
+
 	/* Provide some useful defaults */
 	for (i = 0; i < priv->num_channels; i++)
 		priv->keycodes[i] = KEY_A + i;
-- 
1.9.1
