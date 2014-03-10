From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
Date: Mon, 10 Mar 2014 11:48:19 +0000
Message-ID: <20140310114819.GO14976@lee--X1>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-2-git-send-email-gabriel.fernandez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393990772-9567-2-git-send-email-gabriel.fernandez@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com, Giuseppe Condorelli <giuseppe.condorelli@st.com>
List-Id: linux-input@vger.kernel.org

Hi Gabi,

Sorry for the delay. It was a hectic week last week.

As promised:

> This patch adds ST Keyscan driver to use the keypad hw a subset
> of ST boards provide. Specific board setup will be put in the
> given dt.
>=20
> Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>

Are you sure these are in the correct order?

What is the history of this commit?

> ---
>  .../devicetree/bindings/input/st-keypad.txt        |  50 ++++

This should be submitted as a seperate patch.

>  drivers/input/keyboard/Kconfig                     |  12 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/st-keyscan.c                | 323 +++++++++++=
++++++++++
>  4 files changed, 386 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/st-keypad=
=2Etxt
>  create mode 100644 drivers/input/keyboard/st-keyscan.c
>=20
> diff --git a/Documentation/devicetree/bindings/input/st-keypad.txt b/=
Documentation/devicetree/bindings/input/st-keypad.txt
> new file mode 100644
> index 0000000..63eb07a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/st-keypad.txt
> @@ -0,0 +1,50 @@
> +* ST Keypad controller device tree bindings

s/device tree/Device Tree

> +
> +The ST keypad controller device tree binding is based on the

As above.

> +matrix-keymap.
> +
> +Required properties:
> +
> +- compatible: "st,keypad"

I think there will be subsequent st,keypad drivers? Is there any way
we can make this compatible string more specific to _this_ device?

st,stih4xx-keypad?

> +- reg: Register base address of st-keypad controler.

s/address/address and size AND s/controler/controller

> +- interrupts: Interrupt numberof st-keypad controler.

s/numberof/number for the

> +- clocks: Must contain one entry, for the module clock.
> +  See ../clocks/clock-bindings.txt for details.

Great!

> +- pinctrl-0: Should specify pin control groups used for this control=
ler.
> +
> +- pinctrl-names: Should contain only one value - "default".

Like to ../pinctrl/pinctrl-bindings.txt

> +- linux,keymap: The keymap for keys as described in the binding docu=
ment
> +  devicetree/bindings/input/matrix-keymap.txt.
> +
> +- keypad,num-rows: Number of row lines connected to the keypad contr=
oller.
> +
> +- keypad,num-columns: Number of column lines connected to the keypad
> +  controller.
> +
> +- st,debounce_us: Debouncing interval time in microseconds

I'm sure there will be a shared binding for de-bounce.

If not, there certainly should be.

> +
> +

Superfluous new lines.

> +Example:
> +
> +keyscan: keyscan@fe4b0000 {
> +	compatible =3D "st,keypad";

Is there any way we can make this more specific to _this_ IP?

> +	reg =3D <0xfe4b0000 0x2000>;
> +	interrupts =3D <GIC_SPI 212 IRQ_TYPE_NONE>;
> +	clocks	=3D <&CLK_SYSIN>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_keyscan>;
> +
> +	keypad,num-rows =3D <4>;
> +	keypad,num-columns =3D <4>;
> +	st,debounce_us =3D <5000>;
> +	linux,keymap =3D < /* in0	in1	in2	in3 */

Do these line up in the file? I know Git can be a bit funny about this
sometimes.

> +		KEY_F13 KEY_F9  KEY_F5 KEY_F1		/* out0 */
> +		KEY_F14 KEY_F10 KEY_F6 KEY_F2		/* out1 */
> +		KEY_F15 KEY_F11 KEY_F7 KEY_F3		/* out2 */
> +		KEY_F16 KEY_F12 KEY_F8 KEY_F4 >;	/* out3 */
> +};
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index a673c9f..9e29125 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -512,6 +512,18 @@ config KEYBOARD_STOWAWAY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stowaway.
> =20
> +config KEYBOARD_ST_KEYSCAN
> +	tristate "STMicroelectronics keyscan support"
> +	depends on ARCH_STI
> +	select INPUT_EVDEV
> +	select INPUT_MATRIXKMAP
> +	help
> +	  Say Y here if you want to use a keypad attached to the keyscan bl=
ock
> +	  on some STMicroelectronics SoC devices.

