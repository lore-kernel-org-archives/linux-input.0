From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Wed, 09 Dec 2009 09:31:00 +0200
Message-ID: <1260343860.19669.1189.camel@localhost>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org>
	 <87einfltp3.fsf@tac.ki.iif.hu> <20091206084704.GC2766@ucw.cz>
	 <20091208042251.GB11147@core.coreip.homeip.net>
	 <1260277410.19669.84.camel@localhost>
	 <20091208174218.GB14271@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20722 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199AbZLIHbj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 02:31:39 -0500
In-Reply-To: <20091208174218.GB14271@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Ferenc Wagner <wferi@niif.hu>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 2009-12-08 at 09:42 -0800, Dmitry Torokhov wrote:
> > > I also see that gpio-keys is quite different in the sence that it=
 can
> > > shut off buttons selectively. I fact, at the moment every button =
can be
> > > considered a separate device... But that would be too much overhe=
ad.
> > >=20
> > > They could probably split the keys into 2 groups (critical that s=
hould
> > > be always active) and not critical, that could be shut off, but I=
 think
> > > they want teh flexibility of controlling this at runtime instead =
of
> > > doing it in board data.
> >=20
> > I suggested including this into the "abstract input device" model, =
but
> > you refuse this. But I still think it is a good idea.
> >=20
> > Indeed, if we look at an input device as at something abstract whic=
h has
> > many keys, why we cannot assume that separate keys can be
> > enabled/disabled? Just imagine you have a very advanced keybord :-)=
 And
> > we simply implement an ioctl which enables/disables a specific key.=
 The
> > generic layers just pass this ioctl down to the lower lever drivers=
=2E If
> > the specific input device or driver support it - fine, if not - it
> > returns -EINVAL or something like that.
>=20
> I refuse it because it will be supported by exactly 1 driver in the
> kernel - gpio-keys. It is the only driver that allows shut half of th=
e
> "device" (because in reality it is a group of disjoint devices). It i=
s
> the only case when "muting" a button means that IRQ is shut off abnd
> thus CPU can continue to sleep if that button is pressed. For all oth=
er
> devices that have 1 inettrupt per device, you still have to wake up,
> because you don't know whether the button that generated event is
> "important" or not.

=46air enough.

> Now, there is a issue of waking up userspace task, additional schedul=
ing
> and keeping CPU running longer than necessary for "uninteresting" key=
s.
> This can be solved by implementing a subscription model which allows
> filtering uninteresing events on a per-client basis at evdev level.

Right. And for gpio_keys, this would be dine on the driver level.

> This, if implemented properly, would work for _all_ input devices out
> there. You were not interested into looking into it (because for your
> particular and only device the otehr approach promises bigger savings=
)
> but I think we'll get there eventually.

Well, we can (and have to, if this approach is taken) look into this in
a sense of implementing our particular task in a way that it could be
extended with this generic stuff. We might as well implement something
generic, but may be not too comprehensive, feature-full, and well-teste=
d
(simply because we do not need it, so cannot prove usefulness on real
applications).

> And the third topic - shutting (or putting into low power) entire dev=
ice
> upon request from userspace. This again has much wider auditory than
> gpio-keys, or input devices layer for that matter. We may want to do =
so
> for other types of devices as well. That is why the question when to
> general PM list.

Yeah.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
