From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Wed, 10 Nov 2010 14:46:08 +1000
Message-ID: <20101110044608.GA29110@barra.bne.redhat.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
 <20101108035121.GA4630@barra.bne.redhat.com>
 <4CD7B012.1030809@cena.fr>
 <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
 <20101109033149.GC19313@barra.redhat.com>
 <AANLkTikDk99ikTYYJDwVzNBSzwMA5sqjXa5v3iqbvfid@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:27317 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab0KJEqa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 23:46:30 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikDk99ikTYYJDwVzNBSzwMA5sqjXa5v3iqbvfid@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Benjamin Tissoires <tissoire@cena.fr>, Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Nov 08, 2010 at 10:14:56PM -0600, Chris Bagwell wrote:
> > I feel uncomfortable about splitting up a physical device into mult=
iple
> > devices, it takes information away that cannot easily be re-created=
 in the
> > userspace. Even with a method of associating multiple event devices=
 to the
> > same physical device, the parsing of simultaneous events is harder =
because
> > you're essentially deserialising event streams. In userspace, you h=
ave to
> > re-serialize based on parallel inputs.
> >
> > That said, it also goes counter the whole multi-touch approach - al=
lowing
> > more than one device on a single physical device.
>=20
> Hmm, does this sum up your opinion?  You are a strong proponent of
> having all related tools sent over a single input device so you get
> natural context of events.  When you do it this way, todays sample MT
> implementation for touchpad "just work" for pen+touch as well.  That
> behaviour can basically be summed up with "send MT events for all
> tools and let clients figure it out.  For older ST events do somethin=
g
> sane to help older apps."

yes, that sums it up nicely.

> So I get and do agree with that part but you've not clearly stated if
> your also saying something like refuse to support split input
> solutions and we should fix kernel instead of defining a behaviour fo=
r
> this case.  If we are forced to support split inputs, I suspect your
> basically OK with behaviour #2 because its effectively emulating
> single input behaviour as best it can and we are just picking what
> "sane" means in this case odd case.

If I read this correctly, then yes, I say don't try to find a split dev=
ice
solution but fix up the per-MT-tool axis range problem instead. Once th=
at's
done, we can do #4 as Ping suggested for ST.

Splitting gives us some benefits now, but long-term it'll be harder to
coordinate the different tools and devices. Unfortunately, my crystal b=
all
is cloudy, so I can't prove that case :)=20
Either way, I think even the current bamboo case should be merged back =
into
one single device.
=20
> I've copied #2 below and added my own text in "[]" to be sure and
> clarify text in context of case #2.
>=20
> 2.     Report first finger touch as ABS_X/Y events [on touch input
> device] when pen is not in
> prox.  Arbitrating single touch data [on touch input device] when pen
> is in prox. Pen data is
> reported as ABS_X/Y events [on pen input device]. Both ABS_X/Y for pe=
n
> or the first finger
> and ABS_MT_* for MT data are reported [each MT send].  [MT are even
> sent on touch device even though only 1 in proximity tool possible so
> that client can combine both inputs' events and see same behaviour as
> if it was a single input device.]

Assuming a split device - why do any filtering at all?
Report ABS_X/Y for pen on the pen device, touch as MT events on the tou=
ch
device _and_ first finger touch as ABS_X/Y on the touch device. If user=
space
can somehow couple the two devices then it's easy enough to filter touc=
h
events when necessary.

Don't report pen as the only MT set on the pen device, that's just
confusing.

Does this answer your question?

Cheers,
  Peter

> >> In this case, the RFC example becomes 2 touches on 1 input device =
and
> >> 1 pen on another input device.
> >>
> >> So using same MT guidelines, the touch input device would always s=
end
> >> MT events and always send ST events tracking the first touch.
> >>
> >> For pen input, ST-only events are OK because its not competing wit=
h
> >> anything being in proximity at same time. =A0But we may wish to al=
so
> >> send MT events for this 1 tool/slot as a hint to X drivers that
> >> somehow this input corresponds with another input device and so it
> >> needs to do filtering/arbitration. =A0We also need to somehow give=
 info
> >> to applications so they can bind these 2 inputs.
> >>
> >> Also, non-MT ware drivers are also same apps that will not know ho=
w to
> >> bind 2 input devices and so can't filter/arbitrate the unwanted
> >> touches. =A0So problem, we do want to filter ST events on touch in=
put
> >> when pen is in proximity.
> >>
> >> There are lots of things needing to be addressed for this 2nd case=
 so
> >> I'll not really give a personal opinion. =A0My opinion is likely t=
o
> >> change as we make individual decisions.
> >>
> >
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
