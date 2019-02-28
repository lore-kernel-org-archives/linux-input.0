From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor
Date: Thu, 28 Feb 2019 19:01:17 +0100
Message-ID: <a6ecd59f99aa64355ac7c176aa4310d32ce8969e.camel@suse.de>
References: <20190228135556.14713-1-nsaenzjulienne@suse.de>
         <BYAPR02MB56078ADD429292DF89F8C694ED750@BYAPR02MB5607.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sMBCKcqsKVCMoOP1O0bd"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BYAPR02MB56078ADD429292DF89F8C694ED750@BYAPR02MB5607.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Junge, Terry" <Terry.Junge@plantronics.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "oneukum@suse.de" <oneukum@suse.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--=-sMBCKcqsKVCMoOP1O0bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-02-28 at 17:02 +0000, Junge, Terry wrote:
> This could also be a parser error. In the HID specification section 6.2.2=
.8 it
> states that the last declared Usage Page is applied to Usages when the Ma=
in
> item is encountered.
>=20
> "If the bSize field =3D 1 or 2 then the Usage is interpreted as an unsign=
ed
> value
> that selects a Usage ID on the currently defined Usage Page. When the par=
ser
> encounters a main item it concatenates the last declared Usage Page with =
a
> Usage to form a complete usage value. Extended usages can be used to
> override the currently defined Usage Page for individual usages."
>=20

Hi Terry, thanks for the comment.
Just for the record the paragraph I cited on my patch is the following:

	6.2.2.7 Global Items

	[...]

	Usage Page: Unsigned integer specifying the current Usage Page. Since a
	usage are 32 bit values, Usage Page items can be used to conserve space
	in a report descriptor by setting the high order 16 bits of a
	subsequent usages. Any usage that follows which is defines* 16 bits or
	less is interpreted as a Usage ID and concatenated with the Usage Page
	to form a 32 bit Usage.

	* This is a spec errata, I belive it should say "defined"

As you can see they use the word "follows" which in my opinion contradicts =
the
paragraph you pointed out. That said I may be wrong, I'm not too good at
reading specs :).

I checked the HID parser and it's indeed written assuming local items are
preceded by a Usage Page. I'd be glad to fix it there, but it would be nice=
 to
have the mantainer's opinion on the matter first.

Regards,
Nicolas


--=-sMBCKcqsKVCMoOP1O0bd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlx4Ie0ACgkQlfZmHno8
x/52awf/WZptAHHAqEqvRBY6vygjAgTG8kFUHLgKricp4qNT5WGpkrFYndGxP1hO
iTLcXh+7pNdivfWAaey37Ysyk3rDQdm3klBL1EJHVjXDe1YPy5v5WP3rbcf3egX7
qnm1cKxS+kpPhBSX5aP0IFcQ9asaOVzkqiOUqpt4rk7qHawSiM8amTlVZ28zCekX
IVY7zjRzK4rFOgg64JKboeikPc40pNkIs+IN4DbR+WwRan6qKLaIlNN318jD5LpL
2ejUNMUSklYs4KlpeljEtqr8AxFmDMhlMXP+D48neu8Kw0EA4MZTKIcr1JkLgYlm
xdLyiah062rcqzs/wxG34zyrn3nNgA==
=+hun
-----END PGP SIGNATURE-----

--=-sMBCKcqsKVCMoOP1O0bd--
