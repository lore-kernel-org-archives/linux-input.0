From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix error handling in I2C
 transport driver
Date: Fri, 30 Sep 2016 16:02:03 -0700
Message-ID: <20160930230203.GH30208@dtor-ws>
References: <1475109426-23644-1-git-send-email-linux@roeck-us.net>
 <20160929175540.GF7509@tuxbot>
 <20160930225403.GG30208@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35612 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbcI3XCH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Sep 2016 19:02:07 -0400
Content-Disposition: inline
In-Reply-To: <20160930225403.GG30208@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

On Fri, Sep 30, 2016 at 03:54:03PM -0700, Dmitry Torokhov wrote:
> On Thu, Sep 29, 2016 at 10:55:40AM -0700, Bjorn Andersson wrote:
> > On Wed 28 Sep 17:37 PDT 2016, Guenter Roeck wrote:
> > 
> > > Instantiating the rmi4 I2C transport driver without interrupts assigned
> > > (for example using manual i2c instantiation from the command line)
> > > caused the driver to fail to load, but it does not clean up its
> > > regulator or transport device registrations. Result is a crash at a later
> > > time, for example when rebooting the system.
> > > 
> > > Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplies")
> > 
> > Sorry for that.
> > 
> > > Fixes: fdf51604f104 ("Input: synaptics-rmi4 - add I2C transport driver")
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Applied, thank you.

I take it back. rmi_i2c_init_irq() uses devm* so this whole thing mixes
up devm* and manual unregistering and unwind order is completely
broken.

1. Why do we register interrupt from transport drivers and not make it
part of rmi_register_transport_device()?
2. If we need to use some non-devm-ised resources we should use
devm_add_action[_or_reset] to work these operations into devm stream.

Thanks,

> 
> It looks like we have similar issue in rmi_spi.c. Can I get another
> patch?
> 
> > 
> > Regards,
> > Bjorn
> > 
> > > Cc: Andrew Duggan <aduggan@synaptics.com>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/input/rmi4/rmi_i2c.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> > > index 6f2e0e4f0296..d57b227ccd25 100644
> > > --- a/drivers/input/rmi4/rmi_i2c.c
> > > +++ b/drivers/input/rmi4/rmi_i2c.c
> > > @@ -285,23 +285,30 @@ static int rmi_i2c_probe(struct i2c_client *client,
> > >  	retval = rmi_set_page(rmi_i2c, 0);
> > >  	if (retval) {
> > >  		dev_err(&client->dev, "Failed to set page select to 0.\n");
> > > -		return retval;
> > > +		goto error_disable;
> > >  	}
> > >  
> > >  	retval = rmi_register_transport_device(&rmi_i2c->xport);
> > >  	if (retval) {
> > >  		dev_err(&client->dev, "Failed to register transport driver at 0x%.2X.\n",
> > >  			client->addr);
> > > -		return retval;
> > > +		goto error_disable;
> > >  	}
> > >  
> > >  	retval = rmi_i2c_init_irq(client);
> > >  	if (retval < 0)
> > > -		return retval;
> > > +		goto error_unregister;
> > >  
> > >  	dev_info(&client->dev, "registered rmi i2c driver at %#04x.\n",
> > >  			client->addr);
> > >  	return 0;
> > > +
> > > +error_unregister:
> > > +	rmi_unregister_transport_device(&rmi_i2c->xport);
> > > +error_disable:
> > > +	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
> > > +			       rmi_i2c->supplies);
> > > +	return retval;
> > >  }
> > >  
> > >  static int rmi_i2c_remove(struct i2c_client *client)
> > > -- 
> > > 2.5.0
> > > 
> 
> -- 
> Dmitry

-- 
Dmitry
