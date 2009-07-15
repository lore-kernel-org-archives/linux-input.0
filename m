From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ads7846: allocate separate cache lines for tx and rx data
Date: Wed, 15 Jul 2009 11:06:47 -0700
Message-ID: <200907151106.47917.david-b@pacbell.net>
References: <20090715093313.GA2897@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:41528 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755198AbZGOSGt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 14:06:49 -0400
In-Reply-To: <20090715093313.GA2897@mail.gnudd.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessandro Rubini <rubini-list@gnudd.com>
Cc: linux-input@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk

On Wednesday 15 July 2009, Alessandro Rubini wrote:
> From: Alessandro Rubini <rubini@gnudd.com>
> 
> Since the SPI master might use DMA, tx and rx buffers must live on
> different cache lines.

Not true.  Full duplex tranfsers using a single buffer are
explicitly allowed.


> Here one cache line is used for all tx and 
> another for all rx.  This will work whether the SPI master maps/unmaps
> one buffer at a time or all together.  The patch only fixes the analog
> inputs, as touch screen operation is not affected, although I didn't
> check why.  I tested on at91sam9263, where buffers are all mapped
> initially and unmapped individually at irq time.

If that spi_master driver mis-handles this, it's a bug in that
driver.  (And I hope you were using a version of the '9263 chip
which fixed its SPI bugs.  Initial silicon had a SPI controller
which was essentially unusuable in a multitasking environment.)

 
> The issue was discussed with Russell King on linux-arm-kernel.

Gee, but not with the author of that driver or the maintainer of
the SPI framework.   Who could have pointed out instantly where
the true bug resides.

 
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/input/touchscreen/ads7846.c |   53 +++++++++++++++++++++++++----------
>  1 files changed, 38 insertions(+), 15 deletions(-)
> 
