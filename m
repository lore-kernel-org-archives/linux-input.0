From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] HID: input: Fix NULL pointer dereference when
 power_supply_register fails
Date: Tue, 24 Mar 2015 16:07:06 +0100
Message-ID: <20150324150706.GA22934@earth>
References: <1427124891-30540-1-git-send-email-k.kozlowski@samsung.com>
 <alpine.LNX.2.00.1503241200220.6781@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1503241200220.6781@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-input@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof & Jiri,

On Tue, Mar 24, 2015 at 12:02:41PM +0100, Jiri Kosina wrote:
> On Mon, 23 Mar 2015, Krzysztof Kozlowski wrote:
>=20
> > Do not call power_supply_powers() if power_supply_register() failed
> > earlier. This fixes possible NULL pointer dereference by
> > power_supply_powers() in such case.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >=20
> > ---
> >=20
> > The patch was prepared on top of next-20150323. It depends on changes in
> > power supply core (battery-2.6.git) so probably it should be applied to
> > the battery tree.
>=20
> Acked-by: Jiri Kosina <jkosina@suse.cz>
>=20
> for the merge through battery-2.6.git. Thanks.

Thanks, pulled.

-- Sebastian

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVEX2VAAoJENju1/PIO/qa6OQQAJIswppAbD9UCwmmHYKqj4NE
0cBcyIsU1LxpU0cPebLDS1nl0xu4CuZmqY+HC+t9rmnA83+L3G2wKKBTkjQiefLn
1RuaJKej2s/eXM0pO3JD9CeEHWy0hn0l2ssTHRKjK/RC7cqLFHKPeDXAU4h3frX0
beW4xiY3xCbNjQXhn3anVe1G1UtPDtAgLBHqnfxtTxIFcULMNkEedVvfZT8B+u/f
ASmtTobmTtE4D+jIHSJ8g/GvBKWq6tnotZsqHivh60Gn3O2InZGZRv/+1EXVSp9v
fTrRlPygxzEOTZWXhoKwyxQtATDtmgcXVv13TS8vRp3bMn0laN+Y/mAa1qF1PqSw
Mm0Oe2K49LGoAk0i5U85iNUzM2fOeVygJlx0CT3cwxdugaLXS8+3RZxI9q9th565
g6TMCM/fLytubIesdG+K6ON6xLOad+kpD6Wz7WMv+xLtxX2ueDdy93vdfK5i0XBj
2LFMExEBgz/YZEph+gT3UINu712d4s9UY/NFfGA3FrwIUa7InxSmBO/T6lMJREPL
UDsBlKaW7u8YFG1zcJNhNAUmTAJ4hk9SJtycHLSCZG3IKjGR1vgzl3A4gQGeHe8j
mCih9ecSLxd+/XmbQejiNqOGPWYNHgCqkOCsVlDoL8UJb3+ZSJueyTi8kG6xd9J5
+XYL3CqqOC/r5yz7Knjf
=Y+rV
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
