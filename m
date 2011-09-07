From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: elantech touchpad issues
Date: Wed, 07 Sep 2011 09:46:50 +0800
Message-ID: <8762l5unsl.fsf@emc.com.tw>
References: <4E6633E5.6080108@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:55918 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab1IGBob convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 21:44:31 -0400
In-Reply-To: <4E6633E5.6080108@t-online.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard =?utf-8?Q?Sch=C3=BCtz?= <r.schtz@t-online.de>, linux-input@vger.kernel.org
Cc: Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>

Hi Richard,

I will try to find a touchpad that matches your model and see what I ca=
n
do.

jj

On Tue, 06 Sep 2011 16:53:25 +0200, Richard Sch=C3=BCtz <r.schtz@t-onli=
ne.de> wrote:
> Hello everybody!
>=20
> I'm owning a Samsung N145P netbook, that comes along with an elantech=
=20
> touchpad:
>=20
> [    5.949921] elantech: assuming hardware version 2, firmware versio=
n=20
> 4.2.22
> [    5.985481] elantech: Synaptics capabilities query result 0x09, 0x=
14,=20
> 0x0b.
>=20
> It has some annoying issues, which hopefully can be resolved now as=20
> there is some ongoing development on the driver again. I have already=
=20
> tested the current "[PATCH v5 0/8] Input: elantech: add support for=20
> newer hardware" patchset, but without success.
>=20
>=20
> The device's axis ranges, which are reported to userspace, seem to be=
=20
> totally wrong.
>=20
> (kernel 3.0.4)
> [    17.940] (--) ETPS/2 Elantech Touchpad: x-axis range 8 - 1144
> [    17.940] (--) ETPS/2 Elantech Touchpad: y-axis range 8 - 760
>=20
> (kernel 3.0.4 + patchset)
> [    16.936] (--) ETPS/2 Elantech Touchpad: x-axis range 0 - 1152
> [    16.936] (--) ETPS/2 Elantech Touchpad: y-axis range 0 - 576
>=20
> I get the following ranges, when I use synclient in monitor mode to l=
ook=20
> which values really are passed to the synaptics driver in X:
>=20
> (kernel 3.0.4)
> x: 0-819
> y: 355-760
>=20
> (kernel 3.0.4 + patchset)
> x: 0-819
> y: 171-576
>=20
> Because of this differences the edge/scrolling areas of the touchpad =
are=20
> calculated wrong and can't be used by default.
>=20
>=20
> The other issue occurs very often when two fingers are used:
>=20
> (kernel 3.0.4)
>      time     x    y   z f  w  l r u d m     multi  gl gm gr gdx gdy
>     7.982  1020 -268 127 2  7  0 0 0 0 0  00000000
>=20
> (kernel 3.0.4 + patchset)
>      time     x    y   z f  w  l r u d m     multi  gl gm gr gdx gdy
>     3.118  1020 -444 127 2  7  0 0 0 0 0  00000000
>=20
> When the fingers are released this strange values are reported. This=20
> makes two finger scrolling unusable, because it jumps back to the=20
> beginning everytime.
>=20
> --=20
> Regards,
> Richard Sch=C3=BCtz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
