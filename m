From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1]: input: add support for VirtualBox touchscreen
 emulation to the Lifebook driver
Date: Tue, 2 Mar 2010 13:28:12 -0800
Message-ID: <20100302212812.GA13499@core.coreip.homeip.net>
References: <1266923615.3602.85.camel@michael-laptop>
 <20100223175852.GA11301@core.coreip.homeip.net>
 <1266958533.3602.128.camel@michael-laptop>
 <20100224100206.GA5598@core.coreip.homeip.net>
 <1267011989.2831.30.camel@michael-laptop>
 <20100225101705.GF10823@core.coreip.homeip.net>
 <1267562688.2441.7.camel@michael-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:57671 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0CBV2V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Mar 2010 16:28:21 -0500
Content-Disposition: inline
In-Reply-To: <1267562688.2441.7.camel@michael-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Thayer <Michael.Thayer@Sun.COM>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 02, 2010 at 09:44:48PM +0100, Michael Thayer wrote:
> Hello Dmitry,
>=20
> Le jeudi 25 f=E9vrier 2010 =E0 02:17 -0800, Dmitry Torokhov a =E9crit=
 :
> > On Wed, Feb 24, 2010 at 12:46:29PM +0100, Michael Thayer wrote:
> > > Le mercredi 24 f=E9vrier 2010 =E0 02:02 -0800, Dmitry Torokhov a =
=E9crit :
> > > > On Tue, Feb 23, 2010 at 09:55:33PM +0100, Michael Thayer wrote:
> > > > > I'm not sure, if we ended up doing a completely new device, h=
ow different it
> > > > > would end up being.  Emulating a touchscreen or a tablet make=
s sense for us as
> > > > > these are both something known, which will work with existing=
 systems without
> > > > > too much tweaking
> > > > > [snip]
> > > > But the virtual mouse is not a touchscreen or a tablet, it beha=
ves
> > > > differently.
> > > What would you suggest emulating that exists in the real world?
> >=20
> > There are not many real devices that have teh same characteristics =
as
> > virtual mouse generating absolute coordinates. Umm, the closest wou=
ld be
> > a wacom tablet when used with its own mouse.
> We decided in the end to emulate a USB tablet, as some other virtuali=
sers do.
> It works well out of the box with recent Linux distributions, and whi=
le older
> ones recognise it as a touchpad (in fact they use it through /dev/inp=
ut/mice),

Yes, mousedev will provide workable approximation of standard mouse for
a device that provides absolute events. BTW, the fact that data from a
device is available from /dev/input/mice does not mean that device was
recognized as a mouse, a touchpad or something else. It just means that
kernel is able to approximate device as a standard PS/2 Expolorer mouse=
=2E

> it still provides a reasonable user experience until the user has ins=
talled our
> guest drivers.

It is your call but I would much rather if you worked on fixeng evdev t=
o
work with your virtual device rather than having to install a new X
driver and going through the hoops trying to detect which one should be
used on a particular box. At least on Linux...

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
