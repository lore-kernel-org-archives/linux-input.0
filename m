From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC] Input: MT - Include win8 support
Date: Sun, 6 May 2012 20:28:35 +0200
Message-ID: <20120506182835.GA12221@polaris.bitmath.org>
References: <1336230499-1450-1-git-send-email-rydberg@euromail.se>
 <CAN+gG=HqGmf77P6=7RMFT_Ez7Ysp4ZVJ6skfAoDcZ7JN1JtYnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:59349 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab2EFSYK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 May 2012 14:24:10 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=HqGmf77P6=7RMFT_Ez7Ysp4ZVJ6skfAoDcZ7JN1JtYnw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, peter.hutterer@who-t.net, chasedouglas@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

(doh, trying again without attachment)

Hi,

to aid in the discussion, I have shared a drawing of the MT model
and the (supposed) win8 model.

https://docs.google.com/document/d/1KKu7kqPOsvE9tCmWhdGnmO8tgmN0Cd-Mv_c=
rVaCZueY/view


> > @@ -168,7 +168,9 @@ The TOUCH and WIDTH parameters have a geometric=
al interpretation; imagine
> > =A0looking through a window at someone gently holding a finger agai=
nst the
> > =A0glass. =A0You will see two regions, one inner region consisting =
of the part
> > =A0of the finger actually touching the glass, and one outer region =
formed by
> > -the perimeter of the finger. The diameter of the inner region is t=
he
> > +the perimeter of the finger. The center of the inner region is
> > +ABS_MT_POSITION_X/Y. The center of the outer region may be differe=
nt,
> > +denoted by ABS_MT_APPROACH_X/Y. The diameter of the inner region i=
s the
> > =A0ABS_MT_TOUCH_MAJOR, the diameter of the outer region is
> > =A0ABS_MT_WIDTH_MAJOR. Now imagine the person pressing the finger h=
arder
> > =A0against the glass. The inner region will increase, and in genera=
l, the
> > @@ -252,6 +254,9 @@ can distinguish between the two axis, but not (=
uniquely) any values in
> > =A0between. In such cases, the range of ABS_MT_ORIENTATION should b=
e [0, 1]
> > =A0[4].
> >
> > +For devices capable of 360 degree orientation, the reported orient=
ation
> > +should be twice the given range.
>=20
> Like Chase, I don't understand the necessity of that.

The MT model supports the arbitrary orientation of an ellipse. The
angle is defined as a [-90,90] degree clockwise angle between the y
axis and the major axis of the ellipse (marked o in the figure). Only
180 degrees are specified due to the symmetry; rotating 135 degrees is
equivalent to -45 degrees.

In the win8 model, as in the windows surface model and most
implementations of FTIR, it is possible to distinguish the absolute
direction of a finger. This is equivalent to an ellipse with an arrow
(the angle is marked A in the figure).

To accomodate the directional angle in the MT model, one can simply
report the full [-180,180] range instead. That is, report 135 degrees
instead of -45.

>=20
> > +
> > =A0ABS_MT_POSITION_X
> >
> > =A0The surface X coordinate of the center of the touching ellipse.
> > @@ -260,6 +265,23 @@ ABS_MT_POSITION_Y
> >
> > =A0The surface Y coordinate of the center of the touching ellipse.
> >
> > +ABS_MT_APPROACH_X
>=20
> Honestly, I think that ABS_MT_APPROACH_* is really confusing for
> end-users (Xorg, Wayland, Qt, ...). I know that the explanation are
> given, but looking at the mess we had with the use of the MT events
> before it has been documented, I don't think this is the right term t=
o
> use. Without the doc, and with a little bit of bad faith, I would say
> that approach refers to the T coordinate in Win8 doc (the approximate
> position where the user wants to touch), whereas the POSITION_* is
> more the center of the ellipse of the touch.... But it's the invert..=
=2E
> ;-)

Looking at the figure, it is clear that the MT model has two centers,
one for each ellipse. Thus, center is not discriminating
enough. Perhaps ABS_MT_OUTER_X/Y is more appropriate, then?

> > +For win8 devices with Azimuth or Twist defined, the range max is t=
he value
> > +for 90 degrees, and the orientation mapping is
> > +
> > + =A0 ABS_MT_ORIENTATION :=3D twist < 2 * max ? twist : twist - 4 *=
 max

Reading the HID spec again, it seems azimuth is the preferred value
for touch, so twist can be omitted here. Also, it seems the angle
should be counter-clockwise, thus the sign is wrong. On the other
hand, it is unclear what the reference point is, maybe it can only be
used for differential updates. Also, the word "cursor" is not further
specified, it could be the orientation of the touch point or the
orientation of the whole area. This hopefully will become clearer with
time.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
