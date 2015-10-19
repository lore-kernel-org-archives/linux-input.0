From: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v7 3/9] Input: goodix - write configuration data to
 device
Date: Mon, 19 Oct 2015 14:32:24 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F101AB9@irsmsx105.ger.corp.intel.com>
References: <1444299575-17417-1-git-send-email-irina.tirdea@intel.com>
 <1444299575-17417-4-git-send-email-irina.tirdea@intel.com>
 <20151014065847.GH20406@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151014065847.GH20406@dtor-ws>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: 14 October, 2015 9:59
> To: Tirdea, Irina
> Cc: Bastien Nocera; Aleksei Mamlin; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mark Rutland; Purdila, Octavian; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v7 3/9] Input: goodix - write configuration data to device
> 
> On Thu, Oct 08, 2015 at 01:19:29PM +0300, Irina Tirdea wrote:
> > Goodix devices can be configured by writing custom data to the device at
> > init. The configuration data is read with request_firmware from
> > "goodix_<id>_cfg.bin", where <id> is the product id read from the device
> > (e.g.: goodix_911_cfg.bin for Goodix GT911, goodix_9271_cfg.bin for
> > GT9271).
> >
> > The configuration information has a specific format described in the Goodix
> > datasheet. It includes X/Y resolution, maximum supported touch points,
> > interrupt flags, various sensitivity factors and settings for advanced
> > features (like gesture recognition).
> >
> > Before writing the firmware, it is necessary to reset the device. If
> > the device ACPI/DT information does not declare gpio pins (needed for
> > reset), writing the firmware will not be available for these devices.
> >
> > This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> > driver gt9xx.c for Android (publicly available in Android kernel
> > trees for various devices).
> >
> > Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/input/touchscreen/goodix.c | 229 +++++++++++++++++++++++++++++++------
> >  1 file changed, 196 insertions(+), 33 deletions(-)
> >
<snip>
> > +/**
> > + * goodix_config_cb - Callback to finish device init
> > + *
> > + * @ts: our goodix_ts_data pointer
> > + *
> > + * request_firmware_wait callback that finishes
> > + * initialization of the device.
> > + */
> > +static void goodix_config_cb(const struct firmware *cfg, void *ctx)
> > +{
> > +	struct goodix_ts_data *ts = (struct goodix_ts_data *)ctx;
> > +	int error;
> > +
> > +	if (cfg) {
> > +		/* send device configuration to the firmware */
> > +		error = goodix_send_cfg(ts, cfg);
> > +		if (error)
> > +			goto err_release_cfg;
> > +	}
> > +	goodix_configure_dev(ts);
> > +
> > +err_release_cfg:
> > +	kfree(ts->cfg_name);
> > +	release_firmware(cfg);
> 
> You need to use completion to signal remove() (and also probably
> suspend/resume in the subsequent patches) that you are done handling
> config, otherwise if you do bind/unbind via sysfs in a tight loop you
> will observe a nice crash.
> 
> Thanks.
> 

Right, missed that. Will fix in next version.

Thanks,
Irina

<snip>
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
