From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: lockdep report at resume
Date: Mon, 23 Mar 2009 10:29:32 +0100
Message-ID: <1237800572.19647.97.camel@johannes.local>
References: <1234022517.4175.107.camel@johannes.local>
	 <1237536764.5100.124.camel@johannes.local>
	 <alpine.LNX.2.00.0903201535470.14346@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-J6kDHZkYrhinGrUp21D9"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:41516 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZCWJ3k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2009 05:29:40 -0400
In-Reply-To: <alpine.LNX.2.00.0903201535470.14346@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>


--=-J6kDHZkYrhinGrUp21D9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-03-20 at 15:37 +0100, Jiri Kosina wrote:
> On Fri, 20 Mar 2009, Johannes Berg wrote:
>=20
> > > [20920.458587] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [20920.458944] [ INFO: possible circular locking dependency detected =
]
> > > [20920.459231] 2.6.29-rc3-wl-12787-g17d9115-dirty #38
> > > [20920.459449] ------------------------------------------------------=
-
> > > [20920.459736] events/0/9 is trying to acquire lock:
> > > [20920.459951]  (&dev->mutex){--..}, at: [<ffffffff804be0ac>] input_d=
isconnect_device+0x2c/0xf0
> > > [20920.460369]=20
> > > [20920.460370] but task is already holding lock:
> > > [20920.460637]  (&usbhid->reset_work){--..}, at: [<ffffffff8025a933>]=
 run_workqueue+0xb3/0x250
> > > [20920.461049]=20
> > > [20920.461050] which lock already depends on the new lock.
> > Ping? I just ran into it again on 2.6.29-rc8-wl-18593-gef1cb6f-dirty.
>=20
> I haven't still fully gone through the whole dependency chain, was quite=20
> overloaded lately, sorry.
>=20
> There is a patch from Oliver Neukum, that fixes workqueue usage semantics=
=20
> around hid_reset() on [1], could you please check whether it also fixes=20
> the report you are seeing? Thanks.
>=20
> [1] http://lkml.org/lkml/2009/3/18/39

That patch doesn't even apply against a current tree.

johannes

--=-J6kDHZkYrhinGrUp21D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJx1Z5AAoJEKVg1VMiehFYMhkQAJlkbcn5YTdKY4eQna95eK2S
3uAUeeGqygrwv0EhJH/5S/UXuykIMg6m9lsimeKdHrFEwFQcFszefBNdjQEx5e2V
LG4kFnxvc3hAul2fMHRHnmjouMqghVV0Y4zPZhU1sv9zLX/17WKT1e3cEHt5ebhY
vih7nteve9T4xM1008UIqtN9KQd+8AfDU+K44ZE2XiowKeVVxiKcPCuaTNbvXFxz
TQgQ9GXp3QBg6LpNsHuJxVpbxkVuOrOewCeYuvlna8OCcPSTkM4W+hsMGqLBHmUc
GtzN5ExTx6J476g4Z7v/3WdYh+gpc+F3N6qU69NTTx8EAGGuLvg17oeSXKCk5dR4
63ax7qGywDuz9JMtvvLkpnKhNNUJaZmlSA/i8lnWi6i0i6PmmrfU/TJOD3PrUchK
B3Vo1uA9o13pd5kpMbDEWxdnpwHDYC6PXgww9o6mvSbqGO6UtOKDsnbCgO4Nw5mA
qX93eu/BDSEWts7aay8uISVnLLzWtTgeCgS+IfxrsT7hTBDu1UL+3I6/TRZLLC54
qG5VKk7lRY4v2EtCc/5d4HQ4p+Qm8YcQKSRA1uWdzgK7M4Gvre7CiCuelS3lPB/a
PwjimSn9RN3zX9e1rccsdlCgMKsJr8ksSZZCr8ncDCHo6XR4gKTCV9PtjwOVGnNN
3rzdLTscoRrlrzS9Wz11
=re6U
-----END PGP SIGNATURE-----

--=-J6kDHZkYrhinGrUp21D9--

