From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: Sensitivity of Synaptics pointing stick
Date: Sun, 17 Feb 2008 17:49:15 +0100
Message-ID: <47B8658B.8020104@web.de>
References: <47B486B5.8070202@web.de> <fp4tbt$6km$1@ger.gmane.org>	<47B6AD0D.5060109@web.de> <fp7svm$4ve$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig53647AD98538B8BC3E26F875"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:60499 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYBQQtV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Feb 2008 11:49:21 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 15C9AD36EA48
	for <linux-input@vger.kernel.org>; Sun, 17 Feb 2008 17:49:20 +0100 (CET)
Received: from [88.64.25.126] (helo=[192.168.1.198])
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1JQmhb-0004Ud-00
	for linux-input@vger.kernel.org; Sun, 17 Feb 2008 17:49:19 +0100
In-Reply-To: <fp7svm$4ve$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53647AD98538B8BC3E26F875
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov wrote:
> Jan Kiszka wrote:
>=20
>> Dmitry Baryshkov wrote:
>>> Hi, Jan,
>>>
>>> Jan Kiszka wrote:
>>>
>>>> Hi,
>>>>
>>>> it looks like I have a Synaptics pointing stick on my Lifebook E8110=
,
>>>> connected as PS/2 pass-through device via a Synaptics touchpad. It
>>>> works, but it is horribly insensitive, making me crack my fingers
>>>> regularly. Is anyone aware of a way to tune the sensitivity of this
>>>> device (like one can do with Thinkpad trackpoints)?
>>>>
>>>>
>>> It's strange, because I have the same laptop and both touch pad and
>>> touch stick are working very well. Try setting MinSpeed, MaxSpeed,
> Hi, Ian,
>=20
>>> AccelFactor and TrackstickSpeed parameters.
>> It doesn't like me: I do not see any impact. Could you send me your
>> XF11Config to crosscheck?
>=20
> Sure:
>=20
> Section "InputDevice"
>         Identifier      "Synaptics Touchpad"
>         Driver          "synaptics"
>         Option          "Device"                "/dev/psaux"
>         Option          "Protocol"              "auto-dev"
>         Option          "HorizScrollDelta"      "0"
>         Option          "SHMConfig"             "true"
> EndSection
>=20

Hmm, but that's for the touchpad, not the trackpoint. And it doesn't
contain any sensitivity parameters. /me is confused.

Jan



--------------enig53647AD98538B8BC3E26F875
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHuGWPniDOoMHTA+kRAqQxAJ9/4Pthhd33qZ/F/xLXgUAN6lA+0wCfdgae
cLx+Ym/qFg9iQJkTC7XJ4r4=
=6clU
-----END PGP SIGNATURE-----

--------------enig53647AD98538B8BC3E26F875--
