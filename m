From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 2/2] HID: i2c-hid: support regulator power on/off
Date: Thu, 1 Dec 2016 16:42:15 -0800
Message-ID: <20161202004214.GA112550@google.com>
References: <1480638670-111492-1-git-send-email-briannorris@chromium.org>
 <1480638670-111492-2-git-send-email-briannorris@chromium.org>
 <20161202003737.GA24901@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161202003737.GA24901@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Thu, Dec 01, 2016 at 04:37:37PM -0800, Dmitry Torokhov wrote:
> On Thu, Dec 01, 2016 at 04:31:10PM -0800, Brian Norris wrote:
> > On some boards, we need to enable a regulator before using the HID, and
> > it's also nice to save power in suspend by disabling it. Support an
> > optional "vdd-supply" and a companion initialization delay.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: linux-input@vger.kernel.org
> > ---
> > v2:
> >  * support compatible property for wacom, with specific "vdd-supply" name
> >  * support the 100ms delay needed for this digitizer
> >  * target regulator support only at specific device
> > 
> > v3:
> >  * drop Wacom specifics and allow this to be used generically
> >  * add "init-delay-ms" property support
> > 
> >  drivers/hid/i2c-hid/i2c-hid.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/i2c/i2c-hid.h   |  6 ++++++
> >  2 files changed, 53 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index b3ec4f2de875..4cb523133d13 100644
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
> > @@ -937,6 +939,22 @@ static int i2c_hid_of_probe(struct i2c_client *client,
> >  	}
> >  	pdata->hid_descriptor_address = val;
> >  
> > +	ret = of_property_read_u32(dev->of_node, "init-delay-ms", &val);
> > +	if (!ret)
> > +		pdata->init_delay_ms = ret;
> > +
> > +	pdata->supply = devm_regulator_get_optional(dev, "vdd");
> 
> Make it devm_regulator_get(), it's cleaner (you'll get a dummy regulator
> that you can enable/disbale and not check if it is null or not).
> 
> 	pdata->supply = devm_regulator_get_optional(dev, "vdd");
> 	if (IS_ERR(pdata->supply)) {
> 		ret = PTR_ERR(pdata->supply);
> 		if (ret != -EPROBE_DEFER)
> 			dev_err(...);
> 		return ret;
> 	}

I had it as devm_regulator_get() in v1, but at that time, I was faking
the firmware init delay using a regulator property. Now that I want to
delay in this driver after enabling the regulator, I'd like to know the
difference between a dummy and a real regulator. There's no need to wait
after messing with the dummy regulator.

Brian
