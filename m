From: Jean Delvare <jdelvare@suse.de>
Subject: Re: Dependencies in the HID subsystem
Date: Thu, 13 Jun 2013 08:58:29 +0200
Message-ID: <1371106709.4289.7.camel@chaos.site>
References: <1369855174.4306.198.camel@chaos.site>
	 <alpine.LNX.2.00.1305292245090.30576@pobox.suse.cz>
	 <CANq1E4SPsF1SXC1Buh+VgK1MJ+LPKwQOqVk+xfA0oYqw7ptdqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41182 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550Ab3FMG6j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Jun 2013 02:58:39 -0400
In-Reply-To: <CANq1E4SPsF1SXC1Buh+VgK1MJ+LPKwQOqVk+xfA0oYqw7ptdqw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Michal Marek <mmarek@suse.cz>, linux-input@vger.kernel.org, linux-kbuild <linux-kbuild@vger.kernel.org>

Hi David,

Sorry for the late reply.

Le Thursday 30 May 2013 =C3=A0 00:23 +0200, David Herrmann a =C3=A9crit=
 :
> Hi
>=20
> On Wed, May 29, 2013 at 10:52 PM, Jiri Kosina <jkosina@suse.cz> wrote=
:
> > On Wed, 29 May 2013, Jean Delvare wrote:
> >
> >> I am worried and confused by some Kconfig dependencies in the HID
> >> subsystem.
> >>
> >> There are 11 HID device drivers which are defined in drivers/hid/K=
config
> >> with:
> >>
> >>       tristate "..." if EXPERT
> >>       default !EXPERT
> >>
> >> Unless EXPERT is enabled (and that's not the default), these drive=
r
> >> entries are hidden and automatically selected. If CONFIG_HID=3Dm, =
they are
> >> selected as modules. If CONFIG_HID=3Dy, they are built into the ke=
rnel. So
> >> it is impossible to have CONFIG_HID=3Dy and build these device dri=
vers as
> >> modules - as device drivers typically are.
> >>
> >> I would like to understand the reasoning behind this complexity. W=
hat is
> >> so special about these 11 drivers, that we can't just let the (ker=
nel
> >> configuring) user chose if he/she wants them and in what form?
>=20
> For several reason I recommend CONFIG_EXPERT for all users, anyway.
> But apart from that, what's wrong with "default y" and dropping any
> CONFIG_EXPERT dependency? We can still keep the "tristate '..' if
> EXPERT".

There is a contradiction in your proposal. The tristate "..." if EXPERT
_is_ a CONFIG_EXPERT dependency, and that's exactly what I would like t=
o
see go away. "default y" would be fine with me.

> The CONFIG_EXPERT descriptions says "this option allows certain base
> kernel options and settings to be disabled or tweaked". This really
> doesn't say anything about "disable any non-standard options if this
> is selected". So why do we default to "n" if CONFIG_EXPERT is
> selected? This always bothered me because I don't expect the config t=
o
> change if I select it.

I agree that this kind of option-dependent default value can easily be
confusing. I suppose it was done that way for historical reasons, to
minimize the effect of changes while the HID subsystem was being
reworked. But I would like to see it go away now.

--=20
Jean Delvare
Suse L3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
