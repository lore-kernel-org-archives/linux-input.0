From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input/misc: new ADXL345/346 driver
Date: Thu, 5 Aug 2010 22:37:36 -0700
Message-ID: <20100806053736.GA12956@core.coreip.homeip.net>
References: <1255517680-30733-1-git-send-email-vapier@gentoo.org>
 <1256028039-15044-1-git-send-email-vapier@gentoo.org>
 <20100625071425.GA631@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917712E66DFEF69@LIMKCMBX1.ad.analog.com>
 <20100701075316.GA14696@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917712E7EC860F8@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34966 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab0HFFhm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Aug 2010 01:37:42 -0400
Received: by pwj7 with SMTP id 7so432147pwj.19
        for <linux-input@vger.kernel.org>; Thu, 05 Aug 2010 22:37:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E7EC860F8@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Chris Verges <chrisv@cyberswitching.com>, Luotao Fu <l.fu@pengutronix.de>, "Song, Barry" <Barry.Song@analog.com>

On Thu, Aug 05, 2010 at 01:30:44PM +0100, Hennerich, Michael wrote:
> Hennerich, Michael wrote on 2010-07-01:
> > Dmitry Torokhov wrote on 2010-07-01:
> >> On Fri, Jun 25, 2010 at 02:59:24PM +0100, Hennerich, Michael wrote:
> >>> Dmitry Torokhov wrote on 2010-06-25:
> >>>> Hi Mike, Michael,
> >>>>
> >>>> On Tue, Oct 20, 2009 at 04:40:39AM -0400, Mike Frysinger wrote:
> >>>>> From: Michael Hennerich <michael.hennerich@analog.com>
> >>>>>
> >>>>> This is a driver for the ADXL345/346 Three-Axis Digital
> >>>>> Accelerometers.
> >>>>>
> >>>>
> >>>> As I mentioned in one of the threads I decided to pull 3-axis
> >>>> acceleromenetrs into input and I am finally getting around to
> >>>> apply the patch... However I messed a bit with it so I was
> >>>> wondering if someone could give it a short spin to see if I broke it or not.
> >>>>
> >>>> Thanks!
> >>>>
> >>>
> >>> Hi Dmitry,
> >>>
> >>> Thanks for merging this driver. I gave it a quick spin. And there is
> >>> one issue. There is a code path that is taken with the mutex held,
> >>> which is also trying to acquire the mutex.
> >>>
> >>> Take a look at
> >>>
> >>> adxl34x_input_close() -> __adxl34x_disable() or
> >>> adxl34x_disable() -> __adxl34x_disable()
> >>>
> >>> I think __adxl34x_disable() should not acquire the mutex!
> >>>
> >>
> >> Yes, indeed it shoudl not have. I fixed it up and applied the patch.
> >> Could you also please try the following patch - hopefully it also
> >> works
> >> ;)
> >>
> >> Thank you in advance.
> >>
> >
> > Hi Dmitry,
> >
> > A few minor things.
> > See patch below.
> >
> > -adxl34x is on startup not disabled - otherwise user must reset
> > disable sysfs hook before the driver delivers any data.
> > -restore erroneously dropped line in adxl34x_calibrate_store() -fix
> > typo in adxl34x-i2c.c (l versus 1)
> >
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> >
> >  drivers/input/misc/adxl34x-i2c.c |    6 +++---
> >  drivers/input/misc/adxl34x.c     |    3 ++-
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> > diff --git a/drivers/input/misc/adxl34x-i2c.c
> > b/drivers/input/misc/adxl34x-i2c.c index b1b8df3..0779724 100644 ---
> > a/drivers/input/misc/adxl34x-i2c.c +++
> > b/drivers/input/misc/adxl34x-i2c.c @@ -58,14 +58,14 @@ static int
> > adxl34x_i2c_read_block(struct device *dev,
> >       return 0;
> >  }
> > -static const struct adxl34x_bus_ops adx134x_smbus_bops = {
> > +static const struct adxl34x_bus_ops adxl34x_smbus_bops = {
> >       .bustype        = BUS_I2C,
> >       .write          = adxl34x_smbus_write,
> >       .read           = adxl34x_smbus_read,
> >       .read_block     = adxl34x_smbus_read_block,
> >  };
> > -static const struct adxl34x_bus_ops adx134x_i2c_bops = {
> > +static const struct adxl34x_bus_ops adxl34x_i2c_bops = {
> >       .bustype        = BUS_I2C,
> >       .write          = adxl34x_smbus_write,
> >       .read           = adxl34x_smbus_read,
> > @@ -88,7 +88,7 @@ static int __devinit adxl34x_i2c_probe(struct
> > i2c_client *client,
> >       ac = adxl34x_probe(&client->dev, client->irq, false,
> >                          i2c_check_functionality(client->adapter,
> >                                                  I2C_FUNC_SMBUS_READ_I2C_BLOCK) ?
> > -                             &adx134x_smbus_bops : &adx134x_i2c_bops);
> > +                             &adxl34x_smbus_bops : &adxl34x_i2c_bops);
> >       if (IS_ERR(ac))
> >               return PTR_ERR(ac);
> > diff --git a/drivers/input/misc/adxl34x.c
> > b/drivers/input/misc/adxl34x.c index 2706ea0..756f4d0 100644
> > --- a/drivers/input/misc/adxl34x.c
> > +++ b/drivers/input/misc/adxl34x.c
> > @@ -514,6 +514,7 @@ static ssize_t adxl34x_calibrate_store(struct
> > device *dev,
> >       ac->hwcal.y -= (ac->saved.y / 4);
> >       ac->swcal.y = ac->saved.y % 4;
> > +     ac->hwcal.z -= (ac->saved.z / 4);
> >       ac->swcal.z = ac->saved.z % 4;
> >
> >       AC_WRITE(ac, OFSX, (s8) ac->hwcal.x); @@ -724,7 +725,7 @@ struct
> >  adxl34x *adxl34x_probe(struct device *dev, int irq,  pdata = &ac->pdata;
> >
> >       ac->input = input_dev;
> > -     ac->disabled = true;
> > +     ac->disabled = false;
> >       ac->dev = dev;
> >       ac->irq = irq;
> >       ac->bops = bops;
> >
> >
> > Greetings,
> > Michael
> >
> > Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> > Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036
> > Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
> 
> Hi Dmitry,
> 
> The driver in your next tree misses a piece from my last patch.
> 
> adxl34x is on startup not disabled - otherwise user must reset
> disable sysfs hook before the driver delivers any data.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> 
> drivers/input/misc/adxl34x.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
> index e2ca017..06235ee 100644
> --- a/drivers/input/misc/adxl34x.c
> +++ b/drivers/input/misc/adxl34x.c
> @@ -724,7 +724,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
>         pdata = &ac->pdata;
> 
>         ac->input = input_dev;
> -       ac->disabled = true;
> +       ac->disabled = false;
>         ac->dev = dev;
>         ac->irq = irq;
>         ac->bops = bops;
> 

Gah! I did not mean to drop it... Should be good now (I simply removed
ac->disabled = true; assignment since entire structure is kzalloced and
we do not explicitly initialize other flags either).

Thanks.

-- 
Dmitry
