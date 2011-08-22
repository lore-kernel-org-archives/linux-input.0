From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/9 v4] Input: synaptics - add image sensor support
Date: Sun, 21 Aug 2011 21:28:22 -0700
Message-ID: <20110822042822.GA23010@core.coreip.homeip.net>
References: <1313666888-18939-1-git-send-email-djkurtz@chromium.org>
 <1313666888-18939-5-git-send-email-djkurtz@chromium.org>
 <20110819222203.GC5146@core.coreip.homeip.net>
 <CAGS+omCZSjJoESSvimLEpj9Mwr3d9Vn78e1ZLk-NWEdgQbxNKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56694 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab1HVE2a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Aug 2011 00:28:30 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omCZSjJoESSvimLEpj9Mwr3d9Vn78e1ZLk-NWEdgQbxNKw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: chase.douglas@canonical.com, rydberg@euromail.se, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, chris@cnpbagwell.com

On Sat, Aug 20, 2011 at 03:07:41PM +0800, Daniel Kurtz wrote:
> On Sat, Aug 20, 2011 at 6:22 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Daniel,
> >
> > On Thu, Aug 18, 2011 at 07:28:03PM +0800, Daniel Kurtz wrote:
> >> @@ -558,6 +626,11 @@ static void synaptics_process_packet(struct p=
smouse *psmouse)
> >> =A0 =A0 =A0 if (synaptics_parse_hw_state(psmouse->packet, priv, &h=
w))
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >>
> >> + =A0 =A0 if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 synaptics_image_sensor_process(psmouse, =
&hw);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> + =A0 =A0 }
> >> +
> >
> > So what about the rest of the SYnaptics processing (wheel, addition=
al
> > buttons, etc)? =A0Are we sure that touchpads with image sensors wil=
l never
> > implement them?
> >
> > --
> > Dmitry
> >
>=20
> All image sensors that I am aware of are clickpads, with one button
> integrated under the pad, which is reported as the middle button.
>=20
> We could report right, middle, up, down, and ext_buttons (scroll is
> not possible, since w=3D2;buf[1] is used for x for devices that send =
agm
> packets).
> However, I have no way of knowing if this added complexity is
> necessary

I would prefer us supporting full protocol so if some vendor does add
additional buttons we have everything in place.

> , nor any way of testing it.

As long as your case still works I think it will be good enough.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
