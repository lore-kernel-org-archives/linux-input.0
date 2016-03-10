From: Andrew Shadura <andrew.shadura@collabora.co.uk>
Subject: Re: [PATCH v2] HID: report only one button for PenMount 6000 USB
 touchscreen controller
Date: Thu, 10 Mar 2016 12:46:38 +0100
Message-ID: <56E15E9E.4090107@collabora.co.uk>
References: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk>
 <565456F3.8080408@collabora.co.uk>
 <CAH9NwWfj4pNuqBhYj7ZJQbzqyJ19UpT3iNY8avX-Uu6XLtMW7g@mail.gmail.com>
 <569514D6.2060204@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LkbXQ9xs3VnCUDl4bjgU6NTmHdl5MSRFt"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32883 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbcCJLqn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 06:46:43 -0500
In-Reply-To: <569514D6.2060204@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>, =?UTF-8?B?SmnFmcOtIEtvc2luYQ==?= <jkosina@suse.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LkbXQ9xs3VnCUDl4bjgU6NTmHdl5MSRFt
Content-Type: multipart/mixed; boundary="KAF0XkrmqxTHHViPhW4nCxaWtqXSsPoGq"
From: Andrew Shadura <andrew.shadura@collabora.co.uk>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>,
 =?UTF-8?B?SmnFmcOtIEtvc2luYQ==?= <jkosina@suse.com>
Message-ID: <56E15E9E.4090107@collabora.co.uk>
Subject: Re: [PATCH v2] HID: report only one button for PenMount 6000 USB
 touchscreen controller
References: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk>
 <565456F3.8080408@collabora.co.uk>
 <CAH9NwWfj4pNuqBhYj7ZJQbzqyJ19UpT3iNY8avX-Uu6XLtMW7g@mail.gmail.com>
 <569514D6.2060204@collabora.co.uk>
In-Reply-To: <569514D6.2060204@collabora.co.uk>

--KAF0XkrmqxTHHViPhW4nCxaWtqXSsPoGq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/01/16 15:59, Andrew Shadura wrote:
> On 27/11/15 16:18, Christian Gmeiner wrote:
>> > 2015-11-24 13:24 GMT+01:00 Andrew Shadura <andrew.shadura@collabora.=
co.uk>:
>>> >> On 29/10/15 16:00, Andrew Shadura wrote:
>>>> >>> PenMount 6000 USB resistive touchscreen controller reports it ha=
s three
>>>> >>> buttons, while in reality it doesn't have any and doesn't suppor=
t active
>>>> >>> styli, and only generates touch events.
>>>> >>>
>>>> >>> In penmount_input_mapping(), map only the first button (with cod=
e 0),
>>>> >>> ignore the rest.
>>>> >>>
>>>> >>> Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>
>>> >>
>>> >> Any news on this patch? It'd be cool if it could be merged.
>> >=20
>> > I try to get access to the hardware and will test it.
> Christian, have you had a chance to test the patch?

Ping, once again. Any progress on this?

--=20
Cheers,
  Andrew


--KAF0XkrmqxTHHViPhW4nCxaWtqXSsPoGq--

--LkbXQ9xs3VnCUDl4bjgU6NTmHdl5MSRFt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4V6eAAoJEEFnG7NKhJOBI8kQAMVPUYXRGdRu+EaYV8ogtOht
NvFfZ0O4aZR2eJPEXwiii4VBUoxsGnkza0UV/cFk4sNMycR4DZQUXWDcu0lP5Rpk
opjFipUBmgFVKef0DrlK5phogvfQUgU39uJhY+Vkq1ie2CdAcw/ZqT0tmaBPYwWg
PGY2pnFgBR89XYjzA70h4pvCQ7wtjPViUqX1g/QW5v6kk6k+NZL85pzpgNjVwlL/
cJqtDyc0m8k1dquafYaRoP+mL6AhGyuRJ02qmKTYBPit5dP+vNcJ83hDsEbbIE5a
ekZ6Uj8t+6afz3cuuaVGf27P4bryUPKFcuRpH793Ib8UDySkJ8FnEKiSbxPoZ3Ez
HnxqJvq4ArVEyImqJxtZ8nqibJXyUIkyHlhPUOiCo1iL/ghY4+6d4aD0BLtC2ciV
gKj+KLpVCMK0K7lfJMZB/Sg11ulpLdz6kwsMQoQ/rOPV6KzTGoH2cYUK2t2zCUbO
NBvt3alyvEhJT8AOlaaQGhFsf71Sm60J3YmWX0jDeLNmLXNkT275UzCeULYjhTJ4
dQHYzqd3gH/PHJWSMC1zuyAjlSFFsLFPu63rWHl3Y72oSwh6YJjSYfKXofUGb2Fr
WSk0GBerfd1v3GTutEAyQHwQHfq2ZeoiLlRoPRuVAIHWnWmzEQ5f7GWS3WXy4GVw
kr2C6avLezqIkQfckSe1
=w3GL
-----END PGP SIGNATURE-----

--LkbXQ9xs3VnCUDl4bjgU6NTmHdl5MSRFt--
