From: <Mario.Limonciello@dell.com>
Subject: RE: Dell XPS 13 Fn key bug?
Date: Thu, 2 Feb 2017 19:53:06 +0000
Message-ID: <3fda787427134b31b308fcca33b8758b@ausx13mpc124.AMER.DELL.COM>
References: <20170125084732.5hawvooeegtw4wwc@zenon.in.qult.net>
 <CAKdAkRQ=jCsQvPb8vK1byYYAbLSEeBHpMMDuMGhgwdqVKvQ_yg@mail.gmail.com>
 <20170202084033.76d6youemdr2pc5f@zenon.in.qult.net>
 <20170202164748.GB21924@dtor-ws>
 <20170202170825.r3ellulrx47kku35@zenon.in.qult.net>
 <156e931c68344eccb7360df7c15f6577@ausx13mpc124.AMER.DELL.COM>
 <20170202175023.2fjjoij7p5r3xrsl@zenon.in.qult.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:63871 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751201AbdBBTyI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 14:54:08 -0500
In-Reply-To: <20170202175023.2fjjoij7p5r3xrsl@zenon.in.qult.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: bugs@qult.net
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

> -----Original Message-----
> From: Ignacy Gaw=EAdzki [mailto:bugs@qult.net]
> Sent: Thursday, February 2, 2017 11:50 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: dmitry.torokhov@gmail.com; linux-input@vger.kernel.org
> Subject: Re: Dell XPS 13 Fn key bug?
>=20
> On Thu, Feb 02, 2017 at 05:15:02PM +0000, thus spake
> Mario.Limonciello@dell.com:
> > > -----Original Message-----
> > > From: Ignacy Gaw=EAdzki [mailto:bugs@qult.net]
> > > Sent: Thursday, February 2, 2017 11:08 AM
> > > To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; linux-
> > > input@vger.kernel.org
> > > Subject: Re: Dell XPS 13 Fn key bug?
> > >
> > > On Thu, Feb 02, 2017 at 08:47:48AM -0800, thus spake Dmitry Torokhov:
> > > > On Thu, Feb 02, 2017 at 09:40:33AM +0100, Ignacy Gaw=EAdzki wrote:
> > > > > On Wed, Feb 01, 2017 at 04:16:13PM -0800, thus spake Dmitry
> Torokhov:
> > > > > > OK, so 'cd' is scancode for KEY_RIGHT and 'cf' is scancode for
> > > > > > KEY_END, and it seems that implementation of FN handling is
> > > > > > very naive as it emits "release" keycodes for the state FN is
> > > > > > currently in, not the state it was when key was pressed.
> > > > > >
> > > > > > Ideally Dell would fix that. Mario, any chance of that?
> > > > >
> > > > > I'm just wondering whether this is still something that could be
> > > > > fixed or worked around in the input driver,
> > > >
> > > > Well, obviously I'd rather fix the bug at its root rather than
> > > > piling workarounds in the driver.
> > >
> > > Sure, but supposing that the BIOS has to be fixed, I don't expect
> > > Dell to release a fix for a model that's about five years old.
> > > Unless there's a good soul out there reading this and able to do anyt=
hing
> about it.
> > >
> >
> > There hasn't been any maintenance BIOS releases for the L322X since
> > around the end of 2013.
> > I won't be able to get anyone to spin up resources on this unless it
> > was a major security vulnerability or proverbial kitten killer type of
> > bug.
>=20
> Yeah well, obviously it's not the former.  As for the latter, the qualifi=
cation is
> very subjective.  It's very annoying when it happens, but I must admit I =
can sort
> of live with it (I already have for all these years).  It's just a pity s=
uch a lame
> thing hasn't shown up before production, supposing it is actually somethi=
ng
> that can be fixed with a BIOS patch (a question which hasn't been answere=
d
> yet).
> Anyway, God certainly kills a kitten every time my auto-repeat gets stuck=
. :/
>=20

As much as I hate to use the "you're using it wrong" card, these types of t=
hings
are usually linked to certain typing styles.  Without having dug into this =
code,=20
I would suspect that this is related to how the state machine in the EC wor=
ks. =20
I know from previous key stuck issue reports reworking it can be fragile an=
d
when one mob of people says it's fixed a different mob says it's broken.

At this point I'd recommend to continue to look for an OS solution.

Thanks,
