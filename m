From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 2/2] input: samsung-keypad: Add device tree support
Date: Thu, 22 Sep 2011 11:40:54 -0600
Message-ID: <20110922174054.GO17168@ponder.secretlab.ca>
References: <1316427553-5033-1-git-send-email-thomas.abraham@linaro.org>
 <1316427553-5033-3-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1316427553-5033-3-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

On Mon, Sep 19, 2011 at 03:49:13PM +0530, Thomas Abraham wrote:
> Add device tree based discovery support for Samsung's keypad controller.
> 
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

A few things to fix below, but you can add my acked-by when you've
addressed them.

> ---
>  .../devicetree/bindings/input/samsung-keypad.txt   |   88 ++++++++++
>  drivers/input/keyboard/samsung-keypad.c            |  179 ++++++++++++++++++--
>  2 files changed, 255 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/samsung-keypad.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/samsung-keypad.txt b/Documentation/devicetree/bindings/input/samsung-keypad.txt
> new file mode 100644
> index 0000000..ce3e394
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/samsung-keypad.txt
> @@ -0,0 +1,88 @@
> +* Samsung's Keypad Controller device tree bindings
> +
> +Samsung's Keypad controller is used to interface a SoC with a matrix-type
> +keypad device. The keypad controller supports multiple row and column lines.
> +A key can be placed at each intersection of a unique row and a unique column.
> +The keypad controller can sense a key-press and key-release and report the
> +event using a interrupt to the cpu.
> +
> +Required SoC Specific Properties:
> +- compatible: should be one of the following
> +  - "samsung,s3c6410-keypad": For controllers compatible with s3c6410 keypad
> +    controller.
> +  - "samsung,s5pv210-keypad": For controllers compatible with s5pv210 keypad
> +    controller.
> +
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +- interrupts: The interrupt number to the cpu.
> +
> +Required Board Specific Properties:
> +- samsung,keypad-num-rows: Number of row lines connected to the keypad
> +  controller.
> +
> +- samsung,keypad-num-columns: Number of column lines connected to the
> +  keypad controller.
> +
> +- row-gpios: List of gpios used as row lines. The gpio specifier for
> +  this property depends on the gpio controller to which these row lines
> +  are connected.
> +
> +- col-gpios: List of gpios used as column lines. The gpio specifier for
> +  this property depends on the gpio controller to which these column
> +  lines are connected.
> +
> +- Keys represented as child nodes: Each key connected to the keypad
> +  controller is represented as a child node to the keypad controller
> +  device node and should include the following properties.
> +  - keypad,row: the row number to which the key is connected.
> +  - keypad,column: the column number to which the key is connected.
> +  - linux,code: the key-code to be reported when the key is pressed
> +    and released.
> +
> +Optional Properties specific to linux:
> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
> +- linux,keypad-wakeup: use any event on keypad as wakeup event.
> +
> +
> +Example:
> +	keypad@100A0000 {
> +		compatible = "samsung,s5pv210-keypad";
> +		reg = <0x100A0000 0x100>;
> +		interrupts = <173>;
> +		samsung,keypad-num-rows = <2>;
> +		samsung,keypad-num-columns = <8>;
> +		linux,input-no-autorepeat;
> +		linux,input-wakeup;
> +
> +		row-gpios = <&gpx2 0 3 3 0
> +			     &gpx2 1 3 3 0>;
> +
> +		col-gpios = <&gpx1 0 3 0 0
> +			     &gpx1 1 3 0 0
> +			     &gpx1 2 3 0 0
> +			     &gpx1 3 3 0 0
> +			     &gpx1 4 3 0 0
> +			     &gpx1 5 3 0 0
> +			     &gpx1 6 3 0 0
> +			     &gpx1 7 3 0 0>;
> +
> +		key_1 {
> +			keypad,row = <0>;
> +			keypad,column = <3>;
> +			linux,code = <2>;
> +		};
> +
> +		key_2 {
> +			keypad,row = <0>;
> +			keypad,column = <4>;
> +			linux,code = <3>;
> +		};
> +
> +		key_3 {
> +			keypad,row = <0>;
> +			keypad,column = <5>;
> +			linux,code = <4>;
> +		};
> +	};

Binding looks okay to me.

> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
> index f689f49..2a477bc 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -21,6 +21,8 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/sched.h>
>  #include <plat/keypad.h>
>  
> @@ -68,31 +70,26 @@ struct samsung_keypad {
>  	wait_queue_head_t wait;
>  	bool stopped;
>  	int irq;
> +	enum samsung_keypad_type type;
>  	unsigned int row_shift;
>  	unsigned int rows;
>  	unsigned int cols;
>  	unsigned int row_state[SAMSUNG_MAX_COLS];
> +#ifdef CONFIG_OF
> +	int row_gpios[SAMSUNG_MAX_ROWS];
> +	int col_gpios[SAMSUNG_MAX_COLS];
> +#endif
>  	unsigned short keycodes[];
>  };
>  
> -static int samsung_keypad_is_s5pv210(struct device *dev)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	enum samsung_keypad_type type =
> -		platform_get_device_id(pdev)->driver_data;
> -
> -	return type == KEYPAD_TYPE_S5PV210;
> -}
> -
>  static void samsung_keypad_scan(struct samsung_keypad *keypad,
>  				unsigned int *row_state)
>  {
> -	struct device *dev = keypad->input_dev->dev.parent;
>  	unsigned int col;
>  	unsigned int val;
>  
>  	for (col = 0; col < keypad->cols; col++) {
> -		if (samsung_keypad_is_s5pv210(dev)) {
> +		if (keypad->type == KEYPAD_TYPE_S5PV210) {
>  			val = S5PV210_KEYIFCOLEN_MASK;
>  			val &= ~(1 << col) << 8;
>  		} else {
> @@ -235,6 +232,131 @@ static void samsung_keypad_close(struct input_dev *input_dev)
>  	samsung_keypad_stop(keypad);
>  }
>  
> +#ifdef CONFIG_OF
> +static struct samsung_keypad_platdata *samsung_keypad_parse_dt(
> +				struct device *dev)
> +{
> +	struct samsung_keypad_platdata *pdata;
> +	struct matrix_keymap_data *keymap_data;
> +	uint32_t *keymap, num_rows, num_cols;
> +	struct device_node *np = dev->of_node, *key_np;
> +	unsigned int key_count = 0;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(dev, "could not allocate memory for platform data\n");
> +		return NULL;
> +	}
> +
> +	of_property_read_u32(np, "samsung,keypad-num-rows", &num_rows);
> +	of_property_read_u32(np, "samsung,keypad-num-columns", &num_cols);

property_read doesn't touch the values of num_rows or num_cols on
failure.  The values need to be initialized if you're going to test
the result value.

> +	if (!num_rows || !num_cols) {
> +		dev_err(dev, "number of keypad rows/columns not specified\n");
> +		return NULL;
> +	}
> +	pdata->rows = num_rows;
> +	pdata->cols = num_cols;
> +
> +	keymap_data = devm_kzalloc(dev, sizeof(*keymap_data), GFP_KERNEL);
> +	if (!keymap_data) {
> +		dev_err(dev, "could not allocate memory for keymap data\n");
> +		return NULL;
> +	}
> +	pdata->keymap_data = keymap_data;
> +
> +	for_each_child_of_node(np, key_np)
> +		key_count++;
> +
> +	keymap_data->keymap_size = key_count;
> +	keymap = devm_kzalloc(dev, sizeof(uint32_t) * key_count, GFP_KERNEL);
> +	if (!keymap) {
> +		dev_err(dev, "could not allocate memory for keymap\n");
> +		return NULL;
> +	}
> +	keymap_data->keymap = keymap;
> +
> +	for_each_child_of_node(np, key_np) {
> +		u32 row, col, key_code;
> +		of_property_read_u32(key_np, "keypad,row", &row);
> +		of_property_read_u32(key_np, "keypad,column", &col);
> +		of_property_read_u32(key_np, "linux,code", &key_code);
> +		*keymap++ = KEY(row, col, key_code);
> +	}
> +
> +	if (of_get_property(np, "linux,input-no-autorepeat", NULL))
> +		pdata->no_autorepeat = true;
> +	if (of_get_property(np, "linux,input-wakeup", NULL))
> +		pdata->wakeup = true;
> +
> +	return pdata;
> +}
> +
> +static void samsung_keypad_parse_dt_gpio(struct device *dev,
> +				struct samsung_keypad *keypad)
> +{
> +	struct device_node *np = dev->of_node;
> +	int gpio, ret, row, col;
> +
> +	for (row = 0; row < keypad->rows; row++) {
> +		gpio = of_get_named_gpio(np, "row-gpios", row);
> +		keypad->row_gpios[row] = gpio;
> +		if (!gpio_is_valid(gpio)) {
> +			dev_err(dev, "keypad row[%d]: invalid gpio %d\n",
> +					row, gpio);
> +			continue;
> +		}
> +
> +		ret = gpio_request(gpio, "keypad-row");
> +		if (ret)
> +			dev_err(dev, "keypad row[%d] gpio request failed\n",
> +					row);
> +	}
> +
> +	for (col = 0; col < keypad->cols; col++) {
> +		gpio = of_get_named_gpio(np, "col-gpios", col);
> +		keypad->col_gpios[col] = gpio;
> +		if (!gpio_is_valid(gpio)) {
> +			dev_err(dev, "keypad column[%d]: invalid gpio %d\n",
> +					col, gpio);
> +			continue;
> +		}
> +
> +		ret = gpio_request(col, "keypad-col");
> +		if (ret)
> +			dev_err(dev, "keypad column[%d] gpio request failed\n",
> +					col);
> +	}
> +}
> +
> +static void samsung_keypad_dt_gpio_free(struct samsung_keypad *keypad)
> +{
> +	int cnt;
> +
> +	for (cnt = 0; cnt < keypad->rows; cnt++)
> +		if (gpio_is_valid(keypad->row_gpios[cnt]))
> +			gpio_free(keypad->row_gpios[cnt]);
> +
> +	for (cnt = 0; cnt < keypad->cols; cnt++)
> +		if (gpio_is_valid(keypad->col_gpios[cnt]))
> +			gpio_free(keypad->col_gpios[cnt]);
> +}
> +#else
> +static
> +struct samsung_keypad_platdata *samsung_keypad_parse_dt(struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +static void samsung_keypad_parse_dt_gpio(struct device *dev,
> +				struct samsung_keypad *keypad)
> +{
> +}
> +
> +static void samsung_keypad_dt_gpio_free(struct samsung_keypad *keypad)
> +{
> +}
> +#endif
> +
>  static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>  {
>  	const struct samsung_keypad_platdata *pdata;
> @@ -246,7 +368,10 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>  	unsigned int keymap_size;
>  	int error;
>  
> -	pdata = pdev->dev.platform_data;
> +	if (pdev->dev.of_node)
> +		pdata = samsung_keypad_parse_dt(&pdev->dev);
> +	else
> +		pdata = pdev->dev.platform_data;
>  	if (!pdata) {
>  		dev_err(&pdev->dev, "no platform data defined\n");
>  		return -EINVAL;
> @@ -303,6 +428,16 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>  	keypad->cols = pdata->cols;
>  	init_waitqueue_head(&keypad->wait);
>  
> +	if (pdev->dev.of_node) {
> +		samsung_keypad_parse_dt_gpio(&pdev->dev, keypad);
> +#ifdef CONFIG_OF
> +		keypad->type = of_device_is_compatible(pdev->dev.of_node,
> +					"samsung,s5pv210-keypad");
> +#endif

This still looks odd.  If you move the #ifdef up one line, then you
can remove the empty version of samsung_keypad_parse_dt_gpio(), and
this block won't look so weird.

> +	} else {
> +		keypad->type = platform_get_device_id(pdev)->driver_data;
> +	}
> +
>  	input_dev->name = pdev->name;
>  	input_dev->id.bustype = BUS_HOST;
>  	input_dev->dev.parent = &pdev->dev;
> @@ -343,12 +478,19 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>  
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);
>  	platform_set_drvdata(pdev, keypad);
> +
> +	if (pdev->dev.of_node) {
> +		devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
> +		devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
> +		devm_kfree(&pdev->dev, (void *)pdata);
> +	}
>  	return 0;
>  
>  err_free_irq:
>  	free_irq(keypad->irq, keypad);
>  err_put_clk:
>  	clk_put(keypad->clk);
> +	samsung_keypad_dt_gpio_free(keypad);
>  err_unmap_base:
>  	iounmap(keypad->base);
>  err_free_mem:
> @@ -374,6 +516,7 @@ static int __devexit samsung_keypad_remove(struct platform_device *pdev)
>  	free_irq(keypad->irq, keypad);
>  
>  	clk_put(keypad->clk);
> +	samsung_keypad_dt_gpio_free(keypad);
>  
>  	iounmap(keypad->base);
>  	kfree(keypad);
> @@ -447,6 +590,17 @@ static const struct dev_pm_ops samsung_keypad_pm_ops = {
>  };
>  #endif
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id samsung_keypad_dt_match[] = {
> +	{ .compatible = "samsung,s3c6410-keypad" },
> +	{ .compatible = "samsung,s5pv210-keypad" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, samsung_keypad_dt_match);
> +#else
> +#define samsung_keypad_dt_match NULL
> +#endif
> +
>  static struct platform_device_id samsung_keypad_driver_ids[] = {
>  	{
>  		.name		= "samsung-keypad",
> @@ -465,6 +619,7 @@ static struct platform_driver samsung_keypad_driver = {
>  	.driver		= {
>  		.name	= "samsung-keypad",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = samsung_keypad_dt_match,
>  #ifdef CONFIG_PM
>  		.pm	= &samsung_keypad_pm_ops,
>  #endif
> -- 
> 1.6.6.rc2
> 
