From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 2/8] Input: mms114 - get read of custm i2c read/write
 functions
Date: Tue, 30 Jan 2018 08:25:23 +0900
Message-ID: <20180129232523.GU7575@gangnam.samsung>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p1851ecb668e26bee1a09d162b4fe42225@epcas2p1.samsung.com>
        <20180129113323.18961-3-andi.shyti@samsung.com>
        <20180129190141.w2q55gfjjnvepl6k@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49323 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeA2XZ0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Jan 2018 18:25:26 -0500
Content-disposition: inline
In-reply-to: <20180129190141.w2q55gfjjnvepl6k@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>

Hi Dmitry,

On Mon, Jan 29, 2018 at 11:01:41AM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 29, 2018 at 08:33:17PM +0900, Andi Shyti wrote:
> > The 'mms114_read_reg' and 'mms114_write_reg' are used when
> > reading or writing to the 'MMS114_MODE_CONTROL' register for
> > updating the 'cache_mode_control' variable.
> > 
> > Update the 'cache_mode_control' variable in the calling
> > mms114_set_active() function and get rid of all the custom i2c
> > read/write functions.
> > 
> > With this remove also the redundant sleep of MMS114_I2C_DELAY
> > (50us) between i2c operations. The waiting should to be handled
> > by the i2c driver.
> > 
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > ---
> >  drivers/input/touchscreen/mms114.c | 87 +++++---------------------------------
> >  1 file changed, 10 insertions(+), 77 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> > index 0b8b1f0e8ba6..94a97049d711 100644
> > --- a/drivers/input/touchscreen/mms114.c
> > +++ b/drivers/input/touchscreen/mms114.c
> > @@ -37,9 +37,6 @@
> >  #define MMS152_FW_REV			0xE1
> >  #define MMS152_COMPAT_GROUP		0xF2
> >  
> > -/* Minimum delay time is 50us between stop and start signal of i2c */
> > -#define MMS114_I2C_DELAY		50
> > -
> >  /* 200ms needs after power on */
> >  #define MMS114_POWERON_DELAY		200
> >  
> > @@ -83,76 +80,6 @@ struct mms114_touch {
> >  	u8 reserved[2];
> >  } __packed;
> >  
> > -static int __mms114_read_reg(struct mms114_data *data, unsigned int reg,
> > -			     unsigned int len, u8 *val)
> > -{
> > -	struct i2c_client *client = data->client;
> > -	struct i2c_msg xfer[2];
> > -	u8 buf = reg & 0xff;
> > -	int error;
> > -
> > -	if (reg <= MMS114_MODE_CONTROL && reg + len > MMS114_MODE_CONTROL)
> > -		BUG();
> > -
> > -	/* Write register: use repeated start */
> > -	xfer[0].addr = client->addr;
> > -	xfer[0].flags = I2C_M_TEN | I2C_M_NOSTART;
> 
> So the chip does not use 10-bit addressing? What about I2C_M_NOSTART? It
> is not needed also?

>From the datasheet I have no, indeed I don't understand why this
is coming. That's why I asked Simon to test it on his device as
well.

On my device this patch works just fine.

> > -	xfer[0].len = 1;
> > -	xfer[0].buf = &buf;
> > -
> > -	/* Read data */
> > -	xfer[1].addr = client->addr;
> > -	xfer[1].flags = I2C_M_RD;
> > -	xfer[1].len = len;
> > -	xfer[1].buf = val;
> > -
> > -	error = i2c_transfer(client->adapter, xfer, 2);
> > -	if (error != 2) {
> > -		dev_err(&client->dev,
> > -			"%s: i2c transfer failed (%d)\n", __func__, error);
> > -		return error < 0 ? error : -EIO;
> > -	}
> > -	udelay(MMS114_I2C_DELAY);
> > -
> > -	return 0;
> > -}
> > -
> > -static int mms114_read_reg(struct mms114_data *data, unsigned int reg)
> > -{
> > -	u8 val;
> > -	int error;
> > -
> > -	if (reg == MMS114_MODE_CONTROL)
> > -		return data->cache_mode_control;
> > -
> > -	error = __mms114_read_reg(data, reg, 1, &val);
> > -	return error < 0 ? error : val;
> > -}
> > -
> > -static int mms114_write_reg(struct mms114_data *data, unsigned int reg,
> > -			    unsigned int val)
> > -{
> > -	struct i2c_client *client = data->client;
> > -	u8 buf[2];
> > -	int error;
> > -
> > -	buf[0] = reg & 0xff;
> > -	buf[1] = val & 0xff;
> > -
> > -	error = i2c_master_send(client, buf, 2);
> > -	if (error != 2) {
> > -		dev_err(&client->dev,
> > -			"%s: i2c send failed (%d)\n", __func__, error);
> > -		return error < 0 ? error : -EIO;
> > -	}
> > -	udelay(MMS114_I2C_DELAY);
> > -
> > -	if (reg == MMS114_MODE_CONTROL)
> > -		data->cache_mode_control = val;
> > -
> > -	return 0;
> > -}
> > -
> >  static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *touch)
> >  {
> >  	struct i2c_client *client = data->client;
> > @@ -231,19 +158,25 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
> >  
> >  static int mms114_set_active(struct mms114_data *data, bool active)
> >  {
> > -	int val;
> > +	int val, err;
> >  
> > -	val = mms114_read_reg(data, MMS114_MODE_CONTROL);
> > +	val = i2c_smbus_read_byte_data(data->client, MMS114_MODE_CONTROL);
> 
> If I  understand the original commit for the driver, the control
> register is write only and is not to be read from, that is why we have
> this cached value. With your change you read form it.

Still in my datasheet thee MMS114_MODE_CONTROL is a R/W register.
Still I don't understand the original choice, but it doesn't
change much anyway, I can keep the original idea of never reading
from it. Or I can rework this function in a better way.

> By the way, have you looked into converting it all to regmap?

I could.

Andi
