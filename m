From: Michael Thayer <Michael.Thayer@Sun.COM>
Subject: Re: [PATCH 1/1]: input: add support for VirtualBox touchscreen
 emulation to the Lifebook driver
Date: Tue, 02 Mar 2010 21:44:48 +0100
Message-ID: <1267562688.2441.7.camel@michael-laptop>
References: <1266923615.3602.85.camel@michael-laptop>
 <20100223175852.GA11301@core.coreip.homeip.net>
 <1266958533.3602.128.camel@michael-laptop>
 <20100224100206.GA5598@core.coreip.homeip.net>
 <1267011989.2831.30.camel@michael-laptop>
 <20100225101705.GF10823@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gmp-eb-inf-1.sun.com ([192.18.6.21]:42108 "EHLO
	gmp-eb-inf-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab0CBUpR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Mar 2010 15:45:17 -0500
In-reply-to: <20100225101705.GF10823@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Dmitry,

Le jeudi 25 f=C3=A9vrier 2010 =C3=A0 02:17 -0800, Dmitry Torokhov a =C3=
=A9crit :
> On Wed, Feb 24, 2010 at 12:46:29PM +0100, Michael Thayer wrote:
> > Le mercredi 24 f=C3=A9vrier 2010 =C3=A0 02:02 -0800, Dmitry Torokho=
v a =C3=A9crit :
> > > On Tue, Feb 23, 2010 at 09:55:33PM +0100, Michael Thayer wrote:
> > > > I'm not sure, if we ended up doing a completely new device, how=
 different it
> > > > would end up being.  Emulating a touchscreen or a tablet makes =
sense for us as
> > > > these are both something known, which will work with existing s=
ystems without
> > > > too much tweaking
> > > > [snip]
> > > But the virtual mouse is not a touchscreen or a tablet, it behave=
s
> > > differently.
> > What would you suggest emulating that exists in the real world?
>=20
> There are not many real devices that have teh same characteristics as
> virtual mouse generating absolute coordinates. Umm, the closest would=
 be
> a wacom tablet when used with its own mouse.
We decided in the end to emulate a USB tablet, as some other virtualise=
rs do.
It works well out of the box with recent Linux distributions, and while=
 older
ones recognise it as a touchpad (in fact they use it through /dev/input=
/mice),
it still provides a reasonable user experience until the user has insta=
lled our
guest drivers.

Thank you again for your comments and assistance.

Regards,

Michael
--=20
Sun Microsystems GmbH        Michael Thayer
Werkstrasse 24               VirtualBox engineer
71384 Weinstadt, Germany     mailto:michael.thayer@sun.com

Sitz der Gesellschaft:
Sun Microsystems GmbH, Sonnenallee 1, 85551 Kirchheim-Heimstetten
Amtsgericht Muenchen: HRB 161028
Geschaeftsfuehrer: Thomas Schroeder, Wolfgang Engels
Vorsitzender des Aufsichtsrates: Martin Haering

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
