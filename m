From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add mpr121 capacitive touchkey driver
Date: Mon, 11 Apr 2011 23:18:25 -0700
Message-ID: <20110412061825.GC1854@core.coreip.homeip.net>
References: <1302541337-2934-1-git-send-email-kzjeef@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40835 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab1DLGSa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 02:18:30 -0400
Received: by iwn34 with SMTP id 34so6333426iwn.19
        for <linux-input@vger.kernel.org>; Mon, 11 Apr 2011 23:18:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302541337-2934-1-git-send-email-kzjeef@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiejing Zhang <kzjeef@gmail.com>
Cc: linux-input@vger.kernel.org, Zhang Jiejing <jiejing.zhang@freescale.com>

Hi Jiejing,

On Tue, Apr 12, 2011 at 01:02:17AM +0800, Jiejing Zhang wrote:
> From: Zhang Jiejing <jiejing.zhang@freescale.com>
> 
> This touchkey driver is based on Freescale mpr121 capacitive
> touch sensor controller.
> 
> It can support up to 12 keys, it use i2c interface.
> 
> The product infomation(data sheet, application notes) can
> be found under this link:
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPR121
> 

MOstly reasonable. In addition to Christoph's comments:

> +
> +static struct mpr121_init_register init_reg_table[] = {

const? And also __devinitconst?

> +	{MHD_RISING_ADDR,	0x1},
> +	{NHD_RISING_ADDR,	0x1},
> +	{MHD_FALLING_ADDR,	0x1},
> +	{NHD_FALLING_ADDR,	0x1},
> +	{NCL_FALLING_ADDR,	0xff},
> +	{FDL_FALLING_ADDR,	0x02},
> +	{FILTER_CONF_ADDR,	0x04},
> +	{AFE_CONF_ADDR,		0x0b},
> +	{AUTO_CONFIG_CTRL_ADDR, 0x0b},
> +};
> +
> +static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
> +{
> +	struct mpr121_touchkey_data *data = dev_id;
> +	struct i2c_client *client = data->client;
> +	struct input_dev *input = data->input_dev;
> +	unsigned int key_num, pressed;
> +	int reg;
> +
> +	reg = i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_1_ADDR);
> +	if (reg < 0) {
> +		dev_err(&client->dev, "i2c read error [%d]\n", reg);
> +		goto out;
> +	}
> +
> +	reg <<= 8;
> +	reg |= i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_0_ADDR);
> +	if (reg < 0) {
> +		dev_err(&client->dev, "i2c read error [%d]\n", reg);
> +		goto out;
> +	}
> +
> +	reg &= TOUCH_STATUS_MASK;
> +	/* use old press bit to figure out which bit changed */
> +	key_num = ffs(reg ^ data->statusbits) - 1;
> +	/* use the bit check the press status */
> +	pressed = (reg & (1 << (key_num))) >> key_num;

No need to shift by key_num, input_report_key normalizes to 'bool'.

> +	data->statusbits = reg;
> +	data->key_val = data->keycodes[key_num];
> +
> +	input_event(input, EV_MSC, MSC_SCAN, data->key_val);

sScancode is not data->key_val as it is KEY_XXX value but rather key_num.

> +	input_report_key(input, data->key_val, pressed);
> +	input_sync(input);
> +
> +	dev_dbg(&client->dev, "key %d %d %s\n", key_num, data->key_val,
> +		pressed ? "pressed" : "released");
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +static int mpr121_phys_init(

__devinit

			    struct mpr121_platform_data *pdata,

pdata should be const.

> +			    struct mpr121_touchkey_data *data,
> +			    struct i2c_client *client)
> +{
> +	struct mpr121_init_register *reg;
> +	unsigned char usl, lsl, tl;
> +	int i, t, vdd, ret;
> +
> +	/* setup touch/release threshold for ele0-ele11 */
> +	for (i = 0; i <= MPR121_MAX_KEY_COUNT; i++) {
> +		t = ELE0_TOUCH_THRESHOLD_ADDR + (i * 2);
> +		ret = i2c_smbus_write_byte_data(client, t, TOUCH_THRESHOLD);
> +		if (ret < 0)
> +			goto err_i2c_write;
> +		ret = i2c_smbus_write_byte_data(client, t + 1,
> +						RELEASE_THRESHOLD);
> +		if (ret < 0)
> +			goto err_i2c_write;
> +	}
> +	/* setup init register */
> +	for (i = 0; i < ARRAY_SIZE(init_reg_table); i++) {
> +		reg = &init_reg_table[i];
> +		ret = i2c_smbus_write_byte_data(client, reg->addr, reg->val);
> +		if (ret < 0)
> +			goto err_i2c_write;
> +	}
> +	/* setup auto-register by vdd,the formula please ref: AN3889
> +	 * These register *must* set acrodding your VDD voltage supply
> +	 * to the chip*/
> +	vdd = pdata->vdd_uv / 1000;
> +	usl = ((vdd - 700) * 256) / vdd;
> +	lsl = (usl * 65) / 100;
> +	tl = (usl * 90) / 100;
> +	ret = i2c_smbus_write_byte_data(client, AUTO_CONFIG_USL_ADDR, usl);
> +	ret |= i2c_smbus_write_byte_data(client, AUTO_CONFIG_LSL_ADDR, lsl);
> +	ret |= i2c_smbus_write_byte_data(client, AUTO_CONFIG_TL_ADDR, tl);
> +	ret |= i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
> +					data->keycount);
> +	if (ret != 0)
> +		goto err_i2c_write;
> +
> +	dev_info(&client->dev, "mpr121: config as enable %x of electrode.\n",
> +		 data->keycount);

