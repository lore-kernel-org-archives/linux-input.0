From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 4/6] input: misc: onkey: da9062: DA9062 OnKey driver
Date: Wed, 29 Apr 2015 15:18:48 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B217B29@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <c05802897197e71839a33b1f5ac224031b14e65b.1429280614.git.stwiss.opensource@diasemi.com>
 <20150417161217.GA27440@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.168]:47228 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753549AbbD2PYE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Apr 2015 11:24:04 -0400
In-Reply-To: <20150417161217.GA27440@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>

Hi Dmitry,

Thanks for your patience on this one.
The Dialog OnKey for DA9062 is a fairly complicated set of interrupts
and register read and writes. I've tried to explain the best I can below.

On  17 April 2015 17:12, Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] wrote: 

[...]

> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > index 403a1a5..a631283 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000_I2C)		+=
> cma3000_d0x_i2c.o
> >  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
> >  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
> >  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
> > +obj-$(CONFIG_INPUT_DA9062_ONKEY)	+= da9062-onkey.o
> 
> Can we maybe keep the same naming convention for all of these? Also, any
> chance all of them or some of them can be combined?

Yes. I will rename so it uses an underscore.

Unfortunately, the 55 and 52 drivers are not functionally similar. However the
DA9063 and DA9062 OnKey drivers *are* functionally similar and so I will make
an effort to combine those two drivers in future. I would like to submit DA9063
first and drop this DA9062 until I can combine it. However, since the DA9063 driver
is identical -- your comments will be useful for my DA9063 submission attempt.
I have added my replies here below which will also relate to DA9063.

[...]

