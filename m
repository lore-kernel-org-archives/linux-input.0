From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS -
 fix V8+ protocol handling (73 03 28)")
Date: Sat, 22 Jul 2017 14:57:07 -0400
Message-ID: <20170722185707.GA2164@TopQuark.net>
References: <20170619232026.GG1855@TopQuark.net>
 <s5hwp7f3rdc.wl-tiwai@suse.de>
 <20170711195821.GG1855@TopQuark.net>
 <s5hlgnuf7l0.wl-tiwai@suse.de>
 <20170712162841.GI1855@TopQuark.net>
 <s5hh8y8953z.wl-tiwai@suse.de>
 <KAWPR01MB1092D56648C7759C1267DC77C7A70@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <s5ha83z78o6.wl-tiwai@suse.de>
 <KAWPR01MB109234B8D002C4F2589C375DC7A70@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <s5h379r9yo1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:47229 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdGVS5Z (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 22 Jul 2017 14:57:25 -0400
Content-Disposition: inline
In-Reply-To: <s5h379r9yo1.wl-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Laura Abbott <labbott@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pali Rohar <pali.rohar@gmail.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "scott.s.lowe@gmail.com" <scott.s.lowe@gmail.com>

Hmm... I see the same doubled X values in evtest, but everything works fi=
ne regardless of what value I set x_max to.
Maybe the issue is related to the window manager?  I've tried it under bo=
th Compiz and Xfwm with the same results.
Regardless, the latest patch works for me.

Thanks!

-Paul

On Thu, Jul 20, 2017 at 12:43:10PM +0200, Takashi Iwai wrote:
> On Thu, 20 Jul 2017 12:02:10 +0200,
> Masaki Ota wrote:
> >=20
> > Hi,=20
> >=20
> > Some user reported that this issue happened from kernel 4.10.7.
> > Because the below patch was applied on it.
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.g=
it/commit/?id=3D0186e6a4e501d39f5f90dd7e5887bc668aef06c4
> >=20
> > So, I thought the cause of this issue is this patch.
> > Original code meaning is Kernel 4.10.6, it seems not to have this iss=
ue.
>=20
> The bug has been present from the beginning, but it didn't surface
> until another commit to change x_max and co because MT feature is
> mostly used only for scrolling and such simple behavior.  For
> scrolling, even the bogus MT_X value could work casually with the
> certain x_max value used in the original commit.
> Actually, by fiddling with x_max (either less than 2200 or greater
> than 3000), the two-finger scroll "works", although it shouldn't.
>=20
>=20
> Takashi
>=20
> >=20
> > Best Regards,
> > Masaki Ota
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]=20
> > Sent: Thursday, July 20, 2017 6:35 PM
> > To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.a=
lps.com>
> > Cc: Paul Donohue <linux-kernel@PaulSD.com>; Laura Abbott <labbott@red=
hat.com>; Dmitry Torokhov <dmitry.torokhov@gmail.com>; Pali Rohar <pali.r=
ohar@gmail.com>; Nick Fletcher <nick.m.fletcher@gmail.com>; linux-input@v=
ger.kernel.org; linux-kernel@vger.kernel.org; scott.s.lowe@gmail.com
> > Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input=
: ALPS - fix V8+ protocol handling (73 03 28)")
> >=20
> > On Thu, 20 Jul 2017 11:20:20 +0200,
> > Masaki Ota wrote:
> > >=20
> > > Hi, Takashi-san,
> > >=20
> > > That's great!=20
> > >=20
> > > Actually, SS4 PLUS device is a little different from SS4 device.
> > > I added SS4 PLUS code as below.
> > > Could you try it?
> >=20
> > Yes, it works as expected.  Feel free to take:
> >   Tested-by: Takashi Iwai <tiwai@suse.de>
> >=20
> > > And I still wonder why this issue does not happen on original code =
though X value is so large.
> >=20
> > Which original code are you referring to?
> > The bug manifests itself only for decoding multi-touch events.
> >=20
> >=20
> > thanks,
> >=20
> > Takashi
> >=20
> > >=20
> > > --- a/drivers/input/mouse/alps.c
> > > +++ b/drivers/input/mouse/alps.c
> > > @@ -1210,14 +1210,24 @@ static int alps_decode_ss4_v2(struct=20
> > > alps_fields *f,
> > > =20
> > >  	case SS4_PACKET_ID_TWO:
> > >  		if (priv->flags & ALPS_BUTTONPAD) {
> > > -			f->mt[0].x =3D SS4_BTL_MF_X_V2(p, 0);
> > > +			if (IS_SS4PLUS_DEV(priv->dev_id)) {
> > > +				f->mt[0].x =3D SS4_PLUS_BTL_MF_X_V2(p, 0);
> > > +				f->mt[1].x =3D SS4_PLUS_BTL_MF_X_V2(p, 1);
> > > +			} else {
> > > +				f->mt[0].x =3D SS4_BTL_MF_X_V2(p, 0);
> > > +				f->mt[1].x =3D SS4_BTL_MF_X_V2(p, 1);
> > > +			}
> > >  			f->mt[0].y =3D SS4_BTL_MF_Y_V2(p, 0);
> > > -			f->mt[1].x =3D SS4_BTL_MF_X_V2(p, 1);
> > >  			f->mt[1].y =3D SS4_BTL_MF_Y_V2(p, 1);
> > >  		} else {
> > > -			f->mt[0].x =3D SS4_STD_MF_X_V2(p, 0);
> > > +			if (IS_SS4PLUS_DEV(priv->dev_id)) {
> > > +				f->mt[0].x =3D SS4_PLUS_STD_MF_X_V2(p, 0);
> > > +				f->mt[1].x =3D SS4_PLUS_STD_MF_X_V2(p, 1);
> > > +			} else {
> > > +				f->mt[0].x =3D SS4_STD_MF_X_V2(p, 0);
> > > +				f->mt[1].x =3D SS4_STD_MF_X_V2(p, 1);
> > > +			}
> > >  			f->mt[0].y =3D SS4_STD_MF_Y_V2(p, 0);
> > > -			f->mt[1].x =3D SS4_STD_MF_X_V2(p, 1);
> > >  			f->mt[1].y =3D SS4_STD_MF_Y_V2(p, 1);
> > >  		}
> > >  		f->pressure =3D SS4_MF_Z_V2(p, 0) ? 0x30 : 0; @@ -1234,16 +1244,=
27 @@=20
> > > static int alps_decode_ss4_v2(struct alps_fields *f,
> > > =20
> > >  	case SS4_PACKET_ID_MULTI:
> > >  		if (priv->flags & ALPS_BUTTONPAD) {
> > > -			f->mt[2].x =3D SS4_BTL_MF_X_V2(p, 0);
> > > +			if (IS_SS4PLUS_DEV(priv->dev_id)) {
> > > +				f->mt[0].x =3D SS4_PLUS_BTL_MF_X_V2(p, 0);
> > > +				f->mt[1].x =3D SS4_PLUS_BTL_MF_X_V2(p, 1);
> > > +			} else {
> > > +				f->mt[2].x =3D SS4_BTL_MF_X_V2(p, 0);
> > > +				f->mt[3].x =3D SS4_BTL_MF_X_V2(p, 1);
> > > +			}
> > > +
> > >  			f->mt[2].y =3D SS4_BTL_MF_Y_V2(p, 0);
> > > -			f->mt[3].x =3D SS4_BTL_MF_X_V2(p, 1);
> > >  			f->mt[3].y =3D SS4_BTL_MF_Y_V2(p, 1);
> > >  			no_data_x =3D SS4_MFPACKET_NO_AX_BL;
> > >  			no_data_y =3D SS4_MFPACKET_NO_AY_BL;
> > >  		} else {
> > > -			f->mt[2].x =3D SS4_STD_MF_X_V2(p, 0);
> > > +			if (IS_SS4PLUS_DEV(priv->dev_id)) {
> > > +				f->mt[0].x =3D SS4_PLUS_STD_MF_X_V2(p, 0);
> > > +				f->mt[1].x =3D SS4_PLUS_STD_MF_X_V2(p, 1);
> > > +			} else {
> > > +				f->mt[0].x =3D SS4_STD_MF_X_V2(p, 0);
> > > +				f->mt[1].x =3D SS4_STD_MF_X_V2(p, 1);
> > > +			}
> > >  			f->mt[2].y =3D SS4_STD_MF_Y_V2(p, 0);
> > > -			f->mt[3].x =3D SS4_STD_MF_X_V2(p, 1);
> > >  			f->mt[3].y =3D SS4_STD_MF_Y_V2(p, 1);
> > >  			no_data_x =3D SS4_MFPACKET_NO_AX;
> > >  			no_data_y =3D SS4_MFPACKET_NO_AY;
> > > @@ -2536,8 +2557,8 @@ static int alps_set_defaults_ss4_v2(struct=20
> > > psmouse *psmouse,
> > > =20
> > >  	memset(otp, 0, sizeof(otp));
> > > =20
> > > -	if (alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]) ||
> > > -	    alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]))
> > > +	if (alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]) ||
> > > +	    alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]))
> > >  		return -1;
> > > =20
> > >  	alps_update_device_area_ss4_v2(otp, priv); diff --git=20
> > > a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h index=20
> > > 4334f2805d93..75542199edda 100644
> > > --- a/drivers/input/mouse/alps.h
> > > +++ b/drivers/input/mouse/alps.h
> > > @@ -99,6 +99,10 @@ enum SS4_PACKET_ID {
> > >  				 ((_b[1 + _i * 3]  << 5) & 0x1F00)	\
> > >  				)
> > > =20
> > > +#define SS4_PLUS_STD_MF_X_V2(_b, _i) (((_b[0 + (_i) * 3] << 4) & 0=
x0070) | \
> > > +				 ((_b[1 + (_i) * 3]  << 4) & 0x0F80)	\
> > > +				)
> > > +
> > >  #define SS4_STD_MF_Y_V2(_b, _i)	(((_b[1 + (_i) * 3] << 3) & 0x0010=
) |	\
> > >  				 ((_b[2 + (_i) * 3] << 5) & 0x01E0) |	\
> > >  				 ((_b[2 + (_i) * 3] << 4) & 0x0E00)	\
> > > @@ -108,6 +112,10 @@ enum SS4_PACKET_ID {
> > >  				 ((_b[0 + (_i) * 3] >> 3) & 0x0010)	\
> > >  				)
> > > =20
> > > +#define SS4_PLUS_BTL_MF_X_V2(_b, _i) (SS4_PLUS_STD_MF_X_V2(_b, _i)=
 |	\