Does it have to be dev_info? dev_dbg maybe?

> +
> +	return 0;
> +
> +err_i2c_write:
> +	dev_err(&client->dev, "i2c write error: %d\n", ret);
> +	return ret;
> +}
> +
> +static int __devinit mpr_touchkey_probe(struct i2c_client *client,
> +					const struct i2c_device_id *id)
> +{
> +	struct mpr121_platform_data *pdata;

const.

> +	struct mpr121_touchkey_data *data;
> +	struct input_dev *input_dev;
> +	int error;
> +	int i;
> +
> +	pdata = client->dev.platform_data;
> +	if (!pdata) {
> +		dev_err(&client->dev, "no platform data defined\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!client->irq) {
> +		dev_err(&client->dev, "The irq number should not be zero\n");
> +		return -EINVAL;
> +	}
> +
> +	data = kzalloc(sizeof(struct mpr121_touchkey_data), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!data || !input_dev) {
> +		dev_err(&client->dev, "Falied to allocate memory\n");
> +		error = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	data->client = client;
> +	data->input_dev = input_dev;
> +	data->keycount = pdata->keycount;
> +
> +	if (data->keycount > MPR121_MAX_KEY_COUNT) {
> +		dev_err(&client->dev, "Too many key defined\n");
> +		error = -EINVAL;
> +		goto err_free_mem;
> +	}
> +
> +	error = mpr121_phys_init(pdata, data, client);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to init register\n");
> +		goto err_free_mem;
> +	}
> +
> +	i2c_set_clientdata(client, data);

You should do this at the very end, before returning success (0).
Actually, you do do this, so just remove this instance.

> +
> +	input_dev->name = "FSL MPR121 Touchkey";
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = &client->dev;
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +	input_dev->keycode = pdata->matrix;

No, you are assigning pointer to the platform data, instead of pointer
to the data in device structure. That is why I'd rather you renamed
'struct mpr121_touchkey_data' to 'struct mpr121_touchkey' and 'data' to
'mpr121' so as to avoid confusion with platform data.

> +	input_dev->keycodesize = sizeof(pdata->matrix[0]);
> +	input_dev->keycodemax = data->keycount;
> +
> +	for (i = 0; i < input_dev->keycodemax; i++) {
> +		__set_bit(pdata->matrix[i], input_dev->keybit);
> +		data->keycodes[i] = pdata->matrix[i];
> +	}
> +
> +	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> +	input_set_drvdata(input_dev, data);
> +
> +	error = request_threaded_irq(client->irq, NULL,
> +				     mpr_touchkey_interrupt,
> +				     IRQF_TRIGGER_FALLING,
> +				     client->dev.driver->name, data);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to register interrupt\n");
> +		goto err_free_mem;
> +	}
> +
> +	error = input_register_device(input_dev);
> +	if (error)
> +		goto err_free_irq;
> +	i2c_set_clientdata(client, data);
> +	device_init_wakeup(&client->dev, pdata->wakeup);
> +	dev_info(&client->dev, "Mpr121 touch keyboard init success.\n");

No need for having this message. You can see the device bound to the
driver in sysfs. The boot is noisy enough.

> +	return 0;
> +
> +err_free_irq:
> +	free_irq(client->irq, data);
> +err_free_mem:
> +	input_free_device(input_dev);
> +	kfree(data);
> +	return error;
> +}
> +
> +static int __devexit mpr_touchkey_remove(struct i2c_client *client)
> +{
> +	struct mpr121_touchkey_data *data = i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, data);
> +	input_unregister_device(data->input_dev);
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mpr_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	if (device_may_wakeup(&client->dev))
> +		enable_irq_wake(client->irq);
> +
> +	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x00);
> +
> +	return 0;
> +}
> +
> +static int mpr_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mpr121_touchkey_data *data = i2c_get_clientdata(client);
> +
> +	if (device_may_wakeup(&client->dev))
> +		disable_irq_wake(client->irq);
> +
> +	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, data->keycount);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct i2c_device_id mpr121_id[] = {
> +	{"mpr121_touchkey", 0},
> +	{ }
> +};
> +
> +static SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_resume);
> +
> +static struct i2c_driver mpr_touchkey_driver = {
> +	.driver = {
> +		.name	= "mpr121",
> +		.owner	= THIS_MODULE,
> +		.pm	= &mpr121_touchkey_pm_ops,
> +	},
> +	.id_table	= mpr121_id,
> +	.probe		= mpr_touchkey_probe,
> +	.remove		= __devexit_p(mpr_touchkey_remove),
> +};
> +
> +static int __init mpr_touchkey_init(void)
> +{
> +	return i2c_add_driver(&mpr_touchkey_driver);
> +}
> +
> +static void __exit mpr_touchkey_exit(void)
> +{
> +	i2c_del_driver(&mpr_touchkey_driver);
> +}
> +
> +module_init(mpr_touchkey_init);
> +module_exit(mpr_touchkey_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhang Jiejing <jiejing.zhang@freescale.com>");
> +MODULE_DESCRIPTION("Touch Key driver for FSL MPR121 Chip");
> diff --git a/include/linux/i2c/mpr.h b/include/linux/i2c/mpr.h
> new file mode 100644
> index 0000000..52d6e33
> --- /dev/null
> +++ b/include/linux/i2c/mpr.h
> @@ -0,0 +1,64 @@
> +/* mpr.h - Header file for Freescale mpr121 capacitive touch sensor
> + * controllor */
> +
> +#ifndef MPR_H
> +#define MPR_H
> +
> +/* Register definitions */
> +#define ELE_TOUCH_STATUS_0_ADDR	0x0
> +#define ELE_TOUCH_STATUS_1_ADDR	0X1
> +#define MHD_RISING_ADDR		0x2b
> +#define NHD_RISING_ADDR		0x2c
> +#define NCL_RISING_ADDR		0x2d
> +#define FDL_RISING_ADDR		0x2e
> +#define MHD_FALLING_ADDR	0x2f
> +#define NHD_FALLING_ADDR	0x30
> +#define NCL_FALLING_ADDR	0x31
> +#define FDL_FALLING_ADDR	0x32
> +#define ELE0_TOUCH_THRESHOLD_ADDR	0x41
> +#define ELE0_RELEASE_THRESHOLD_ADDR	0x42
> +/* ELE0...ELE11's threshold will set in a loop */
> +#define AFE_CONF_ADDR			0x5c
> +#define FILTER_CONF_ADDR		0x5d
> +
> +/* ELECTRODE_CONF: this register is most important register, it
> + * control how many of electrode is enabled. If you set this register
> + * to 0x0, it make the sensor going to suspend mode. Other value(low
> + * bit is non-zero) will make the sensor into Run mode.  This register
> + * should be write at last.

Hmm, most of the comments require proper grammar. If you need help with
it - let the list know, we'll try to help.

> + */
> +#define ELECTRODE_CONF_ADDR		0x5e
> +#define AUTO_CONFIG_CTRL_ADDR		0x7b
> +/* AUTO_CONFIG_USL: Upper Limit for auto baseline search, this
> + * register is related to VDD supplied on your board, the value of
> + * this register is calc by EQ: `((VDD-0.7)/VDD) * 256`.
> + * AUTO_CONFIG_LSL: Low Limit of auto baseline search. This is 65% of
> + * USL AUTO_CONFIG_TL: The Traget Level of auto baseline search, This
> + * is 90% of USL  */
> +#define AUTO_CONFIG_USL_ADDR		0x7d
> +#define AUTO_CONFIG_LSL_ADDR		0x7e
> +#define AUTO_CONFIG_TL_ADDR		0x7f
> +
> +/* Threshold of touch/release trigger */
> +#define TOUCH_THRESHOLD			0x0f
> +#define RELEASE_THRESHOLD		0x0a
> +/* Mask Button bits of STATUS_0 & STATUS_1 register */
> +#define TOUCH_STATUS_MASK		0xfff
> +/* MPR121 have 12 electrodes */
> +#define MPR121_MAX_KEY_COUNT		12
> +
> +
> +/**
> + * @keycount: how many key maped
> + * @vdd_uv: voltage of vdd supply the chip in uV
> + * @matrix: maxtrix of keys
> + * @wakeup: can key wake up system.
> + */
> +struct mpr121_platform_data {
> +	u16 keycount;
> +	u16 *matrix;

If this device is indeed organized as a matrix (lookslike this) maybe
you should look at definitions provided by
include/linux/input/matrix_keypad.h

> +	int wakeup;

bool?

> +	int vdd_uv;
> +};
> +
> +#endif

Thanks.

-- 
Dmitry
