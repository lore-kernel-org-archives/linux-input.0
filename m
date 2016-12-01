From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] HID: i2c-hid: support Wacom digitizer + regulator
Date: Thu, 1 Dec 2016 09:30:31 -0800
Message-ID: <20161201173031.GB46688@google.com>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
 <1480555288-142791-2-git-send-email-briannorris@chromium.org>
 <20161201144126.GE1280@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161201144126.GE1280-/m+UfqrgI5QNLKR9yMNcA1aTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Thu, Dec 01, 2016 at 03:41:26PM +0100, Benjamin Tissoires wrote:
> On Nov 30 2016 or thereabouts, Brian Norris wrote:
> > We need to power on the digitizer before using it, and it's also nice to
> > save power in suspend by disabling it. Support an optional "vdd-supply"
> > and wire it up for the new Wacom device.
> > 
> > Wacom recommended waiting up to 100ms after powering on before trying to
> > access this device.
> > 
> > Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > ---
> > v1 was a few months back. I finally got around to rewriting it based on
> > DT binding feedback.
> > 
> > v2:
> >  * support compatible property for wacom, with specific "vdd-supply" name
> >  * support the 100ms delay needed for this digitizer
> >  * target regulator support only at specific device
> > 
> >  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 6 +++++-
> >  drivers/hid/i2c-hid/i2c-hid.c | 70 ++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/i2c/i2c-hid.h   |  6 ++++
> >  2 files changed, 75 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index b3ec4f2de875..1bc174f3a788 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -37,7 +37,9 @@
> >  #include <linux/mutex.h>
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #include <linux/i2c/i2c-hid.h>
> >  
> > @@ -918,10 +920,25 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client *client,
> >  #endif
> >  
> >  #ifdef CONFIG_OF
> > +
> > +/* of_device_id match data */
> > +struct i2c_hid_of_data {
> > +	/* Name of supply regulator. */
> > +	const char *supply_name;
> > +	/* Delay required after powering on device before it is usable. */
> > +	int init_delay_ms;
> > +};
> > +
> > +static const struct i2c_hid_of_data wacom_w9013_data = {
> 
> Why is the struct "wacom" specific?
> If the vdd line is required, I don't see why there is a need to specify
> that this is a Wacom specifics. Then Elan, SYnaptics will want the same
> and we won't be able to to follow.
> 
> > +	.supply_name		= "vdd",
> > +	.init_delay_ms		= 100,
> 
> If the purpose of this declaration is to set the delay, why isn't this
> something provided by the device tree?

The alleged purpose wasn't just for the delay (it wasn't even mentioned
in v1), but in case there are ever devices with multiple regulators and
different power sequencing (?) I guess. I still don't see why Rob
thought it needed a separate compatible property.

About the delay: as noted in my reply to patch 1, this was actually a
property of the device/firmware -- it needs some time to initialize
before we can talk to it. I previously had included that delay in the
regulator ramp delay, but since we'd know the device info here, I found
it convenient to latch onto the same property.

IOW, typically, if you have a device-specific compatible property, it
makes sense to key device-specific info off of that property where
possible. But if (like you suggest) the compatible property is
counter-productive, then we would need a separate property for this
delay.

> > +};
> > +
> >  static int i2c_hid_of_probe(struct i2c_client *client,
> >  		struct i2c_hid_platform_data *pdata)
> >  {
> >  	struct device *dev = &client->dev;
> > +	const struct i2c_hid_of_data *data = of_device_get_match_data(dev);
> >  	u32 val;
> >  	int ret;
> >  
> > @@ -937,10 +954,33 @@ static int i2c_hid_of_probe(struct i2c_client *client,
> >  	}
> >  	pdata->hid_descriptor_address = val;
> >  
> > +	if (data) {
> > +		pdata->init_delay_ms = data->init_delay_ms;
> > +		if (data->supply_name) {
> > +			pdata->supply = devm_regulator_get_optional(&client->dev,
> > +								    data->supply_name);
> > +			if (IS_ERR(pdata->supply)) {
> > +				ret = PTR_ERR(pdata->supply);
> > +				pdata->supply = NULL;
> > +				if (ret == -EPROBE_DEFER)
> > +					return ret;
> > +				if (ret == -ENODEV)
> > +					return 0;
> > +				dev_err(dev, "Failed to get %s regulator: %d\n",
> > +					data->supply_name, ret);
> > +				return ret;
> > +			}
> > +		}
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> >  static const struct of_device_id i2c_hid_of_match[] = {
> > +	{
> > +		.compatible = "wacom,w9013",
> > +		.data = &wacom_w9013_data,
> > +	},
> 
> NACK, see 1/2

Fine with me, if Rob is OK. I replid on 1/2.

> I don't really like the v2. IMO, v1 was less intrusive (though it was
> missing the init_delay_ms).
> I believe it's possible to have a generic device tree description which
> doesn't require us to adapt the driver for each and every device.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
