From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: samsung-keypad: Add device tree support
Date: Wed, 7 Sep 2011 13:50:32 -0700
Message-ID: <20110907205032.GA8265@core.coreip.homeip.net>
References: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
 <1315317317-21873-2-git-send-email-thomas.abraham@linaro.org>
 <1315317317-21873-3-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315317317-21873-3-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Thomas,

On Tue, Sep 06, 2011 at 07:25:17PM +0530, Thomas Abraham wrote:
>  static int samsung_keypad_is_s5pv210(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	enum samsung_keypad_type type =
> -		platform_get_device_id(pdev)->driver_data;
> +	enum samsung_keypad_type type;
>  
> +#ifdef CONFIG_OF
> +	if (dev->of_node)
> +		return of_device_is_compatible(dev->of_node,
> +				"samsung,s5pv210-keypad");
> +#endif
> +	type = platform_get_device_id(pdev)->driver_data;
>  	return type == KEYPAD_TYPE_S5PV210;

This function is called every time we scan keypad matrix, I do not think
you want to scan DT bindings here. You need to cache the device type at
probe time and use it.

>  }
>  
> @@ -235,6 +246,130 @@ static void samsung_keypad_close(struct input_dev *input_dev)
>  	samsung_keypad_stop(keypad);
>  }
>  
> +#ifdef CONFIG_OF
> +static
> +struct samsung_keypad_platdata *samsung_keypad_parse_dt(struct device *dev)
> +{
> +	struct samsung_keypad_platdata *pdata;
> +	struct matrix_keymap_data *keymap_data;
> +	uint32_t *keymap;
> +	struct device_node *np = dev->of_node, *key_np;
> +	unsigned int key_count = 0;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(dev, "could not allocate memory for platform data\n");
> +		return NULL;
> +	}

pdata is not used once probe() completes so it would be better to free
it and not rely on devm_* facilities to free it for you once device
unbinds from the driver.

> +
> +	of_property_read_u32(np, "samsung,keypad-num-rows", &pdata->rows);
> +	of_property_read_u32(np, "samsung,keypad-num-columns", &pdata->cols);
> +	if (!pdata->rows || !pdata->cols) {
> +		dev_err(dev, "number of keypad rows/columns not specified\n");
> +		return NULL;
> +	}
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
> +		unsigned int row, col, key_code;
> +		of_property_read_u32(key_np, "keypad,row", &row);
> +		of_property_read_u32(key_np, "keypad,column", &col);
> +		of_property_read_u32(key_np, "keypad,key-code", &key_code);
> +		*keymap++ = KEY(row, col, key_code);
> +	}

THis seems like generic mechanism that could be used by other drivers...
Maybe move into matrix-keypad.c? You would also not need to allocate
temporary buffer for intermediate keymap data.

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

I think we should bail out if one of the calls fails.

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
> +static void samsung_keypad_parse_dt_gpio(struct device_node *np,
> +		struct samsung_keypad *keypad, unsigned int rows,
> +		unsigned int cols)
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
> @@ -246,7 +381,10 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
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
> @@ -303,6 +441,9 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>  	keypad->cols = pdata->cols;
>  	init_waitqueue_head(&keypad->wait);
>  
> +	if (pdev->dev.of_node)
> +		samsung_keypad_parse_dt_gpio(&pdev->dev, keypad);
> +
>  	input_dev->name = pdev->name;
>  	input_dev->id.bustype = BUS_HOST;
>  	input_dev->dev.parent = &pdev->dev;
> @@ -349,6 +490,7 @@ err_free_irq:
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

Thanks.

-- 
Dmitry
