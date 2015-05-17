From: Evgeniy Dushistov <dushistov@mail.ru>
Subject: Re: [PATCH 3/3] max7359_keypad: implement DT bindings
Date: Sun, 17 May 2015 19:55:02 +0300
Message-ID: <20150517165502.GA781@fifteen>
References: <ppRxn-3aD-5@gated-at.bofh.it>
 <pquS6-2DV-9@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.181.253]:52181 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbEQQzS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 May 2015 12:55:18 -0400
Content-Disposition: inline
In-Reply-To: <pquS6-2DV-9@gated-at.bofh.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, May 15, 2015 at 11:00:02PM +0200, Dmitry Torokhov wrote:
> On Thu, May 14, 2015 at 05:38:03AM +0300, Evgeniy Dushistov wrote:
> > +		maxim,debounce_reg = /bits/ 8 <0x5F>;
> > +		maxim,ports_reg = /bits/ 8 <0xFF>;
> 
> Specifying exact size for properties is quite uncommon; I think the
> usual recommendation is is to use the "standard" u32 and validate the
> range in parser function.
> 

Using of u8 has advantages, it is possible on compilation stage
(dts->dtb) check that you enter right value, but
because of DT validation tools are not part of mainline,
I replace u8 with u32 as you suggest, see patch bellow.

> > +		MATRIX_KEY(0, 7, KEY_RESERVED)
> > +		...
> 
> 
> Indent one more level? Also, maybe fill with something other than
> KEY_RESERVED?
> 

Fixed, see patch bellow.

> 
> 
 
