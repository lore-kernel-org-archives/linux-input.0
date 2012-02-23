From: Florian Mickler <florian@mickler.org>
Subject: Re: multi-media key "mute" no longer recognized
Date: Fri, 24 Feb 2012 00:08:26 +0100
Message-ID: <20120224000826.05039158@schatten>
References: <201201231152.25344.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/DPjb43P1iTL6f7sTIE6Acnc"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201201231152.25344.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Toralf =?ISO-8859-15?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-kernel@vger.kernel.org, mjg@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--Sig_/DPjb43P1iTL6f7sTIE6Acnc
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Let's try to cc some people...

On Mon, 23 Jan 2012 11:52:24 +0100
Toralf F=F6rster <toralf.foerster@gmx.de> wrote:

> With kernel 3.1.10 I could mute my system by pressing the appropriate=20
> multimedia button either at my ThinkPad or at my external keyboard.
> With 3.2.1 this doesn't work anymore although the button itself is recogn=
ized=20
> when pressed (checked with xev).
>=20
> Now I'm wondering where to start to debug ?
>=20

In https://bugzilla.kernel.org/show_bug.cgi?id=3D42685 Toralf wrote:
> > with xev I get only one small diff related to "serial":
> >=20
> > tfoerste@n22 ~ $ tail -v mute-3.*
> > =3D=3D> mute-3.0.21 <=3D=3D
> > KeyRelease event, serial 33, synthetic NO, window 0x4600001,
> > root 0xc3, subw 0x0, time 293494, (1260,275), root:(1262,298),
> > state 0x0, keycode 121 (keysym 0x1008ff12, XF86AudioMute), same_screen =
YES,
> > XLookupString gives 0 bytes:=20
> > XFilterEvent returns: False
> >=20
> >=20
> > =3D=3D> mute-3.2.6 <=3D=3D
> > KeyRelease event, serial 32, synthetic NO, window 0x3a00001,
> > root 0xc3, subw 0x0, time 3424766, (-1217,745), root:(74,768),
> > state 0x0, keycode 121 (keysym 0x1008ff12, XF86AudioMute), same_screen =
YES,
> > XLookupString gives 0 bytes:=20
> > XFilterEvent returns: False


--Sig_/DPjb43P1iTL6f7sTIE6Acnc
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk9GxvEACgkQPjqCkyL3Kv1/CQCfUyDJZNPDgmxjwshWKLnn479G
INIAnjWo1zcuMzt2pKalgAWEv/R+GdAk
=a8ag
-----END PGP SIGNATURE-----

--Sig_/DPjb43P1iTL6f7sTIE6Acnc--
