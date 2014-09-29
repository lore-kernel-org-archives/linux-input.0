From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] i2c: cros-ec-tunnel: Add of match table
Date: Mon, 29 Sep 2014 22:59:23 +0200
Message-ID: <20140929205922.GB2758@katana>
References: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1411114093-3505-2-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411114093-3505-2-git-send-email-sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2014 at 10:08:12AM +0200, Sjoerd Simons wrote:
> To enable the cros-ec-tunnel driver to be auto-loaded when build as a
> module add an of match table (and export it) to match the modalias
> information passed on to userspace as the Cros EC MFD driver registers
> the MFD subdevices with an of_compatibility string.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> Reviewed-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

Applied to for-next, thanks!

However, since you are working on this driver: sparse rightfully
complains about:

drivers/i2c/busses/i2c-cros-ec-tunnel.c:97:44: warning: cast truncates bits=
 from constant value (10000 becomes 0)

I don't know the EC protocol, can you check?


--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKcgqAAoJEBQN5MwUoCm2twEP/1sRKq/eDRFxR5Z5rh67ynUT
22EIwT6s1A3OTPDWtZ693Wqb2WT1xxaoSdK9idmzX5Hh+FlkHybCqn9SylVGgwVV
wf8UHidcirrsXhBEZU71pUTxPxEmTOjMxSmLQ9zfG9LkoamsCJ4om0fxZMgGq7ME
aAqz6sMuTiqxOAl5e7e3eyplIceCYbTzid4cxBhIBlZekFmV6T0oK1effsEbfsuO
ukaYafpiNze5/2sM6rrwhcd8tse6pgrTtOaI9WJgUqwJUK8bx44rJ29809h8KOxD
8ijssJVzYwfqbKwadu2Nxsng3WaCQ6rx9Dgbb4zOLKoizBi7qt6KZ2htKe4+bJOi
rXExDWaqqQkFvDIBb5TFiaLO8w2qy/Lwfk1jJWSBP8AKEalX0PyXdMWxQIg8qsgI
yuolq9n5/nNa81AyEjHnIiWC7/RYXAPd+FpgRlUrOEDWDjT3cqWCxYl1We/LRzeF
caxZfPfD+nb0y1gZ76+BL9z9OAhRHPCddBLQOMDHhBMWG41O5+LxEN89yyYwSect
S4hMnyVNFDeXWWj6zOv3BlgBfPrHtpx2V36sV+/QzPmQd2nGhlPiwSrTl0JbMcUE
tZYok8W2HVkHvU3aij5jH97hA8k6fD+hBsCinT1rPRpsdNOvzXanEiRz+ndT29B+
qs/4k5bF7M+0+Ov+WjQr
=stXG
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
