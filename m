From: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 4/9] input: goodix: add ACPI IDs for GT911 and GT9271
Date: Fri, 5 Jun 2015 17:01:15 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A79E95@irsmsx105.ger.corp.intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-5-git-send-email-irina.tirdea@intel.com>
 <1433422260.5346.15.camel@hadess.net>
 <1F3AC3675D538145B1661F571FE1805F19A79DA8@irsmsx105.ger.corp.intel.com>
 <20150605164145.GB26708@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150605164145.GB26708@dtor-ws>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'Bastien Nocera' <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: 05 June, 2015 19:42
> To: Tirdea, Irina
> Cc: 'Bastien Nocera'; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 4/9] input: goodix: add ACPI IDs for GT911 and GT9271
> 
> On Fri, Jun 05, 2015 at 04:36:24PM +0000, Tirdea, Irina wrote:
> >
> >
> > > -----Original Message-----
> > > From: Bastien Nocera [mailto:hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org]
> > > Sent: 04 June, 2015 15:51
> > > To: Tirdea, Irina
> > > Cc: Dmitry Torokhov; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Subject: Re: [PATCH 4/9] input: goodix: add ACPI IDs for GT911 and GT9271
> > >
> > > On Thu, 2015-05-28 at 15:47 +0300, Irina Tirdea wrote:
> > > > Add ACPI IDs to support Goodix GT911 and GT9271
> > > > touchscreens.
> > >
> > > Those devices are present on which systems which you would have tested
> > > this on?
> > >
> >
> > I have been using a custom setup by connecting the touchscreen directly
> > to a virtual Linux environment through an USB-I2C adapter (https://diolan.com/dln-2).
> > So these ACPI IDs do not correspond to any device publicly available.
> > However, once in upstream we can use this IDs for our future platforms.
> 
> I'd rather wait until they become available then.
> 

Ok, I will drop this patch then.

> Thanks.
> 
> >
> > > > Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > >  drivers/input/touchscreen/goodix.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/input/touchscreen/goodix.c
> > > > b/drivers/input/touchscreen/goodix.c
> > > > index 9561396..9e7d215 100644
> > > > --- a/drivers/input/touchscreen/goodix.c
> > > > +++ b/drivers/input/touchscreen/goodix.c
> > > > @@ -392,6 +392,8 @@ static const struct i2c_device_id goodix_ts_id[]
> > > > = {
> > > >  #ifdef CONFIG_ACPI
> > > >  static const struct acpi_device_id goodix_acpi_match[] = {
> > > >       { "GDIX1001", 0 },
> > > > +     { "GDIX0911", 0 },
> > > > +     { "GDIX9271", 0 },
> > > >       { }
> > > >  };
> > > >  MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
> 
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
