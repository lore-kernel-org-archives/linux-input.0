From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 28/33] Input: egalax_ts - Drop unnecessary call to
 i2c_set_clientdata and other changes
Date: Wed, 18 Jan 2017 12:32:08 -0800
Message-ID: <20170118203208.GA6807@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-29-git-send-email-linux@roeck-us.net>
 <20170118193154.GF33920@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170118193154.GF33920@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 18, 2017 at 11:31:54AM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 18, 2017 at 09:46:49AM -0800, Guenter Roeck wrote:
> > There is no call to i2c_get_clientdata() or dev_get_drvdata().
> > Drop the unnecessary call to i2c_set_clientdata().
> > Other relevant changes:
> >   Simplify error return
> >   Drop error messages after memory allocation failures
> > 
> > This conversion was done automatically with coccinelle using the
> > following semantic patches. The semantic patches and the scripts
> > used to generate this commit log are available at
> > https://github.com/groeck/coccinelle-patches
> > 
> > - Drop unused variables
> > - Drop unnecessary braces around conditional return statements
> > - Drop error message after devm_kzalloc() failure
> > - Replace 'if (e) return e; return 0;' with 'return e;'
> > - Drop i2c_set_clientdata()
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/input/touchscreen/egalax_ts.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
> > index 1afc08b08155..05ba1a6dc7fc 100644
> > --- a/drivers/input/touchscreen/egalax_ts.c
> > +++ b/drivers/input/touchscreen/egalax_ts.c
> > @@ -82,10 +82,9 @@ static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
> >  	if (ret < 0)
> >  		return IRQ_HANDLED;
> >  
> > -	if (buf[0] != REPORT_MODE_MTTOUCH) {
> > +	if (buf[0] != REPORT_MODE_MTTOUCH)
> >  		/* ignore mouse events and vendor events */
> >  		return IRQ_HANDLED;
> > -	}
> 
> These are not unnecessary braces, as there are more than 1 line. I.e.
> comments are counted along statements, at least by myself. Also, if
> there is a single statement spanning several lines I also prefer to have
> braces around it.
> 
Makes sense, and agreed. I'll have to figure out how to tell coccinelle about
situations like this.

> >  
> >  	state = buf[1];
> >  	x = (buf[3] << 8) | buf[2];
> > @@ -155,13 +154,8 @@ static int egalax_wake_up_device(struct i2c_client *client)
> >  static int egalax_firmware_version(struct i2c_client *client)
> >  {
> >  	static const u8 cmd[MAX_I2C_DATA_LEN] = { 0x03, 0x03, 0xa, 0x01, 0x41 };
> > -	int ret;
> > -
> > -	ret = i2c_master_send(client, cmd, MAX_I2C_DATA_LEN);
> > -	if (ret < 0)
> > -		return ret;
> >  
> > -	return 0;
> > +	return i2c_master_send(client, cmd, MAX_I2C_DATA_LEN);
> 
> This is not an equivalent transformation, as now callers need to check
> for negative return value instead of non-zero. i2c_master_send() returns
> number of bytes written on success.
> 

Oops, yes. Excellent point. I am way too agressive here. Thanks for pointing
this out.

Thanks,
Guenter
