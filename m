From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] Input: touchscreen: edt_ft5x06 - change msleep to
 usleep_range for small msecs
Date: Wed, 4 Jan 2017 19:19:56 +0100
Message-ID: <708bb254-2830-63c6-f8c8-38fba0b8f988@kernelconcepts.de>
References: <1480358514-2894-1-git-send-email-a.mathur@samsung.com>
 <CAOXgUe1MULGQZJ=pNsSKrvVcCFptVn5b2Qafjao1_xrxVYn0JQ@mail.gmail.com>
 <d95fa514-6e3f-1eb3-8204-60a7d7df494d@kernelconcepts.de>
 <CADYu309AZ_pj_ssVqPV+sXjW8fqMKTXwL_EoTBgLg2K1Ci614Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XNIb0r0IXrSeebi9eqXD8cJ6ohJLlMrFt"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADYu309AZ_pj_ssVqPV+sXjW8fqMKTXwL_EoTBgLg2K1Ci614Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, daniel.wagener@kernelconcepts.de, LW@karo-electronics.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XNIb0r0IXrSeebi9eqXD8cJ6ohJLlMrFt
Content-Type: multipart/mixed; boundary="oo8JM5NlK6hKtljUxkGsR2ohOJnHqjAPN";
 protected-headers="v1"
From: Simon Budig <simon.budig@kernelconcepts.de>
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: Aniroop Mathur <a.mathur@samsung.com>, daniel.wagener@kernelconcepts.de,
 LW@karo-electronics.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>
Message-ID: <708bb254-2830-63c6-f8c8-38fba0b8f988@kernelconcepts.de>
Subject: Re: [PATCH] Input: touchscreen: edt_ft5x06 - change msleep to
 usleep_range for small msecs
References: <1480358514-2894-1-git-send-email-a.mathur@samsung.com>
 <CAOXgUe1MULGQZJ=pNsSKrvVcCFptVn5b2Qafjao1_xrxVYn0JQ@mail.gmail.com>
 <d95fa514-6e3f-1eb3-8204-60a7d7df494d@kernelconcepts.de>
 <CADYu309AZ_pj_ssVqPV+sXjW8fqMKTXwL_EoTBgLg2K1Ci614Q@mail.gmail.com>
In-Reply-To: <CADYu309AZ_pj_ssVqPV+sXjW8fqMKTXwL_EoTBgLg2K1Ci614Q@mail.gmail.com>

--oo8JM5NlK6hKtljUxkGsR2ohOJnHqjAPN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/12/16 19:17, Aniroop Mathur wrote:
> Since here we are using msleep(1) which is worse as it sleeps for
> minimum two jiffies so 20 ms on HZ=3D100 system and we are doing here
> 100 retries if register reading fails. So as you can deduce usleep_rang=
e
> will serve better here.
> Explained originally here why to not use msleep for 1-20ms:
> http://lkml.org/lkml/2007/8/3/250

Acked-by: Simon Budig <simon.budig@kernelconcepts.de>

Bye,
        Simon
--=20
     kernel concepts GmbH                 Simon Budig
     Sieghuetter Hauptweg 48              simon.budig@kernelconcepts.de
     D-57072 Siegen                       +49-271-771091-17
     http://www.kernelconcepts.de/
     HR Siegen, HR B 9613; Gesch=C3=A4ftsf=C3=BChrer: Nils Faerber, Ole R=
einhardt



--oo8JM5NlK6hKtljUxkGsR2ohOJnHqjAPN--

--XNIb0r0IXrSeebi9eqXD8cJ6ohJLlMrFt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTPAwhwx6BA+WIUvUM7Y79Fd6yIcAUCWG08zAAKCRA7Y79Fd6yI
cFpDAJ46qQ1Xg5LS5uSzi7cQXYXtKipdhwCfW86rth3HjcKylISBU5aq2F05tJI=
=sAqq
-----END PGP SIGNATURE-----

--XNIb0r0IXrSeebi9eqXD8cJ6ohJLlMrFt--
