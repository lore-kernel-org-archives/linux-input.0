From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 4/4] ARM: LPC32xx: Device tree support
Date: Mon, 16 Apr 2012 08:24:48 +0200
Message-ID: <20120416062444.GD3037@avionic-0098.adnet.avionic-design.de>
References: <1334400790-10892-1-git-send-email-stigge@antcom.de>
 <1334400790-10892-5-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8089985626127724788=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1334400790-10892-5-git-send-email-stigge@antcom.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roland Stigge <stigge@antcom.de>
Cc: devel@driverdev.osuosl.org, srinivas.bakki@nxp.com, dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, marek.vasut@gmail.com, arm@kernel.org, linux-input@vger.kernel.org, axel.lin@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


--===============8089985626127724788==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Roland Stigge wrote:
> This patch adds device tree support for the LPC32xx SoC
>=20
> arch/arm/boot/dts/lpc32xx.dtsi: Include for devices based on LPC32xx
> arch/arm/boot/dts/phy3250.dts: Board support for PHYTEC phyCORE-LPC3250
> arch/arm/boot/mach-lpc32xx/irq.c: irq domain conversion
>=20
> Signed-off-by: Roland Stigge <stigge@antcom.de>
>=20
> ---
>=20
> Applies to v3.4-rc2 and requires the previously posted lpc32xx driver dt
> patches (Set 1: 1..8 + GPIO patch)
>=20
>  Documentation/devicetree/bindings/arm/lpc32xx-mic.txt |   38 ++
>  Documentation/devicetree/bindings/arm/lpc32xx.txt     |    8=20
>  arch/arm/Kconfig                                      |    1=20
>  arch/arm/boot/dts/lpc32xx.dtsi                        |  303 +++++++++++=
+++++++
>  arch/arm/boot/dts/phy3250.dts                         |  108 ++++++
>  arch/arm/mach-lpc32xx/Kconfig                         |   26 -
>  arch/arm/mach-lpc32xx/clock.c                         |   77 ++--
>  arch/arm/mach-lpc32xx/common.c                        |  192 -----------
>  arch/arm/mach-lpc32xx/common.h                        |   14=20
>  arch/arm/mach-lpc32xx/irq.c                           |   78 +++-
>  arch/arm/mach-lpc32xx/phy3250.c                       |  146 +++-----
>  11 files changed, 613 insertions(+), 378 deletions(-)

This looks like too many unrelated changes for one patch.

Thierry

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+LuysACgkQZ+BJyKLjJp/YYACffDx5L5Bnn1/UnZDkRiewtD/p
Fc8An3lHrjlrPZyPRy+8HO12pgxJK2ro
=FLPw
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--


--===============8089985626127724788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8089985626127724788==--
