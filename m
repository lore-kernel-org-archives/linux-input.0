From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: Add keycodes for touchpad on/off keys
Date: Tue, 09 Nov 2010 11:13:51 +0000
Message-ID: <1289301231.13239.3.camel@novo.hadess.net>
References: <1289220130.5418.109.camel@novo.hadess.net>
	 <20101109073953.GA14177@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:42236 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab0KILN5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 06:13:57 -0500
In-Reply-To: <20101109073953.GA14177@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, 2010-11-08 at 23:39 -0800, Dmitry Torokhov wrote:
> On Mon, Nov 08, 2010 at 12:42:10PM +0000, Bastien Nocera wrote:
> > Some laptops will have a "touchpad toggle" soft button, which
> > expects user-space to turn off the touchpad themselves, some
> > other devices will do this in hardware, but send key events telling
> > us that the touchpad has been turned off/on.
> > 
> > KEY_TOUCHPAD_ON/KEY_TOUCHPAD_OFF will be used by user-space to
> > show a popup with the status of the touchpad.
> > 
> > Signed-Off-By: Bastien Nocera <hadess@hadess.net>
> > ---
> >  include/linux/input.h |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/linux/input.h b/include/linux/input.h
> > index 896a922..46dca75 100644
> > --- a/include/linux/input.h
> > +++ b/include/linux/input.h
> > @@ -545,6 +545,10 @@ struct input_absinfo {
> >  #define KEY_CONTEXT_MENU	0x1b6	/* GenDesc - system context menu */
> >  #define KEY_MEDIA_REPEAT	0x1b7	/* Consumer - transport control */
> >  
> > +#define KEY_TOUCHPAD_TOGGLE	0x1b8	/* Ask user-space to switch the touchpad off */
> 
> Just off or is it true toggle?

It's a toggle.

> > +#define KEY_TOUCHPAD_ON		0x1b9	/* Tell user-space touchpad is now on */
> > +#define KEY_TOUCHPAD_OFF	0x1ba	/* As above but off */
> 
> I do not like the idea that keycodes are limited to signalling the
> state. Either they can also request the transition to given state or we
> need to find some other way to communicate the state.

The transition is done completely in hardware, so there's no state
whatsoever on the software side, just notifications that something
happened.

This is similar to what some hardware does with mixer settings, still
sending events about the hardware being muted, or the volume having
changed when they handle the mixer events in hardware (at least some
Thinkpads and HP laptops do that).

I don't see how we can export this information in any other way...

Cheers

