From: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 4/8] input: goodix: reset device at init
Date: Tue, 23 Jun 2015 13:20:39 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F061632@irsmsx105.ger.corp.intel.com>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
 <1433774273-23103-5-git-send-email-irina.tirdea@intel.com>
 <20150609175756.GI6338@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150609175756.GI6338@dtor-ws>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: linux-input-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-input-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Dmitry Torokhov
> Sent: 09 June, 2015 20:58
> To: Tirdea, Irina
> Cc: Bastien Nocera; Mark Rutland; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Rob
> Herring; Pawel Moll; Ian Campbell; Kumar Gala; Purdila, Octavian
> Subject: Re: [PATCH v2 4/8] input: goodix: reset device at init
> 
> Hi Irina,
> 
> On Mon, Jun 08, 2015 at 05:37:49PM +0300, Irina Tirdea wrote:
> > +static int goodix_get_gpio_config(struct goodix_ts_data *ts)
> > +{
> > +	struct device *dev;
> > +	struct gpio_desc *gpiod;
> > +	int ret;
> > +
> > +	if (!ts->client)
> > +		return -EINVAL;
> > +	dev = &ts->client->dev;
> > +
> > +	/* Get interrupt GPIO pin number */
> > +	gpiod = devm_gpiod_get(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
> > +	if (IS_ERR(gpiod)) {
> > +		ret = PTR_ERR(gpiod);
> > +		dev_err(dev, "Failed to get %s GPIO: %d\n",
> > +			GOODIX_GPIO_INT_NAME, ret);
> 
> You need to handle -EPROBE_DEFER (suppress error) and especially -ENOENT error
> codes, otherwise, as Bastien mentioned, you will break existing DTS.
> 

Yes, I will handle the -EPROBE_DEFER and -ENOENT for devices that might not have these
gpio pins connected or declared in ACPI/DTS. Since the following patches depend on these
pins, I will bypass the functionality for these devices (suspend/resume, esd, writing config
will not be available if gpio pins are not found).

Thanks,
Irina

> Thanks.
> 
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
