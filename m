From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: synaptics touchpad doesn't click
Date: Wed, 16 Dec 2009 00:20:20 -0800
Message-ID: <20091216082020.GG2699@core.coreip.homeip.net>
References: <20091215062628.GA12669@core.coreip.homeip.net> <s5h1viwn3ig.wl%tiwai@suse.de> <20091215073358.GC12669@core.coreip.homeip.net> <s5hvdg8lm5q.wl%tiwai@suse.de> <20091215082518.GD12669@core.coreip.homeip.net> <20091216010506.GA26367@ldl.fc.hp.com> <20091216025934.GA2699@core.coreip.homeip.net> <20091216065200.GC20352@ldl.fc.hp.com> <20091216070343.GF2699@core.coreip.homeip.net> <s5hfx7b5r7a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53023 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934787AbZLPIUZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2009 03:20:25 -0500
Content-Disposition: inline
In-Reply-To: <s5hfx7b5r7a.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alex Chiang <achiang@hp.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Wed, Dec 16, 2009 at 08:11:05AM +0100, Takashi Iwai wrote:
> At Tue, 15 Dec 2009 23:03:43 -0800,
> Dmitry Torokhov wrote:
> > 
> > On Tue, Dec 15, 2009 at 11:52:00PM -0700, Alex Chiang wrote:
> > > * Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > > > On Tue, Dec 15, 2009 at 06:05:06PM -0700, Alex Chiang wrote:
> > > > > * Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > > > > >
> > > > > > The updated patch is below.
> > > > > > 
> > > > > > -- 
> > > > > > Dmitry
> > > > > 
> > > > > Should I test this one or wait one more iteration to address
> > > > > Takashi's last comments?
> > > > > 
> > > > 
> > > > Actually I think we took the wrong direction with the original patch and
> > > > we should do what other buttonless devices (bcm5974) do: report touchpad
> > > > click as left button and have Synaptics X driver provide enhanced
> > > > support. This way we can have both modes (ClickZones and ClickButtons)
> > > > and users will get to chose (provided that someone takes time to add
> > > > that support to Synaptics driver of course ;) ).
> > > > 
> > > > Could you tell me if the below works for you?
> > > 
> > > Left clicks work. Right/middle do not (as expected, I guess).
> > > 
> > > I liked the behaviour of Takashi's patch a little better wrt what
> > > happens when you try to click/drag, because he disabled movement
> > > in the click area.
> > 
> > Are the clicks register only in that special area? Reading Synaptics
> > product description it sounds like entire surface should be clickable.
> 
> In the case of ClickZone, the click in the button area is taken as
> clicks, if I understand correctly.
> 
> The problem is, however, not about where to click.  It's about the
> precision.  When you click a pad, your finger slips a little bit in
> millimeter.  This already corresponds to a few pixels, and the pointer
> moves away from the point you wanted to click.
>

Right, this will have to be dealt with in X driver.

> In my original patch, I disabled the pointer movement in the button
> area before click for avoiding this problem.
>

However it will not work if you want to do 'ClickButtons' mode where
you don't assign secific areas for clicking.

-- 
Dmitry