> > > +				 ((_b[0 + (_i) * 3] >> 4) & 0x0008)	\
> > > +				)
> > > +
> > >  #define SS4_BTL_MF_Y_V2(_b, _i)	(SS4_STD_MF_Y_V2(_b, _i) | \
> > >  				 ((_b[0 + (_i) * 3] >> 3) & 0x0008)	\
> > >  				)
> > > --
> > >=20
> > > Best Regards,
> > > Masaki Ota
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, July 19, 2017 5:57 PM
> > > To: Paul Donohue <linux-kernel@PaulSD.com>
> > > Cc: Laura Abbott <labbott@redhat.com>; =E5=A4=AA=E7=94=B0 =E7=9C=9F=
=E5=96=9C Masaki Ota=20
> > > <masaki.ota@jp.alps.com>; Dmitry Torokhov <dmitry.torokhov@gmail.co=
m>;=20
> > > Pali Rohar <pali.rohar@gmail.com>; Nick Fletcher=20
> > > <nick.m.fletcher@gmail.com>; linux-input@vger.kernel.org;=20
> > > linux-kernel@vger.kernel.org; scott.s.lowe@gmail.com
> > > Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Inp=
ut:=20
> > > ALPS - fix V8+ protocol handling (73 03 28)")
> > >=20
> > > On Wed, 12 Jul 2017 18:28:41 +0200,
> > > Paul Donohue wrote:
> > > >=20
> > > > On Wed, Jul 12, 2017 at 09:16:43AM +0200, Takashi Iwai wrote:
> > > > > On Tue, 11 Jul 2017 21:58:21 +0200, Paul Donohue wrote:
> > > > > >=20
> > > > > > On Tue, Jul 11, 2017 at 05:50:07PM +0200, Takashi Iwai wrote:
> > > > > > > Hi, just joining to the party in the middle, as I'm also=20
> > > > > > > facing the same problem on Dell E7270 laptop.  Has this iss=
ue=20
> > > > > > > already been addressed?
> > > > > > >=20
> > > > > > > If not, the following was my result:
> > > > > > >=20
> > > > > > > - the first patch slowed the pointer movement a lot, it's e=
ven slower
> > > > > > >   than the old kernel (e.g. 4.4.x).
> > > > > > >   The two finger scroll works fine on all touchpad area now=
.
> > > > > > >=20
> > > > > > > - the second patch made the pointer movement even faster th=
an now (as
> > > > > > >   I feel, not quite sure).  The two finger scroll doesn't w=
ork at the
> > > > > > >   right side of the touchpad.
> > > > > > >=20
> > > > > > >=20
> > > > > > > The kernel output from the first patch is below:
> > > > > > >   psmouse serio1: alps: test1 pitch 37x37 num-electrodes 8x=
7=20
> > > > > > > physical size 25x22mm res 69x69 max 1792x1536
> > > > > > >=20
> > > > > > > Let me know if you have any further test.
> > > > > > >=20
> > > > > > >=20
> > > > > > > thanks,
> > > > > > >=20
> > > > > > > Takashi
> > > > > >=20
> > > > > > Do you have the kernel output from the second patch?
> > > > >=20
> > > > > Here it is:
> > > > >=20
> > > > > psmouse serio1: alps: test2 pitch 50x54 num-electrodes 20x11=20
> > > > > physical size 95x54mm res 25x23 max 2432x1280
> > > >=20
> > > > Thanks!
> > > >=20
> > > > Wow, this is weird ... Values that cause scrolling issues for you=
 work fine for me.
