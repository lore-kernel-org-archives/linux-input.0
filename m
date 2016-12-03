From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] Input: touchscreen: edt_ft5x06 - change msleep to
 usleep_range for small msecs
Date: Sat, 3 Dec 2016 18:28:37 +0100
Message-ID: <d95fa514-6e3f-1eb3-8204-60a7d7df494d@kernelconcepts.de>
References: <1480358514-2894-1-git-send-email-a.mathur@samsung.com>
 <CAOXgUe1MULGQZJ=pNsSKrvVcCFptVn5b2Qafjao1_xrxVYn0JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NPGIwApog8MnaWQTrrPK8aMMgqute2d9r"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([188.40.83.200]:44107 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbcLCSEb (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 3 Dec 2016 13:04:31 -0500
In-Reply-To: <CAOXgUe1MULGQZJ=pNsSKrvVcCFptVn5b2Qafjao1_xrxVYn0JQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>, daniel.wagener@kernelconcepts.de, LW@karo-electronics.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <aniroop.mathur@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NPGIwApog8MnaWQTrrPK8aMMgqute2d9r
Content-Type: multipart/mixed; boundary="rGg9XPLWeq2JPwHeqqTFROisWFmCWJj1f";
 protected-headers="v1"
From: Simon Budig <simon.budig@kernelconcepts.de>
To: Aniroop Mathur <a.mathur@samsung.com>, daniel.wagener@kernelconcepts.de,
 LW@karo-electronics.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com,
 Aniroop Mathur <aniroop.mathur@gmail.com>
Message-ID: <d95fa514-6e3f-1eb3-8204-60a7d7df494d@kernelconcepts.de>
Subject: Re: [PATCH] Input: touchscreen: edt_ft5x06 - change msleep to
 usleep_range for small msecs
References: <1480358514-2894-1-git-send-email-a.mathur@samsung.com>
 <CAOXgUe1MULGQZJ=pNsSKrvVcCFptVn5b2Qafjao1_xrxVYn0JQ@mail.gmail.com>
In-Reply-To: <CAOXgUe1MULGQZJ=pNsSKrvVcCFptVn5b2Qafjao1_xrxVYn0JQ@mail.gmail.com>

--rGg9XPLWeq2JPwHeqqTFROisWFmCWJj1f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Mr, Mathur.

On 29/11/16 21:54, Aniroop Mathur wrote:
> I have submitted one patch as below for review to Linux Open Source.
> The problem is that we do not have the hardware available with us to
> test it and we would like to test it before actually applying it.
> As you are the author of this driver, I am contacting you to request yo=
u to
> provide your feedback upon this patch.
>=20
> Also if you have the hardware available, could you please help to
> test this patch on your hardware? or could you provide contact points
> of individuals who could support to test it?

My first question regarding the patch is: What is your motivation for
doing this change? Did you actually encounter any problems with some
touch hardware? Or is this a part of a global search/replace mission
across the linux kernel?

The change is in a function that is pretty irrelevant for most users of
the driver: reading out raw sensor data, which is only available for
EDT's M06 models of the touchscreen. I am actually tempted to remove
this stuff, since it never really provided helpful for us in debugging
touch screen problems, and adds a certain amount of complexity to the
driver.

I don't have a setup for the hardware readily available at the moment,
so I can't currently help you there. But from reading the patch it seems
pretty harmless and from my point of view there is nothing that speaks
against incorporating that patch. On the other hand I don't see a lot
that speaks in favor of it.

*shrug*

Bye,
        Simon
--=20
     kernel concepts GmbH                 Simon Budig
     Sieghuetter Hauptweg 48              simon.budig@kernelconcepts.de
     D-57072 Siegen                       +49-271-771091-17
     http://www.kernelconcepts.de/
     HR Siegen, HR B 9613; Gesch=C3=A4ftsf=C3=BChrer: Nils Faerber, Ole R=
einhardt



--rGg9XPLWeq2JPwHeqqTFROisWFmCWJj1f--

--NPGIwApog8MnaWQTrrPK8aMMgqute2d9r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTPAwhwx6BA+WIUvUM7Y79Fd6yIcAUCWEMAxgAKCRA7Y79Fd6yI
cDrAAJ4x97TkJnxRlLV0PXeJvI0x/3Xq6gCfaaLn2y8RJ6VQU00KvT0vr07TAyg=
=FPtM
-----END PGP SIGNATURE-----

--NPGIwApog8MnaWQTrrPK8aMMgqute2d9r--
