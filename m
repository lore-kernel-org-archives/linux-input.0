From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH] add sur40 driver for Samsung SUR40 (aka MS Surface 2.0/Pixelsense)
Date: Fri, 11 Oct 2013 11:22:43 +0200
Message-ID: <5257C363.5020708@butterbrot.org>
References: <1378934763-17938-1-git-send-email-floe@butterbrot.org>	<20130918193853.GA2070@polaris.bitmath.org>	<524BD2D8.505@butterbrot.org>	<CANq1E4S6ZkcCs8a6wo76kZq1R2vB3ti1Mw9y+_jE81c30gr6Pg@mail.gmail.com>	<524C24B8.9090000@butterbrot.org> <CANq1E4R5-WEx_e1vYOmY-xGL0w669Qj54SGLU_tb8h97=5zH=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cO7jQguqkp0LjIfE4b68LwFi0cCEUJmTk"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:33741 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab3JKJWq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Oct 2013 05:22:46 -0400
In-Reply-To: <CANq1E4R5-WEx_e1vYOmY-xGL0w669Qj54SGLU_tb8h97=5zH=A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>, HID CORE LAYER <linux-input@vger.kernel.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cO7jQguqkp0LjIfE4b68LwFi0cCEUJmTk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02.10.2013 15:59, David Herrmann wrote:
>>> Or maybe even replace it by "u32 angle;". That should always be safe.=

>>> Once you make use of this field, you can reconsider whether it's wort=
h
>>> doing FP in the kernel. But as long as it's unused, I'd vote for
>>> avoiding "float" entirely.
>>
>> I was indeed planning to use this for orientation (as intended) in the=

>> next iteration, what macros would I have to use for proper float handl=
ing?
>=20
> Archived from 2003 but afaik his last paragraph still applies today:
>   http://yarchive.net/comp/linux/kernel_fp.html
>=20
> So what you should do is forward the raw angle data to user-space and
> let them deal with it. We usually don't apply policy in the kernel but
> instead forward the given data to the user and let them do the
> orientation computations. Any specific reason why you want to do that
> in the kernel?
I think it would be more consistent to have an EV_ABS value for
orientation, ranging e.g. from 0 to 359 (or rather from 0 to e.g. 90, as
described in multi-touch-protocol.txt). For pass-through to work, I
would probably have to set min and max to 0 and __UINT32_MAX__?

Alternatively, I think it should be possible to perform the required
conversion using integer arithmetic and bit operations alone.

However, for the time being, I'd suggest to simply leave the float
alone, use just a 0/1 value for orientation and deal with this in a
later patch, agreed?

One additional question: is there any provision in the multitouch
protocol for differentiation between various types of objects, e.g.
"finger" and "palm"?

BTW, what's the best practice for resubmitting a patch? I've used "git
commit --amend" on my previous commit, and would now just use "git
send-email" again, creating a new thread?

Best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL




--cO7jQguqkp0LjIfE4b68LwFi0cCEUJmTk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlJXw2MACgkQ7CzyshGvatgBAgCg8dGaizO4+5Nw9IeIuCtKm+AT
S/gAn0eVFBFiGm4D4r1r00saTkKs8UQG
=32r2
-----END PGP SIGNATURE-----

--cO7jQguqkp0LjIfE4b68LwFi0cCEUJmTk--
