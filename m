From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ads7846: allocate separate cache lines for tx and rx data
Date: Thu, 16 Jul 2009 00:51:04 -0700
Message-ID: <200907160051.04506.david-b@pacbell.net>
References: <200907151106.47917.david-b@pacbell.net> <20090715093313.GA2897@mail.gnudd.com> <20090715193326.GA13306@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:43520 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752571AbZGPHvF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2009 03:51:05 -0400
In-Reply-To: <20090715193326.GA13306@mail.gnudd.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessandro Rubini <rubini-list@gnudd.com>
Cc: linux-input@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk

On Wednesday 15 July 2009, Alessandro Rubini wrote:
> >> Since the SPI master might use DMA, tx and rx buffers must live on
> >> different cache lines.
> > 
> > Not true.  Full duplex tranfsers using a single buffer are
> > explicitly allowed.
> 
> Ok, thanks.
> 
> > If that spi_master driver mis-handles this, it's a bug in that
> > driver.
> 
> Well, the driver receives one spi message made of 4 or 6 transfers.
> It does one at a time, shouldn't it?

Yes, where each transfer may be full or half duplex.


> If the transfer description is 
> intermixed with the data buffer, we fetch a line from ram with
> not-yet-filled input buffers. So I get invalid data from the analog
> inputs -- usually zero, as the structure is kzalloced.

If you're referring to the way the spi_message and spi_transfer
structs sit in the same cache lines as the data buffers, that's
something that should get fixed.  It started out that way since
none of the *initial* configurations used DMA, and the driver was
evolved from existing code.  Sometime later this was noted to be
a bug when used with DMA...

It seems that e8f462d202026d8e99f553ed5a09422321226ac9 wasn't a
complete fix ... this explains why the touchscreen behaves but
not the ADC inputs (as you noted).

Note that this issue is unrelated to full duplex DMA support.
Full duplex DMA is no problem.  It's not at all common, but that's
exactly what DMA_BIDIRECTIONAL means.  If you look at atmel_spi
you will notice that it maps the TX first, flushing caches; then
the RX next.  The other way around would break; some drivers
got that wrong, and had to be fixed last year sometime.

 
> >> The issue was discussed with Russell King on linux-arm-kernel.
> > 
> > Gee, but not with the author of that driver or the maintainer of
> > the SPI framework.   Who could have pointed out instantly where
> > the true bug resides.
> 
> So, where is it? I don't get it I'm sorry.

See above; this something an earlier patch didn't quite cover.


> ps: yes, it's a revB silicon.

Good.  That SPI bug in revA made it pretty useless for SPI stuff.
Bitbanging works annoyingly slowly!

- Dave