> > +static void da9062_poll_on(struct work_struct *work)
> > +{
> > +	struct da9062_onkey *onkey = container_of(work, struct
> da9062_onkey,
> > +						  work.work);
> > +	unsigned int val;
> > +	int fault_log = 0;
> > +	bool poll = true;
> > +	int ret;
> > +
> > +	/* poll to see when the pin is released */
> > +	ret = regmap_read(onkey->hw->regmap, DA9062AA_STATUS_A,
> &val);
> > +	if (ret < 0) {
> > +		dev_err(&onkey->input->dev,
> > +			"Failed to read ON status: %d\n", ret);
> > +		goto err_poll;
> > +	}
> > +
> > +	if (!(val & DA9062AA_NONKEY_MASK)) {
> > +		ret = regmap_update_bits(onkey->hw->regmap,
> > +					 DA9062AA_CONTROL_B,
> > +					 DA9062AA_NONKEY_LOCK_MASK,
> 0);
> > +		if (ret < 0) {
> > +			dev_err(&onkey->input->dev,
> > +				"Failed to reset the Key Delay %d\n", ret);
> > +			goto err_poll;
> > +		}
> > +
> > +		input_report_key(onkey->input, KEY_POWER, 0);
> > +		input_sync(onkey->input);
> > +
> > +		poll = false;
> > +	}
> > +
> > +	/* if the fault log KEY_RESET is detected,
> > +	 * then clear it and shutdown DA9062 via I2C
> > +	 */
> > +	ret = regmap_read(onkey->hw->regmap, DA9062AA_FAULT_LOG,
> &fault_log);
> > +	if (ret < 0)
> > +		dev_warn(&onkey->input->dev, "Cannot read
> FAULT_LOG\n");
> > +
> > +	if (fault_log & DA9062AA_KEY_RESET_MASK) {
> > +		ret = regmap_write(onkey->hw->regmap,
> > +				   DA9062AA_FAULT_LOG,
> > +				   DA9062AA_KEY_RESET_MASK);
> > +		if (ret < 0)
> > +			dev_warn(&onkey->input->dev,
> > +				 "Cannot reset KEY_RESET fault log\n");
> > +		else {
> > +			/* at this point we do any S/W housekeeping
> > +			 * and then send shutdown command
> > +			 */
> > +			dev_info(&onkey->input->dev,
> > +				 "Sending SHUTDOWN to DA9062 ...\n");
> > +			ret = regmap_write(onkey->hw->regmap,
> > +					   DA9062AA_CONTROL_F,
> > +					   DA9062AA_SHUTDOWN_MASK);
> > +			if (ret < 0)
> > +				dev_err(&onkey->input->dev,
> > +					"Cannot SHUTDOWN DA9062\n");
> > +		}
> > +	}
> 
> This entire block seems to not belong to the input portion of MFD. Why
> do we do it here?
> 

There are four modes of OnKey operation here, but only the first three are handled
in software. This block relates to case (3).

(1) short press & release -- SLEEP
(2) long press & release -- POWER
(3) long-long press (no release) -- software power cut
(4) long-long press (no release) -- hardware power cut

For cases (1) and (2) the OnKey driver will handle the events using the Linux
framework. And for case (4) this is completed totally in hardware and is the
emergency power off for holding down the OnKey until the power is cut by
the PMIC -- this is not handled here and in any case it is designed to be used
when the software is not responding: H/W shutdown

There is one more case and this is covered by point (3). This is when the user
holds down the OnKey as though they were attempting an emergency power
off. This is the same operation as point (4) except that software *is* still
able to respond. At this point it sends the power off signal to the PMIC in a similar
way as the hardware power cut operation would do -- but it does this 1 second
before the hardware has chance to step-in and force the PMIC to go down.

There are several reasons for case (3).

 - It is to cover the usecase of a user pressing the OnKey until the device goes
   off as their main way of turning the power off to their device.
   This software power cut allows any critical house-keeping to be completed
   before the power switch is flicked and so it mitigates the possibility for loss 
   of any data.
 - It also ensures the FAULT_LOG is cleared. The FAULT_LOG is a persistent register
   in the PMIC and holds its information between resets -- in this case the reason the
   device was powered off.

In case (4)

If the software was not responsive, then the hardware shutdown would happen
1 second later and the FAULT_LOG would persist enough information to be able
to tell the difference between a software power cut and a hardware power cut
when the device was restarted. If the software had not responded, then due to
the FAULT_LOG persistence, it would be possible to take action the next time the
device was turned on again (maybe in the bootloader -- e.g. say to complete
memory checks or put the device into a safe mode).

> > +
> > +err_poll:
> > +	if (poll)
> > +		schedule_delayed_work(&onkey->work, 50);
> > +}
> > +
> > +static irqreturn_t da9062_onkey_irq_handler(int irq, void *data)
> > +{
> > +	struct da9062_onkey *onkey = data;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = regmap_read(onkey->hw->regmap, DA9062AA_STATUS_A,
> &val);
> > +	if (onkey->key_power && (ret >= 0) && (val &
> DA9062AA_NONKEY_MASK)) {
> > +		input_report_key(onkey->input, KEY_POWER, 1);
> > +		input_sync(onkey->input);
> > +		schedule_delayed_work(&onkey->work, 0);
> > +		dev_notice(&onkey->input->dev, "KEY_POWER
> pressed.\n");
> > +	} else {
> > +		input_report_key(onkey->input, KEY_SLEEP, 1);
> > +		input_sync(onkey->input);
> > +		input_report_key(onkey->input, KEY_SLEEP, 0);
> > +		input_sync(onkey->input);
> > +		dev_notice(&onkey->input->dev, "KEY_SLEEP pressed.\n");
> > +	}
> 
> Why do we handle KEY_POWER and KEY_SLEEP completely differently?
> 

The reason for the keys being handled differently is due to the way with the
interrupt is being triggered differently in the OnKey. This depends on whether
the key-press is a short (SLEEP) or a long (POWER) key-press. 

For case (1)
(1) short-press & release -- SLEEP
The *release* of the OnKey is the trigger of the interrupt. So we know the device
has a press-release operation. This was the intention of the two key reports, one
for press and the other for release. There is no way to detect the key press here,
only the key release, but both must have happened.
input_report_key(onkey->input, KEY_SLEEP, 1);
input_report_key(onkey->input, KEY_SLEEP, 0);

For the next case (2)
(2) long-press & release -- POWER
The key is pressed but not released for a period of time (say longer than 2 seconds),
and once this time-limit has been passed without the key being released an interrupt
is triggered. This is different to case (1) in that the key release was not the trigger
of the interrupt, it was a time-out trip-line -- hence the single key report, because at
this point we know that the key was pressed, just not released yet.
input_report_key(onkey->input, KEY_POWER, 1);
The second key report is triggered when the key is released, and this can only
be detected during a polling operation and examination of the register
DA9063_REG_STATUS_A. Once the key release is detected, then the second key report
is sent out
input_report_key(onkey->input, KEY_SLEEP, 0);
This last operation happens inside the da9063_poll_on() function.

It is this polling function that also detects for the key never being released and so is
also able to handle case (3)
(3) long-long press (no release) -- software power cut

[...]

> > +static int da9062_onkey_probe(struct platform_device *pdev)
> > +{
> > +	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
> > +	struct da9062_onkey *onkey;
> > +	bool kp_tmp = true;
> > +	int ret = 0;
> > +
> > +		kp_tmp = of_property_read_bool((&pdev->dev)->of_node,
> > +					       "dlg,disable-key-power");
> > +		kp_tmp = !kp_tmp;
> 
> Should we just allow specifying the keycode instead of hardcoding
> KEY_POWER/KEY_SLEEP?
> 

The reason I have hard-coded the key-power and key-sleep is because this
is the configuration written into the default PMIC one-time-programming
registers. Perhaps I am not quite understanding your question properly here.

[...]

> > +static int da9062_onkey_remove(struct platform_device *pdev)
> > +{
> > +	struct	da9062_onkey *onkey = platform_get_drvdata(pdev);
> > +
> > +	free_irq(onkey->irq, onkey);
> > +	cancel_delayed_work_sync(&onkey->work);
> > +	input_unregister_device(onkey->input);
> 	
> No need to unregister explicitly if you allocated input device with
> devm.
> 

Yep. I can alter this by removing the function input_unregister_device()
as described.

So, just to finish this off. I would like to reiterate that I am going to drop this patch
from my next submission attempt of the DA9062. However because the DA9063 
OnKey component is functionally identical, the comments from above will be
used to modify my DA9063 driver submission.

http://www.spinics.net/lists/linux-input/msg38034.html
http://www.spinics.net/lists/linux-input/msg38137.html

Regards,
Steve
