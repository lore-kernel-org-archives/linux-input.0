From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] ntrig tool separation
Date: Wed, 17 Jun 2009 14:37:44 -0400
Message-ID: <4A3937F8.9080606@seas.upenn.edu>
References: <4A388422.7020802@seas.upenn.edu> <9A2A8015-912B-498D-B5E1-1D79B933DECD@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.SEAS.upenn.edu ([158.130.12.194]:45867 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759585AbZFQShr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 14:37:47 -0400
In-Reply-To: <9A2A8015-912B-498D-B5E1-1D79B933DECD@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Good point, that's actually what I did earlier in my much sloppier vers=
ion.  I'll rewrite this patch.

St=E9phane Chatty wrote:
>=20
> Le 17 juin 09 =E0 07:50, Rafi Rubin a =E9crit :
>=20
>> When both touch and pen are active send a tool announcement before
>> sending any status changes so that event users may differentiate
>> which tool is changing.
>>
>=20
> With my multitouch-enabled TouchSmart tx2 (firwmare 4.2.17.8.5, final=
ly
> found it!) I get a series of ten BTN_TOOL_DOUBLETAP (value =3D 0 then=
 1,
> five times) in every event. This is because the device emits HID_GD_X
> several times in every event, whatever the real number of touches on =
the
> screen.
>=20
> The way to avoid this would be to delay the emission of your
> BTN_TOOL_DOUBLETAP as I did for ABS_X and ABS_Y, that is when we rece=
ive
> HID_DG_HEIGHT (single touch firmware) or 0xff000002 (multi-touch firm=
ware)
>=20
> St.
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAko5N/cACgkQwuRiAT9o609lZACfUyxsUSbrSXSsZtJFXLgBSU9B
J0kAmwSeANwjprdqc6BTjIFozVWsfQxn
=3D5z+v
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
