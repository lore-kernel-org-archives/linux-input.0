From: Simon Budig <simon.budig-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: [PATCHv4 2/5] Input: edt-ft5x06: Add DT support
Date: Thu, 20 Mar 2014 12:18:10 +0100
Message-ID: <532ACE72.6030807@kernelconcepts.de>
References: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de> <1395234563-11034-3-git-send-email-LW@KARO-electronics.de> <20140320093719.GB14420@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xqvuqOQtrhkAKdn4NtqigxkfFc2kKccsf"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140320093719.GB14420-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xqvuqOQtrhkAKdn4NtqigxkfFc2kKccsf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 20/03/14 10:37, Mark Rutland wrote:
> On Wed, Mar 19, 2014 at 01:09:20PM +0000, Lothar Wa=C3=9Fmann wrote:
>> +FocalTech EDT-FT5x06 Polytouch driver
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Required properties:
>> + - compatible:  "edt,edt-ft5x06"
>=20
> Is the 'x' part of a particular product name, or is this a class of
> devices?

The driver is intended for the EDT "polytouch" family touches, which are
based on a focaltec controller. The current line of touches uses e.g.
the ft5306 as well as the ft5406 focaltec controller.

> It's preferable to have a specific string which another similar variant=
s
> can claim compatibility with (while also additionally having a more
> specific string), as this makes it possible to handle variants more
> specially in future, target workarounds, etc.

I chose the driver name since I wanted to differentiate from other EDT
touches, which used a different controller. With hindsight it was
unfortunately confusing, since I get quite some request from people, who
also have a device based on the focaltec controllers, but with a very
different firmware (and communication protocol). They got tricked into
thinking that this driver would be suitable...

If I were to chose the name again I'd probably pick "edt-polytouch" or
something like this. But I doubt that it is useful to change the name now=
=2E

Bye,
        Simon

--=20
       Simon Budig                        kernel concepts GmbH
       simon.budig-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen



--xqvuqOQtrhkAKdn4NtqigxkfFc2kKccsf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMqznIACgkQO2O/RXesiHCNyACbBPXVJSQzQv9OvjDS1iKaIFuE
PtgAn0MD54DVQUguggi+oifaTxLL5xYx
=QYF/
-----END PGP SIGNATURE-----

--xqvuqOQtrhkAKdn4NtqigxkfFc2kKccsf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
