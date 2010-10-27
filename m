From: Samuel Thibault <sthibault@debian.org>
Subject: Re: Bug#594089: keyboard-configuration: caps lock keycode problem
Date: Wed, 27 Oct 2010 17:22:42 +0200
Message-ID: <20101027152242.GO4725@const.famille.thibault.fr>
References: <20101024144150.GV24091@const.famille.thibault.fr> <20101025045003.GA1438@core.coreip.homeip.net> <4CC58816.3090301@triadsys.com> <20101025180320.GA4725@const.famille.thibault.fr> <4CC6E9D8.8010201@triadsys.com> <20101026161820.GE13097@core.coreip.homeip.net> <4CC7426C.8040502@triadsys.com> <20101027091029.GB28895@core.coreip.homeip.net> <20101027120513.GT4725@const.famille.thibault.fr> <99F91536-4413-430C-9932-7CEF6AB656DB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:35517 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933342Ab0J0PWo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Oct 2010 11:22:44 -0400
Content-Disposition: inline
In-Reply-To: <99F91536-4413-430C-9932-7CEF6AB656DB@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tom Vier <tom@triadsys.com>, "594089@bugs.debian.org" <594089@bugs.debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Dmitry Torokhov, le Wed 27 Oct 2010 08:06:26 -0700, a =E9crit :
> On Oct 27, 2010, at 5:05 AM, Samuel Thibault <sthibault@debian.org> w=
rote:
>=20
>=20
>     Dmitry Torokhov, le Wed 27 Oct 2010 02:10:29 -0700, a =E9crit :
>=20
>         Also, based on evtest data I only see presses/releases for on=
e key
>         (Caps Lock, Right Shift, etc.) I do not see the presses for t=
he additional
>         keys in the evtest stream so I am baffled as to where the add=
itional
>         scancode is coming from... Do you have some funky keymap load=
ed?
>         Anything interesting in dumpkeys?
>=20
>=20
>     Err, since the duplicates appear in scancodes already, is the con=
tent of
>     dumpkeys really involved?
>=20
> Evtest data does not show any additional events, so the additional sc=
ancodes
> must be coming from the legacy keyboard driver.=20

Sure, but dumpkeys shows the table from scancodes to keycodes, not from
input events to scancodes.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
