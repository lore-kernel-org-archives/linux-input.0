From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Fri, 26 Nov 2010 23:59:20 -0800
Message-ID: <20101127075920.GB28667@core.coreip.homeip.net>
References: <4CEE6D2A.9040408@euromail.se>
 <4CEE6EE8.4060805@gmail.com>
 <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42580 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab0K0H71 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 02:59:27 -0500
Received: by iwn35 with SMTP id 35so327860iwn.19
        for <linux-input@vger.kernel.org>; Fri, 26 Nov 2010 23:59:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On Fri, Nov 26, 2010 at 05:02:05PM -0600, Chris Bagwell wrote:
> On Thu, Nov 25, 2010 at 8:12 AM, Nikolai Kondrashov <spbnick@gmail.co=
m> wrote:
> > On 11/25/2010 05:05 PM, Henrik Rydberg wrote:
> >>
> >> =A0 =A0 =A0 =A0__u32 =A0 phys_abs_width; =A0 =A0 =A0 =A0 /* physic=
al width of surface (mm)
> >> */
> >> =A0 =A0 =A0 =A0__u32 =A0 phys_abs_height; =A0 =A0 =A0 =A0/* physic=
al height of surface (mm)
> >> */
> >
> > This is better and is already covered by input_absinfo.
> > You could calculate it with (maximum - minimum) / resolution.
>=20
> On this topic.  I'd like to start reporting resolution for a few waco=
m
> devices.
>=20
> When I looked at input_absinfo.resolution, I see only synaptics.c is
> using it right now and it is defined using units/mm.  Currently, this
> makes it up to xf86-input-synaptics were X is fed this value after
> converting to units/meter.  Thats my intended usage as well.
>=20
> I'm more used to values in inches (lpi) or at least something higher
> then mm.  If I converted my lpi to mm for resolution I'd lose some
> accuracy.

Right, with devices that have low accuracy you'd be losing accuracy her=
e
too.

>=20
> We could solve that a few ways.  Provide units in input_absinfo,
> convert to units/inch, units/cm or even units/meter, or define
> physical size in mm.

How big is the error and how important is it if we go with option 4 (do
nothing)?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
