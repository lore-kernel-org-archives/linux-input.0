From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Bug in i2c-core?
Date: Sun, 8 Mar 2015 09:26:17 +0100
Message-ID: <20150308082617.GA1904@katana>
References: <54F0507F.6030804@armadeus.com>
 <20150227165944.GA6679@dtor-ws>
 <3574616.qzNqihiGp7@avalon>
 <20150304082237.GA2955@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57683 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbbCHI0L (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 8 Mar 2015 04:26:11 -0400
Content-Disposition: inline
In-Reply-To: <20150304082237.GA2955@katana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, =?utf-8?Q?S=C3=A9bastien?= SZYMANSKI <sebastien.szymanski@armadeus.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, Rob Herring <robh@kernel.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2015 at 09:22:37AM +0100, Wolfram Sang wrote:
>=20
> > > > I am writing an I2C touchscreen driver for an i.MX6 based board. I
> > > > compiled it as a module and when I unload it, I get the following w=
arning:
> > > >=20
> > > > # modprobe sx8654
> > > > [   46.261494] input: SX8654 I2C Touchscreen as
> > > > /devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-0048/input/i=
nput1
> > > > # rmmod sx8654
> > > > [   76.435223] ------------[ cut here ]------------
> > > > [   76.439909] WARNING: CPU: 0 PID: 134 at fs/proc/generic.c:552
> > > > remove_proc_entry+0x148/0x164()
> > > > [   76.448582] remove_proc_entry: removing non-empty directory
> > > > 'irq/208', leaking at least 'sx8654'
> > >=20
> > > ...
> > >=20
> > > > When I revert commit e4df3a0 (i2c: core: Dispose OF IRQ mapping at
> > > > client removal time) I don't get the warning.
> > > >=20
> > > > Is this a bug in the i2c-core or am I doing something wrong in my d=
river?
> > >=20
> > > Yes, this commit breaks all drivers using devm* for IRQ management on
> > > OF-based systemsi because devm* cleanup happens in device code, after
> > > bus's remove() method returns. I'd recommend reverting and finding a
> > > better way (making cleanup a custom devm action as well?).
> >=20
> > Ouch, my bad.
> >=20
> > Wolfram, any opinion ? The original patch fixes a real bug, so we shoul=
dn't=20
> > just revert it.
>=20
> Looking at it some more: What bug does it fix? Anything you experienced?
>=20
> I wonder if we really need e4df3a0 because I can't see where
> platform_get_irq, the major user of of_irq_get, disposes the mapping.
> irq_create_of_mapping() will return an already assigned mapping if
> called twice. I don't know yet, though, if mappings are static or if a
> mapping can be routed to another irq controller over some time because
> theoretically they can be dynamically added/removed.
>=20
> Adding Rob to CC as he wrote of_irq_get and put it into
> platform_get_irq. Rob, we use of_irq_get() in the I2C core and the
> question is now if we need to dispose the mapping and if so what would
> be a good place for it so managed devices will not have their mappings
> removed before the managed irq is removed.

Ping. Just so you know: Without further information, I will revert the
patch in question around rc4/rc5. I'd still like to know if the
non-disposing of the mapping in platform_get_irq() is intentional.

Thanks,

   Wolfram


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/AepAAoJEBQN5MwUoCm28IcP/jr+R9502SS6bGp3NV2B3XuT
1C3x2MmmlUYzA9MBm1X8nfZ+RxlTCdBDzdltO01MfJ6KoU0E/KrNe2Wshl2Wd1rV
pW1wMiHa3Z+e6jYq5jMR5j1QtAXWTZvpZ+VaS2O/FcWnnclfShP+vm8l6axHQPwX
1gbplUlF3yWx8/nssex0S6GwQWEmWBijeUQB7pBa4IWFXZjw+FOX3A6SyKYqYlF8
IUc5EBPRcjxTYo5kKtwmym54tYrydhDVwKF6T4vFVv7ni3e3Lu+TkUEGCToxRYFe
mGaIoJj++lVzhWI9aizLwltiCjBJq43E3ZFueYc4ve2kuA6CuOY0IF5nCjEK34/o
rZmqGOMAYVUpzyTM6Tw8sffOY9vKcP37FzRrtgm/z4DCG4XbSG3auTbFOJdhijha
JUaWJRYVpX20p7bteu7N88jQXhsIHyt/G7do8kO6T+hH59+QDiU4pLxqax5qZDMk
KyI9oomXw7RmU8Mi67S4mWMkR1p7WxoSn4+NxMc/XbuKS+HWOBXJnm/VZn1c2jmM
yDdniXu03gK6fZeCbhyWZ6WKiKy/aFLzZ1ZXUfkAVjb4pSNKQRy6E+fhmSzjw289
6jwSFQGnBRtkGn4A+Dtr9P3ASjdLcGbJFzRiooed+w7awzIgci/3BU5yjm47udoy
B3/MgPA+a4jJl2+OddH0
=7I3C
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
