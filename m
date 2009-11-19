From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from Arnaud
	Patard.
Date: Thu, 19 Nov 2009 09:14:23 -0800
Message-ID: <20091119171423.GD15647@core.coreip.homeip.net>
References: <20091118232939.201290297@fluff.org.uk> <20091118232948.063635416@fluff.org.uk> <20091119025930.GA20172@core.coreip.homeip.net> <4B052D50.2070002@simtec.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B052D50.2070002@simtec.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: Simtec Linux Team <linux@simtec.co.uk>, linux-samsung-soc@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Nov 19, 2009 at 11:34:40AM +0000, Ben Dooks wrote:
> Dmitry Torokhov wrote:
>
>>> +
>>> +static char *s3c2410ts_name = "s3c2410 TouchScreen";

Btw, "static char s3c2410ts_name[]" will save you a pointer. But, it
looks like it is used only once, in probe(), so just put it there.

>>> +
>>> +/* Per-touchscreen data. */
>>> +
>>> +/**
>>> + * struct s3c2410ts - driver touchscreen state.
>>> + * @client: The ADC client we registered with the core driver.
>>> + * @dev: The device we are bound to.
>>> + * @input: The input device we registered with the input subsystem.
>>> + * @clock: The clock for the adc.
>>> + * @io: Pointer to the IO base.
>>> + * @xp: The accumulated X position data.
>>> + * @yp: The accumulated Y position data.
>>> + * @irq_tc: The interrupt number for pen up/down interrupt
>>> + * @count: The number of samples collected.
>>> + * @shift: The log2 of the maximum count to read in one go.
>>> + */
>>
>> These sructures are driver-internal and so don't need to be kernel-doc-ed.
>> Same goes for the driver-private functions.
>
> I like having the documentation, and I would much prefer to leave it
> in as useful.
>

Ah, I wasn't requiesting to remove the documentation, I was just saying
that since these data structures and fucntions are driver-provate they
don't need to use kernel-doc style.

>>> +
>>> +		input_report_key(ts.input, BTN_TOUCH, 1);
>>> +		input_report_abs(ts.input, ABS_PRESSURE, 1);
>>
>> No fake pressure events please, BTN_TOUCH should be enough.
>
> I'd have to check, IIRC tslib needs these to function properly.
>

Just update your tslib, the issue was fixed there last November.

>>> +{
>>> +	struct s3c2410_ts_mach_info *info;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct input_dev *input_dev;
>>> +	struct resource *res;
>>> +	int ret = -EINVAL;
>>
>> Can we call it "error" (since that's what you use it for).
>
> Is it really necessary to change this?
>

No, it is my personal preference/style. In case when it is used like:

	var = blah();
	if (var)
		goto err_unblah;

	return 0;

err_unblah:
	unblah();
	return var;
}

I prefer that var called 'error'. If the value is returned on both error
and success paths then I call it 'ret', 'retval', etc.

But no, if you prefer 'ret' that is fine too.

>>
>>> +	.suspend	= s3c2410ts_suspend,
>>> +	.resume		= s3c2410ts_resume,
>>
>> Switch to pm_ops.
>
> ok, will do. may as well remove the #ifdef CONFIG_PM
> for such small amount of code too.
>

As long as it does not break when CONFIG_PM is not set...

-- 
Dmitry
