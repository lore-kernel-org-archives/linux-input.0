From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [GIT PULL RFC] directly poll battery strength when reading power_supply
Date: Wed, 7 Dec 2011 17:29:21 +0000
Message-ID: <CAD2FfiF+fVoLPWpPyGGKdnoGhx1f=Loh2Ju-vdU58Y=2kf6C3g@mail.gmail.com>
References: <4EC75224.7070207@goop.org>
	<alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
	<4EC820F8.4070900@goop.org>
	<alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz>
	<4ECA7E7D.80207@goop.org>
	<alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
	<4ECAE019.4000409@goop.org>
	<alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz>
	<4ECCB38A.8000503@goop.org>
	<alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz>
	<CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com>
	<4ED90E6D.8090402@goop.org>
	<CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com>
	<4ED9BDF8.3010600@goop.org>
	<CAD2FfiE-rg-1bMmVpYzBhnQcBMKKKO4WPnu0bvx+pvdFnpARrQ@mail.gmail.com>
	<4EDE4C7A.1010802@goop.org>
	<CAD2FfiHWuEmVTa54YqfJDk5zHpSQuM_nwPT=mR6NoWpajpydpg@mail.gmail.com>
	<4EDFA192.7000602@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59195 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506Ab1LGR3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2011 12:29:22 -0500
Received: by eekd41 with SMTP id d41so708412eek.19
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2011 09:29:21 -0800 (PST)
In-Reply-To: <4EDFA192.7000602@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Daniel Nicoletti <dantti12@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Richard Hughes <richard@hughsie.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On 7 December 2011 17:25, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> Something like this?
> @@ -63,6 +63,9 @@ static ssize_t power_supply_show_property(struct de=
vice *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static char *capacity_level_text[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Unknown", "Cr=
itical", "Low", "Normal", "High", "Full"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> + =C2=A0 =C2=A0 =C2=A0 static char *scope_text[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Unknown", "System=
", "Device"
> + =C2=A0 =C2=A0 =C2=A0 };

That looks perfect.

> Well, what are you really trying to represent? =C2=A0Is it enough for=
 upower
> to say "here are some devices with batteries, this is everything I kn=
ow
> about them", and let its clients work out what they really are? =C2=A0=
Does
> upower need to work out what kind of device it is?

Well, upower just assigns a "kind" to each battery which means the
clients can for instance show all the laptop batteries, but ignore any
mice and keyboards. For practical purposes, it's so we suspend the
computer for a low power laptop battery, but not for a low power
keyboard :)

Richard.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
