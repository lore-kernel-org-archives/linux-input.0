From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2] HID: uhid: fix leak for 64/32 UHID_CREATE
Date: Tue, 26 Nov 2013 14:29:57 +0000
Message-ID: <1385476197.23855.51.camel@deadeye.wl.decadent.org.uk>
References: <1385449330.23855.46.camel@deadeye.wl.decadent.org.uk>
	 <1385470698-6036-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-kGTod3EcyhVpUmPqH8iB"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1385470698-6036-1-git-send-email-dh.herrmann@gmail.com>
Sender: stable-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-kGTod3EcyhVpUmPqH8iB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2013-11-26 at 13:58 +0100, David Herrmann wrote:
> UHID allows short writes so user-space can omit unused fields. We
> automatically set them to 0 in the kernel. However, the 64/32 bit
> compat-handler didn't do that in the UHID_CREATE fallback. This will
> reveal random kernel heap data (of random size, even) to user-space.
>=20
> Reported-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> Cc: stable@vger.kernel.org

Fixes: befde0226a59 ('HID: uhid: make creating devices work on 64/32 system=
s')

(that should make it clear which versions need the fix)

> ---
>  drivers/hid/uhid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 93b00d7..cedc6da 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -287,7 +287,7 @@ static int uhid_event_from_user(const char __user *bu=
ffer, size_t len,
>  			 */
>  			struct uhid_create_req_compat *compat;
> =20
> -			compat =3D kmalloc(sizeof(*compat), GFP_KERNEL);
> +			compat =3D kzalloc(sizeof(*compat), GFP_KERNEL);
>  			if (!compat)
>  				return -ENOMEM;
> =20

--=20
Ben Hutchings
Usenet is essentially a HUGE group of people passing notes in class.
                      - Rachel Kadel, `A Quick Guide to Newsgroup Etiquette=
'

--=-kGTod3EcyhVpUmPqH8iB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUAUpSwZee/yOyVhhEJAQolVQ//QVREhIqRiV5VWBGvmflZ2aOaigiFgUns
SKeQhPRimzYVaG7FmyFNP77G6aZxByn1zeyasdt0kpA/Hhz3N6SUDryd9W9ZnXhD
oHop0gvI+sfT5lEFtvpzFF+6ZUdCC0+78YLma+Z+ZJYQeH96iaIIN2D6nLjjJuOB
eN6kIkkEOHnCrEJH9zkpfqSN8mjkgQa8HB6RtIhiieZxv5u2YO1O1Sl6spromO4n
kBmwG3geABHEc6d2ZXU8icJbWjFK+GeM9j4WS64+bRUt/TepeIpepzGZg4pGpLSc
lzeddCSgbvNsL1wNFvbStsE53ysUA849ETHRKburG/RhppTDOl5pt8QVWn1iCoYm
wNTBD4u/mN94rNBeJIfM4CFPpwIKRjvtjhfjikjNB81z8O1kVajrVsDcxifNpM4C
OwiIUAdMKMuDzqVRGW+VYwloVmcJiJYYRU+k6awGt/b7ha0MVjXvh2k6wUCXeltO
I9kW8aIEN5tT64No6FTXG4In/Rj09+kOUvL+YGHrvACEzJ5qKMKM/fvoG0Xrb4tu
xyewr15H6lTrT+aKqGGuKbmHFR039jiZLmzv7L/5qFlWMfD449K8hgY2IvVcKs6X
HXwew1Q3+UnkPFmx5Eb1RVAWLe6cu2GoTOTlW+3ZVWVNBGKd4g/t0pGWjLWXIKuP
AEk6ZaZevao=
=sgxz
-----END PGP SIGNATURE-----

--=-kGTod3EcyhVpUmPqH8iB--
