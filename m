From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not  work
	anymore
Date: Thu, 22 Oct 2009 09:22:02 -0700
Message-ID: <20091022162202.GA18031@core.coreip.homeip.net>
References: <928C125D-D36B-47C9-A549-3EE502C9EC73@gmail.com> <20091015215944.GA9845@core.coreip.homeip.net> <4ADF6237.9070004@tremplin-utc.net> <200910211320.16339.dmitry.torokhov@gmail.com> <4AE0840C.8070801@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:43599 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbZJVQWE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Oct 2009 12:22:04 -0400
Content-Disposition: inline
In-Reply-To: <4AE0840C.8070801@tremplin-utc.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Oct 22, 2009 at 06:10:52PM +0200, =C9ric Piel wrote:
> Op 21-10-09 22:20, Dmitry Torokhov schreef:
> >=20
> > Nothing, as far as I can tell... I see you typing "qwerty"... Does =
the=20
> > keyboard work in console (let's say if you boot in run level 3 to t=
ake X out=20
> > of the picture)? Could you please try compiling evbug module - it w=
ill show if=20
> > keyboard events are propagated through input core. Also, whta drive=
r are you=20
> > using in X? Legacy keyboard or evdev?
> In the console (in init 3), I haven't managed to reproduce it. In xor=
g,
> the keyboard input uses evdev. Now I've just tried "evtest
> /dev/input/event4", when the keyboard doesn't work... and I see the k=
ey
> presses!
>=20
> So I guess it rules out a bug in the kernel, and I have to talk with =
the
> people from Xorg, right?
>=20

Yep... but it is still wierd since evdev driver works fine for me...
Could it be you are using either too old or too new version of X?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
