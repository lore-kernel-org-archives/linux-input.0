From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] Input: Add driver for Microchip's CAP1106
Date: Tue, 15 Jul 2014 15:42:59 +0100
Message-ID: <20140715144259.GD26465@leverpostej>
References: <1405073193-21448-1-git-send-email-zonque@gmail.com>
 <20140714095247.GB4980@leverpostej>
 <53C3AEE1.4030805@zonque.org>
 <20140715085138.GR26465@leverpostej>
 <53C4F076.1070500@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55228 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752626AbaGOOnT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jul 2014 10:43:19 -0400
Content-Disposition: inline
In-Reply-To: <53C4F076.1070500@zonque.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: "dtor@mail.ru" <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "dh.herrmann@gmail.com" <dh.herrmann@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Jul 15, 2014 at 10:12:22AM +0100, Daniel Mack wrote:
> On 07/15/2014 10:51 AM, Mark Rutland wrote:
> > On Mon, Jul 14, 2014 at 11:20:17AM +0100, Daniel Mack wrote:
> 
> >> Hmm, I thought about that, but there are - in theory - more details that
> >> could be specified per channel. I left those functions out for the first
> >> version, as I have no good way to test them.
> > 
> > Ok. Could you elaborate on what those details might be? It might make
> > sense to have these as nodes if there are arbitrary properties to
> > describe for each button, but I'm not familiar enough with the hardware
> > to make a call either way.
> 
> No, there are just settings that can be made for each indvidual
> channel/button, such as sensitivity settings for instance. But they can
> of course be specified in a similar manner as the keycodes, in a
> fixed-size array. That's completely ok I think.
> 
> >> linux,keycode feels a bit overkill here though, so I'd rather go for a
> >> fixed-size linux,keycodes property. The number of entries is fixed,
> >> anyway. Would you be fine with that?
> > 
> > Assuming no-one's likely to want a sparse keymap (i.e. one where some
> > keys do nothing) then that's probably ok.
> 
> If such a setup occurs, support for disabling channels could easily be
> added, and in such cases, the keycode is simple ignored. I don't think a
> sparse matrix keymap makes much sense here, especially as the buttons
> are not organized in rows and columns.
> 
> >>> /me mutters usual grumblings about the autorepeat property.
> >>
> >> I took that from the gpio-keys driver. Is there a better way to denote
> >> such a feature?
> > 
> > Unfortunately not, given current practice. My gripe is that it's a Linux
> > detail that were describing rather than a property of the device. We can
> > forget about that for now.
> 
> I see, so I'll leave it as it is.
> 
> I'll drop the input device unregister call as Dmitry said, and repost v5.

Sure, that all sounds fine.

Cheers,
Mark.
