From: Andrew Shadura <andrew.shadura@collabora.co.uk>
Subject: Re: [PATCH v2] HID: report only one button for PenMount 6000 USB
 touchscreen controller
Date: Tue, 12 Jan 2016 15:59:34 +0100
Message-ID: <569514D6.2060204@collabora.co.uk>
References: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk>
 <565456F3.8080408@collabora.co.uk>
 <CAH9NwWfj4pNuqBhYj7ZJQbzqyJ19UpT3iNY8avX-Uu6XLtMW7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bptv5Waimh5oxJwH0pIAjoggQuDuh15cM"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38364 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbcALO7i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2016 09:59:38 -0500
In-Reply-To: <CAH9NwWfj4pNuqBhYj7ZJQbzqyJ19UpT3iNY8avX-Uu6XLtMW7g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>, =?UTF-8?B?SmnFmcOtIEtvc2luYQ==?= <jkosina@suse.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bptv5Waimh5oxJwH0pIAjoggQuDuh15cM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27/11/15 16:18, Christian Gmeiner wrote:
> 2015-11-24 13:24 GMT+01:00 Andrew Shadura <andrew.shadura@collabora.co.=
uk>:
>> On 29/10/15 16:00, Andrew Shadura wrote:
>>> PenMount 6000 USB resistive touchscreen controller reports it has thr=
ee
>>> buttons, while in reality it doesn't have any and doesn't support act=
ive
>>> styli, and only generates touch events.
>>>
>>> In penmount_input_mapping(), map only the first button (with code 0),=

>>> ignore the rest.
>>>
>>> Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>
>>
>> Any news on this patch? It'd be cool if it could be merged.
>=20
> I try to get access to the hardware and will test it.

Christian, have you had a chance to test the patch?

--=20
Cheers,
  Andrew


--bptv5Waimh5oxJwH0pIAjoggQuDuh15cM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWlRTXAAoJEEFnG7NKhJOBedoP/01v3a93y6XlCK6+IWAYvoB7
g3ypVIXucynH412T2W9f5yqdEz7CJ9W/uAkMB+qh/7nne7dSY8Wd3yYv0mlniekj
SyKrQ7za8NbMRmsXih2ozv+CncLdD9QPpfRSyrW3i4KIxp1e9R3+d3nQkLCCb4K4
OTuKC2oRFhR7/XAvwQRM61orPaH3JJ3uUFUq/9oh463C6/Zx1a9wuyPlsPWzjDeK
yWlIU0m7EmfVpU+g5TVC5Z+I24+A7hrjGO8jTq8DAvLQxaweC1+MxCN+6whI5N60
ehhLhmAisABUUdcRRMhMY0W3XgVNJAHR6U5gqdp1HNJNcY/vnkAze2PggDOeFY3S
/lqCy/ThSfxJziihNmaKKYw0jokFKVET8yjElgpmfhafpCk8HehJs9gm81q0z3ss
/xqyXRVbLjS+CUZd137NtgFcfXtikj9EO4Si004PXKQPaNCfh31D9zGLTPxRsuJp
HxYqT35z1TA9IwzSLRxWuQcItx3ZznTYn735KAaIFlQ71uBviOU/l2zsaynVheFO
azPM7G4EM/npBOVi7wzlEarrFHsAZvUVMQg3aXXC8fNX0v7AqsEEWGBgYMqVcKNf
Qo8249EcEFr3LYyqABIv9ZcXHw3Jzm+mvVtg8Gj+CtH93EjLnYkggFi5OIxZgG5G
Vo40KKHCLb+TWb0Jzx8l
=PSJQ
-----END PGP SIGNATURE-----

--bptv5Waimh5oxJwH0pIAjoggQuDuh15cM--
