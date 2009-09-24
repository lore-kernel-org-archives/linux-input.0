From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 1/2] Input: DaVinci Keypad Driver
Date: Thu, 24 Sep 2009 08:59:56 -0600
Message-ID: <4ABB896C.4010205@ridgerun.com>
References: <1253654850-11983-1-git-send-email-miguel.aguilar@ridgerun.com> <20090923034643.GB1458@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:43019 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbZIXO76 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2009 10:59:58 -0400
In-Reply-To: <20090923034643.GB1458@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

Dmitry,

I addressed your comments but I still have a couple of questions.


>> +CONFIG_KEYBOARD_DAVINCI_DM365=m
>>  # CONFIG_INPUT_MOUSE is not set
>>  # CONFIG_INPUT_JOYSTICK is not set
>>  # CONFIG_INPUT_TABLET is not set
> 
> 
> If you want to merge the driver through input tree the defconfig chunk
> has to go elsewhere.
[MA] Ok, independent patch.


>>  
>> +config KEYBOARD_DAVINCI
>> +	tristate "TI DaVinci Keypad"
>> +	depends on ARCH_DAVINCI_DM365
>> +	help
>> +	  Say Y to enable keypad module support for the TI DaVinci
>> +	  platforms (DM365)
>> +
> 
> "To compile this driver as a module..."
[MA] Comment added.


>> +		keycode = keymap[position];
>> +		if((new_status >> position) & 0x1) {
> 
> bool release = (new_status >> position) & 0x1;
> input_report_key(davinci_kp->input, keycode, !release);
> dev_dbg(dev, "davinci_keypad: key %d %s\n",
> 	keycode, release ? "released" : "pressed");
> 
> is shorter.
> 
>> +			/* Report release */
>> +			dev_dbg(dev, "davinci_keypad: key %d released\n",
>> +				    keycode);
>> +			input_report_key(davinci_kp->input, keycode, 0);
>> +		} else {
>> +			/* Report press */
>> +			dev_dbg(dev, "davinci_keypad: key %d pressed\n",
>> +				    keycode);
>> +			input_report_key(davinci_kp->input, keycode, 1);
>> +		}
>> +		input_sync(davinci_kp->input);
>> +		ret = IRQ_HANDLED;
>> +	}
>> +
>> +	/* Clearing interrupt */
>> +	davinci_kp_write(davinci_kp, DAVINCI_KEYPAD_INT_ALL, DAVINCI_KEYPAD_INTCLR);
> 
> You return IRQ_HANDLED only if keypad state changed but clear interrupt
> regardless. This is suspicious.
> 
>> +
>> +	/* Enable interrupts */
>> +	davinci_kp_write(davinci_kp, 0x1, DAVINCI_KEYPAD_INTENA);
>> +
>> +	return ret;
>> +}

[MA] This is the current irq function:
static irqreturn_t davinci_ks_interrupt(int irq, void *dev_id)
{
	struct davinci_ks *davinci_ks = dev_id;
	struct device *dev = &davinci_ks->input->dev;
	unsigned short *keymap = davinci_ks->keymap;
	u32 prev_status, new_status, changed, position;
	bool release;
	int keycode = KEY_UNKNOWN;
	int ret = IRQ_NONE;

	/* Disable interrupt */
	davinci_ks_write(davinci_ks, 0x0, DAVINCI_KEYSCAN_INTENA);

	/* Reading previous and new status of the key scan */
	prev_status = davinci_ks_read(davinci_ks, DAVINCI_KEYSCAN_PREVSTATE);
	new_status = davinci_ks_read(davinci_ks, DAVINCI_KEYSCAN_CURRENTST);

	changed = prev_status ^ new_status;
	position = ffs(changed) - 1;

	if (changed) {
		keycode = keymap[position];
		release = (new_status >> position) & 0x1;
		dev_dbg(dev, "davinci_keyscan: key %d %s\n",
		    keycode, release ? "released" : "pressed");

		input_report_key(davinci_ks->input, keycode, !release);
		input_sync(davinci_ks->input);

		/* Clearing interrupt */
		davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL,
				    DAVINCI_KEYSCAN_INTCLR);

		ret = IRQ_HANDLED;
	}

	/* Enable interrupts */
	davinci_ks_write(davinci_ks, 0x1, DAVINCI_KEYSCAN_INTENA);

	return ret;
}


>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "no mem resource\n");
>> +		ret = -ENODEV;
> 
> -EINVAL I'd say.
[MA] Ok. -EINVAL


>> +	key_dev->id.vendor = 0x0001;
>> +	key_dev->id.product = 0x0001;
>> +	key_dev->id.version = 0x0001;
>> +	key_dev->keycode = davinci_kp->pdata->keymap;
> 
> Please kopy keymap into the davinci_kp stucture and use it so that
> platform data is never changed and can be declared const.
> 
[MA] keymap copied to private data.

>> +	key_dev->keycodesize = sizeof(unsigned int);
> 
> sizeof(davinci_kp->keymap[0]) is safer. Plus make it unsigned short.
> 
[MA] Now it uses sizeof(davinci_kp->keymap[0])

>> +}
>> +
>> +static int __exit davinci_kp_remove(struct platform_device *pdev)
> 
> __devexit?
>

[MA] So, this will be __devexit


>> +static struct platform_driver davinci_kp_driver = {
>> +	.driver = {
>> +			.name = "davinci_keypad",
>> +			.owner = THIS_MODULE,
>> +		},
>> +	.remove = __exit_p(davinci_kp_remove),
> 
> __devexit_p(). I think you can still unbind the device even if you use
> platform_driver_probe.
> 
[MA] ... and __devexit.


>> +static int __init davinci_kp_init(void)
>> +{
>> +	return platform_driver_probe(&davinci_kp_driver, davinci_kp_probe);
>> +}
>> +module_init(davinci_kp_init);
[MA] Should I use platform_driver_probe?


>> +static void __exit davinci_kp_exit(void)
>> +{
>> +	platform_driver_unregister(&davinci_kp_driver);
>> +}
>> +module_exit(davinci_kp_exit);
[MA] Is the module exit function __exit or __devexit

Thanks,
Miguel Aguilar
