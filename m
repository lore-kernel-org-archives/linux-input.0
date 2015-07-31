From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Fri, 31 Jul 2015 23:17:43 +0200
Message-ID: <201507312317.43809@pali>
References: <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com> <55BA3C28.3080506@redhat.com> <CANuv8Qyx3zPDmWvV-2XRQXEiSVnOa10GYPGiYaF1B9iru10_9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5974949.WeIDSmoDo0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37606 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbbGaVRr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2015 17:17:47 -0400
Received: by wibud3 with SMTP id ud3so46776507wib.0
        for <linux-input@vger.kernel.org>; Fri, 31 Jul 2015 14:17:46 -0700 (PDT)
In-Reply-To: <CANuv8Qyx3zPDmWvV-2XRQXEiSVnOa10GYPGiYaF1B9iru10_9A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

--nextPart5974949.WeIDSmoDo0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 31 July 2015 23:12:56 Douglas Christman wrote:
> On Thu, Jul 30, 2015 at 11:00 AM, Hans de Goede <hdegoede@redhat.com>
> wrote:
> > Hi,
> >=20
> > On 30-07-15 16:46, Pali Roh=C3=A1r wrote:
> >> What about introducing new flag ALPS_<something> instead calling
> >> dmi_name_in_vendors() function every time when we need to process
> >> packet?
> >=20
> > That is a good idea. Douglas can you test the attached version
> > instead of the previous one please ?
> >=20
> > Thanks & Regards,
> >=20
> > Hans
>=20
> This patch works for me.
>=20
> Doug

Douglas: Thanks for testing!

Hans: Can you update also documentation in Documentation/input/alps.txt=20
to match with this your change?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5974949.WeIDSmoDo0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW75fcACgkQi/DJPQPkQ1ID+ACcDjuECRUXvQznqMBjXMwruCXV
UUgAn3fCcQg4Nhs5eVyjEpGj8jdyUBQi
=f5vc
-----END PGP SIGNATURE-----

--nextPart5974949.WeIDSmoDo0--
