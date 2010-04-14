From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Acpi4asus-user] Hotkeys generating input as well as ACPI events
Date: Wed, 14 Apr 2010 15:11:09 -0700
Message-ID: <20100414221109.GA12040@core.coreip.homeip.net>
References: <87vdbvvbp8.fsf@cybersource.com.au>
 <g2j71cd59b01004130512ydcecbbf9n5a8c5e271881d080@mail.gmail.com>
 <87633uq0oz.fsf@cybersource.com.au>
 <r2z71cd59b01004132314r6fdbbd63r3fba622d1c6f105f@mail.gmail.com>
 <87pr22o83t.fsf@cybersource.com.au>
 <s2x71cd59b01004140011jc2416c14x259627e278c6a162@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62248 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692Ab0DNWLT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 18:11:19 -0400
Received: by vws18 with SMTP id 18so298260vws.19
        for <linux-input@vger.kernel.org>; Wed, 14 Apr 2010 15:11:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s2x71cd59b01004140011jc2416c14x259627e278c6a162@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: "Trent W. Buck" <twb@cybersource.com.au>, acpi4asus-user@lists.sourceforge.net, debian-eeepc-devel@lists.alioth.debian.org, linux-input@vger.kernel.org

On Wed, Apr 14, 2010 at 09:11:24AM +0200, Corentin Chary wrote:
> On Wed, Apr 14, 2010 at 8:34 AM, Trent W. Buck <twb@cybersource.com.a=
u> wrote:
> > Corentin Chary <corentin.chary@gmail.com>
> > writes:
> >
> >> All seems ok and I was able to reproduce the issue (only in screen=
),
> >
> > Hmm; I can also reproduce this as root on vt2, without screen. =A0I=
t's
> > more obvious if I run "cat -A" before typing; otherwise I only see =
a ~
> > and hear a beep.
> >
> >> but I don't really know what's the best way to fix it.
> >> Isn't there any way to "ignore" an input device in screen/fbcon ?
> >
> > I don't know. =A0I guess that would be disconnecting
> >
> > =A0 =A0/sys/devices/platform/eeepc/input/input8
> > =A0 =A0i.e. SUBSYSTEM=3D=3D"input", NAME=3D=3D"Asus EeePC extra but=
tons"
> >
> > ...from fbcon. =A0Obviously I don't want to disable the ACPI events=
, nor
> > the normal keyboard input. =A0I'll try to find an fbcon guru.
> >
> > I might be able to patch terminfo/termcap entries to discard those
> > escape sequences, but it feels like a bodge.
> >
>=20
> If there is no way to ignore an input device in userspace, maybe the
> right way to do it is to add a way to disable an input device using
> some /sys/ file.
>=20
> CC-ing linux-input, they probably have something to tell about that.
>=20

I'd say kernel should settle on the delivery transport and simply not
use both.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