Might be worth mentioning which ones.

> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stm-keyscan.
> +
>  config KEYBOARD_SUNKBD
>  	tristate "Sun Type 4 and Type 5 keyboard"
>  	select SERIO
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard=
/Makefile
> index a699b61..5fd020a 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+=3D sh_keysc.o
>  obj-$(CONFIG_KEYBOARD_SPEAR)		+=3D spear-keyboard.o
>  obj-$(CONFIG_KEYBOARD_STMPE)		+=3D stmpe-keypad.o
>  obj-$(CONFIG_KEYBOARD_STOWAWAY)		+=3D stowaway.o
> +obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)	+=3D st-keyscan.o
>  obj-$(CONFIG_KEYBOARD_SUNKBD)		+=3D sunkbd.o
>  obj-$(CONFIG_KEYBOARD_TC3589X)		+=3D tc3589x-keypad.o
>  obj-$(CONFIG_KEYBOARD_TEGRA)		+=3D tegra-kbc.o
> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyb=
oard/st-keyscan.c
> new file mode 100644
> index 0000000..606cc19
> --- /dev/null
> +++ b/drivers/input/keyboard/st-keyscan.c
> @@ -0,0 +1,323 @@
> +/*
> + * STMicroelectronics Key Scanning driver
> + *
> + * Copyright (c) 2014 STMicroelectonics Ltd.
> + * Author: Stuart Menefy <stuart.menefy@st.com>
> + *
> + * Based on sh_keysc.c, copyright 2008 Magnus Damm

Did sh_keysc.c ever exist in Mainline?

> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/input/matrix_keypad.h>
> +
> +#define ST_KEYSCAN_MAXKEYS 16
> +
> +#define KEYSCAN_CONFIG_OFF		0x000
> +#define KEYSCAN_CONFIG_ENABLE		1

0x001?

> +#define KEYSCAN_DEBOUNCE_TIME_OFF	0x004
> +#define KEYSCAN_MATRIX_STATE_OFF	0x008
> +#define KEYSCAN_MATRIX_DIM_OFF		0x00c

Odd that these are 3 digit padded? Is there a reason for that?

> +#define KEYSCAN_MATRIX_DIM_X_SHIFT	0
> +#define KEYSCAN_MATRIX_DIM_Y_SHIFT	2

=46or all 'ST_KEYSCAN_...'?

> +struct keypad_platform_data {
> +	const struct matrix_keymap_data *keymap_data;
> +	unsigned int num_out_pads;
> +	unsigned int num_in_pads;
> +	unsigned int debounce_us;
> +};
> +
> +struct keyscan_priv {
> +	void __iomem *base;
> +	int irq;
> +	struct clk *clk;
> +	struct input_dev *input_dev;
> +	struct keypad_platform_data *config;
> +	unsigned int last_state;
> +	u32 keycodes[ST_KEYSCAN_MAXKEYS];

Seems odd to limit this. Can't the information come from DT
i.e. keypad,num-rows and keypad,num-columns?

> +};
> +
> +static irqreturn_t keyscan_isr(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev =3D dev_id;
> +	struct keyscan_priv *priv =3D platform_get_drvdata(pdev);
> +	int state;
> +	int change;
> +
> +	state =3D readl(priv->base + KEYSCAN_MATRIX_STATE_OFF) & 0xffff;
> +	change =3D priv->last_state ^ state;
> +
> +	while (change) {
> +		int scancode =3D __ffs(change);
> +		int down =3D state & (1 << scancode);

int down =3D state & BIT(scancode);

> +		input_report_key(priv->input_dev, priv->keycodes[scancode],
> +				 down);
> +		change ^=3D 1 << scancode;

change ^=3D BIT(scancode);

> +	};
> +
> +	input_sync(priv->input_dev);
> +
> +	priv->last_state =3D state;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void keyscan_start(struct keyscan_priv *priv)
> +{
> +	clk_enable(priv->clk);
> +
> +	writel(priv->config->debounce_us * (clk_get_rate(priv->clk) / 10000=
00),
> +	       priv->base + KEYSCAN_DEBOUNCE_TIME_OFF);
> +
> +	writel(((priv->config->num_in_pads - 1) << KEYSCAN_MATRIX_DIM_X_SHI=
=46T) |
> +	       ((priv->config->num_out_pads - 1) << KEYSCAN_MATRIX_DIM_Y_SH=
IFT),
> +	       priv->base + KEYSCAN_MATRIX_DIM_OFF);
> +
> +	writel(KEYSCAN_CONFIG_ENABLE, priv->base + KEYSCAN_CONFIG_OFF);
> +}
> +
> +static void keyscan_stop(struct keyscan_priv *priv)
> +{
> +	writel(0, priv->base + KEYSCAN_CONFIG_OFF);
> +
> +	clk_disable(priv->clk);
> +}
> +
> +static int keypad_matrix_key_parse_dt(struct keyscan_priv *st_kp)
> +{
> +	struct device *dev =3D st_kp->input_dev->dev.parent;
> +	struct device_node *np =3D dev->of_node;
> +	struct keypad_platform_data *pdata;
> +	int error;
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(dev, "failed to allocate driver pdata\n");

If the system is OOM, this sort of error message will be pretty
redundant. Just return -ENOMEM instead.

> +		return -ENOMEM;
> +	}
> +
> +	error =3D matrix_keypad_parse_of_params(dev, &pdata->num_out_pads,
> +			&pdata->num_in_pads);
> +	if (error) {
> +		dev_err(dev, "failed to parse keypad params\n");
> +		return error;

Nit: It's pretty unusual to use this for a standard error handling
variable. Consider 'ret' or 'err' as a replacement.

> +	}
> +
> +	of_property_read_u32(np, "st,debounce_us", &pdata->debounce_us);

Isn't this a required property? Might be worth checking the return
value if so.

> +	st_kp->config =3D pdata;
> +
> +	dev_info(dev, "rows=3D%d col=3D%d debounce=3D%d\n",
> +			pdata->num_out_pads,
> +			pdata->num_in_pads,
> +			pdata->debounce_us);

Might be worth moving this down passed the final point of failure.

> +	error =3D of_property_read_u32_array(np, "linux,keymap",
> +					st_kp->keycodes, ST_KEYSCAN_MAXKEYS);
> +	if (error) {
> +		dev_err(dev, "failed to parse keymap\n");
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init keyscan_probe(struct platform_device *pdev)
> +{
> +	struct keypad_platform_data *pdata =3D
> +		dev_get_platdata(&pdev->dev);

Do we really support platform data still?

> +	struct keyscan_priv *st_kp;
> +	struct input_dev *input_dev;
> +	struct device *dev =3D &pdev->dev;

dev and pdev are used randomly in probe(). Just remove the dev
de-reference and use &pdev->dev exclusively.

It's pretty common to de-reference 'np =3D pdev->dev.of_node' though.

> +	struct resource *res;
> +	int len;
> +	int error;
> +	int i;
> +
> +	if (!pdata && !pdev->dev.of_node) {
> +		dev_err(&pdev->dev, "no keymap defined\n");
> +		return -EINVAL;
> +	}
> +
> +	st_kp =3D devm_kzalloc(dev, sizeof(*st_kp), GFP_KERNEL);
> +	if (!st_kp) {
> +		dev_err(dev, "failed to allocate driver data\n");
> +		return -ENOMEM;

I wouldn't print any messages on -ENOMEM personally. It's not a driver
failure per se, but a system one where the user will soon be notified.

> +	}
> +	st_kp->config =3D pdata;

You only want to do this in the !np case.

> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "no I/O memory specified\n");
> +		return -ENXIO;
> +	}
> +
> +	len =3D resource_size(res);
> +	if (!devm_request_mem_region(dev, res->start, len, pdev->name)) {
> +		dev_err(dev, "failed to reserve I/O memory\n");
> +		return -EBUSY;
> +	}
> +
> +	st_kp->base =3D devm_ioremap_nocache(dev, res->start, len);
> +	if (st_kp->base =3D=3D NULL) {
> +		dev_err(dev, "failed to remap I/O memory\n");
> +		return -ENXIO;
> +	}

Replace the two above with devm_ioremap_resource().

Make sure the IORESOURCE_CACHEABLE is set.

> +	st_kp->irq =3D platform_get_irq(pdev, 0);
> +	if (st_kp->irq < 0) {
> +		dev_err(dev, "no IRQ specified\n");
> +		return -ENXIO;

No such device or address, are you sure?

Perhaps -EINVAL would be better, as one should be specified.

> +	}
> +
> +	error =3D devm_request_irq(dev, st_kp->irq, keyscan_isr, 0,
> +				 pdev->name, pdev);
> +	if (error) {
> +		dev_err(dev, "failed to request IRQ\n");
> +		return error;
> +	}
> +
> +	input_dev =3D devm_input_allocate_device(&pdev->dev);
> +	if (!input_dev) {
> +		dev_err(&pdev->dev, "failed to allocate the input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	st_kp->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(st_kp->clk)) {
> +		dev_err(dev, "cannot get clock");
> +		return PTR_ERR(st_kp->clk);
> +	}
> +
> +	input_dev =3D input_allocate_device();
> +	if (!input_dev) {
> +		dev_err(dev, "failed to allocate input device\n");
> +		return -ENOMEM;
> +	}

Wasn't this done already?

> +	st_kp->input_dev =3D input_dev;
> +
> +	input_dev->name =3D pdev->name;
> +	input_dev->phys =3D "keyscan-keys/input0";
> +	input_dev->dev.parent =3D dev;
> +
> +	input_dev->id.bustype =3D BUS_HOST;
> +	input_dev->id.vendor =3D 0x0001;
> +	input_dev->id.product =3D 0x0001;
> +	input_dev->id.version =3D 0x0100;

Any chance we can #define these?

> +	if (!pdata) {
> +		error =3D keypad_matrix_key_parse_dt(st_kp);
> +		if (error)
> +			return error;
> +		pdata =3D st_kp->config;

Is pdata used after this?

> +	}
> +
> +	input_dev->keycode =3D st_kp->keycodes;
> +	input_dev->keycodesize =3D sizeof(st_kp->keycodes[0]);
> +	input_dev->keycodemax =3D ARRAY_SIZE(st_kp->keycodes);
> +
> +	for (i =3D 0; i < ST_KEYSCAN_MAXKEYS; i++)
> +		input_set_capability(input_dev, EV_KEY, st_kp->keycodes[i]);
> +	__clear_bit(KEY_RESERVED, input_dev->keybit);
> +
> +	error =3D input_register_device(input_dev);
> +	if (error) {
> +		dev_err(dev, "failed to register input device\n");
> +		input_free_device(input_dev);
> +		platform_set_drvdata(pdev, NULL);

You don't need to do this anymore. It's taken care of elsewhere.

> +		return error;
> +	}
> +
> +	platform_set_drvdata(pdev, st_kp);
> +
> +	keyscan_start(st_kp);
> +
> +	device_set_wakeup_capable(&pdev->dev, 1);
> +
> +	return 0;
> +}
> +
> +static int __exit keyscan_remove(struct platform_device *pdev)
> +{
> +	struct keyscan_priv *priv =3D platform_get_drvdata(pdev);
> +
> +	keyscan_stop(priv);
> +
> +	input_unregister_device(priv->input_dev);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;

I already saw that Dmitry commented on the rest of the file.

<snip>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
