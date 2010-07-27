From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [RFC][PATCH] GPIO keys
Date: Tue, 27 Jul 2010 23:31:32 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B37D1C6F@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C003B37D1C39@dbde02.ent.ti.com>
 <20100727170047.GC5961@core.coreip.homeip.net>
 <0680EC522D0CC943BC586913CF3768C003B37D1C68@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39177 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab0G0SBi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jul 2010 14:01:38 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B37D1C68@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-
> owner@vger.kernel.org] On Behalf Of Datta, Shubhrajyoti
> Sent: Tuesday, July 27, 2010 11:15 PM
> To: Dmitry Torokhov
> Cc: linux-input@vger.kernel.org
> Subject: RE: [RFC][PATCH] GPIO keys
> 
> Hi Dmitry,
> 
> > -----Original Message-----
> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > Sent: Tuesday, July 27, 2010 10:31 PM
> > To: Datta, Shubhrajyoti
> > Cc: linux-input@vger.kernel.org
> > Subject: Re: [RFC][PATCH] GPIO keys
> >
> > Hi Shubhrajyoti,
> >
> > On Tue, Jul 27, 2010 at 08:11:31PM +0530, Datta, Shubhrajyoti wrote:
> > >
> > > Allowing the call of open and close functions.
> > > If the gpio-keys device has some initialization
> > > to be done allow the call of platform functions.
> > > An example would be to enable the device.
> > >
> >
> > Makes sense, although I'd prefer 2 separate methods. Also, make sure you
> > run you patch through scripts/checkpatch.pl - I see a coupe of small
> > formatting issues (note that I do not care strongly about 80 column
> > limit).
> >
> I did run checkpatch maybe you may be I corrupted something while sending.
> Will check.
> 
may be I corrupted something while sending. 
-Correcting the typo 
> I chose this approach as at later point maybe some driver may use it for
> custom suspend and resume etc. However will send another patch if you so
> prefer.
> > Thanks.
> >
> > > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > > ---
> > >  drivers/input/keyboard/gpio_keys.c |   23 +++++++++++++++++++++++
> > >  include/linux/gpio_keys.h          |    1 +
> > >  2 files changed, 24 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/input/keyboard/gpio_keys.c
> > b/drivers/input/keyboard/gpio_keys.c
> > > index b8213fd..f459f38 100644
> > > --- a/drivers/input/keyboard/gpio_keys.c
> > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > @@ -38,6 +38,7 @@ struct gpio_keys_drvdata {
> > >  	struct input_dev *input;
> > >  	struct mutex disable_lock;
> > >  	unsigned int n_buttons;
> > > +	void (*enable)(int state);
> > >  	struct gpio_button_data data[0];
> > >  };
> > >
> > > @@ -414,6 +415,24 @@ fail2:
> > >  	return error;
> > >  }
> > >
> > > +static int gpio_keys_open(struct input_dev *dev)
> > > +{
> > > +	struct gpio_keys_drvdata *ddata;
> > > +	ddata = input_get_drvdata(dev);
> > > +	if (ddata->enable)
> > > +		ddata->enable(1);
> > > +	return 0;
> > > +}
> > > +
> > > +static void gpio_keys_close(struct input_dev *dev)
> > > +{
> > > +	struct gpio_keys_drvdata *ddata;
> > > +
> > > +	ddata = input_get_drvdata(dev);
> > > +	if (ddata->enable)
> > > +		ddata->enable(0);
> > > +}
> > > +
> > >  static int __devinit gpio_keys_probe(struct platform_device *pdev)
> > >  {
> > >  	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
> > > @@ -435,13 +454,17 @@ static int __devinit gpio_keys_probe(struct
> > platform_device *pdev)
> > >
> > >  	ddata->input = input;
> > >  	ddata->n_buttons = pdata->nbuttons;
> > > +	ddata->enable =  pdata->enable;
> > >  	mutex_init(&ddata->disable_lock);
> > >
> > >  	platform_set_drvdata(pdev, ddata);
> > > +	input_set_drvdata(input , ddata);
> > >
> > >  	input->name = pdev->name;
> > >  	input->phys = "gpio-keys/input0";
> > >  	input->dev.parent = &pdev->dev;
> > > +	input->open = gpio_keys_open;
> > > +	input->close = gpio_keys_close;
> > >
> > >  	input->id.bustype = BUS_HOST;
> > >  	input->id.vendor = 0x0001;
> > > diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> > > index cd0b3f3..5645996 100644
> > > --- a/include/linux/gpio_keys.h
> > > +++ b/include/linux/gpio_keys.h
> > > @@ -17,6 +17,7 @@ struct gpio_keys_platform_data {
> > >  	struct gpio_keys_button *buttons;
> > >  	int nbuttons;
> > >  	unsigned int rep:1;		/* enable input subsystem auto repeat
> > */
> > > +	void (*enable)(int state);
> > >  };
> > >
> > >  #endif
> > > --
> > > 1.5.4.7
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-input"
> > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
