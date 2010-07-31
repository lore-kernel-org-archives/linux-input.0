From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Sun, 01 Aug 2010 01:04:30 +0200
Message-ID: <4C54ABFE.8050106@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>	<4C1FD454.4050807@tudelft.nl>	<20100721033655.GA9070@core.coreip.homeip.net>	<4C532009.4020103@tudelft.nl>	<4C533DC3.9070001@euromail.se> <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:37705 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab0GaXE0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jul 2010 19:04:26 -0400
In-Reply-To: <AANLkTi=cEEx-5eQPbRYvMMaECvXKQ+i-e0Eaw_g4JY7=@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Op 31-07-10 21:53, Chris Bagwell schreef:
>=20
>=20
> On Fri, Jul 30, 2010 at 4:01 PM, Henrik Rydberg <rydberg@euromail.se
> <mailto:rydberg@euromail.se>> wrote:
>=20
>     On 07/30/2010 08:55 PM, =C9ric Piel wrote:
>=20
>     > On 21-07-10 05:36, Dmitry Torokhov wrote:
>     >> On Mon, Jun 21, 2010 at 11:06:28PM +0200, =C9ric Piel wrote:
>     >>> When 2 fingers are pressed, the low and high coordinates are =
given.
>     >>> Instead of reporting just the low coordinate as the normal po=
sition,
>     >>> report an average of both. This allow to have the cursor alwa=
ys
>     move,
>     >>> whichever finger moves. In practice, this improves the suppor=
t of
>     >>> two-fingers scolling with the synaptics X driver.
>     > :
>     >>> -        input_report_abs(dev, ABS_X, x1<<  2);
>     >>> -        input_report_abs(dev, ABS_Y, y1<<  2);
>     >>> +        input_report_abs(dev, ABS_X, (x1 + x2)<<  1);
>     >>> +        input_report_abs(dev, ABS_Y, (y1 + y2)<<  1);
>     >>
>     >> I am concerned what happens when you put one finger first and
>     then add
>     >> another one. Would not that couse the cursor to jump?
>=20
>=20
>     I agree, I have seen this behavior before and it is not quite wha=
t
>     you want. The
>     average point does jump.
>=20
>=20
> This is basically same approach as what synaptics hardware is
> reporting.  Their  Synaptics PS/2 TouchPad Interfacing Guide mentions
> current hardware reports an x/y closer to first finger during multipl=
e
> fingers and that older hardware reports a value closer to center.  Bo=
th
> cases, you can see movement when either finger is moving.
>=20
> There are a few existing X side bug reports I've seen related to this
> behaviour.  On newer synaptics pad its easiest to see if you touch 1s=
t
> finger on left side of pad, 2nd finger on right side of pad, and then
> release 1st finger then you will see a big cursor jump as hardware is
> force to transition over to 2nd finger x/y (make sure 2 finger scroll=
ing
> is disabled as that feature can fix issue).
>=20
> I've seen xf86-input-synaptics patches floating around that try to
> detect jumps-because-of-averaging from the size of delta and discard =
but
> it is easy to be mistaken.  Probably its better to detect
> BTN_TOOL_DOUBLETAP transitions back to 0 and treating similar to both
> fingers being lifted to account for expected jump.
>=20
> So an option is to do something similar to below and clearly document
> that user space needs to account for known reporting behaviour when
> BTN_TOOL_DOUBLETOUCH transitions back to 0.
I've got some fairly new versions of everything, but at least here, thi=
s
is already happening with the X synaptics driver: in practice there is
not jump at all, which ever finger is reported in doubletap. In
doubletap it moves the scrolling axes, and changing to singletap, it
resets to the new current position. No jump, both with my old synaptics
hardware and with the elantech.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
