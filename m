From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH v6] Touchscreen driver for FT5x06 based EDT displays
Date: Mon, 25 Jun 2012 11:27:37 +0200
Message-ID: <4FE82F09.8020203@kernelconcepts.de>
References: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de> <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de> <1340408898-491-2-git-send-email-simon.budig@kernelconcepts.de> <20120625085113.GA648@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:55914 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab2FYJ1l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 05:27:41 -0400
In-Reply-To: <20120625085113.GA648@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Henrik.

On 06/25/2012 10:51 AM, Henrik Rydberg wrote:
>> [Sysfs files]
> 
> I would very much prefer if the driver functioned well without
> such settings, since they complicate userspace and are not likely
> to ever go away. Oh well.

I would prefer to have the touchscreen adjust itself as well,
unfortunately this is not available and you definitely need different
settings depending for different touch setups.

Would an ioctl() be more acceptable? Would make it harder to adjust it
in startup scripts etc. though.

>> +	if (error) { +		dev_err(&tsdata->client->dev, +			"Unable to
>> write to fetch data, error: %d\n", error); +		goto out; +	}
> 
> No risk of flooding the logs here? Perhaps rate-limit the outputs?

Hmm, possible. Can you point me to a driver that does this in a sane
fashion?

>> +	for (i = 0; i < MAX_SUPPORT_POINTS; i++) { +		u8 *buf =
>> &rdbuf[i * 4]; +		bool down; + +		type = buf[5] >> 6; +		/*
>> ignore Reserved events */ +		if (type == TOUCH_EVENT_RESERVED) +
>> continue;
> 
> As per the implementation by Olivier, it seems these touches may
> get stuck in the down position. No?

Not if you do the loop over all 5 event entries in the report. The
n_touches field really contains the number of fingers on the touch,
not the number of events in the report. Since the "down"-events
conveniently are sorted to the beginning of the report for the type A
protocol it was enough to to just iterate over these (we ignored the
UP-events anyway). Now that we need them we just iterate over all of
the events and there they are.

>> +	tsdata->threshold = edt_ft5x06_i2c_register_read(tsdata, +
>> WORK_REGISTER_THRESHOLD); +	tsdata->gain =
>> edt_ft5x06_i2c_register_read(tsdata, +						WORK_REGISTER_GAIN); 
>> +	tsdata->offset = edt_ft5x06_i2c_register_read(tsdata, +
>> WORK_REGISTER_OFFSET); +	tsdata->report_rate =
>> edt_ft5x06_i2c_register_read(tsdata, +
>> WORK_REGISTER_REPORT_RATE); +	tsdata->num_x =
>> edt_ft5x06_i2c_register_read(tsdata, +
>> WORK_REGISTER_NUM_X); +	tsdata->num_y =
>> edt_ft5x06_i2c_register_read(tsdata, +
>> WORK_REGISTER_NUM_Y); + +	dev_dbg(&client->dev, +		"Model \"%s\",
>> Rev. \"%s\", %dx%d sensors\n", +		tsdata->name, fw_version,
>> tsdata->num_x, tsdata->num_y); + +	input->name = tsdata->name; +
>> input->id.bustype = BUS_I2C; +	input->dev.parent = &client->dev; 
>> + +	__set_bit(EV_SYN, input->evbit); +	__set_bit(EV_KEY,
>> input->evbit); +	__set_bit(EV_ABS, input->evbit); +
>> __set_bit(BTN_TOUCH, input->keybit); +
>> input_set_abs_params(input, ABS_X, 0, tsdata->num_x * 64 - 1, 0,
>> 0); +	input_set_abs_params(input, ABS_Y, 0, tsdata->num_y * 64 -
>> 1, 0, 0); +	input_set_abs_params(input, ABS_MT_POSITION_X, +
>> 0, tsdata->num_x * 64 - 1, 0, 0); +	input_set_abs_params(input,
>> ABS_MT_POSITION_Y, +			     0, tsdata->num_y * 64 - 1, 0, 0); +
>> input_mt_init_slots(input, MAX_SUPPORT_POINTS);
> 
> No error checking here?

I guess you're referring to the _register_read()s? Yeah, they probably
could use some.

Thanks,
        Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/oLwkACgkQO2O/RXesiHCSHgCdHV7OHSfBVrePLL4F19j+MwvH
lkYAoIfI9X61yTWwG1AFcaGiJhefdShr
=wpmW
-----END PGP SIGNATURE-----
