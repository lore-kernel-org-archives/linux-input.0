From: roswest <roswest@cisco.com>
Subject: Re: USB vulnerabilities
Date: Thu, 28 Jul 2016 16:58:27 -0400
Message-ID: <c82cf97a-444b-07b6-bc35-6350aa3797c9@cisco.com>
References: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
 <20160728174848.GA16852@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LGXHJsctWWmVCx3pfGCDr3NuLf6BeaGCo"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:10391 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbcG1U6c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 16:58:32 -0400
In-Reply-To: <20160728174848.GA16852@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Christopher Kopek <ckopek@cisco.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LGXHJsctWWmVCx3pfGCDr3NuLf6BeaGCo
Content-Type: multipart/mixed; boundary="ffAocoQT50fwfrBK8IcRbgbCj4kbEmhbq"
From: roswest <roswest@cisco.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Christopher Kopek <ckopek@cisco.com>
Message-ID: <c82cf97a-444b-07b6-bc35-6350aa3797c9@cisco.com>
Subject: Re: USB vulnerabilities
References: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
 <20160728174848.GA16852@dtor-ws>
In-Reply-To: <20160728174848.GA16852@dtor-ws>

--ffAocoQT50fwfrBK8IcRbgbCj4kbEmhbq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dmitry,

Tomorrow is his last day, but he is going to try to accomplish that.

Rosie

On Thu Jul 28 2016 13:48:48 GMT-0400 (EDT), Dmitry Torokhov wrote:
> Hi Rosie,
>=20
> On Thu, Jul 28, 2016 at 12:23:09PM -0400, roswest wrote:
>>
>> Dmitry,
>>
>> Hi, I am an engineer at Cisco Systems, and this summer we tasked some
>> interns with performing USB fuzzing. One of the interns, Anirudh Bagde=
,
>> was able to crash the USB stack due to an error in the iforce module a=
nd
>> discovered a buffer over-read in the usbtouchscreen module.  Please se=
e
>> the attachment for details.
>=20
> Thank you for the report. Any chance Anirudh could provide patches to
> fix these issues as well?
>=20
> Thanks!
>=20


--ffAocoQT50fwfrBK8IcRbgbCj4kbEmhbq--

--LGXHJsctWWmVCx3pfGCDr3NuLf6BeaGCo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAleacfUACgkQBAXm4T8ynGvjLwCfasZwDvdFeyM/y56jnk9NeT9E
j7IAoLPJsElhCk866433BMekYxCv7DT8
=vINq
-----END PGP SIGNATURE-----

--LGXHJsctWWmVCx3pfGCDr3NuLf6BeaGCo--
