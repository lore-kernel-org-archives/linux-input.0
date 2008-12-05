From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] tsc2007 based touchscreen driver.(corrected)
Date: Fri, 5 Dec 2008 13:03:02 +0200
Message-ID: <20081205110302.GC6445@gandalf.research.nokia.com>
References: <483a38b80812042045n49bc6dc2pd0998813c0cef2f1@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33738 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbYLELDi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Dec 2008 06:03:38 -0500
Content-Disposition: inline
In-Reply-To: <483a38b80812042045n49bc6dc2pd0998813c0cef2f1@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com

On Fri, Dec 05, 2008 at 01:45:30PM +0900, ext Kwangwoo Lee wrote:
> +static int tsc2007_xfer(void *tsc, unsigned char cmd)
> +{
> +	struct tsc2007    *ts     = tsc;
> +	struct i2c_client *client = ts->client;
> +	s32 data;
> +	u16 val;
> +
> +	data = i2c_smbus_read_word_data(client, cmd);
> +	if (data < 0) {
> +		dev_err(&client->dev, "I2C IO error: %d\n", data);
> +		return data;
> +	}
> +
> +	val = (u16) (data & 0xFFFF);
> +	val = be16_to_cpu(val) >> 4;

this chip really uses bigendian ??

> +
> +	dev_dbg(&client->dev, "data: 0x%x, val: 0x%x\n", data, val);
> +
> +	return (int) val;
> +}

normally you would:

static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
{
	s32 data;
	u16 val;

	data = i2c_smbuc_read_word_data(tsc->client, cmd);
	if (data < 0) {
		dev_err(&tsc->client->dev, "i2c io error: %d\n", data);
		return data;
	}

	val = (u16) (data & 0xffff);
	val = be16_to_cpu(val) >> 4;

	return val;
}

> +static void tsc2007_send_event(void *tsc)
> +{
> +	struct tsc2007	*ts = tsc;
> +	u32		Rt;

no CaMeLcAsE, please.

> +static int tsc2007_read_values(struct tsc2007 *tsc)
> +{
> +	struct tsc2007	*ts = tsc;

why ?? You already have the reference as the argument, use it in the
funcion.

> +static int tsc2007_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct tsc2007		*ts;
> +	struct tsc2007_platform_data *pdata;
> +	struct input_dev	*input_dev;
> +	int			err;
> +
> +	pdata = client->dev.platform_data;
> +	if (pdata == NULL) {
> +		dev_err(&client->dev, "platform data is required!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!i2c_check_functionality(client->adapter,
> +		I2C_FUNC_SMBUS_READ_WORD_DATA))
> +		return -EIO;
> +
> +	ts = kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!ts || !input_dev) {
> +		err = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	ts->client = client;
> +	i2c_set_clientdata(client, ts);
> +
> +	ts->input = input_dev;
> +
> +	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ts->timer.function = tsc2007_timer;
> +
> +	spin_lock_init(&ts->lock);
> +
> +	ts->model 	      = pdata->model;
                 ^ trailing whitespace

> +static struct i2c_driver tsc2007_driver = {
> +	.driver 	= {
               ^ trailing whitespace

-- 
balbi
