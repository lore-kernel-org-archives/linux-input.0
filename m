From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] input/misc: rotary-encoder: Set gpio direction
Date: Tue, 9 Feb 2010 02:30:29 +0100
Message-ID: <20100209013029.GL28972@buzzloop.caiaq.de>
References: <20100208210350.36f51cbf@digital-domain.net>
 <20100208221206.GP9007@buzzloop.caiaq.de>
 <201002081618.23605.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:43140 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab0BIBam (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 20:30:42 -0500
Content-Disposition: inline
In-Reply-To: <201002081618.23605.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Clayton <andrew@digital-domain.net>, linux-input@vger.kernel.org, Mark Somerville <mark@scottishclimbs.com>

On Mon, Feb 08, 2010 at 04:18:23PM -0800, Dmitry Torokhov wrote:
> On Monday 08 February 2010 02:12:06 pm Daniel Mack wrote:
> > On Mon, Feb 08, 2010 at 09:03:50PM +0000, Andrew Clayton wrote:
> > > While trying to get a rotary encoder working under a beagle board using
> > > the drivers/input/misc/rotary-encoder.c driver, we found that even with
> > > the right pin mux settings configured through
> > > /sys/kernel/debug/omap_mux/*, i.e INPUT_PULLUP and MODE4, the
> > > gpio_get_value() functions only ever returned 1.
> > >
> > > By explicitly calling gpio_direction_input() after each requested gpio,
> > > the driver started working and started returning correct input events.
> > >
> > > The following is the patch that works for us. What do you think?
> > 
> > Yep, that looks good to me, thanks!
> > 
> > Acked-by: Daniel Mack <daniel@caiaq.de>
> 
> .33 material or hold off till .34?

Hmm, it doesn't fix any existing upstream platform, so I think it should
be fine for .34.

Thanks,
Daniel
