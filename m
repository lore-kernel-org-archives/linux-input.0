From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] Input - surface3_spi: add new driver for the Surface 3
Date: Tue, 17 May 2016 21:13:55 +0200
Message-ID: <20160517191355.GD23234@mail.corp.redhat.com>
References: <1463480179-11974-1-git-send-email-benjamin.tissoires@redhat.com>
 <20160517180428.GA9007@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60914 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcEQTN7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 15:13:59 -0400
Content-Disposition: inline
In-Reply-To: <20160517180428.GA9007@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On May 17 2016 or thereabouts, Dmitry Torokhov wrote:
> Hi Benjamin,
> 
> On Tue, May 17, 2016 at 12:16:19PM +0200, Benjamin Tissoires wrote:
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
> > Changes in v2:
> > 
> > - module renamed from ntrig_spi to surface3_spi
> > - took into account Dmitry's remarks
> > - kept the retrieval of the GPIO as mandatory as otherwise the device fails to work
> > 
> > Changes in v3:
> > 
> > - asm include put at the end
> > - used proper types in struct surfacae3_ts_data_finger
> > - dropped temps in surface3_spi_report_touch()
> > - inlined surface3_spi_request_irq()
> > - detect IRQ type (falling/rising) depending on the gpiod active low parameter
> 
> I do not think that this should be done in the driver. The device either
> has interrupt descriptor or GpioInt decriptor in DSDT and SPI core/ACPI
> should do the right thing and configure GPIO as input and set interrupt
> polarity accordingly, so when you do request_threaded_irq() you only
> need to specify IRQF_ONESHOT.
> 
> See drivers/spi/spi.c - in case there is no interrupt specified we call
> acpi_dev_gpio_irq_get(). Do you see it called in your case? Or your DSDT
> has interrupt for the touchscreen device and acpi_spi_add_resource() and
> acpi_dev_resource_interrupt() are called? You need to trace it and
> figure out if there is an issue there with setting up interrupt
> properly.

Looks like I need to push further the tests. From what I can see, using
just IRQF_ONESHOT is not sufficient enough and I need to add the trigger
falling manually (thus this way of doing).

I'll keep digging.

Cheers,
Benjamin
