From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Route kbd leds through the generic leds layer (3rd
 version)
Date: Sun, 7 Mar 2010 09:25:19 +0100
Message-ID: <20100307082519.GC1987@elf.ucw.cz>
References: <20100224012010.GA4062@const>
 <20100225013840.GA5519@const.homenet.telecomitalia.it>
 <20100225102056.GG10823@core.coreip.homeip.net>
 <20100225214403.GB9378@const.homenet.telecomitalia.it>
 <20100226035448.GA16797@core.coreip.homeip.net>
 <20100226103505.GB3992@const.homenet.telecomitalia.it>
 <20100306065457.GE28759@elf.ucw.cz>
 <20100306123058.GE5203@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:36741 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750857Ab0CGIZG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Mar 2010 03:25:06 -0500
Content-Disposition: inline
In-Reply-To: <20100306123058.GE5203@const.famille.thibault.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-found

On Sat 2010-03-06 13:30:58, Samuel Thibault wrote:
> Pavel Machek, le Sat 06 Mar 2010 07:54:57 +0100, a =E9crit :
> > > That being said, usermode tools which want to set up the modifier=
s and
> > > connect the input LEDs to them need an easy and proper way to do =
so.
> > > Having central input::numlock and such still seems a good thing.
> >=20
> > This is something where I'm not too sure. Opening few files in
> > sequence is not that hard to the userland so "group of leds"
> > abstraction does not make too much sense...
>=20
> But then userland has to monitor keyboard hotplug. At the moment,
> neither kbd nor console-setup use a daemon to handle keyboards, and I
> doubt their authors will be happy to have to.

Okay, that makes some sense.

But you mentioned having per-keyboard led would be quite easy, it does
not seem to be controversial, so perhaps that's way to go, first?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