> > > >=20
> > > > It looks like the priv->x_max value that is causing your problem,=
 but perhaps you can confirm this with another test:
> > > > Revert the patches above, then just before the 'return' at the en=
d of alps_update_device_area_ss4_v2() add the following line:
> > > > priv->x_max =3D 1792;
> > > > I suspect this line will make two-finger scrolling work again.
> > > >=20
> > > > It might also help if you could experiment with other x_max value=
s.  2432 is the correct value that causes problems for you..  Does a smal=
l value like 500 or a large value like 5000 change the behavior?
> > > >=20
> > > > Another test you can try is to add a print statement in the 'case=
 SS4_PACKET_ID_TWO' section of alps_decode_ss4_v2() and print out the f->=
mt[0].x and f->mt[1].x values.  With x_max set to 2432, what range of x v=
alues does this print when scrolling works, and what range of values are =
printed when scrolling doesn't work?
> > >=20
> > > Sorry for the late reply.
> > >=20
> > > I checked your suggestion, and noticed that actually x_max is a red=
=20
> > > herring.  Then I started looking at the output of evtest (should ha=
ve=20
> > > done from the beginning!), and the problem became obvious: the=20
> > > reported X values for MT with finger > 1 are doubled, e.g. it repor=
ts
> > > 4800 instead of 2400.  The MT_Y coordinate looks OK, so it's only a=
bout MT_X.  And finger=3D1 reports correctly.
> > >=20
> > > After reading the code, I ended up the patch like below.  This seem=
s working through a quick test.  Could anyone check the patch to see whet=
her it works / breaks anything?
> > >=20
> > > The evtest showed that the MT_X for finger 3 and 4 are also bogus, =
and the patch should address it, too.
> > >=20
> > > My only concern so far is whether correcting this globally is right=
, or it's specific to some certain models.  This needs the confirmation f=
rom ALPS people...
> > >=20
> > >=20
> > > thanks,
> > >=20
> > > Takashi
> > >=20
> > >=20
> > > --- a/drivers/input/mouse/alps.h
> > > +++ b/drivers/input/mouse/alps.h
> > > @@ -96,8 +96,8 @@ enum SS4_PACKET_ID {
> > > =20
> > >  #define SS4_BTN_V2(_b)		((_b[0] >> 5) & SS4_MASK_NORMAL_BUTTONS)
> > > =20
> > > -#define SS4_STD_MF_X_V2(_b, _i)	(((_b[0 + (_i) * 3] << 5) & 0x00E0=
) |	\
> > > -				 ((_b[1 + _i * 3]  << 5) & 0x1F00)	\
> > > +#define SS4_STD_MF_X_V2(_b, _i)	(((_b[0 + (_i) * 3] << 4) & 0x0070=
) |	\
> > > +				 ((_b[1 + (_i) * 3] << 4) & 0x0F80)	\
> > >  				)
> > > =20
> > >  #define SS4_STD_MF_Y_V2(_b, _i)	(((_b[1 + (_i) * 3] << 3) & 0x0010=
) |	\
> > > @@ -106,7 +106,7 @@ enum SS4_PACKET_ID {
> > >  				)
> > > =20
> > >  #define SS4_BTL_MF_X_V2(_b, _i)	(SS4_STD_MF_X_V2(_b, _i) |		\
> > > -				 ((_b[0 + (_i) * 3] >> 3) & 0x0010)	\
> > > +				 ((_b[0 + (_i) * 3] >> 2) & 0x0008)	\
> > >  				)
> > > =20
> > >  #define SS4_BTL_MF_Y_V2(_b, _i)	(SS4_STD_MF_Y_V2(_b, _i) | \
> > >=20
>=20
