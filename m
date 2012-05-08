From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC] Input: MT - Include win8 support
Date: Tue, 8 May 2012 16:02:21 +1000
Message-ID: <20120508060221.GA15925@yabbi.bne.redhat.com>
References: <1336230499-1450-1-git-send-email-rydberg@euromail.se>
 <CAN+gG=HqGmf77P6=7RMFT_Ez7Ysp4ZVJ6skfAoDcZ7JN1JtYnw@mail.gmail.com>
 <20120506182835.GA12221@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:56052 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab2EHGci (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 May 2012 02:32:38 -0400
Content-Disposition: inline
In-Reply-To: <20120506182835.GA12221@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, chasedouglas@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 06, 2012 at 08:28:35PM +0200, Henrik Rydberg wrote:
> (doh, trying again without attachment)
>=20
> Hi,
>=20
> to aid in the discussion, I have shared a drawing of the MT model
> and the (supposed) win8 model.
>=20
> https://docs.google.com/document/d/1KKu7kqPOsvE9tCmWhdGnmO8tgmN0Cd-Mv=
_crVaCZueY/view

having an asciiart version of this in Documentation/ would be quite use=
ful,
IMO
=20
> > > @@ -168,7 +168,9 @@ The TOUCH and WIDTH parameters have a geometr=
ical interpretation; imagine
> > > =A0looking through a window at someone gently holding a finger ag=
ainst the
> > > =A0glass. =A0You will see two regions, one inner region consistin=
g of the part
> > > =A0of the finger actually touching the glass, and one outer regio=
n formed by
> > > -the perimeter of the finger. The diameter of the inner region is=
 the
> > > +the perimeter of the finger. The center of the inner region is
> > > +ABS_MT_POSITION_X/Y. The center of the outer region may be diffe=
rent,
> > > +denoted by ABS_MT_APPROACH_X/Y. The diameter of the inner region=
 is the
> > > =A0ABS_MT_TOUCH_MAJOR, the diameter of the outer region is
> > > =A0ABS_MT_WIDTH_MAJOR. Now imagine the person pressing the finger=
 harder
> > > =A0against the glass. The inner region will increase, and in gene=
ral, the
> > > @@ -252,6 +254,9 @@ can distinguish between the two axis, but not=
 (uniquely) any values in
> > > =A0between. In such cases, the range of ABS_MT_ORIENTATION should=
 be [0, 1]
> > > =A0[4].
> > >
> > > +For devices capable of 360 degree orientation, the reported orie=
ntation
> > > +should be twice the given range.
> >=20
> > Like Chase, I don't understand the necessity of that.
>=20
> The MT model supports the arbitrary orientation of an ellipse. The
> angle is defined as a [-90,90] degree clockwise angle between the y
> axis and the major axis of the ellipse (marked o in the figure). Only
> 180 degrees are specified due to the symmetry; rotating 135 degrees i=
s
> equivalent to -45 degrees.
>=20
> In the win8 model, as in the windows surface model and most
> implementations of FTIR, it is possible to distinguish the absolute
> direction of a finger. This is equivalent to an ellipse with an arrow
> (the angle is marked A in the figure).
>=20
> To accomodate the directional angle in the MT model, one can simply
> report the full [-180,180] range instead. That is, report 135 degrees
> instead of -45.

Insert a paragraph into the actual documentation. I think that's more
helpful than tacking it on (if not quite as nice in a diff)

"The orientation of the ellipse. The value should describe a signed qua=
rter
of a revolution clockwise around the touch center. The signed value ran=
ge
is arbitrary, but zero should be returned for a finger aligned along th=
e Y
axis of the surface, a negative value when finger is turned to the left=
, and
a positive value when finger turned to the right. When completely align=
ed
with the X axis, the range max should be returned. =20

Touch ellipsis are symmetrical by default. For devices capable of true =
360
degree orientation, the reported orientation must exceed the range max =
to
indicate more than a quarter of a revolution. For an upside-down finger=
,=20
range max * 2 should be returned.

Orientation can be omitted if the touching object is circular, or if th=
e
information is not available in the kernel driver. Partial orientation
support is possible if the device can distinguish between the two axis,=
 but
not (uniquely) any values in between. In such cases, the range of
ABS_MT_ORIENTATION should be [0, 1] [4]."


Not a big fan of reporting values above absmin/absmax, tbh. It means we
can't rely on the axis values and have to special-case it. Plus, there'=
s no
way to detect this before you actually get a value.

> > > +
> > > =A0ABS_MT_POSITION_X
> > >
> > > =A0The surface X coordinate of the center of the touching ellipse=
=2E
> > > @@ -260,6 +265,23 @@ ABS_MT_POSITION_Y
> > >
> > > =A0The surface Y coordinate of the center of the touching ellipse=
=2E
> > >
> > > +ABS_MT_APPROACH_X
> >=20
> > Honestly, I think that ABS_MT_APPROACH_* is really confusing for
> > end-users (Xorg, Wayland, Qt, ...). I know that the explanation are
> > given, but looking at the mess we had with the use of the MT events
> > before it has been documented, I don't think this is the right term=
 to
> > use. Without the doc, and with a little bit of bad faith, I would s=
ay
> > that approach refers to the T coordinate in Win8 doc (the approxima=
te
> > position where the user wants to touch), whereas the POSITION_* is
> > more the center of the ellipse of the touch.... But it's the invert=
=2E..
> > ;-)
>=20
> Looking at the figure, it is clear that the MT model has two centers,
> one for each ellipse. Thus, center is not discriminating
> enough. Perhaps ABS_MT_OUTER_X/Y is more appropriate, then?

ABS_MT_OUTER_CENTER

Cheers,
  Peter

>=20
> > > +For win8 devices with Azimuth or Twist defined, the range max is=
 the value
> > > +for 90 degrees, and the orientation mapping is
> > > +
> > > + =A0 ABS_MT_ORIENTATION :=3D twist < 2 * max ? twist : twist - 4=
 * max
>=20
> Reading the HID spec again, it seems azimuth is the preferred value
> for touch, so twist can be omitted here. Also, it seems the angle
> should be counter-clockwise, thus the sign is wrong. On the other
> hand, it is unclear what the reference point is, maybe it can only be
> used for differential updates. Also, the word "cursor" is not further
> specified, it could be the orientation of the touch point or the
> orientation of the whole area. This hopefully will become clearer wit=
h
> time.
>=20
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
