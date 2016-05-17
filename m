From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] Input - surface3_spi: add new driver for the Surface 3
Date: Tue, 17 May 2016 12:09:25 +0200
Message-ID: <20160517100925.GC23234@mail.corp.redhat.com>
References: <1463153826-10283-1-git-send-email-benjamin.tissoires@redhat.com>
 <20160516195118.GG12752@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56632 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755924AbcEQKJc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 06:09:32 -0400
Content-Disposition: inline
In-Reply-To: <20160516195118.GG12752@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On May 16 2016 or thereabouts, Dmitry Torokhov wrote:
> On Fri, May 13, 2016 at 05:37:06PM +0200, Benjamin Tissoires wrote:
> > This is a basic driver for the Surface 3. I am not so sure it will work
> > with any firmwares as most values are encoded, but given that I only have
> > access to my current device with its firmware and I don't have the
> > datasheet, it should be OK for now.
> > 
> > The Surface Pen is not supported (if it is supposed to be). I'll work on
> > this when I get one.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> > 
> > Changes in v2:
> > 
> > - module renamed from ntrig_spi to surface3_spi
> > - took into account Dmitry's remarks
> > - kept the retrieval of the GPIO as mandatory as otherwise the device fails to work
> > 
> >  drivers/input/touchscreen/Kconfig        |  11 ++
> >  drivers/input/touchscreen/Makefile       |   1 +
> >  drivers/input/touchscreen/surface3_spi.c | 320 +++++++++++++++++++++++++++++++
> >  3 files changed, 332 insertions(+)
> >  create mode 100644 drivers/input/touchscreen/surface3_spi.c
> > 

[snipped]

> > +static int surface3_spi_request_irq(struct surface3_ts_data *data)
> > +{
> > +	struct spi_device *spi = data->spi;
> > +
> > +	return devm_request_threaded_irq(&spi->dev, spi->irq,
> > +					  NULL, surface3_spi_irq_handler,
> > +					  IRQ_TYPE_EDGE_RISING | IRQF_ONESHOT,
> > +					  "Surface3-irq", data);
> > +}
> 
> Please just call devm_request_threaded_irq directly in probe.
> 
> Do you really need to specify IRQ_TYPE_EDGE_RISING? Does not ACPI has
> proper trigger specifier for the IRQ?

The ACPI indeed specify ActiveHigh (see line 12681 of the dump of the
DSDT in the kernel bug #104291:
https://bugzilla.kernel.org/attachment.cgi?id=187171 )

So I can detect this and use IRQ_TYPE_EDGE_RISING or
IRQ_TYPE_EDGE_FALLING accordingly.

Cheers,
Benjamin
