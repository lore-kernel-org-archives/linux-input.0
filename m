From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v2 2/5] platform/x86: intel-vbtn: Support separate press/release events
Date: Fri, 10 Nov 2017 03:44:08 +0100
Message-ID: <6160107.5aeZWuaZvU@pebbles>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de> <1637751.MqEGyCB5Qi@pebbles> <20171110021137.GE9783@fury>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2675023.LTSkr8gxWR";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20171110021137.GE9783@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart2675023.LTSkr8gxWR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, November 10, 2017 3:11:37 AM CET Darren Hart wrote:
> On Fri, Nov 10, 2017 at 02:58:36AM +0100, Stefan Br=FCns wrote:
> > On Friday, November 10, 2017 2:34:17 AM CET Darren Hart wrote:
> > > On Thu, Nov 09, 2017 at 11:44:33PM +0100, Stefan Br=FCns wrote:
> > > > Currently all key events use autorelease, but this forbids use as a
> > > > modifier key.
> > > >=20
> > > > As all event codes come in even/odd pairs, we can lookup the key ty=
pe
> > > > (KE_KEY/KE_IGNORE) for the key up event corresponding to the curren=
tly
> > > > handled key down event. If the key up is ignored, we keep setting t=
he
> > > > autorelease flag for the key down.
> > >=20
> > > What is the use-case for using these buttons as modifiers? I'm pictur=
ing
> > > one of these devices in tablet mode, with a physical Windows button.
> > > What other action does a user want to modify by holding the Windows
> > > button down? Or is there another scenario we're trying to support her=
e?
> >=20
> > Windows/KEY_LEFTMETA can be used as a modifier key, e.g. in combination
> > with the Volume Up/Down keys. On Windows, the default for Win + VolumeUp
> > creates a screenshot.
> >=20
> > You can also use this in combination with an onscreen keyboard. Pressing
> > the hardware button with the hand holding the tablet and typing with the
> > other hand on the OSK is probably easier than hitting both keys on the
> > OSK.
> This all makes sense - good context for the commit message. If no other
> changes end up being needed, I'm happy to paste it in at merge. If changes
> are required, please add it in v3.
>=20
> > Additionally, the Volume Up/Down currently do not autorepeat, as the key
> > is
> > autoreleased on the press event. The XPS 12 does issue distinct
> > press/release events, so this could be done properly. The same apparent=
ly
> > holds for some other convertibles, see the links in Patch 1/5.
>=20
> It sounds like this is spotty across intel-vbtn implementations? Some
> devices emit release, others do not? How would you teach the driver about
> the differences? Assume autorelease and change the sparse keymap entry for
> DMI matched platforms with release? Doable... sounds unpleasant to mainta=
in
> and update. Do we support this fully in userspace already?

=2D 0xcc/0xcd SW_TABLET mode seems to be consistent and widespread

=2D 0xc4-0xc7 KEY_VOLUME_{UP,DOWN} seems to be consistent, although not use=
d=20
very often (Lenovo Helix 2, XPS 12, other Dell XPS), others probably use WMI

=2D 0xc2/0xc3 KEY_LEFTMETA is used on Helix 2 and XPS 12, but only the XPS=
=20
issues 0xc2 on press and 0xc3 on release, the Helix 2 issues both codes on=
=20
release and none on press.

The statements above are verified on the XPS 12, the other findings are fro=
m=20
the Internet, search for "unknown event index" + "intel-vbtn".

As far as I can see, there are no implementation which do not issue the eve=
nts=20
in pairs, so currently the quirks table would be empty.

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart2675023.LTSkr8gxWR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWgUSeAAKCRBvf0o9jP6q
UweFAKCoMD5ZxmBTCdz/IhqmtxAHvR5mlQCeJjPyVsD2Wj9q6jC3cF7IBPyDA6c=
=fOop
-----END PGP SIGNATURE-----

--nextPart2675023.LTSkr8gxWR--
