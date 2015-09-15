From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v5 3/9] Input: goodix - reset device at init
Date: Tue, 15 Sep 2015 14:27:04 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0CD269@irsmsx105.ger.corp.intel.com>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
	<1441636583-14188-4-git-send-email-irina.tirdea@intel.com>
 <20150915124817.8c53e274e178800edc5767bf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150915124817.8c53e274e178800edc5767bf@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Aleksei Mamlin [mailto:mamlinav@gmail.com]
> Sent: 15 September, 2015 12:48
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 3/9] Input: goodix - reset device at init
> 
> On Mon,  7 Sep 2015 17:36:17 +0300
> Irina Tirdea <irina.tirdea@intel.com> wrote:
> 
> > After power on, it is recommended that the driver resets the device.
> > The reset procedure timing is described in the datasheet and is used
> > at device init (before writing device configuration) and
> > for power management. It is a sequence of setting the interrupt
> > and reset pins high/low at specific timing intervals. This procedure
> > also includes setting the slave address to the one specified in the
> > ACPI/device tree.
> >
> > This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> > driver gt9xx.c for Android (publicly available in Android kernel
> > trees for various devices).
> >
> > For reset the driver needs to control the interrupt and
> > reset gpio pins (configured through ACPI/device tree). For devices
> > that do not have the gpio pins declared, the functionality depending
> > on these pins will not be available, but the device can still be used
> > with basic functionality.
> >
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > ---
> >  .../bindings/input/touchscreen/goodix.txt          |   5 +
> >  drivers/input/touchscreen/goodix.c                 | 136 +++++++++++++++++++++
> >  2 files changed, 141 insertions(+)
> >
<snip>
> > +/**
> > + * goodix_reset - Reset device during power on
> > + *
> > + * @ts: goodix_ts_data pointer
> > + */
> > +static int goodix_reset(struct goodix_ts_data *ts)
> > +{
> > +	int error;
> > +
> > +	/* begin select I2C slave addr */
> > +	error = gpiod_direction_output(ts->gpiod_rst, 0);
> > +	if (error)
> > +		return error;
> > +	msleep(20);				/* T2: > 10ms */
> > +	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
> > +	error = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
> > +	if (error)
> > +		return error;
> > +	usleep_range(100, 2000);		/* T3: > 100us */
> > +	error = gpiod_direction_output(ts->gpiod_rst, 1);
> > +	if (error)
> > +		return error;
> > +	usleep_range(6000, 10000);		/* T4: > 5ms */
> > +	/* end select I2C slave addr */
> > +	error = gpiod_direction_input(ts->gpiod_rst);
> > +	if (error)
> > +		return error;
> > +	return goodix_int_sync(ts);
> > +}
> > +
<snip>
> >  /**
> >   * goodix_read_config - Read the embedded configuration of the panel
> >   *
> > @@ -419,6 +542,19 @@ static int goodix_ts_probe(struct i2c_client *client,
> >
> >  	ts->cfg_len = goodix_get_cfg_len(id_info);
> >
> > +	error = goodix_get_gpio_config(ts, id);
> > +	if (error)
> > +		return error;
> > +
> > +	if (ts->gpiod_int && ts->gpiod_rst) {
> > +		/* reset the controller */
> > +		error = goodix_reset(ts);
> > +		if (error) {
> > +			dev_err(&client->dev, "Controller reset failed.\n");
> > +			return error;
> > +		}
> > +	}
> > +
> 
> On devices with devicetree, such as ARM tablets, we can set I2C address via DT, so driver should reset controller and set right address.
> If we don't do this we get "I2C communication failure: -6".
>

This is exactly what this patch tries to do. The address set in ACPI or DT will be available
in ts->client->addr. The reset code checks for the address set by ACPI/DT and configures
the device to use that address.
 
> Also, most of touchscreen drivers tries to reset controllers before start communicating, so we need do the same.

Good catch! goodix_reset should be called before goodix_i2c_test. I'll send a new version with this fix.

Thanks,
Irina

> 
> >  	goodix_read_config(ts);
> >
> >  	error = goodix_request_input_dev(ts, version_info, id_info);
> > --
> > 1.9.1
> >
> 
> 
> --
> Thanks and regards,
> Aleksei Mamlin
