From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] Touchscreen driver for FT5x06 based EDT displays
Date: Thu, 29 Sep 2011 17:46:25 +0200
Message-ID: <4E8492D1.10807@kernelconcepts.de>
References: <1317053189-29831-1-git-send-email-simon.budig@kernelconcepts.de> <1317053189-29831-2-git-send-email-simon.budig@kernelconcepts.de> <20110928054738.GB28341@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:42227 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab1I2Pq2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Sep 2011 11:46:28 -0400
In-Reply-To: <20110928054738.GB28341@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Dmitry

Thanks for your review. I used a lot of your hints.

Sorry, the patch was developed for an embedded platform which
unfortunately still is stuck on 2.6.38. I now have adapted the patch for
current GIT head, but I could not yet test it properly (for the lack of
the proper kernel for my testhardware). So the following patch should
probably be taken with a grain of salt.

On 09/28/2011 07:47 AM, Dmitry Torokhov wrote:
>> +	mutex_lock (&tsdata->mutex);
>> +	ret = edt_ft5x06_ts_readwrite (tsdata->client,
>> +	                               1, wrbuf,
>> +	                               sizeof (rdbuf), rdbuf);
> 
> i2c_transfer() already provides necessary locking on adapter level so
> several transfers would not race with each other. This locking seems
> excessive.

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

>> +			input_report_abs (tsdata->input, ABS_PRESSURE, 1);
> 
> If the device does not report true pressure readings please do not fake
> them. BTN_TOUCH alone should suffice.

Hum, ok. I need to check again, but at some point tslib had a problem
with a missing ABS_PRESSURE axis. Yeah, this would need fixing in tslib
obviously. Not sure what the current state of this problem is though.

>> +		input_report_abs (tsdata->input, ABS_MT_POSITION_X, ((rdbuf[i*4+5] << 8) | rdbuf[i*4+6]) & 0x0fff);
>> +		input_report_abs (tsdata->input, ABS_MT_POSITION_Y, ((rdbuf[i*4+7] << 8) | rdbuf[i*4+8]) & 0x0fff);
>> +		input_report_abs (tsdata->input, ABS_MT_TRACKING_ID, (rdbuf[i*4+7] >> 4) & 0x0f);
>> +		input_mt_sync (tsdata->input);
> 
> Any change to use stateful MT-B protocol here?

I will look into it. For now the application software expects MT-A,
although changing this shouldnt be too hard.

>> +	disable_irq (tsdata->irq);
> 
> Do you really need to disable IRQ here? We already established that
> i2c_transefr()s won't race.

I need to think about that. Not sure at the moment.

>> +	mutex_lock (&tsdata->mutex);
>> +
>> +	if (tsdata->factory_mode == 1) {
>> +		dev_err (dev, "setting register not available in factory mode\n");
> 
> You just left with mutex locked. Mutex is most likely not needed at all.

Oops, thanks.

>> +static ssize_t edt_ft5x06_i2c_raw_data_show (struct device *dev,
>> +                                             struct device_attribute *attr,
>> +                                             char *buf)
>> +{
>> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_get_drvdata (dev);
>> +	int i, ret;
>> +	char *ptr, wrbuf[3];
>> +
>> +	if (tsdata->factory_mode == 0) {
>> +		dev_err (dev, "raw data not available in work mode\n");
>> +		return -EIO;
>> +	}
>> +
>> +	mutex_lock (&tsdata->mutex);
>> +	ret = edt_ft5x06_i2c_register_write (tsdata, 0x08, 0x01);
>> +	for (i = 0; i < 100; i++) {
>> +		ret = edt_ft5x06_i2c_register_read (tsdata, 0x08);
>> +		if (ret < 1)
>> +			break;
>> +		udelay (1000);
>> +	}
>> +
>> +	if (i == 100 || ret < 0) {
>> +		dev_err (dev, "waiting time exceeded or error: %d\n", ret);
>> +		mutex_unlock (&tsdata->mutex);
>> +		return ret || ETIMEDOUT;
> 
> -ENOPARSE.

Ok, maybe this is written a bit convoluted.

I need to trigger the readout of the raw values (the register_write) and
then wait until the raw values have been prepared. That is the loop
which waits up to 100 msecs. The loop ends when the register_read either
returns an error (< 0) or the register value has changed to 0 (== 0).

If ret is < 0 (an error happened) or I ended up doing 100 iterations of
the loop (the timeout) I return either the error or ETIMEDOUT.

...at least that was the intention. I just realize there indeed is a
bug, the return statement is bogus. I have adressed this in the next
iteration.

>> +
>> +	return 0;
>> +
>> +err_free_irq:
>> +	free_irq (client->irq, tsdata);
>> +err_unregister_device:
>> +	input_unregister_device (input);
>> +err_free_input_device:
>> +	kfree (input->name);
>> +	input_free_device (input);
> 
> Calls to input_free_device() are prohibited after calling
> input_unregister_device().

Hmm, Ok. I missed that other modules set the input pointer to NULL in
their cleanup path.

I will change that, the updated patch follows soon.

Thanks,
        Simon
- -- 
       Simon Budig                        kernel concepts GbR
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6EktEACgkQO2O/RXesiHDWrgCfUb7hZ5v+Fs4/js92QfRGbj8o
aFQAn3MENdFAM503X1QE0dMppnnxrDQh
=EeeG
-----END PGP SIGNATURE-----
