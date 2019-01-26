From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] Input: st1232 - add support for st1633
Date: Fri, 25 Jan 2019 16:55:36 -0800
Message-ID: <20190126005536.GA212026@dtor-ws>
References: <20190124102125.25458-1-martink@posteo.de>
 <20190124102125.25458-2-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124102125.25458-2-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, chinyeow.sim.xt@renesas.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

Hi Martin,

On Thu, Jan 24, 2019 at 11:21:25AM +0100, Martin Kepplinger wrote:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> Add support for the Sitronix ST1633 touchscreen controller to the st1232
> driver. A protocol spec can be found here:
> www.ampdisplay.com/documents/pdf/AM-320480B6TZQW-TC0H.pdf
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> while this works, I'm not totally convinced by how the i2c path of probe
> looks. what do you say?

Not quite what I had in mind. See below...

>  static int st1232_ts_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
>  	struct st1232_ts_data *ts;
> +	struct st1232_ts_finger *finger;
>  	struct input_dev *input_dev;
>  	int error;
> +	const struct st_chip_info *match = NULL;
> +
> +	if (dev_fwnode(&client->dev))
> +		match = device_get_match_data(&client->dev);
> +	else if (id && id->driver_data == st1232)
> +		match = &st1232_chip_info;
> +	else if (id && id->driver_data == st1633)
> +		match = &st1633_chip_info;
> +	if (!match) {
> +		dev_err(&client->dev, "unknown device model\n");
> +		return -ENODEV;
> +	}

If you do:

static const struct i2c_device_id st1232_ts_id[] = {
	{ ST1232_TS_NAME, (unsigned long)&st1232_chip_info },
	{ ST1633_TS_NAME, (unsigned long)&st1633_chip_info },
	{ }
};


Then you can do:

	match = device_get_match_data(&client->dev);
	if (!match && id)
		match = (const void *)id->driver_data;
	if (!match) {
		dev_err(&client->dev, "unknown device model\n");
		return -ENODEV;
	}

Thanks.

-- 
Dmitry
