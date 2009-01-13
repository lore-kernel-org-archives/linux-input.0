From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.28-rc6-davinci1 5/6] dm355evm input driver
Date: Mon, 12 Jan 2009 22:13:01 -0800
Message-ID: <20090112220448.ZZRA012@mailhub.coreip.homeip.net>
References: <200812071159.50267.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:4903 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252AbZAMGNm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 01:13:42 -0500
Received: by qw-out-2122.google.com with SMTP id 3so10070764qwe.37
        for <linux-input@vger.kernel.org>; Mon, 12 Jan 2009 22:13:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200812071159.50267.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: davinci-linux-open-source@linux.davincidsp.com, Felipe Balbi <felipebalbi@users.sourceforge.net>, linux-input@vger.kernel.org

Hi David,

On Sun, Dec 07, 2008 at 11:59:50AM -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Simple input driver support for the events reported by the
> MSP430 firmware on the DM355 EVM.  Verified using the remote
> included with the kit; docs weren't quite right.  Some of
> the keycode selections might need improvement; I'm hoping
> I implemented the remapping support right, so there's at
> least a runtime workaround.
> 
> Keys on the remote seem to repeat undesirably.  Someone might
> want to see what's up with that, and fix it; it might just
> be an issue of tracking RC5 state and using the toggle.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Depends on the patch for the parent MFD driver, and won't work
> without the patch making GPIO IRQs work on dm355.
> 
> NOTE:  not suitable for mainline until the dm355evm board support
> (and parent MFD driver) is in the merge queue.
> 

It looks like the MFD driver was merged so we need to start wokring
on this one :)

> +		dev_dbg(&keys->pdev->dev,
> +			"input event 0x%04x--> keycode %d\n",
> +			event, keycode);
> +
> +		/* Report press + release ... we can't tell if
> +		 * this is an autorepeat, and we need to guess
> +		 * about the release.
> +		 */
> +		input_report_key(keys->input, keycode, 1);

input_sync() is also needed here.

> +		input_report_key(keys->input, keycode, 0);
> +	}
> +	input_sync(keys->input);
> +}
> +
> +static int dm355evm_setkeycode(struct input_dev *dev, int index, int keycode)
> +{
> +	if (index >= ARRAY_SIZE(dm355evm_keys))
> +		return -EINVAL;
> +
> +	dm355evm_keys[index].keycode = keycode;

You also need to alter dev->keybit to indicate that device may generate
new keycode, otherwise input core will drop event intead of passing it
on. Also I prefer devices that support remapping to keep their copy of
keymap so in unlikely case there are 2 devices in the system they can
have separate keymaps.

> +	return 0;
> +}
> +
> +static int dm355evm_getkeycode(struct input_dev *dev, int index, int *keycode)
> +{
> +	if (index >= ARRAY_SIZE(dm355evm_keys))
> +		return -EINVAL;
> +
> +	return dm355evm_keys[index].keycode;
> +}
> +
> +/*----------------------------------------------------------------------*/
> +
> +static int __devinit dm355evm_keys_probe(struct platform_device *pdev)
> +{
> +	struct dm355evm_keys	*keys;
> +	int			status = -ENOMEM;
> +	struct input_dev	*input;
> +	int			i;
> +
> +	/* allocate instance struct */
> +	keys = kzalloc(sizeof *keys, GFP_KERNEL);
> +	if (!keys)
> +		goto fail0;
> +	platform_set_drvdata(pdev, keys);
> +	keys->pdev = pdev;
> +
> +	/* ... and input dev ... */
> +	input = input_allocate_device();
> +	if (!input)
> +		goto fail0;
> +	keys->input = input;
> +	input_set_drvdata(input, keys);
> +
> +	input->name = "DM355 EVM Controls";
> +	input->phys = "dm355evm/input0";
> +	input->dev.parent = &pdev->dev;
> +
> +	input->id.bustype = BUS_I2C;
> +	input->id.product = 0x0355;
> +	input->id.version = dm355evm_msp_read(DM355EVM_MSP_FIRMREV);
> +
> +	input->evbit[0] = BIT(EV_KEY);
> +	for (i = 0; i < ARRAY_SIZE(dm355evm_keys); i++)
> +		set_bit(dm355evm_keys[i].keycode, input->keybit);
> +
> +	input->keycodemax = ARRAY_SIZE(dm355evm_keys);
> +	input->keycodesize = sizeof(dm355evm_keys[0]);

You don't need to setup keycodesize and keycodemax since you provide
your own get and set keycode helpers.

> +	input->keycode = dm355evm_keys;
> +	input->setkeycode = dm355evm_setkeycode;
> +	input->getkeycode = dm355evm_getkeycode;
> +
> +	/* set up "threaded IRQ handler" */
> +	status = platform_get_irq(pdev, 0);
> +	if (status < 0)
> +		goto fail1;
> +	keys->irq = status;
> +	INIT_WORK(&keys->work, dm355evm_keys_work);
> +
> +	/* REVISIT:  flush the event queue? */
> +
> +	/* register */
> +	status = input_register_device(input);
> +	if (status < 0)
> +		goto fail1;
> +
> +	/* start reporting events */
> +	status = request_irq(keys->irq, dm355evm_keys_irq,
> +			IRQF_TRIGGER_FALLING,
> +			dev_name(&pdev->dev), keys);
> +	if (status < 0) {
> +		input_unregister_device(input);
> +		goto fail1;

You should not call input_free_device() after input_unregister_device().
Either jump to "fail0" or do "input = NULL;".

> +	}
> +
> +	return 0;
> +
> +fail1:
> +	input_free_device(input);
> +fail0:
> +	kfree(keys);
> +	dev_err(&pdev->dev, "can't register, err %d\n", status);
> +	return status;
> +}
> +

-- 
Dmitry
