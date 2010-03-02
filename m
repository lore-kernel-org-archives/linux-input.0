From: Michael Thayer <Michael.Thayer@Sun.COM>
Subject: Re: [PATCH 1/1]: input: add support for VirtualBox touchscreen
 emulation to the Lifebook driver
Date: Tue, 02 Mar 2010 23:00:19 +0100
Message-ID: <1267567219.2441.12.camel@michael-laptop>
References: <1266923615.3602.85.camel@michael-laptop>
 <20100223175852.GA11301@core.coreip.homeip.net>
 <1266958533.3602.128.camel@michael-laptop>
 <20100224100206.GA5598@core.coreip.homeip.net>
 <1267011989.2831.30.camel@michael-laptop>
 <20100225101705.GF10823@core.coreip.homeip.net>
 <1267562688.2441.7.camel@michael-laptop>
 <20100302212812.GA13499@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20100302212812.GA13499@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Le mardi 02 mars 2010 =C3=A0 13:28 -0800, Dmitry Torokhov a =C3=A9crit =
:
> On Tue, Mar 02, 2010 at 09:44:48PM +0100, Michael Thayer wrote:
> > it still provides a reasonable user experience until the user has i=
nstalled our
> > guest drivers.
>=20
> It is your call but I would much rather if you worked on fixeng evdev=
 to
> work with your virtual device rather than having to install a new X
> driver and going through the hoops trying to detect which one should =
be
> used on a particular box. At least on Linux...
That wouldn't really help us much here, as we are talking about distrib=
utions
shipping X.Org Server 1.4 and earlier, and those distributions are no l=
onger
going to get that sort of update (in those cases in which they are stil=
l
getting updates at all).  Legacy support if you like.

Thanks again,

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
