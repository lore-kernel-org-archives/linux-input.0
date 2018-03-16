From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization for v3
 and v6 protocols
Date: Fri, 16 Mar 2018 11:58:11 +0100
Message-ID: <20180316105811.t2nkwowqs66f6ji6@pali>
References: <20180312230915.26050-1-pali.rohar@gmail.com>
 <20180312231335.fnfxgenu22utr3z6@pali>
 <TYXPR01MB0719092EDE164BA6C576A1C7C7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
 <20180314225816.634w64kggycj67ec@pali>
 <TYXPR01MB07191C487C66BA03E5D9AB3DC7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TYXPR01MB07191C487C66BA03E5D9AB3DC7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Great, thank you. Enabling that RAW/extended/SP4 mode is done by
sequence E6, E6, E6, F3, C8, F3, 14 (written in page 35) and it matches
what function alps_trackstick_enter_extended_mode_v3_v6() in my patch is
doing. So is correct.

On page 36 I see that there is described Method 1 for reporting stick
data which prevents cursor jumps. Seems that kernel uses Method 2.
Method 1 depends on some prioritization.

Do you have some information how to activate Method 1? Sometimes I
observe that problem with "cursor jumps" and from Method 1 could prevent
it. So I would like to try experimenting...

On Wednesday 14 March 2018 23:56:46 Masaki Ota wrote:
> Hi, Pali,
>=20
> I have added Appendix.
> According to this spec documents, SP raw mode is SP 4 byte mode.
> I think Extended mode meaning is almost all the same as Raw mode.
> The description of how to set is written in Page 35.
>=20
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]=20
> Sent: Thursday, March 15, 2018 7:58 AM
> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps.=
com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; linux-input@vger.kernel.=
org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization fo=
r v3 and v6 protocols
>=20
> Hi! Thank you for information.
>=20
> Your PS/2 Aux Port Control description seems to really matches. Just ther=
e is reverse order of bits. Bit 0 in description is highest, therefore matc=
hes BIT(7) macro.
>=20
> Bit 6 in description (BIT(1) in code) describes SP Extended Mode which al=
ps.c enabled. And in that description is written:
>=20
> "If 1 SP is extended packet format (driver must set SP raw mode and GP ab=
solute mode)."
>=20
> Do you have any idea what "SP raw mode" is? How to set it? For me it look=
s like it could be that extended mode of trackstick itself.
>=20
> "GP absolute mode" I guess is GlidePoint absolute mode, therefore enable
> 6 byte absolute mode for touchpad.
>=20
> And for Bit 7 (BIT(0)) is written:
>=20
> This bit is used with the PS/2 Aux port to use the Pass-Thru mode ( see a=
ppendix A ). Do you have some information about this appendix A?
>=20
> On Wednesday 14 March 2018 10:21:43 Masaki Ota wrote:
> > Hi, Pali,
> >=20
> > I just picked up the spec which relates with trackstic.
> >=20
> > Best Regards,
> > Masaki Ota
> > -----Original Message-----
> > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > Sent: Tuesday, March 13, 2018 8:14 AM
> > To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alp=
s.com>; Dmitry Torokhov=20
> > <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization=
=20
> > for v3 and v6 protocols
> >=20
> > Masaki, if you have access to the internal ALPS v3 / Rushmore=20
> > documentation, I would like to have a review of this patch or=20
> > confirmation of those information :-)
>=20
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
