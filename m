From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Input: add support for the Samsung S6SY761 touchscreen
Date: Mon, 25 Sep 2017 11:47:25 +0900
Message-ID: <20170925024725.GH2957@gangnam>
References: <CGME20170921132940epcas2p35b501f1ccc79d55c0427bb1ed36e10c6@epcas2p3.samsung.com>
        <20170921132950.17452-1-andi.shyti@samsung.com>
        <20170921205607.GA15858@dtor-ws> <20170922041702.GE2957@gangnam>
        <20170922171410.GD24037@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <20170922171410.GD24037@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

> > > > +static void s6sy761_report_coordinates(struct s6sy761_data *sdata, u8 *event)
> > > > +{
> > > > +	u8 tid = ((event[0] & S6SY761_MASK_TID) >> 2) - 1;
> > > 
> > > Should we make sure that event[0] & S6SY761_MASK_TID is not 0?
> > 
> > I check event[0] already in s6sy761_handle_events (called by the
> > irq handler), if we get here event[0] is for sure positive...
> > 
> > [...]
> > 
> > > > +static void s6sy761_handle_events(struct s6sy761_data *sdata, u8 left_event)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < left_event; i++) {
> > > > +		u8 *event = &sdata->data[i * S6SY761_EVENT_SIZE];
> > > > +		u8 event_id = event[0] & S6SY761_MASK_EID;
> > > > +
> > > > +		if (!event[0])
> > > > +			return;
> > 		   ^^^^^^^^
> > ... exactly here.
> > 
> > '!event[0]' means also to me that there is nothing left,
> > therefore I can discard whatever is next (given that there is
> > something left).
> 
> What happens if you get event[0] == S6SY761_EVENT_ID_COORDINATE? I.e.
> the value is non-zero, but tid component is 0?

Oh, I see what you mean. It shouldn't happen, in anycase I can
put it under an 'unlikely' statement.

> > > > +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > > > +					s6sy761_irq_handler,
> > > > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > > > +					"s6sy761_irq", sdata);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	disable_irq(client->irq);
> > > 
> > > Can you request IRQ after allocating and setting up the input device?
> > > Then you do not need to check for its presence in the interrupt handler.
> > 
> > The reason I do it here is because the x and y are embedded in
> > the device itself. This means that I first need to enable the
> > device, read x and y and then register the input device.
> > 
> > At power up I might expect an interrupt coming, thus I need to
> > check if 'input' is not 'NULL'.
> 
> But you do not need interrupts to read x and y, right? So you can power
> device, create input device, set it up as needed, and then request irq,
> or am I missing something?

OK, all right. I'll do that. I will move the irq request after
the input registration.

Thanks again for your review,
Andi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
