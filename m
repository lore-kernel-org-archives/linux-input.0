From: Andrew Duggan <andrew@duggan.us>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix error handling in I2C transport
 driver
Date: Sat, 01 Oct 2016 10:27:42 -0700
Message-ID: <1475342862.162608.742891553.456AA401@webmail.messagingengine.com>
References: <1475109426-23644-1-git-send-email-linux@roeck-us.net>
 <20160929175540.GF7509@tuxbot> <20160930225403.GG30208@dtor-ws>
 <20160930230203.GH30208@dtor-ws>
 <74a818fc-6ebf-0514-461e-b664390c32cb@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39936 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750984AbcJARgL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 1 Oct 2016 13:36:11 -0400
In-Reply-To: <74a818fc-6ebf-0514-461e-b664390c32cb@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>



On Fri, Sep 30, 2016, at 08:44 PM, Guenter Roeck wrote:
> On 09/30/2016 04:02 PM, Dmitry Torokhov wrote:
> > On Fri, Sep 30, 2016 at 03:54:03PM -0700, Dmitry Torokhov wrote:
> >> On Thu, Sep 29, 2016 at 10:55:40AM -0700, Bjorn Andersson wrote:
> >>> On Wed 28 Sep 17:37 PDT 2016, Guenter Roeck wrote:
> >>>
> >>>> Instantiating the rmi4 I2C transport driver without interrupts assigned
> >>>> (for example using manual i2c instantiation from the command line)
> >>>> caused the driver to fail to load, but it does not clean up its
> >>>> regulator or transport device registrations. Result is a crash at a later
> >>>> time, for example when rebooting the system.
> >>>>
> >>>> Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplies")
> >>>
> >>> Sorry for that.
> >>>
> >>>> Fixes: fdf51604f104 ("Input: synaptics-rmi4 - add I2C transport driver")
> >>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>>
> >>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>
> >> Applied, thank you.
> >
> > I take it back. rmi_i2c_init_irq() uses devm* so this whole thing mixes
> > up devm* and manual unregistering and unwind order is completely
> > broken.
> >
> Oops ...
> 
> > 1. Why do we register interrupt from transport drivers and not make it
> > part of rmi_register_transport_device()?

Not all RMI devices will have access to interrupts (ie HID and SMBus).
The same goes for regulators. Here is a reference to a previous
discussion regarding both:
https://lkml.org/lkml/2016/5/9/1055

> 
> rmi_register_transport_device() doesn't take dev as parameter.
> 
> > 2. If we need to use some non-devm-ised resources we should use
> > devm_add_action[_or_reset] to work these operations into devm stream.
> 

Since the regulator functions have their own devm_ versions I would
suggest switching to those functions to avoid dealing with
unregistering. 

Registering and unregistering the transport device is a bit more
complicated since these functions add and put the rmi_dev device. But,
it sounds like we can handle the unregister using
devm_add_action_or_reset().

Andrew 

> Ok, no problem.
> 
> Guenter
> 
> >
> > Thanks,
> >
> >>
> >> It looks like we have similar issue in rmi_spi.c. Can I get another
> >> patch?
> >>
> >>>
> >>> Regards,
> >>> Bjorn
> >>>
> >>>> Cc: Andrew Duggan <aduggan@synaptics.com>
> >>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>>> ---
> >>>>  drivers/input/rmi4/rmi_i2c.c | 13 ++++++++++---
> >>>>  1 file changed, 10 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> >>>> index 6f2e0e4f0296..d57b227ccd25 100644
> >>>> --- a/drivers/input/rmi4/rmi_i2c.c
> >>>> +++ b/drivers/input/rmi4/rmi_i2c.c
> >>>> @@ -285,23 +285,30 @@ static int rmi_i2c_probe(struct i2c_client *client,
> >>>>  	retval = rmi_set_page(rmi_i2c, 0);
> >>>>  	if (retval) {
> >>>>  		dev_err(&client->dev, "Failed to set page select to 0.\n");
> >>>> -		return retval;
> >>>> +		goto error_disable;
> >>>>  	}
> >>>>
> >>>>  	retval = rmi_register_transport_device(&rmi_i2c->xport);
> >>>>  	if (retval) {
> >>>>  		dev_err(&client->dev, "Failed to register transport driver at 0x%.2X.\n",
> >>>>  			client->addr);
> >>>> -		return retval;
> >>>> +		goto error_disable;
> >>>>  	}
> >>>>
> >>>>  	retval = rmi_i2c_init_irq(client);
> >>>>  	if (retval < 0)
> >>>> -		return retval;
> >>>> +		goto error_unregister;
> >>>>
> >>>>  	dev_info(&client->dev, "registered rmi i2c driver at %#04x.\n",
> >>>>  			client->addr);
> >>>>  	return 0;
> >>>> +
> >>>> +error_unregister:
> >>>> +	rmi_unregister_transport_device(&rmi_i2c->xport);
> >>>> +error_disable:
> >>>> +	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
> >>>> +			       rmi_i2c->supplies);
> >>>> +	return retval;
> >>>>  }
> >>>>
> >>>>  static int rmi_i2c_remove(struct i2c_client *client)
> >>>> --
> >>>> 2.5.0
> >>>>
> >>
> >> --
> >> Dmitry
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
