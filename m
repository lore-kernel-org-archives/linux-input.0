From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 2/2] HID: i2c-hid: support regulator power on/off
Date: Thu, 1 Dec 2016 18:43:00 -0800
Message-ID: <20161202024259.GA39759@google.com>
References: <1480638670-111492-1-git-send-email-briannorris@chromium.org>
 <1480638670-111492-2-git-send-email-briannorris@chromium.org>
 <20161202003737.GA24901@dtor-ws>
 <20161202004214.GA112550@google.com>
 <20161202011615.GB24901@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161202011615.GB24901@dtor-ws>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 01, 2016 at 05:16:15PM -0800, Dmitry Torokhov wrote:
> On Thu, Dec 01, 2016 at 04:42:15PM -0800, Brian Norris wrote:
> > On Thu, Dec 01, 2016 at 04:37:37PM -0800, Dmitry Torokhov wrote:
> > > On Thu, Dec 01, 2016 at 04:31:10PM -0800, Brian Norris wrote:
> > > > On some boards, we need to enable a regulator before using the HID, and
> > > > it's also nice to save power in suspend by disabling it. Support an
> > > > optional "vdd-supply" and a companion initialization delay.
> > > > 
> > > > Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > > > Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > > Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > ---
> > > > v2:
> > > >  * support compatible property for wacom, with specific "vdd-supply" name
> > > >  * support the 100ms delay needed for this digitizer
> > > >  * target regulator support only at specific device
> > > > 
> > > > v3:
> > > >  * drop Wacom specifics and allow this to be used generically
> > > >  * add "init-delay-ms" property support
> > > > 
> > > >  drivers/hid/i2c-hid/i2c-hid.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
> > > >  include/linux/i2c/i2c-hid.h   |  6 ++++++
> > > >  2 files changed, 53 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > > > index b3ec4f2de875..4cb523133d13 100644
> > > > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > > > +++ b/drivers/hid/i2c-hid/i2c-hid.c

...

> > > > @@ -937,6 +939,22 @@ static int i2c_hid_of_probe(struct i2c_client *client,
> > > >  	}
> > > >  	pdata->hid_descriptor_address = val;
> > > >  
> > > > +	ret = of_property_read_u32(dev->of_node, "init-delay-ms", &val);
> > > > +	if (!ret)
> > > > +		pdata->init_delay_ms = ret;
> > > > +
> > > > +	pdata->supply = devm_regulator_get_optional(dev, "vdd");
> > > 
> > > Make it devm_regulator_get(), it's cleaner (you'll get a dummy regulator
> > > that you can enable/disbale and not check if it is null or not).
> > > 
> > > 	pdata->supply = devm_regulator_get_optional(dev, "vdd");
> > > 	if (IS_ERR(pdata->supply)) {
> > > 		ret = PTR_ERR(pdata->supply);
> > > 		if (ret != -EPROBE_DEFER)
> > > 			dev_err(...);
> > > 		return ret;
> > > 	}
> > 
> > I had it as devm_regulator_get() in v1, but at that time, I was faking
> > the firmware init delay using a regulator property. Now that I want to
> > delay in this driver after enabling the regulator, I'd like to know the
> > difference between a dummy and a real regulator. There's no need to wait
> > after messing with the dummy regulator.
> 
> If there is no regulator in ACPI/DT there would not be "init-delay-ms"
> property either.

I suppose that's a fair assumption... the difference being that you
assumed it, and I enforced it :)

Anyway, I can respin without the _optional(). I'll wait at least a day
or so, as the DT binding could use some review (it's the more
controversial piece).

Brian
