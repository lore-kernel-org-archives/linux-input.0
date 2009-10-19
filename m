From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] leds-alix2: add support for button connected to J15
Date: Mon, 19 Oct 2009 09:16:21 +0200
Message-ID: <20091019071621.GZ28832@buzzloop.caiaq.de>
References: <20091016130315.GT28832@buzzloop.caiaq.de>
 <1255863412.27878.136.camel@ted>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:59005 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbZJSHQW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 03:16:22 -0400
Content-Disposition: inline
In-Reply-To: <1255863412.27878.136.camel@ted>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Constantin Baranov <const@mimas.ru>

On Sun, Oct 18, 2009 at 11:56:52AM +0100, Richard Purdie wrote:
> On Fri, 2009-10-16 at 15:03 +0200, Daniel Mack wrote:
> > for a project I was working on, we used the J15 connector of the ALIX.2D
> > board (which is connected to a GPIO of the CS5536 Geode companion chip)
> > for an external button switch.
> > 
> > I thought it might be worth sharing this piece of code, so others can do
> > the same.
> > 
> > There is, however, a small hardware modification is necessary as the pin
> > is also shared as buzzer output. I noted that in the Kconfig entry.
> > 
> > The patch should go thru Richard's led-2.6.git as it depends on another
> > one that has been queued there already.
> 
> How common is this modification? I'm just trying to get a feel for the
> number of users out there of this feature...

Hmm, hard to say. One can either use that IO as output to control a
buzzer (which isn't placed on the board, but there are solder pads for
it), as output for other purpose or as input.

Don't know what other people use it for, though, but we needed an
external button in our case and use this IO pin for that purpose.

Anyway - I don't insist in that patch to be taken. The idea was more to
share it so others won't have to hack the same thing.

I'll still submit a new version with Dmitry's suggestions addressed.

Thanks,
Daniel
