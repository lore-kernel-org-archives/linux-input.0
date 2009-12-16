From: Alex Chiang <achiang@hp.com>
Subject: Re: synaptics touchpad doesn't click
Date: Wed, 16 Dec 2009 10:31:59 -0700
Message-ID: <20091216173159.GA26757@ldl.fc.hp.com>
References: <20091215034127.GC587@ldl.fc.hp.com> <20091215062628.GA12669@core.coreip.homeip.net> <s5h1viwn3ig.wl%tiwai@suse.de> <20091215073358.GC12669@core.coreip.homeip.net> <s5hvdg8lm5q.wl%tiwai@suse.de> <20091215082518.GD12669@core.coreip.homeip.net> <20091216010506.GA26367@ldl.fc.hp.com> <20091216025934.GA2699@core.coreip.homeip.net> <20091216065200.GC20352@ldl.fc.hp.com> <20091216070343.GF2699@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:23537 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762536AbZLPRcA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2009 12:32:00 -0500
Content-Disposition: inline
In-Reply-To: <20091216070343.GF2699@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Tue, Dec 15, 2009 at 11:52:00PM -0700, Alex Chiang wrote:
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > > On Tue, Dec 15, 2009 at 06:05:06PM -0700, Alex Chiang wrote:
> > > > * Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > > > >
> > > > > The updated patch is below.
> > > > > 
> > > > > -- 
> > > > > Dmitry
> > > > 
> > > > Should I test this one or wait one more iteration to address
> > > > Takashi's last comments?
> > > > 
> > > 
> > > Actually I think we took the wrong direction with the original patch and
> > > we should do what other buttonless devices (bcm5974) do: report touchpad
> > > click as left button and have Synaptics X driver provide enhanced
> > > support. This way we can have both modes (ClickZones and ClickButtons)
> > > and users will get to chose (provided that someone takes time to add
> > > that support to Synaptics driver of course ;) ).
> > > 
> > > Could you tell me if the below works for you?
> > 
> > Left clicks work. Right/middle do not (as expected, I guess).
> > 
> > I liked the behaviour of Takashi's patch a little better wrt what
> > happens when you try to click/drag, because he disabled movement
> > in the click area.
> 
> Are the clicks register only in that special area? Reading Synaptics
> product description it sounds like entire surface should be clickable.

Well, maybe in theory the entire surface is clickable.

My observation is that the physical design resembles a lever on a
fulcrum though, with the fulcrum at the edge near the keyboard.

Pressing the click zone is mechanically nice, since you are away
from the fulcrum. Moving "up" towards the keyboard, there seems
to be much less mechanical advantage, and the surface doesn't
seem so clicky.

But really, I was talking about what Takashi mentioned in a later
mail, namely that trying to actually click with the click zone in
a precise manner is difficult because as you press the surface
down, the touch pad registers some movement, and moves the
pointer away from the area you're trying to click.

Fitts would have a fit. ;)

/ac

