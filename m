From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: imx_keypad - Add device tree support
Date: Sun, 30 Dec 2012 15:28:52 -0800
Message-ID: <20121230232852.GB13899@core.coreip.homeip.net>
References: <1356872946-2810-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1356872946-2810-1-git-send-email-Ying.Liu@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Liu Ying <Ying.Liu@freescale.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, shawn.guo@linaro.org, s.hauer@pengutronix.de, linus.walleij@linaro.org, cjb@laptop.org, broonie@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, liu.y.victor@gmail.com
List-Id: linux-input@vger.kernel.org

Hi Liu,

On Sun, Dec 30, 2012 at 09:09:04PM +0800, Liu Ying wrote:
> This patch adds device tree support for imx keypad driver.
> 1) Basic device tree binding support.
> 2) Since the probe function needs keymap and keymap size
>    information, we get them from device tree if it is
>    supported, otherwise, we fall back to legacy platform data.
> 3) Support to configure keypad pins via pinctrl system.
> 
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
>  .../devicetree/bindings/input/imx-keypad.txt       |   54 +++++++++++++
>  drivers/input/keyboard/imx_keypad.c                |   80 ++++++++++++++++++--
>  2 files changed, 127 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/imx-keypad.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/imx-keypad.txt b/Documentation/devicetree/bindings/input/imx-keypad.txt
> new file mode 100644
> index 0000000..1c6e16d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/imx-keypad.txt
> @@ -0,0 +1,54 @@
> +* Freescale i.MX Keypad Port(KPP) device tree bindings
> +
> +The KPP is designed to interface with a keypad matrix with 2-point contact
> +or 3-point contact keys. The KPP is designed to simplify the software task
> +of scanning a keypad matrix. The KPP is capable of detecting, debouncing,
> +and decoding one or multiple keys pressed simultaneously on a keypad.
> +
> +Required SoC Specific Properties:
> +- compatible: Should be "fsl,imx-kpp".
> +
> +- reg: Physical base address of the KPP and length of memory mapped
> +  region.
> +
> +- interrupts: The KPP interrupt number to the CPU(s).
> +
> +- clocks: The clock provided by the SoC to the KPP. Some SoCs use ipg clock,
> +others use dummy clock(The clock for the KPP is provided by the SoCs
> +automatically).
> +
> +Required Board Specific Properties:
> +- pinctrl-names: The definition can be found at
> +pinctrl/pinctrl-bindings.txt.
> +
> +- pinctrl-0: The definition can be found at
> +pinctrl/pinctrl-bindings.txt.
> +
> +- linux,keymap: The definition can be found at
> +bindings/input/matrix-keymap.txt.
> +
> +Example:
> +kpp: kpp@73f94000 {
> +	compatible = "fsl,imx-kpp";
> +	reg = <0x73f94000 0x4000>;
> +	interrupts = <60>;
> +	clocks = <&clks 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_kpp_1>;
> +	linux,keymap = <0x00000067	/* KEY_UP */
> +			0x0001006c	/* KEY_DOWN */
> +			0x00020072	/* KEY_VOLUMEDOWN */
> +			0x00030066	/* KEY_HOME */
> +			0x0100006a	/* KEY_RIGHT */
> +			0x01010069	/* KEY_LEFT */
> +			0x0102001c	/* KEY_ENTER */
> +			0x01030073	/* KEY_VOLUMEUP */
> +			0x02000040	/* KEY_F6 */
> +			0x02010042	/* KEY_F8 */
> +			0x02020043	/* KEY_F9 */
> +			0x02030044	/* KEY_F10 */
> +			0x0300003b	/* KEY_F1 */
> +			0x0301003c	/* KEY_F2 */
> +			0x0302003d	/* KEY_F3 */
> +			0x03030074>;	/* KEY_POWER */
> +};
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index 6d150e3..e4f5c6a 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -20,6 +20,8 @@
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/timer.h>
> @@ -414,17 +416,76 @@ open_err:
>  	return -EIO;
>  }
>  
> +static struct of_device_id imx_keypad_of_match[] = {
> +	{ .compatible = "fsl,imx-kpp", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_keypad_of_match);
> +
> +#ifdef CONFIG_OF
> +static int imx_keypad_parse_dt(struct platform_device *pdev,
> +			       uint32_t *keymap, int *keymap_size)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	unsigned int proplen, i;
> +	const __be32 *prop;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	prop = of_get_property(np, "linux,keymap", &proplen);
> +	if (!prop) {
> +		dev_err(dev, "OF: linux,keymap property not defined in %s\n",
> +				np->full_name);
> +		return -ENOENT;
> +	}
> +
> +	if (proplen % sizeof(u32)) {
> +		dev_err(dev, "OF: Malformed keycode property in %s\n",
> +				np->full_name);
> +		return -EINVAL;
> +	}
> +
> +	*keymap_size = proplen / sizeof(u32);
> +	if (*keymap_size > MAX_MATRIX_KEY_NUM) {
> +		dev_err(dev, "OF: linux,keymap size overflow\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < *keymap_size; i++)
> +		keymap[i] = be32_to_cpup(prop + i);

All of this is implemented in matrix_keypad_build_keymap(), there is no
need to do it again here.

> +
> +	return 0;
> +}
> +#else
> +static inline int imx_keypad_parse_dt(struct platform_device *pdev,
> +				      uint32_t *keymap, int *keymap_size)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int imx_keypad_probe(struct platform_device *pdev)
>  {
>  	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
>  	struct imx_keypad *keypad;
>  	struct input_dev *input_dev;
>  	struct resource *res;
> -	int irq, error, i;
> +	int irq, error, i, keymap_size = 0;
> +	uint32_t keymap[MAX_MATRIX_KEY_NUM];
> +	struct pinctrl *pinctrl;
>  
> -	if (keymap_data == NULL) {
> -		dev_err(&pdev->dev, "no keymap defined\n");
> -		return -EINVAL;
> +	error = imx_keypad_parse_dt(pdev, keymap, &keymap_size);
> +	if (error) {
> +		if (keymap_data) {
> +			keymap_size = keymap_data->keymap_size;
> +			memcpy(keymap, keymap_data->keymap,
> +					keymap_size * sizeof(keymap[0]));

I believe kernel-provided platform data should take precedence over
DT-supplied data.

> +		} else {
> +			dev_err(&pdev->dev, "no keymap defined\n");
> +			return -EINVAL;
> +		}
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -473,6 +534,10 @@ static int imx_keypad_probe(struct platform_device *pdev)
>  		goto failed_free_priv;
>  	}
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev, "failed to get default pinctrl\n");
> +

No, please let core do this for you. Linus has a patch doing just that.

>  	keypad->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(keypad->clk)) {
>  		dev_err(&pdev->dev, "failed to get keypad clock\n");
> @@ -481,9 +546,9 @@ static int imx_keypad_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Search for rows and cols enabled */
> -	for (i = 0; i < keymap_data->keymap_size; i++) {
> -		keypad->rows_en_mask |= 1 << KEY_ROW(keymap_data->keymap[i]);
> -		keypad->cols_en_mask |= 1 << KEY_COL(keymap_data->keymap[i]);
> +	for (i = 0; i < keymap_size; i++) {
> +		keypad->rows_en_mask |= 1 << KEY_ROW(keymap[i]);
> +		keypad->cols_en_mask |= 1 << KEY_COL(keymap[i]);
>  	}
>  
>  	if (keypad->rows_en_mask > ((1 << MAX_MATRIX_KEY_ROWS) - 1) ||
> @@ -631,6 +696,7 @@ static struct platform_driver imx_keypad_driver = {
>  		.name	= "imx-keypad",
>  		.owner	= THIS_MODULE,
>  		.pm	= &imx_kbd_pm_ops,
> +		.of_match_table = of_match_ptr(imx_keypad_of_match),
>  	},
>  	.probe		= imx_keypad_probe,
>  	.remove		= imx_keypad_remove,
> -- 
> 1.7.1
> 
> 

Thanks.

-- 
Dmitry
