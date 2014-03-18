From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 3/8] input: misc: Add driver for AXP20x Power Enable
 Key
Date: Tue, 18 Mar 2014 11:15:54 +0100
Message-ID: <20140318101554.GZ27873@lukather>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-4-git-send-email-carlo@caione.org>
 <20140318090013.GU27873@lukather>
 <20140318095002.GM25478@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EH85xkKza2NXtwkF"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35299 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753994AbaCRKUF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2014 06:20:05 -0400
Content-Disposition: inline
In-Reply-To: <20140318095002.GM25478@lee--X1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org


--EH85xkKza2NXtwkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 09:50:02AM +0000, Lee Jones wrote:
> > > This patch add support for the Power Enable Key found on MFD AXP202 a=
nd
> > > AXP209. Besides the basic support for the button, the driver adds two
> > > entries in sysfs to configure the time delay for power on/off.
> > >=20
> > > Signed-off-by: Carlo Caione <carlo@caione.org>
> > > ---
> > >  drivers/input/misc/Kconfig      |  11 ++
> > >  drivers/input/misc/Makefile     |   1 +
> > >  drivers/input/misc/axp20x-pek.c | 267 ++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 279 insertions(+)
> > >  create mode 100644 drivers/input/misc/axp20x-pek.c
> >=20
> > From what I understood of the MFD framework, you usually have a MFD
> > core driver that gets loaded from the DT and instantiate its various
> > functions through sub-devices, that are registered through
> > mfd_add_devices, and the drivers for these sub-devices are supported
> > in sub-drivers that are located in the driver/mfd, alongside the core
> > driver.
> >=20
> > I believe that such a pattern allows for two interesting things:
> >   - You don't have to search around the whole kernel tree to find
> >     where a given sub-feature is supported.
> >   - You don't have to cripple your DT with instantiation of all the
> >     subcomponents, while you only really have one device.
> >=20
> > Do you have a reason for not following this pattern?
>=20
> Sorry Maxime, this is not the case.
>=20
> If an MFD contains Regulators and USB & GPIO Controllers, I'd expect
> to see the device represented in the following way:
>=20
>   drivers/mfd/<id>.c
>   drivers/{gpio,pinctrl}/{gpio,pinctrl}-<id>.c
>   drivers/regulator/<id>-regulator.c
>   drivers/usb/host/<id>.c

Oh, ok. Nevermind then :)

Just out of curiosity, some drivers at least seem to follow that trend
in drivers/mfd, is there any reason for this (other than historical) ?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--EH85xkKza2NXtwkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTKBzZAAoJEBx+YmzsjxAgha4P/RMnn3WZFtdczUuSi/7cHVEq
DgCdQhtnckl7GGa518/QE6XEX3Vdw1PRsj9ZgYFX+64N3kbc7ul1ix3RAxIzd+AV
eiYtHp6D2RS69l6va2M+Pz6x3+Eb3PjjaJIGJyONFXTKvxRHxFDobqlokQe0jPU+
HH7mb4vKGaqaJFXhfY5yp83PvIfpuueZb1py+q0xG2egtS5jXfgW7qNmoPciHChm
whgGNyzz3b9XwFbV5hgARQALkxtW1fmMOqFa+LwBmkctXVo2O0NibRk5uF/tpuWM
isFwDwVp/IgvHr8x87h841MTwnNX0M6WXI0DB/cHTxF7awUsmoXb1+JyCJSEZ2gA
YYQFaEMm4GtGCdG+jpjUGbwQdgwS2vtUV1ZhgnHkJql5oIHBOpVAxMRI0S2EwFXV
1bxYeYychiiCFVaCpuKI2nB2wiGkyVKQc8M5bvE2BLg6HtTxDZVPIGVnUBuE9dci
ngloCRk/aNTouZLbt9qV4XvsNRx3XekWJi6ZoGIj8Xnj/g2e6yAGKNcJBut04t6/
qKxPmg53Niy3ZV8TsHoLkS1ZBtIbKFKIraTkmKHFgGSYTpST5zHolPGnWHQBTNbX
xQ3s4EnaaWO68h/k2idXdYecppJK0OwYX+85PBXt0576mJCHthsjS9grEp1LLGgp
aV7MyUlATCt91UcpHjkj
=rdFw
-----END PGP SIGNATURE-----

--EH85xkKza2NXtwkF--
