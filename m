From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/misc: rotary-encoder: Set gpio direction
Date: Wed, 10 Feb 2010 23:19:21 -0800
Message-ID: <20100211071921.GF8252@core.coreip.homeip.net>
References: <20100208210350.36f51cbf@digital-domain.net>
 <20100208221206.GP9007@buzzloop.caiaq.de>
 <201002081618.23605.dmitry.torokhov@gmail.com>
 <20100209013029.GL28972@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:55349 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab0BKHT1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 02:19:27 -0500
Received: by gxk24 with SMTP id 24so861747gxk.1
        for <linux-input@vger.kernel.org>; Wed, 10 Feb 2010 23:19:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100209013029.GL28972@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Andrew Clayton <andrew@digital-domain.net>, linux-input@vger.kernel.org, Mark Somerville <mark@scottishclimbs.com>

On Tue, Feb 09, 2010 at 02:30:29AM +0100, Daniel Mack wrote:
> On Mon, Feb 08, 2010 at 04:18:23PM -0800, Dmitry Torokhov wrote:
> > On Monday 08 February 2010 02:12:06 pm Daniel Mack wrote:
> > > On Mon, Feb 08, 2010 at 09:03:50PM +0000, Andrew Clayton wrote:
> > > > While trying to get a rotary encoder working under a beagle board using
> > > > the drivers/input/misc/rotary-encoder.c driver, we found that even with
> > > > the right pin mux settings configured through
> > > > /sys/kernel/debug/omap_mux/*, i.e INPUT_PULLUP and MODE4, the
> > > > gpio_get_value() functions only ever returned 1.
> > > >
> > > > By explicitly calling gpio_direction_input() after each requested gpio,
> > > > the driver started working and started returning correct input events.
> > > >
> > > > The following is the patch that works for us. What do you think?
> > > 
> > > Yep, that looks good to me, thanks!
> > > 
> > > Acked-by: Daniel Mack <daniel@caiaq.de>
> > 
> > .33 material or hold off till .34?
> 
> Hmm, it doesn't fix any existing upstream platform, so I think it should
> be fine for .34.
> 

Applied to 'next' then, thank you.

-- 
Dmitry
