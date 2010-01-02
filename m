From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE Remote"
  quirky remote
Date: Sat, 2 Jan 2010 22:25:30 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001022221320.2277@pobox.suse.cz>
References: <3711715e0912310013u25e921cbqe6abb7c1621109e@mail.gmail.com>  <20100102025312.GC5788@core.coreip.homeip.net> <3711715e1001020152s626739daw6cdf2d7742a0d959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37315 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657Ab0ABVZf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Jan 2010 16:25:35 -0500
In-Reply-To: <3711715e1001020152s626739daw6cdf2d7742a0d959@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wayne Thomas <waynethomas69@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2 Jan 2010, Wayne Thomas wrote:

> >> The Behavior Tech. Computer Corp. (BTC) remote branded as "Emprex =
3009URF III
> >> Vista Remote Controller" uses non-standard mappings for all of its=
 'special
> >> purpose' keys (0xffbc usage page). =A0Applies cleanly to 2.6.30 an=
d 2.6.32
> >> (other versions not tested).
> >> scripts/scriptpatch.pl reports 13 styling errors in hid-btc.c
> >> ("break;" should be on trailing lines)
> >> but have not changed them to maintain styling consistency with exi=
sting drivers.
> >
> > I believe that this kind of mapping adjustment can be done via UDEV=
/HAL
> > key remapping facilities, without need for the kernel patch.
>=20
> I'll look into what you have suggested.  The issue is identical to
> that of the TopSeed remote, which is why I used this method.  If this
> is the case I assume that the topseed driver (and any others) should
> also be removed?

Hi Wayne,

unfortunately you have a point here.

Moving all the drivers which don't do anything else than establish simp=
le=20
HID->input mappings (such as your driver, or the TopSpeed one), into=20
userspace (udev, please note that HAL is now deprecated), has been on m=
y=20
TODO list for quite a long time.

But there has unfortunately always been something more important, so I=20
have been quite sluggish with this.

If you'd be submitting your changes for BTC to udev, it would be cool i=
f=20
you could do the same for other drivers we now have in kernel, so that=20
they could be removed one day.
Otherwise I'll do it hopefully soon, I will push it in my TODO a little=
=20
bit higher as a new-year's resolution :)

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