> >  	dev_dbg(&client->dev, "keys FIFO is 0x%02x\n", ret);
> > +	if (!keymap_data) {
> > +		error = max7359_parse_dt(&client->dev, &init_state);
> > +		if (error) {
> > +			dev_err(&client->dev, "platform data null, and no DT data\n");
> > +			return error;
> 
> Both debounce and ports values are optional and we'll fail building
> keymap if there are no platform data nor device tree data, so I would
> drop this check and the stub for max7359_parse_dt() as well - we have
> stubs for property parsing anyway.
> 

Because of u32/u8 check at now max7359_parse_dt can return not 0.

> -- 
> Dmitry
> 

Thanks, for review. 

Please add me to CC, because of I'm not the part
of any mailing list (too huge traffic for me).
Here patch with fixes mentioned above:


max7359_keypad: implement DT bindings

Signed-off-by: Evgeniy A. Dushistov <dushistov@mail.ru>
---
 .../devicetree/bindings/input/max7359-keypad.txt   | 33 ++++++++++
 drivers/input/keyboard/max7359_keypad.c            | 70 +++++++++++++++++++++-
 2 files changed, 100 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/max7359-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/max7359-keypad.txt b/Documentation/devicetree/bindings/input/max7359-keypad.txt
new file mode 100644
index 0000000..5bd4a4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max7359-keypad.txt
@@ -0,0 +1,33 @@
+* MAX7359 keypda device tree bindings
+
+Required Properties:
+- compatible:		Should be "maxim,max7359"
+- linux,keymap:		The definition can be found at
+			bindings/input/matrix-keymap.txt
+
+Optional Properties:
+- maxim,debounce_reg: u32, in short allow control debounce,
+see max7359 datasheet for details
+- maxim,ports_reg: u32, in short allow control what pin used,
+and what pins should be configured as GPIO
+
+Example:
+max7359_keypad@38 {
+	compatible = "maxim,max7359";
+	reg = <0x38>;
+	interrupts = <28 IRQ_TYPE_LEVEL_LOW>;/*gpio_156*/
+	interrupt-parent = <&gpio5>;
+	maxim,debounce_reg = <0x5F>;
+	maxim,ports_reg = <0xFF>;
+	linux,keymap = <
+	MATRIX_KEY(0, 0, KEY_F1)
+	MATRIX_KEY(0, 1, KEY_RESERVED)
+	MATRIX_KEY(0, 2, KEY_F2)
+	MATRIX_KEY(0, 3, KEY_RESERVED)
+	MATRIX_KEY(0, 4, KEY_M)
+	MATRIX_KEY(0, 5, KEY_L)
+	MATRIX_KEY(0, 6, KEY_P)
+	MATRIX_KEY(0, 7, KEY_ESC)
+	...
+	>;
+};
diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index 5091133..60b4d29 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -20,6 +20,7 @@
 #include <linux/pm.h>
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/of.h>
 
 #define MAX7359_MAX_KEY_ROWS	8
 #define MAX7359_MAX_KEY_COLS	8
@@ -64,6 +65,11 @@ struct max7359_keypad {
 	struct i2c_client *client;
 };
 
+struct max7359_initial_state {
+	u8 debounce_val;
+	u8 ports_val;
+};
+
 static int max7359_write_reg(struct i2c_client *client, u8 reg, u8 val)
 {
 	int ret = i2c_smbus_write_byte_data(client, reg, val);
@@ -143,24 +149,64 @@ static void max7359_close(struct input_dev *dev)
 	max7359_fall_deepsleep(keypad->client);
 }
 
-static void max7359_initialize(struct i2c_client *client)
+static void max7359_initialize(struct i2c_client *client,
+			       const struct max7359_initial_state *init_state)
 {
 	max7359_write_reg(client, MAX7359_REG_CONFIG,
 		MAX7359_CFG_KEY_RELEASE | /* Key release enable */
 		MAX7359_CFG_WAKEUP); /* Key press wakeup enable */
 
 	/* Full key-scan functionality */
-	max7359_write_reg(client, MAX7359_REG_DEBOUNCE, 0x1F);
+	max7359_write_reg(client, MAX7359_REG_DEBOUNCE,
+			  init_state->debounce_val);
 
 	/* nINT asserts every debounce cycles */
 	max7359_write_reg(client, MAX7359_REG_INTERRUPT, 0x01);
+	max7359_write_reg(client, MAX7359_REG_PORTS, init_state->ports_val);
 
 	max7359_fall_deepsleep(client);
 }
 
+#ifdef CONFIG_OF
+static int max7359_parse_dt(struct device *dev,
+			    struct max7359_initial_state *init_state)
+{
+	struct device_node *np = dev->of_node;
+	u32 prop;
+
+	if (!of_property_read_u32(np, "maxim,debounce_reg", &prop)) {
+		if (prop > 0xFF) {
+			dev_err(dev, "expect 8bit value for maxim,debounce_reg\n");
+			return -EINVAL;
+		}
+		init_state->debounce_val = prop;
+	}
+
+	if (!of_property_read_u32(np, "maxim,ports_reg", &prop)) {
+		if (prop > 0xFF) {
+			dev_err(dev, "expect 8bit value for maxim,ports_reg\n");
+			return -EINVAL;
+		}
+		init_state->ports_val = prop;
+	}
+
+	return 0;
+}
+#else
+static inline int max7359_parse_dt(struct device *dev,
+				   struct max7359_initial_state *init_state)
+{
+	return -EINVAL;
+}
+#endif
+
 static int max7359_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
+	struct max7359_initial_state init_state = {
+		.debounce_val = 0x1F,
+		.ports_val = 0xFE,
+	};
 	const struct matrix_keymap_data *keymap_data =
 			dev_get_platdata(&client->dev);
 	struct max7359_keypad *keypad;
@@ -181,6 +227,15 @@ static int max7359_probe(struct i2c_client *client,
 	}
 
 	dev_dbg(&client->dev, "keys FIFO is 0x%02x\n", ret);
+	if (!keymap_data) {
+		error = max7359_parse_dt(&client->dev, &init_state);
+		if (error) {
+			dev_err(&client->dev, "Invalid DT data\n");
+			return error;
+		}
+		dev_dbg(&client->dev, "Init vals: debounce %X, ports %X\n",
+			init_state.debounce_val, init_state.ports_val);
+	}
 
 	keypad = devm_kzalloc(&client->dev, sizeof(struct max7359_keypad),
 			      GFP_KERNEL);
@@ -239,7 +294,7 @@ static int max7359_probe(struct i2c_client *client,
 	}
 
 	/* Initialize MAX7359 */
-	max7359_initialize(client);
+	max7359_initialize(client, &init_state);
 
 	i2c_set_clientdata(client, keypad);
 	device_init_wakeup(&client->dev, 1);
@@ -282,10 +337,19 @@ static const struct i2c_device_id max7359_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max7359_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id max7359_dt_match[] = {
+	{ .compatible = "maxim,max7359" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, max7359_dt_match);
+#endif
+
 static struct i2c_driver max7359_i2c_driver = {
 	.driver = {
 		.name = "max7359",
 		.pm   = &max7359_pm,
+		.of_match_table = of_match_ptr(max7359_dt_match),
 	},
 	.probe		= max7359_probe,
 	.id_table	= max7359_ids,
-- 
2.3.6


-- 
/Evgeniy
