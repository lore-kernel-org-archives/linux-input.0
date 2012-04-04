From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] Touchscreen driver for FT5x06 based EDT displays
Date: Wed, 04 Apr 2012 22:52:30 +0200
Message-ID: <4F7CB48E.9060305@kernelconcepts.de>
References: <1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de> <1333564079-23893-1-git-send-email-simon.budig@kernelconcepts.de> <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de> <20120404191043.GA11042@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:56195 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab2DDUwf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Apr 2012 16:52:35 -0400
In-Reply-To: <20120404191043.GA11042@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, agust@denx.de, yanok@emcraft.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Dmitry.

On 04/04/2012 09:10 PM, Dmitry Torokhov wrote:
> On Wed, Apr 04, 2012 at 08:27:59PM +0200, simon.budig@kernelconcepts.de wrote:
>> +		if (!have_abs) {
>> +			input_report_key(tsdata->input, BTN_TOUCH,    1);
>> +			input_report_abs(tsdata->input, ABS_PRESSURE, 1);
>> +			input_report_abs(tsdata->input, ABS_X,
>> +			                 ((rdbuf[i*4+5] << 8) |
>> +			                  rdbuf[i*4+6]) & 0x0fff);
>> +			input_report_abs(tsdata->input, ABS_Y,
>> +			                 ((rdbuf[i*4+7] << 8) |
>> +			                  rdbuf[i*4+8]) & 0x0fff);
>> +			have_abs = 1;
> 
> 
> The mt pointer emulation should do this for you.

Can you point me to some documentation on that? Do I need to enable this?

[...]

>> +	mutex_lock(&tsdata->mutex);
>> +
>> +	if (tsdata->factory_mode) {
>> +		dev_err(dev,
>> +		        "setting register not available in factory mode\n");
> 
> This will spam logs, just return error silently.

Hmm, the idea was to give the user a hint for an attempt to read the
attribute values in factory mode instead of just silently failing.

Where would be a proper place to document such device-specific behaviour?

[...]

> See if you could wrap an attribute into your own structure that will
> allow you to get to the address, field and limits without matching on
> attribute name.

will try.

>> +	mutex_lock(&tsdata->mutex);
> 
> Instead of taking mutex why don't you disable IRQ?

Does the Linux kernel guarantee that there is just one attribute access
at a time?

Otherwise:

The reason for this locking is two fold.

First, the touch sensor has two modes, a "operation mode" and a "factory
mode". The problem is, that the register numbering in the two modes is
mostly disjunct. I.e. reading the "gain" register in factory mode gives
a number, which has no real connection to the actual gain value. Since
the mode can be changed via a sysfs file I have a potential race
condition when e.g. concurrent access to the sysfs entries happen:

Lets say I want to read the gain value, while something else tries to
switch to factory mode.

1) edt_ft5x06_i2c_setting_show checks for factory_mode == 0
2) edt_ft5x06_i2c_mode_store changes factory_mode to 1
3) edt_ft5x06_i2c_setting_show reads register 0x30, reading and
returning a bogus value.

Also reading raw values is a series of i2c transactions (for each column
of the sensor) and I need to avoid at least a mode change inbetween.
That is the purpose of the mutex.

[...]
>> +static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
>> +                                   const struct i2c_device_id *id)
>> +{
>> +
>> +	struct edt_ft5x06_i2c_ts_data *tsdata;
>> +	struct edt_ft5x06_platform_data *pdata;
> 
> const.

What do you mean?

[..]
>> +	/* request IRQ pin */
>> +	tsdata->irq_pin = pdata->irq_pin;
>> +	tsdata->irq = gpio_to_irq(tsdata->irq_pin);
> 
> Take from the client.
[...]
> Should this GPIO configuration be done by the driver or by the board
> code that configures i2c client? I think latter is better.

I got conflicting opinions when I asked for advice on this last december
(before changing it to a pin-based configuration). Why do you think that
your suggestion is better?

>> +	mutex_lock(&tsdata->mutex);
> 
> Why are you taking this lock here?

Paranoia. I wanted to ensure that the controller stays in
non-factory-mode because I am about to read some configuration
registers- However, the attributes are probably not yet available to
userspace, so I can probably skip the mutex in _probe.

>> +	input->name = kstrdup(model_name, GFP_NOIO);
> 
> Why don't you just allocate a few bytes in tsdata structure instead of
> allocating and managing this separately. You'll also avoid race when
> freeing it.

Yeah, I guess that is simpler.

Thanks for the review.
        Simon
- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk98tI4ACgkQO2O/RXesiHAopwCfTnRzBEiFbN/tGcRl/TLBl7yR
KpwAn13Bzx+Q6Avj0edwwC+6qkPjAhfq
=Zg0q
-----END PGP SIGNATURE-----
