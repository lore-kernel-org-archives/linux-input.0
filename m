From: Fabien Marteau <fabien.marteau@armadeus.com>
Subject: Re: [PATCH] input: joystick:   Adding Austria Microsystem AS5011
 joystick driver (second version)
Date: Fri, 31 Dec 2010 12:38:07 +0100
Message-ID: <4D1DC09F.2030404@armadeus.com>
References: <4D1C60F1.5090305@armadeus.com> <4D1DACFF.9070504@codeaurora.org>
Reply-To: fabien.marteau@armadeus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D1DACFF.9070504@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Trilok,

> 
>> +	int ret;
>> +
>> +	mutex_lock(&plat_dat->button_lock);
>> +	ret = gpio_get_value(plat_dat->button_gpio);
>> +	if (ret)
>> +		input_report_key(plat_dat->input_dev, BTN_JOYSTICK, 0);
>> +	else
>> +		input_report_key(plat_dat->input_dev, BTN_JOYSTICK, 1);
>> +	input_sync(plat_dat->input_dev);
>> +	mutex_unlock(&plat_dat->button_lock);
> 
> Do you need this lock? Please explain.

If gpio_get_value() sleep, I need it to avoid race condition.

>> +static int as5011_i2c_write(struct i2c_client *client,
>> +			    uint8_t aRegAddr,
>> +			    uint8_t aValue)
>> +{
>> +	int ret;
>> +	uint8_t data[2] = { aRegAddr, aValue };
> 
> No CamelCases please. Please run scripts/checkpatch.pl on your patch before submission.

I had no warning for CamelCases name.

>> +static int __devinit as5011_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	struct as5011_platform_data *plat_dat = client->dev.platform_data;
>> +	int retval = 0;
>> +
>> +	plat_dat->num = g_num;
>> +	g_num++;
> 
> What is g_num++ and why it has to be global?

It's for interruptions name, if several as5011 joystick I set a number different for each joystick :

	scnprintf(plat_dat->button_irq_name,
		  SIZE_NAME,
		  "as5011_%d_button",
		  plat_dat->num);
> 
>> +
>> +	if (!i2c_check_functionality(client->adapter,
>> +				     I2C_FUNC_PROTOCOL_MANGLING)) {
> 
> Please explain why MANGLING required.

It's required for i2c register reading. To read register as5011 chip use this i2c frames :
	S Addr Rd [A] Register_addr [A] [Data] NA P
Wich is not conform to i2c protocol, i2c protocol require a repeated start to do that :
	S Addr Wr [A] Register_addr [A] S Addr Rd [Data] NA P

Then protocol mangling capability is required to avoid repeated start.


>> +	int (*init_gpio)(void); /* init interrupts gpios */
>> +	void (*exit_gpio)(void);/* exit gpios */
> 
> You should better do gpio_request/free etc, in the driver itself,
> and anyother thing can be left out in these hooks.

Yes, but on my platform, requesting gpio are specific. And I have to configure irq edge on initialization :
static int as5011_init_gpio(void)
{
	int ret;

	ret = mxc_gpio_setup_multiple_pins(as5011_pins0,
					   ARRAY_SIZE(as5011_pins0),
					   "AS5011_0");
	if (ret < 0) {
		goto as5011_gpio_setup_error;
	}
	set_irq_type(AS5011_INT_IRQ, IRQ_TYPE_EDGE_FALLING);
	set_irq_type(AS5011_BUTTON_IRQ, IRQ_TYPE_EDGE_BOTH);
	return ret;

	mxc_gpio_release_multiple_pins(as5011_pins0, ARRAY_SIZE(as5011_pins0));
as5011_gpio_setup_error:
	return ret;
}


> ---Trilok Soni
Thanks for the review.

--- Fabien Marteau
