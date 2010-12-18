From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/4] Input: synaptics - add multitouch packet support
Date: Sat, 18 Dec 2010 18:06:03 +0100
Message-ID: <20101218170603.GA1498@polaris.bitmath.org>
References: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
 <1292683981-6908-2-git-send-email-rydberg@euromail.se>
 <AANLkTimrNrfTXGh675_8zhOg_+9+NKgOmzJq9rafyh+6@mail.gmail.com>
 <AANLkTiktxcwfSvoVDEe3ykcT7ff9VwL_NBRVbbEvuJCV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:39555 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753147Ab0LRRGo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Dec 2010 12:06:44 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTiktxcwfSvoVDEe3ykcT7ff9VwL_NBRVbbEvuJCV@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

On Sat, Dec 18, 2010 at 10:56:59AM -0600, Chris Bagwell wrote:
> On Sat, Dec 18, 2010 at 10:55 AM, Chris Bagwell <chris@cnpbagwell.com=
> wrote:
> > On Sat, Dec 18, 2010 at 8:52 AM, Henrik Rydberg <rydberg@euromail.s=
e> wrote:
> >> From: Chase Douglas <chase.douglas@canonical.com>
> >>
> >> Synaptics 2.7 series of touchpads support a mode for reporting 2 s=
ets
> >> of X/Y/Pressure data (multi-touch). =A0These same devices default =
mode
> >> report single finger data and do not report finger counts.
> >>
> >> Enabling MT mode makes finger count reporting start working in sam=
e
> >> fashion as touchpads that claim that capability. Up to three finge=
rs
> >> can be reported this way.
> >>
> >> While in MT mode and two or three fingers are touching, two sets o=
f
> >> data are sent. =A0The first is a new format buffer with lower reso=
lution
> >> reporting of stationary finger and the second is standard data for=
mat
> >> reporting movement.
> >
> > We should probably update this comment and remove parts that mentio=
n
> > stationary and movement. =A0It appears to be doing finger tracking =
and
> > first packet is always first touch... except we are getting reports
> > that clickpads/integrated button pads may not be consistently like
> > this.
> >
>=20
> Sorry.  Not first packet but higher resolution/second packet.

Not for all devices, it seems - at least not mine, which is not a click=
pad.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
