From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH resend v2] input: Add new sun4i-lradc-keys driver
Date: Wed, 17 Dec 2014 15:43:31 +0100
Message-ID: <1418827411-13265-2-git-send-email-hdegoede@redhat.com>
References: <1418827411-13265-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORBHFNY2SAKGQEY2TJVTI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1418827411-13265-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Allwinnner sunxi SoCs have a low resolution adc (called lradc) which is
specifically designed to have various (tablet) keys (ie home, back, search,
etc). attached to it using a resistor network. This adds a driver for this.

There are 2 channels, currently this driver only supports chan0 since there
are no boards known to use chan1.

This has been tested on an olimex a10s-olinuxino-micro, a13-olinuxino, and
a20-olinuxino-micro.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
Changes in v2:
-Change devicetree bindings to use a per key subnode, like gpio-keys does
---
 .../devicetree/bindings/input/sun4i-lradc-keys.txt |  62 +++++
 MAINTAINERS                                        |   7 +
 drivers/input/keyboard/Kconfig                     |  10 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/sun4i-lradc-keys.c          | 258 +++++++++++++++++=
++++
 5 files changed, 338 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sun4i-lradc-key=
s.txt
 create mode 100644 drivers/input/keyboard/sun4i-lradc-keys.c

diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt b=
/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
new file mode 100644
index 0000000..b9c32f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
@@ -0,0 +1,62 @@
+Allwinner sun4i low res adc attached tablet keys
+------------------------------------------------
+
+Required properties:
+ - compatible: "allwinner,sun4i-a10-lradc-keys"
+ - reg: mmio address range of the chip
+ - interrupts: interrupt to which the chip is connected
+ - vref-supply: powersupply for the lradc reference voltage
+
+Each key is represented as a sub-node of "allwinner,sun4i-a10-lradc-keys":
+
+Required subnode-properties:
+	- label: Descriptive name of the key.
+	- linux,code: Keycode to emit.
+	- channel: Channel this key is attached to, mut be 0 or 1.
+	- voltage: Voltage in =C2=B5V at lradc input when this key is pressed.
+
+Example:
+
+#include <dt-bindings/input/input.h>
+
+	lradc: lradc@01c22800 {
+		compatible =3D "allwinner,sun4i-a10-lradc-keys";
+		reg =3D <0x01c22800 0x100>;
+		interrupts =3D <31>;
+		vref-supply =3D <&reg_vcc3v0>;
+
+		button@191 {
+			label =3D "Volume Up";
+			linux,code =3D <KEY_VOLUMEUP>;
+			channel =3D <0>;
+			voltage =3D <191274>;
+		};
+
+		button@392 {
+			label =3D "Volume Down";
+			linux,code =3D <KEY_VOLUMEDOWN>;
+			channel =3D <0>;
+			voltage =3D <392644>;
+		};
+
+		button@601 {
+			label =3D "Menu";
+			linux,code =3D <KEY_MENU>;
+			channel =3D <0>;
+			voltage =3D <601151>;
+		};
+
+		button@795 {
+			label =3D "Enter";
+			linux,code =3D <KEY_ENTER>;
+			channel =3D <0>;
+			voltage =3D <795090>;
+		};
+
+		button@987 {
+			label =3D "Home";
+			linux,code =3D <KEY_HOMEPAGE>;
+			channel =3D <0>;
+			voltage =3D <987387>;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index fdffe96..fb3d33e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9193,6 +9193,13 @@ F:	arch/m68k/sun3*/
 F:	arch/m68k/include/asm/sun3*
 F:	drivers/net/ethernet/i825xx/sun3*
=20
+SUN4I LOW RES ADC ATTACHED TABLET KEYS DRIVER
+M:	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+L:	linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
+F:	drivers/input/keyboard/sun4i-lradc-keys.c
+
 SUNDANCE NETWORK DRIVER
 M:	Denis Kirjanov <kda-u1c8ncikuMvVAZt0uhVF+Ni2O/JbrIOy@public.gmane.org>
 L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfi=
g
index a3958c6..2d11b44 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -567,6 +567,16 @@ config KEYBOARD_STMPE
 	  To compile this driver as a module, choose M here: the module will be
 	  called stmpe-keypad.
=20
+config KEYBOARD_SUN4I_LRADC
+	tristate "Allwinner sun4i low res adc attached tablet keys support"
+	depends on ARCH_SUNXI
+	help
+	  This selects support for the Allwinner low res adc attached tablet
+	  keys found on Allwinner sunxi SoCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sun4i-lradc-keys.
+
 config KEYBOARD_DAVINCI
 	tristate "TI DaVinci Key Scan"
 	depends on ARCH_DAVINCI_DM365
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makef=
ile
index 0a33456..a35269a 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_KEYBOARD_SPEAR)		+=3D spear-keyboard.o
 obj-$(CONFIG_KEYBOARD_STMPE)		+=3D stmpe-keypad.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+=3D stowaway.o
 obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)	+=3D st-keyscan.o
+obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)	+=3D sun4i-lradc-keys.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+=3D sunkbd.o
 obj-$(CONFIG_KEYBOARD_TC3589X)		+=3D tc3589x-keypad.o
 obj-$(CONFIG_KEYBOARD_TEGRA)		+=3D tegra-kbc.o
diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyb=
oard/sun4i-lradc-keys.c
new file mode 100644
index 0000000..f11f002
--- /dev/null
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -0,0 +1,258 @@
+/*
+ * Allwinner sun4i low res adc attached tablet keys driver
+ *
+ * Copyright (C) 2014 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * Allwinnner sunxi SoCs have a lradc which is specifically designed to ha=
ve
+ * various (tablet) keys (ie home, back, search, etc). attached to it usin=
g
+ * a resistor network. This driver is for the keys on such boards.
+ *
+ * There are 2 channels, currently this driver only supports channel 0 sin=
ce
+ * there are no boards known to use channel 1.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#define LRADC_CTRL		0x00
+#define LRADC_INTC		0x04
+#define LRADC_INTS		0x08
+#define LRADC_DATA0		0x0c
+#define LRADC_DATA1		0x10
+
+/* LRADC_CTRL bits */
+#define FIRST_CONVERT_DLY(x)	((x) << 24) /* 8 bits */
+#define CHAN_SELECT(x)		((x) << 22) /* 2 bits */
+#define CONTINUE_TIME_SEL(x)	((x) << 16) /* 4 bits */
+#define KEY_MODE_SEL(x)		((x) << 12) /* 2 bits */
+#define LEVELA_B_CNT(x)		((x) << 8)  /* 4 bits */
+#define HOLD_EN(x)		((x) << 6)
+#define LEVELB_VOL(x)		((x) << 4)  /* 2 bits */
+#define SAMPLE_RATE(x)		((x) << 2)  /* 2 bits */
+#define ENABLE(x)		((x) << 0)
+
+/* LRADC_INTC and LRADC_INTS bits */
+#define CHAN1_KEYUP_IRQ		BIT(12)
+#define CHAN1_ALRDY_HOLD_IRQ	BIT(11)
+#define CHAN1_HOLD_IRQ		BIT(10)
+#define	CHAN1_KEYDOWN_IRQ	BIT(9)
+#define CHAN1_DATA_IRQ		BIT(8)
+#define CHAN0_KEYUP_IRQ		BIT(4)
+#define CHAN0_ALRDY_HOLD_IRQ	BIT(3)
+#define CHAN0_HOLD_IRQ		BIT(2)
+#define	CHAN0_KEYDOWN_IRQ	BIT(1)
+#define CHAN0_DATA_IRQ		BIT(0)
+
+struct sun4i_lradc_keymap {
+	u32 voltage;
+	u32 keycode;
+};
+
+struct sun4i_lradc_data {
+	struct device *dev;
+	struct input_dev *input;
+	void __iomem *base;
+	struct regulator *vref_supply;
+	struct sun4i_lradc_keymap *chan0_map;
+	u32 chan0_map_count;
+	u32 chan0_keycode;
+	u32 vref;
+};
+
+static irqreturn_t sun4i_lradc_irq(int irq, void *dev_id)
+{
+	struct sun4i_lradc_data *lradc =3D dev_id;
+	u32 i, ints, val, voltage, diff, keycode =3D 0, closest =3D 0xffffffff;
+
+	ints  =3D readl(lradc->base + LRADC_INTS);
+
+	/*
+	 * lradc supports only one keypress at a time, release does not give
+	 * any info as to which key was released, so we cache the keycode.
+	 */
+	if ((ints & CHAN0_KEYDOWN_IRQ) && lradc->chan0_keycode =3D=3D 0) {
+		val =3D readl(lradc->base + LRADC_DATA0) & 0x3f;
+		voltage =3D val * lradc->vref / 63;
+
+		for (i =3D 0; i < lradc->chan0_map_count; i++) {
+			diff =3D abs(lradc->chan0_map[i].voltage - voltage);
+			if (diff < closest) {
+				closest =3D diff;
+				keycode =3D lradc->chan0_map[i].keycode;
+			}
+		}
+
+		lradc->chan0_keycode =3D keycode;
+		input_report_key(lradc->input, lradc->chan0_keycode, 1);
+	}
+
+	if (ints & CHAN0_KEYUP_IRQ) {
+		input_report_key(lradc->input, lradc->chan0_keycode, 0);
+		lradc->chan0_keycode =3D 0;
+	}
+
+	input_sync(lradc->input);
+
+	writel(ints, lradc->base + LRADC_INTS);
+
+	return IRQ_HANDLED;
+}
+
+static int sun4i_lradc_open(struct input_dev *dev)
+{
+	struct sun4i_lradc_data *lradc =3D input_get_drvdata(dev);
+	int ret;
+
+	ret =3D regulator_enable(lradc->vref_supply);
+	if (ret)
+		return ret;
+
+	/* lradc Vref internally is divided by 2/3 */
+	lradc->vref =3D regulator_get_voltage(lradc->vref_supply) * 2 / 3;
+
+	/*
+	 * Set sample time to 4 ms / 250 Hz. Wait 2 * 4 ms for key to
+	 * stabilize on press, wait (1 + 1) * 4 ms for key release
+	 */
+	writel(FIRST_CONVERT_DLY(2) | LEVELA_B_CNT(1) | HOLD_EN(1) |
+		SAMPLE_RATE(0) | ENABLE(1), lradc->base + LRADC_CTRL);
+
+	writel(CHAN0_KEYUP_IRQ | CHAN0_KEYDOWN_IRQ, lradc->base + LRADC_INTC);
+
+	return 0;
+}
+
+static void sun4i_lradc_close(struct input_dev *dev)
+{
+	struct sun4i_lradc_data *lradc =3D input_get_drvdata(dev);
+
+	/* Disable lradc, leave other settings unchanged */
+	writel(FIRST_CONVERT_DLY(2) | LEVELA_B_CNT(1) | HOLD_EN(1) |
+		SAMPLE_RATE(2), lradc->base + LRADC_CTRL);
+	writel(0, lradc->base + LRADC_INTC);
+
+	regulator_disable(lradc->vref_supply);
+}
+
+static int sun4i_lradc_probe(struct platform_device *pdev)
+{
+	struct sun4i_lradc_data *lradc;
+	struct device *dev =3D &pdev->dev;
+	struct device_node *pp, *np =3D dev->of_node;
+	u32 channel;
+	int i, ret;
+
+	lradc =3D devm_kzalloc(dev, sizeof(struct sun4i_lradc_data), GFP_KERNEL);
+	if (!lradc)
+		return -ENOMEM;
+
+	lradc->chan0_map_count =3D of_get_child_count(np);
+	lradc->chan0_map =3D devm_kmalloc(dev, lradc->chan0_map_count *
+				sizeof(struct sun4i_lradc_keymap), GFP_KERNEL);
+	if (!lradc->chan0_map)
+		return -ENOMEM;
+
+	i =3D 0;
+	for_each_child_of_node(np, pp) {
+		struct sun4i_lradc_keymap *map =3D &lradc->chan0_map[i];
+
+		ret =3D of_property_read_u32(pp, "channel", &channel);
+		if (ret || channel !=3D 0) {
+			dev_err(dev, "%s: Inval channel prop\n", pp->name);
+			return -EINVAL;
+		}
+
+		ret =3D of_property_read_u32(pp, "voltage", &map->voltage);
+		if (ret) {
+			dev_err(dev, "%s: Inval voltage prop\n", pp->name);
+			return -EINVAL;
+		}
+
+		ret =3D of_property_read_u32(pp, "linux,code", &map->keycode);
+		if (ret) {
+			dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
+			return -EINVAL;
+		}
+
+		i++;
+	}
+
+	lradc->vref_supply =3D devm_regulator_get(dev, "vref");
+	if (IS_ERR(lradc->vref_supply))
+		return PTR_ERR(lradc->vref_supply);
+
+	lradc->dev =3D dev;
+	lradc->input =3D devm_input_allocate_device(dev);
+	if (!lradc->input)
+		return -ENOMEM;
+
+	lradc->input->name =3D pdev->name;
+	lradc->input->phys =3D "sun4i_lradc/input0";
+	lradc->input->open =3D sun4i_lradc_open;
+	lradc->input->close =3D sun4i_lradc_close;
+	lradc->input->id.bustype =3D BUS_HOST;
+	lradc->input->id.vendor =3D 0x0001;
+	lradc->input->id.product =3D 0x0001;
+	lradc->input->id.version =3D 0x0100;
+	lradc->input->evbit[0] =3D  BIT(EV_SYN) | BIT(EV_KEY);
+	for (i =3D 0; i < lradc->chan0_map_count; i++)
+		set_bit(lradc->chan0_map[i].keycode, lradc->input->keybit);
+	input_set_drvdata(lradc->input, lradc);
+
+	lradc->base =3D devm_ioremap_resource(dev,
+			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	if (IS_ERR(lradc->base))
+		return PTR_ERR(lradc->base);
+
+	ret =3D devm_request_irq(dev, platform_get_irq(pdev, 0), sun4i_lradc_irq,
+			       0, "sun4i-a10-lradc-keys", lradc);
+	if (ret)
+		return ret;
+
+	ret =3D input_register_device(lradc->input);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, lradc);
+	return 0;
+}
+
+static const struct of_device_id sun4i_lradc_of_match[] =3D {
+	{ .compatible =3D "allwinner,sun4i-a10-lradc-keys", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
+
+static struct platform_driver sun4i_lradc_driver =3D {
+	.driver =3D {
+		.name	=3D "sun4i-a10-lradc-keys",
+		.of_match_table =3D of_match_ptr(sun4i_lradc_of_match),
+	},
+	.probe	=3D sun4i_lradc_probe,
+};
+
+module_platform_driver(sun4i_lradc_driver);
+
+MODULE_DESCRIPTION("Allwinner sun4i low res adc attached tablet keys drive=
r");
+MODULE_AUTHOR("Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>");
+MODULE_LICENSE("GPL");
--=20
2.1.0

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
