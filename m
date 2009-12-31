From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.33-rc2
Date: Wed, 30 Dec 2009 17:22:52 -0800
Message-ID: <20091231012252.GA13512@core.coreip.homeip.net>
References: <20091227214924.GB16279@core.coreip.homeip.net>
 <alpine.LFD.2.00.0912301257340.11961@localhost.localdomain>
 <C08FBDE4-7143-46E4-9DB8-912E870D0008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52977 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbZLaBW5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2009 20:22:57 -0500
Content-Disposition: inline
In-Reply-To: <C08FBDE4-7143-46E4-9DB8-912E870D0008@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Dec 30, 2009 at 01:16:31PM -0800, Dmitry Torokhov wrote:
>=20
>=20
>=20
>=20
> On Dec 30, 2009, at 12:58 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>=20
> >
> >
> >On Sun, 27 Dec 2009, Dmitry Torokhov wrote:
> >>
> >>8 files changed, 84 insertions(+), 70 deletions(-)
> >
> >I get
> >
> >14 files changed, 94 insertions(+), 96 deletions(-)
> >
> >so unpulled.
> >
> >If you updated your tree on purpose, you need to send me an email
> >saying
> >so (preferably as a reply to your previous "please pull", so that
> >when I
> >see the old one and it doesn't match what I get, I can then also
> >see the
> >new one without having to search for it)
>=20
> Yes, I just updated that branch with more fixes, not seeing any
> pulls after rc2 i thought you were gone till after New Year. I will
> resend updated pull request later tonight.
>=20

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

Dmitry Torokhov (7):
      Input: speed up suspend/shutdown for PS/2 mice and keyboards
      Input: serio - do not mark kseriod freezable anymore
      Input: ff-memless - another fix for signed to unsigned overflow
      Input: iforce - fix oops on device disconnect
      Input: matrix-keypad - handle cases when GPIOs can't be wakeup so=
urces
      Input: lifebook - add CONFIG_DMI dependency
      Input: iforce - wait for command completion when closing the devi=
ce

=46elipe Balbi (2):
      Input: twl4030_keypad - switch to using threaded IRQ
      Input: twl4030-pwrbutton - switch to using threaded IRQ

Jari Vanhala (2):
      Input: ff-memless - start playing FF effects immediately
      Input: ff-memless - add notion of direction to for rumble effects

Rakib Mullick (1):
      Input: wistron - fix test for CONFIG_PM

Ren=E9 Bolldorf (1):
      Input: psmouse - fix compile warning in hgpk module


Diffstat:
--------

 drivers/input/ff-memless.c                  |   48 +++++++++++++++++++=
++++----
 drivers/input/joystick/iforce/iforce-main.c |   29 ++++------------
 drivers/input/joystick/iforce/iforce-usb.c  |   29 ++++------------
 drivers/input/joystick/iforce/iforce.h      |    2 -
 drivers/input/keyboard/atkbd.c              |    5 ++-
 drivers/input/keyboard/matrix_keypad.c      |   29 ++++++++++++----
 drivers/input/keyboard/twl4030_keypad.c     |   11 +-----
 drivers/input/misc/twl4030-pwrbutton.c      |   14 +-------
 drivers/input/misc/wistron_btns.c           |    2 +-
 drivers/input/mouse/Kconfig                 |    2 +-
 drivers/input/mouse/hgpk.c                  |    1 -
 drivers/input/mouse/lifebook.c              |    2 -
 drivers/input/mouse/psmouse-base.c          |    5 ++-
 drivers/input/serio/serio.c                 |   11 +-----
 14 files changed, 94 insertions(+), 96 deletions(-)

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
