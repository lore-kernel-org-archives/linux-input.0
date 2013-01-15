From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v2 2/4] input: keyboard: tegra: use devm_* for resource
 allocation
Date: Tue, 15 Jan 2013 07:44:18 +0100
Message-ID: <20130115064418.GA31561@avionic-0098.adnet.avionic-design.de>
References: <1357371910-3164-1-git-send-email-ldewangan@nvidia.com>
 <20130114161644.GC14721@kroah.com>
 <20130114221551.GA30020@avionic-0098.adnet.avionic-design.de>
 <201301142224.11243.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8218566189502329644=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201301142224.11243.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--===============8218566189502329644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 10:24:11PM +0000, Arnd Bergmann wrote:
> On Monday 14 January 2013, Thierry Reding wrote:
> > It certainly sounds like a less complicated way to do it. But it also
> > involves adding a function with a made up name and drop a function with
> > a perfectly good name instead. I wouldn't even know what name to choose
> > for the new API.
> >=20
>=20
> How about devm_ioremap_resource()? Sounds equally fitting, and is shorter.

Yes, that sounds good. Thanks for the suggestion.

Thierry

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ9PrCAAoJEN0jrNd/PrOh8EUQAINqNe6OAwnG8+v2YacerpeP
jpM0W7ng9kly+Jh7wPl2MpBEzDoKAp9AvmPmOuPZVaLBhVikJB0pB/cQgtERlLxA
KJgtdEepQb5RInvaZ3lMO07W/OlsZyP3F16e4GO5MEN3VN93QqFgWACRl8U+52aM
yEbUu6cHImAsxEeWTiLzAJJpTqTmvj0+BN15W4jirVJKWG6dyp6QQP0QyWONro/a
FEH0UygwPMAz8Mv5eL3p8of87Xt07A4NMAjfTSOpLVIilX3ElJkKsKfr5IbHD+nX
r8UODa6sM4LD1c1w0TM5so1DpsVE+YEdm6PbCOeqLa3zqJ3gpkm/psrd9Dwp6ThG
P0FZUrjDcGucznVzRY9LuU5etPd9oLcdMsF65J6k4wXgaAFQ92lQ2yC97H6p7q2j
k+YdPIPz8jKouwlpywHvLvmcjZv4tO8r/L5dVuT77uinWN8ZNFjfFbRylgbrLPxb
OfVF1sBokC6kGTAww71VaNURxOFt28QkGEkr8juCO83eZR2Ms4/NQxmLHggoGPf/
GDdDX81LW2tXRK5AFPFduXOsxt+Fek/E7R0B0EyFY6u+JLVeLhj2htZz2LOh/JHF
hbU9kZaO44C16wx4/4XhnGsLUxhPGw0MS1aVF/EmKiq4op9QxR2BO0xpDM3i6H45
piEnYv4jP0kNIUbOhlJm
=n2WD
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

--===============8218566189502329644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8218566189502329644==--
