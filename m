From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Thu, 10 Dec 2009 11:19:19 +0200
Message-ID: <1260436759.12346.44.camel@localhost>
References: <Pine.LNX.4.44L0.0911300956400.4478-100000@iolanthe.rowland.org>
	 <87einfltp3.fsf@tac.ki.iif.hu> <20091206084704.GC2766@ucw.cz>
	 <20091208042251.GB11147@core.coreip.homeip.net>
	 <1260277410.19669.84.camel@localhost>
	 <20091208174218.GB14271@core.coreip.homeip.net>
	 <1260343860.19669.1189.camel@localhost>
	 <20091209180345.GE4456@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63773 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758055AbZLJJUZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 04:20:25 -0500
In-Reply-To: <20091209180345.GE4456@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Ferenc Wagner <wferi@niif.hu>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, 2009-12-09 at 10:03 -0800, Dmitry Torokhov wrote:
> On Wed, Dec 09, 2009 at 09:31:00AM +0200, Artem Bityutskiy wrote:
> > On Tue, 2009-12-08 at 09:42 -0800, Dmitry Torokhov wrote:
> > > > > I also see that gpio-keys is quite different in the sence tha=
t it can
> > > > > shut off buttons selectively. I fact, at the moment every but=
ton can be
> > > > > considered a separate device... But that would be too much ov=
erhead.
> > > > >=20
> > > > > They could probably split the keys into 2 groups (critical th=
at should
> > > > > be always active) and not critical, that could be shut off, b=
ut I think
> > > > > they want teh flexibility of controlling this at runtime inst=
ead of
> > > > > doing it in board data.
> > > >=20
> > > > I suggested including this into the "abstract input device" mod=
el, but
> > > > you refuse this. But I still think it is a good idea.
> > > >=20
> > > > Indeed, if we look at an input device as at something abstract =
which has
> > > > many keys, why we cannot assume that separate keys can be
> > > > enabled/disabled? Just imagine you have a very advanced keybord=
 :-) And
> > > > we simply implement an ioctl which enables/disables a specific =
key. The
> > > > generic layers just pass this ioctl down to the lower lever dri=
vers. If
> > > > the specific input device or driver support it - fine, if not -=
 it
> > > > returns -EINVAL or something like that.
> > >=20
> > > I refuse it because it will be supported by exactly 1 driver in t=
he
> > > kernel - gpio-keys. It is the only driver that allows shut half o=
f the
> > > "device" (because in reality it is a group of disjoint devices). =
It is
> > > the only case when "muting" a button means that IRQ is shut off a=
bnd
> > > thus CPU can continue to sleep if that button is pressed. For all=
 other
> > > devices that have 1 inettrupt per device, you still have to wake =
up,
> > > because you don't know whether the button that generated event is
> > > "important" or not.
> >=20
> > Fair enough.
> >=20
> > > Now, there is a issue of waking up userspace task, additional sch=
eduling
> > > and keeping CPU running longer than necessary for "uninteresting"=
 keys.
> > > This can be solved by implementing a subscription model which all=
ows
> > > filtering uninteresing events on a per-client basis at evdev leve=
l.
> >=20
> > Right. And for gpio_keys, this would be dine on the driver level.
>=20
> But the semantics are different - if done on driver level you'd be
> affecting _all_  consumers of the device; what I want to be done only
> affects owner of the file descriptor.

OK, makes sense. I'm convinced, thanks!

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
