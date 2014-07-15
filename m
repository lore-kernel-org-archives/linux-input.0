From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] Input: Add driver for Microchip's CAP1106
Date: Tue, 15 Jul 2014 18:17:40 +0100
Message-ID: <20140715171740.GA26068@leverpostej>
References: <1405073193-21448-1-git-send-email-zonque@gmail.com>
 <20140714095247.GB4980@leverpostej>
 <53C3AEE1.4030805@zonque.org>
 <20140715085138.GR26465@leverpostej>
 <20140715164149.GA40351@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:57363 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754473AbaGORRy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jul 2014 13:17:54 -0400
Content-Disposition: inline
In-Reply-To: <20140715164149.GA40351@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "dh.herrmann@gmail.com" <dh.herrmann@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Jul 15, 2014 at 05:41:49PM +0100, Dmitry Torokhov wrote:
> Hi Mark,
> 
> On Tue, Jul 15, 2014 at 09:51:38AM +0100, Mark Rutland wrote:
> > On Mon, Jul 14, 2014 at 11:20:17AM +0100, Daniel Mack wrote:
> > > 
> > > linux,keycode feels a bit overkill here though, so I'd rather go for a
> > > fixed-size linux,keycodes property. The number of entries is fixed,
> > > anyway. Would you be fine with that?
> > 
> > Assuming no-one's likely to want a sparse keymap (i.e. one where some
> > keys do nothing) then that's probably ok.
> 
> 
> For such a small keymap, if one does not want to use some of the
> buttons, setting corresponding entries to KEY_RESERVED should work well.

Ah, I was not aware of KEY_RESERVED. That sounds perfect then.

> > > 
> > > I took that from the gpio-keys driver. Is there a better way to denote
> > > such a feature?
> > 
> > Unfortunately not, given current practice. My gripe is that it's a Linux
> > detail that were describing rather than a property of the device. We can
> > forget about that for now.
> 
> I prefer looking at it as user expressing the desired behavior of the
> driver; it is up to OS to deliver such behavior ;)

Sure, but the user and DTB author are not the same, and may have
different preferences. Additionally autorepeat as a property only tells
half the story; I might prefer a 1ms delay while my neighbour Joe might
like a 3 billion year delay (he's a bit like that, Joe is). He also only
wants the esc key to repeat and can't figure out how to express that in
this DTB thing he's never heard of.

We can just leave this with me grumbling if you prefer ;)

Thanks,
Mark.
