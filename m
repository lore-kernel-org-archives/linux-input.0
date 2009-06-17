From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] Restoring usages used by the pen.
Date: Wed, 17 Jun 2009 14:34:56 -0400
Message-ID: <4A393750.7020706@seas.upenn.edu>
References: <4A385751.8000904@seas.upenn.edu> <93BE517D-F863-4F80-8060-CC36562E02CC@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.SEAS.upenn.edu ([158.130.12.194]:49899 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760056AbZFQSfK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 14:35:10 -0400
In-Reply-To: <93BE517D-F863-4F80-8060-CC36562E02CC@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, brysgo@gmail.com, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Sebastien Hamdani <sebastien.hamdani@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

I did in fact submit a patch to linuxwacom a while ago specifically to =
solve that problem.

Perhaps in the long run a separate driver would be better.  But on the =
other hand, there is so much that is similar in the way the
devices behave and in the output we'd like from the driver, that it rea=
lly seems a shame to have to fork or rewrite.


diff -r1.39 wcmUSB.c
510c510,511
< 	{ 0x9A, 2540, 2540, &usbTabletPC   }  /* TabletPC 0x9A */
---
> 	{ 0x9A, 2540, 2540, &usbTabletPC   },  /* TabletPC 0x9A */
> 	{ 0x1, 935, 1122, &usbTabletPC   }  /* TabletPC 0x9A */
529c530
< 	if (sID[1] =3D=3D 0x056A)
---
> 	if (sID[1] =3D=3D 0x056A || sID[1] =3D=3D 0x1b96)
552c553
< 		if (common->tablet_id =3D=3D 0x9A || common->tablet_id =3D=3D 0x93 =
|| common->tablet_id =3D=3D 0x90)
---
> 		if (common->tablet_id =3D=3D 0x9A || common->tablet_id =3D=3D 0x93 =
|| common->tablet_id =3D=3D 0x90 || common->tablet_id=3D=3D1)


St=E9phane Chatty wrote:
>=20
> Le 17 juin 09 =E0 04:39, Rafi Rubin a =E9crit :
>=20
>> Restoring usages used by the pen.
>>
>> +
>> +        /* these are actually used by the pen */
>> +        case HID_DG_INVERT: /* high when the eraser button is press=
ed */
>> +        case HID_DG_ERASER: /* high when the tip and eraser are bot=
h
>> pressed */
>> +        case HID_DG_BARRELSWITCH:  /* doubtful */
>> +            return 0;
>=20
> I just tested this on my multitouch-enabled Touchsmart tx2 (that is, =
one
> on which the Windows 7 driver published by NTrig in March 2009 was
> installed, which triggered a firmware install).
>=20
> This is tricky:
>  - as one can expect, the multitouch events are still emitted properl=
y.
> Fine.
>  - but the Wacom Xorg driver patched by Rafi is not interested in the
> device anymore. I had managed to emit touchscreen-like events for the
> first finger detected on the screen, so as to feed Xorg with pointer
> events. This does not work anymore. This probably has to do with the
> complex rules that have been designed over time to decide what type o=
f
> device should be handled by what driver. I remember having to dig dee=
p
> in the code of hid, input *and* the Wacom driver last month to fit in
> these rules.
>=20
> TBH, this is not a big loss to me personally, because:
>  - so far I had not been able to give the appropriate Xmax and Ymax
> parameters to the Wacom Xorg driver, so the pointer was badly warped =
and
> this was pretty useless anyway.
>  -  at some point we'll probably want the NTrig digitizer to be manag=
ed
> by another Xorg driver than the Wacom driver. Peter? Bryan? What do y=
ou
> think?
>=20
> I guess the whole issue is to try and understand what will be the mos=
t
> popular uses of this device:
>  - with which version of the firmware? the one with stylus and single
> touch? the one with multitouch but no stylus?
>  - as a touch screen? as a pen computer?
>=20
> Leaving aside the pain of having incompatible versions of the firmwar=
e
> around, it looks this type of dual device (stylus + finger) challenge=
s
> the way linux-hid, linux-input and Xorg regard touch devices: yes,
> something that looks like a touchscreen can be a digitizer too... May=
be
> we should create two Linux devices, one for the stylus and one for fi=
ngers?
>=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
