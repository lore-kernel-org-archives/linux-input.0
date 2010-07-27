From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/6] *	Register platform interface
Date: Tue, 27 Jul 2010 01:16:33 -0700
Message-ID: <20100727081633.GC32084@core.coreip.homeip.net>
References: <20100723134852.19151.6999.stgit@localhost.localdomain>
 <20100723135219.19151.98855.stgit@localhost.localdomain>
 <20100723160716.GA21546@core.coreip.homeip.net>
 <20100723163859.1a8bfe7d@linux.intel.com>
 <20100723164316.GA21684@core.coreip.homeip.net>
 <20100726224942.GA17929@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56918 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab0G0IQh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jul 2010 04:16:37 -0400
Received: by pvc7 with SMTP id 7so347747pvc.19
        for <linux-input@vger.kernel.org>; Tue, 27 Jul 2010 01:16:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100726224942.GA17929@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org

On Mon, Jul 26, 2010 at 03:49:42PM -0700, Greg KH wrote:
> On Fri, Jul 23, 2010 at 09:43:17AM -0700, Dmitry Torokhov wrote:
> > On Fri, Jul 23, 2010 at 04:38:59PM +0100, Alan Cox wrote:
> > > > I am confused here... Are you having a separate SPI driver create a
> > > > platform device and then you have mrstouch to bind to this
> > > > intermediate platform device? Are you doing that so you can introduce
> > > > I2C interface later? If so I think I prefer how adxl34x and ad7879
> > > > drivers are structured - they are split into core and interface parts
> > > > but do not require extra devices/drivers (see in my 'next' brnach).
> > > 
> > > There is no SPI interface to the device. It ended up in the kernel SPI
> > > because old versions of the device firmware listed it in the firmware
> > > tables as SPI and rather than doing the right thing (correcting the
> > > type) the x86 code created an SPI device for it.
> > > 
> > > At a certain level it may be SPI, but it's all hidden behind the
> > > firmware on the SCU and nothing to do with Linux SPI at all.
> > > 
> > 
> > Ah, OK then.
> > 
> > So, what is the plan of action? Greg, are you going to apply the patches
> > to staging and move over to input or shoudl I do that (apply Alan's
> > patches to staging _in my tree_ and move over to drivers.input)?
> 
> I already have the driver in my staging-next tree, so I can apply these
> 6 patches as well, and then move it to the drivers/input subdirectory if
> you want.
> 
> Or I can leave it all in drivers/staging/ and then after 2.6.36-rc1
> comes, you can move the driver into drivers/input/ subdir.
> 

The 2nd one I think is the best.

Thanks.

-- 
Dmitry
