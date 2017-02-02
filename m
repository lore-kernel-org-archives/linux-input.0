From: <Mario.Limonciello@dell.com>
Subject: RE: Dell XPS 13 Fn key bug?
Date: Thu, 2 Feb 2017 17:15:02 +0000
Message-ID: <156e931c68344eccb7360df7c15f6577@ausx13mpc124.AMER.DELL.COM>
References: <20170125084732.5hawvooeegtw4wwc@zenon.in.qult.net>
 <CAKdAkRQ=jCsQvPb8vK1byYYAbLSEeBHpMMDuMGhgwdqVKvQ_yg@mail.gmail.com>
 <20170202084033.76d6youemdr2pc5f@zenon.in.qult.net>
 <20170202164748.GB21924@dtor-ws>
 <20170202170825.r3ellulrx47kku35@zenon.in.qult.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:36476 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751441AbdBBR1L (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 12:27:11 -0500
In-Reply-To: <20170202170825.r3ellulrx47kku35@zenon.in.qult.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: bugs@qult.net, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

> -----Original Message-----
> From: Ignacy Gaw=EAdzki [mailto:bugs@qult.net]
> Sent: Thursday, February 2, 2017 11:08 AM
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; linux-
> input@vger.kernel.org
> Subject: Re: Dell XPS 13 Fn key bug?
>=20
> On Thu, Feb 02, 2017 at 08:47:48AM -0800, thus spake Dmitry Torokhov:
> > On Thu, Feb 02, 2017 at 09:40:33AM +0100, Ignacy Gaw=EAdzki wrote:
> > > On Wed, Feb 01, 2017 at 04:16:13PM -0800, thus spake Dmitry Torokhov:
> > > > OK, so 'cd' is scancode for KEY_RIGHT and 'cf' is scancode for
> > > > KEY_END, and it seems that implementation of FN handling is very
> > > > naive as it emits "release" keycodes for the state FN is currently
> > > > in, not the state it was when key was pressed.
> > > >
> > > > Ideally Dell would fix that. Mario, any chance of that?
> > >
> > > I'm just wondering whether this is still something that could be
> > > fixed or worked around in the input driver,
> >
> > Well, obviously I'd rather fix the bug at its root rather than piling
> > workarounds in the driver.
>=20
> Sure, but supposing that the BIOS has to be fixed, I don't expect Dell to=
 release
> a fix for a model that's about five years old.  Unless there's a good sou=
l out
> there reading this and able to do anything about it.
>=20

There hasn't been any maintenance BIOS releases for the L322X since around =
the
end of 2013.
I won't be able to get anyone to spin up resources on this unless it was a =
major=20
security vulnerability or proverbial kitten killer type of bug.

> > > since the bug obviously doesn't
> > > show up in neither in the linux console nor in Windows.
> >
> > So where does it not work in Linux? Because keyboard driver in console
> > and elsewhere is the same. Maybe it is not noticeable when in text
> > console?
>=20
> The bug appears only in X11.  Not in the console, although autorepeat is =
active
> there too.
>=20
> > In Windows the bug might be masked if they use hardware autorepeat for
> > PS/2 keyboards. I don't know if they do or not.
>=20
> I have no idea either.
>=20
> --
> To err is human, to purr feline.
