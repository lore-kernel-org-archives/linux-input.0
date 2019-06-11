From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= input: alps-fix the issue alps
 cs19 trackstick do not work.
Date: Tue, 11 Jun 2019 19:17:07 +0200
Message-ID: <20190611171707.tydk7rsmtzmjohky@pali>
References: <20190528071824.jimhixhtsynzwixe@pali>
 <OSBPR01MB48556FD88D7F7D5F91CB5579DA1E0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <OSBPR01MB4855707AC8ABB7CFBE5BBBD5DA130@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <OSBPR01MB4855A2A30A4F5E6BDCFE715FDA130@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <20190610104310.qa5snt7jpcljodfv@pali>
 <OSBPR01MB485504868362073ED434F82FDAED0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <ed65f8af-fefb-3c40-e7b1-dde3605f30e3@canonical.com>
 <5587ddb9-fb5f-03db-ac11-a696c85c5f2f@canonical.com>
 <20190611072333.nd4va4q2m5epmukc@pali>
 <20190611170707.GA143729@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yk3mp3oui5gzabch"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190611170707.GA143729@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: Hui Wang <hui.wang@canonical.com>, Xiaoxiao Liu <xiaoxiao.liu-1@cn.alps.com>, XiaoXiao Liu <sliuuxiaonxiao@gmail.com>, "peter.hutterer@who-t.net" <peter.hutterer@who-t.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaojian Cao <xiaojian.cao@cn.alps.com>, "zhangfp1@lenovo.com" <zhangfp1@lenovo.com>, Naoki Saito <naoki.saito@alpsalpine.com>, Hideo Kawase <hideo.kawase@alpsalpine.com>
List-Id: linux-input@vger.kernel.org


--yk3mp3oui5gzabch
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 11 June 2019 10:07:07 dmitry.torokhov@gmail.com wrote:
> On Tue, Jun 11, 2019 at 09:23:33AM +0200, Pali Roh=C3=A1r wrote:
> > On Tuesday 11 June 2019 12:32:33 Hui Wang wrote:
> > > On 2019/6/11 =E4=B8=8A=E5=8D=8811:23, Hui Wang wrote:
> > > > On 2019/6/11 =E4=B8=8A=E5=8D=8811:05, Xiaoxiao Liu wrote:
> > > > > Hi Pali,
> > > > >=20
> > > > > I discussed with our FW team about this problem.
> > > > > We think the V8 method means a touchpad feature=C2=A0 and does no=
t fit
> > > > > the CS19 trackpoint device.
> > > > > CS19 TrackPoint needn't=C2=A0 use any Absolute (Raw) mode and is =
usually
> > > > > use standard mouse data.
> > > > > CS19 TrackPoint device is a completely different device with
> > > > > DualPoint device of Dell/HP.
> > > > > CS19 TrackPoint device is independent=C2=A0 of Touchpad. (Touchpa=
d is
> > > > > connecting by I2C, TrackPoint is directly connecting with PS2 por=
t.)
> > > > > And it has completely another FW.
> > > > >=20
> > > > > So we think it is better to use the mouse mode for CS19 trackpoin=
t.
> > > >=20
> > > > Maybe here is some mis-understanding,=C2=A0 the mouse mode here doe=
sn't mean
> > > > we use psmouse-base.c for cs19 (bare ps/2 mouse), we plan to use
> > > > trackpoint.c to drive this HW, so this trackpoint has all features a
> > > > trackpoint should have.
> > > >=20
> > > And I sent a patch one month ago to let the the trackpoint.c to drive=
 this
> > > HW: https://www.spinics.net/lists/linux-input/msg61341.html, maybe th=
at
> > > patch is reference.
> >=20
> > So instead of creating blacklist, you should check for TP_VARIANT_ALPS
> > in alps.c and disallow its usage.
> >=20
> > Or maybe better, move trackpoint.c detect code before alsp.c detect code
> > in psmouse-base. And no changes in alps.c are needed.
>=20
> I'd be very cautions of moving around the protocol detection. It is very
> fragile, so if we can detect trackpoint-only case in alps.c and skip on
> to trackpoint I would prefer it.

The main problem is that proposed trackpoint-only check in alps.c is
basically what trackpoint.c is doing for checking if device is
trackpoint (via function trackpoint_start_protocol()).

So I'm not sure now what is the best solution...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yk3mp3oui5gzabch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXP/iEAAKCRCL8Mk9A+RD
Up7mAJ9bQIgZ06pMlZa1t6WOZ1oJCtYTxgCcC8h8NbVMVQgvRKYcG5H5EAHhWto=
=nHiP
-----END PGP SIGNATURE-----

--yk3mp3oui5gzabch--
