From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] HID: i2c-hid: support regulator power on/off
Date: Mon, 5 Dec 2016 10:14:33 +0100
Message-ID: <20161205091433.GM1280@mail.corp.redhat.com>
References: <1480717140-14558-1-git-send-email-briannorris@chromium.org>
 <1480717140-14558-2-git-send-email-briannorris@chromium.org>
 <20161202230013.GA18268@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161202230013.GA18268@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Dec 02 2016 or thereabouts, Dmitry Torokhov wrote:
> On Fri, Dec 02, 2016 at 02:19:00PM -0800, Brian Norris wrote:
> > On some boards, we need to enable a regulator before using the HID, and
> > it's also nice to save power in suspend by disabling it. Support an
> > optional "vdd-supply" and a companion initialization delay.
> > 
> > Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > ---
> > v2:
> >  * support compatible property for wacom, with specific "vdd-supply"
> >  * name
> >  * support the 100ms delay needed for this digitizer
> >  * target regulator support only at specific device
> > 
> > v3:
> >  * drop Wacom specifics and allow this to be used generically
> >  * add "init-delay-ms" property support
> > 
> > v4:
> >  * use devm_regulator_get() (with a 'dummy' regulator for most cases)
> >    instead of _optional() version, to make code less conditional (Dmitry)
> >  * fix but where 'init_delay_ms' wasn't getting assigned properly
> >  * disable regulator in probe() failure path
> > ---
> >  drivers/hid/i2c-hid/i2c-hid.c | 44 +++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/i2c/i2c-hid.h   |  6 ++++++
> >  2 files changed, 48 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index b3ec4f2de875..5c6e037613d7 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> >  #include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #include <linux/i2c/i2c-hid.h>
> >  
> > @@ -937,6 +938,10 @@ static int i2c_hid_of_probe(struct i2c_client *client,
> >  	}
> >  	pdata->hid_descriptor_address = val;
> >  
> > +	ret = of_property_read_u32(dev->of_node, "init-delay-ms", &val);
> > +	if (!ret)
> > +		pdata->init_delay_ms = val;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -983,6 +988,15 @@ static int i2c_hid_probe(struct i2c_client *client,
> >  		ihid->pdata = *platform_data;
> >  	}
> >  
> > +	ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
> 
> Oh, haveni't noticed that the rest of the driver does not use devm.
> Well, I'll leave it up to hid-i2c folks to decide if they are OK with
> mixing up the managed and non-managed resources, it seems safe to me in
> this case.

Yeah, it looks good to me as well. However, I think that will be the
trigger to request a devm conversion of the i2c-hid driver. Something
I'll add to my list of things to consider for v4.11 then :)

Acked-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Cheers,
Benjamin

> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Thanks.
> 
> -- 
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
