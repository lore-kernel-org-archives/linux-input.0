From: Michael Grzeschik <mgr@pengutronix.de>
Subject: Re: [PATCH] pcf8574_keypad: use request_devm_threaded_irq
Date: Tue, 23 Jun 2015 08:42:38 +0200
Message-ID: <20150623064238.GD19386@pengutronix.de>
References: <1434710154-25834-1-git-send-email-m.grzeschik@pengutronix.de>
 <20150622205552.GB2350@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49308 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbFWGmk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 02:42:40 -0400
Content-Disposition: inline
In-Reply-To: <20150622205552.GB2350@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Jun 22, 2015 at 01:55:52PM -0700, Dmitry Torokhov wrote:
> On Fri, Jun 19, 2015 at 12:35:54PM +0200, Michael Grzeschik wrote:
> > We can use the devres API here. Remove the extra cleanup codepath.
> 
> We could, but not like that (hint: what is the order of releasing
> resources with your patch?). Also, calling free_irq() on IRQ requested
> by devm_* is not quite valid. Did you test the patch, especially the
> remove portion?

Doh, thanks for the hints. I will send v2.

Michael

> 
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> >  drivers/input/misc/pcf8574_keypad.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
> > index 97f711a..62fcf36 100644
> > --- a/drivers/input/misc/pcf8574_keypad.c
> > +++ b/drivers/input/misc/pcf8574_keypad.c
> > @@ -131,7 +131,8 @@ static int pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_i
> >  
> >  	lp->laststate = read_state(lp);
> >  
> > -	ret = request_threaded_irq(client->irq, NULL, pcf8574_kp_irq_handler,
> > +	ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +				   NULL, pcf8574_kp_irq_handler,
> >  				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> >  				   DRV_NAME, lp);
> >  	if (ret) {
> > @@ -142,14 +143,12 @@ static int pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_i
> >  	ret = input_register_device(idev);
> >  	if (ret) {
> >  		dev_err(&client->dev, "input_register_device() failed\n");
> > -		goto fail_free_irq;
> > +		goto fail_free_device;
> >  	}
> >  
> >  	i2c_set_clientdata(client, lp);
> >  	return 0;
> >  
> > - fail_free_irq:
> > -	free_irq(client->irq, lp);
> >   fail_free_device:
> >  	input_free_device(idev);
> >   fail_allocate:
> > -- 
> > 2.1.4
> > 
> 
> Thanks.
> 
> -- 
> Dmitry
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
