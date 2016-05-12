From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - ntrig_spi: add new driver for the Surface 3
Date: Thu, 12 May 2016 12:56:38 -0700
Message-ID: <20160512195638.GC25805@dtor-ws>
References: <1463065674-14775-1-git-send-email-benjamin.tissoires@redhat.com>
 <20160512191613.GB25805@dtor-ws>
 <20160512195122.GX23234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33260 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbcELT4l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2016 15:56:41 -0400
Content-Disposition: inline
In-Reply-To: <20160512195122.GX23234@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 12, 2016 at 09:51:22PM +0200, Benjamin Tissoires wrote:
> On May 12 2016 or thereabouts, Dmitry Torokhov wrote:
> > On Thu, May 12, 2016 at 05:07:54PM +0200, Benjamin Tissoires wrote:
> > > +static int __maybe_unused ntrig_spi_suspend(struct device *dev)
> > > +{
> > > +	struct spi_device *spi = to_spi_device(dev);
> > > +	struct ntrig *data = spi_get_drvdata(spi);
> > > +
> > > +	ntrig_spi_free_irq(data);
> > 
> > Why?
> 
> To disable the IRQ and be sure we won't wake up the device...
> It might just work without though.

Or you can do disable_irq(). Do you want it to be wakeup source by
chance? Then you need to wire it up some more.

Thanks.

-- 
Dmitry
