From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input - ntrig_spi: add new driver for the Surface 3
Date: Fri, 13 May 2016 17:02:17 +0200
Message-ID: <20160513150206.GA23234@mail.corp.redhat.com>
References: <1463065674-14775-1-git-send-email-benjamin.tissoires@redhat.com>
 <20160512191613.GB25805@dtor-ws>
 <20160512195122.GX23234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48000 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbcEMPCV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 11:02:21 -0400
Content-Disposition: inline
In-Reply-To: <20160512195122.GX23234@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On May 12 2016 or thereabouts, Benjamin Tissoires wrote:
> On May 12 2016 or thereabouts, Dmitry Torokhov wrote:
> > Hi Benjamin,
> > 
> > On Thu, May 12, 2016 at 05:07:54PM +0200, Benjamin Tissoires wrote:
> > > This is a basic driver for the Surface 3. I am not so sure it will work
> > > with any firmwares as most values are encoded, but given that I only have
> > > access to my current device with its firmware and I don't have the
> > > datasheet, it should be OK for now.
> > > 
> > > The Surface Pen is not supported (if it is supposed to be). I'll work on
> > > this when I get one.
> > > 
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > ---
> > >  drivers/input/touchscreen/Kconfig     |  11 ++
> > >  drivers/input/touchscreen/Makefile    |   1 +
> > >  drivers/input/touchscreen/ntrig_spi.c | 339 ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 351 insertions(+)
> > >  create mode 100644 drivers/input/touchscreen/ntrig_spi.c
> > > 
> > > diff --git a/drivers/input/touchscreen/ntrig_spi.c b/drivers/input/touchscreen/ntrig_spi.c
> > > new file mode 100644
> > > index 0000000..0d61fc0
> > > --- /dev/null
> > > +++ b/drivers/input/touchscreen/ntrig_spi.c

[stripped]

> > > +
> > > +	while (gpiod_get_value(data->gpiod_int)) {
> > 
> > What if interrupt line is not described as GPIO?
> 
> I do not have the spec, but I implied that it might be close to the
> official HID over I2C spec. In this spec, they said that the interrupt
> line will be kept high until there is no more data.
> 
> I can try to work around this, but right now, the driver fails if the
> interrupt line is not a GPIO.

So if I check the value of the GPIO after the full read, it stays at 0
so the while loop can be removed.

[stripped]
> > > +
> > > +	dev = &data->spi->dev;
> > > +
> > > +	/* Get the interrupt GPIO pin number */
> > > +	gpiod = devm_gpiod_get_index(dev, NULL, 2, GPIOD_IN);
> > > +	if (IS_ERR(gpiod)) {
> > > +		error = PTR_ERR(gpiod);
> > > +		if (error != -EPROBE_DEFER)
> > > +			dev_err(dev, "Failed to get int GPIO: %d\n", error);
> > > +		return error;
> > > +	}
> > 
> > Can this made optional?
> 
> I can work around an optional INT GPIO. But I don't know if Ntrig will
> provide this touchscreen to other devices than just the Surface.

I just checked if I remove this hunk. The touchscreen gets unresponsive.
I *think* we need to actually configure the GPIO as an IN to make it
work. I would have thought that it would have been translated
automatically by requesting the irq but it looks like not.

Also, given that the driver will be renamed into surface3_spi I think
it's safe to assume that the GPIO will be there and are mandatory.

Cheers,
Benjamin

