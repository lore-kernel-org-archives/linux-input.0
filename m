From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Sun, 01 Aug 2010 11:37:28 +0200
Message-ID: <4C554058.6080203@euromail.se>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com> <4C54ABFE.8050106@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:54811 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753400Ab0HAJhi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Aug 2010 05:37:38 -0400
In-Reply-To: <4C54ABFE.8050106@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 08/01/2010 01:04 AM, =C9ric Piel wrote:

[...]

> I've got some fairly new versions of everything, but at least here, t=
his
> is already happening with the X synaptics driver: in practice there i=
s
> not jump at all, which ever finger is reported in doubletap. In
> doubletap it moves the scrolling axes, and changing to singletap, it
> resets to the new current position. No jump, both with my old synapti=
cs
> hardware and with the elantech.


You are right. Jumping does not generally occur in synaptics when the n=
umber of
fingers changes.

The overall solution is still not quite satisfactory, since the MT poin=
ts
reported are the lower-left and upper-right corners of a rectangle, ins=
tead of
the actual touch points. As mentioned in another mail, it would make se=
nse to
add logic to bring this device up to the type A level. If the needed lo=
gic turns
out to be equivalent to the type B level, what can you do. :-)

How about this as a stab at the MT point problem. The idea here is that
get_corner_id() returns the rectangle corner which minimizes the change=
 in
motion direction, according to the principle of inertia. For all cases,
position[0] is reported as the ABS_X/Y point.

state =3D (num_finger, corner_id, motion_id, position[n])

At each touch frame update, do

1. num_finger =3D=3D 1

Set
  position[0] =3D finger-position

2. num_finger =3D=3D 2

If last frame was one finger, do
  Find corner id such that position change is minimized
    id =3D get_initial_corner_id(position[0], corner-position[id])

Else
  Find temporary motion id
    mid =3D get_motion_id(position[0], corner-position[corner_id])
  Find corner id such that motion change is minimized
    id =3D get_corner_id(corner_id, motion_id, mid)

Set
  corner_id =3D id
  motion_id =3D get_motion_id(position[0], corner-position[id])
  position[0] =3D corner-position[id],
  position[1] =3D corner-position[opposite[id]]

Report position[0] and position[1] as MT points

Since this is all integer logic, it should be possible to detect motion=
 changes
as sign changes, such that get_motion_id() and get_corner_id() can be
implemented as constant arrays.

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
