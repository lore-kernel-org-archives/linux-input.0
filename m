From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [git pull] Input updates for 2.6.35-rc0
Date: Fri, 28 May 2010 16:19:57 +1000
Message-ID: <20100528061957.GA19624@quokka.bne.redhat.com>
References: <20100520165243.GA20861@core.coreip.homeip.net>
 <alpine.LFD.2.00.1005271837050.11382@i5.linux-foundation.org>
 <AANLkTiklv48cDWNqKlFfh5RVtxxNH8shH_JjDypPgeHA@mail.gmail.com>
 <alpine.LFD.2.00.1005272108210.11382@i5.linux-foundation.org>
 <AANLkTinPt49coLNjPqJSSxDP8zTmnjbKuIP1NuQFvwL-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:31731 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab0E1GUD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 02:20:03 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinPt49coLNjPqJSSxDP8zTmnjbKuIP1NuQFvwL-@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, Arjan Opmeer <arjan@opmeer.net>, Eric Piel <eric.piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Fri, May 28, 2010 at 03:44:18PM +1000, Dave Airlie wrote:
> On Fri, May 28, 2010 at 2:12 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Fri, 28 May 2010, Dave Airlie wrote:
> >>
> >> Was this in GNOME?
> >>
> >> Does System->Preferences->Mouse have a touchpad tab? do it have tapping off?
> >
> > Bingo! Yup, that turns a totally useless piece-of-crap touchpad into a
> > perfectly cromulent one!
> >
> > Too bad that the default behavior made it act so horribly bad.
> >
> 
> I've cc'ed Peter, but I think thats the GNOME default behaviour, which
> might make sense for older style touchpads, but maybe not for these newer
> the touchpad is a button type.

Default behaviour is tapping on for no-button touchpads (like the ones on
the apples) and tapping off for everything else. <insert flamewar here>
If you're suggesting to change the defaults, I think you're best off just
filing a GNOME bug - the number of multi-finger tap-capable touchpads has
increased enough in the last years that this default is worth rethinking.

For the rest - please leave the touchpad in touchpad mode, because while the
emulation may look nice if you like tapping, it removes a lot of the other
configuration features that the driver can otherwise provide (edge
scrolling, multifinger scrolling, clickfinger, to name just a few).

Cheers,
  Peter
