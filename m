From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: INFO: possible recursive locking detected ps2_command
Date: Thu, 3 Sep 2009 20:23:43 -0700
Message-ID: <20090904035641.2B5B6526EA5@mailhub.coreip.homeip.net>
References: <c4e36d110807310241n512b01e4v898e883d740de879@mail.gmail.com> <20080731145739.fe8923be.akpm@linux-foundation.org> <20080801030444.GB18953@anvil.corenet.prv> <1218192589.8625.88.camel@twins> <20080808082930.ZZRA012@mailhub.coreip.homeip.net> <c4e36d110909031548y38276e0cjfc5eee7bfdba8e50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:48701 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638AbZIDDXu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2009 23:23:50 -0400
Content-Disposition: inline
In-Reply-To: <c4e36d110909031548y38276e0cjfc5eee7bfdba8e50@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Rabin Vincent <rabin@rab.in>

On Fri, Sep 04, 2009 at 12:48:45AM +0200, Zdenek Kabelac wrote:
> 2008/8/8 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > On Fri, Aug 08, 2008 at 12:49:49PM +0200, Peter Zijlstra wrote:
> >> On Thu, 2008-07-31 at 23:04 -0400, Dmitry Torokhov wrote:
> >> > On Thu, Jul 31, 2008 at 02:57:39PM -0700, Andrew Morton wrote:
> >> > >
> >> > > (cc linux-input)
> >> > >
> >> > > On Thu, 31 Jul 2008 11:41:25 +0200
> >> > > "Zdenek Kabelac" <zdenek.kabelac@gmail.com> wrote:
> >> > >
> >> > > > Hi
> >> > > >
> >> > > > During mouse unplugging from psaux connector from the laptop=
s' docking
> >> > > > station I've got attached INFO trace.
> >> > > > (laptops still has synaptics device)
> >> > > >
> >> >
> >> > Dell?
> >> >
> >> > > > Also for unknown reason to me =A0psaux mouse & synaptic devi=
ce do not
> >> > > > work somehow together - is it hw limitation
> >> > > > of /dev/input/mice =A0interface?
> >> > > > (USB mouse and synaptics do work quite well together)
> >> > > >
> >> > > > [ INFO: possible recursive locking detected ]
> >> > > > 2.6.27-rc1 #48
> >> > >
> >> > > (it's 2.6.27-rc1)
> >> > >
> >> >
> >> > Peter, here is the trace we talked about long time ago. For some=
 reason
> >> > lockdep annotation only works once. If reconnect is forced or ps=
mouse
> >> > module is reloaded lockdep starts complaining about passthrough =
port.
> >>
> >> Bit puzzling - and I don't have any ps2 hardware around to test wi=
th
> >> (nor do I normally use modules - but that is fixable of course).
> >>
> >> Does Rabin's patch help?
> >>
> >> =A0 http://lkml.org/lkml/2008/8/7/329
> >>
> >
> > I doubt it resolves problem fully because it only takes care of mod=
ule
> > unload. I can easily trip lockdep by reconnecting the device. Just =
to
> > give some more details about the problem:
> >
> > =A0- synaptics touchpads have a pass-through port that allows to co=
nnect
> > =A0 either external mouse or maybe a trackpoint device. Both device=
s
> > =A0 are represented by 'serio' structures and are handled by the sa=
me
> > =A0 driver (psmouse).
> >
> > =A0- as far as I know we have proper locking there and lockdep
> > =A0 annotatinos were added to lockdep to reflect the nesting of the
> > =A0 serio ports.
> >
> > =A0- if child port (pass-through port) is destroyed and recreated (=
due
> > =A0 to module unload, or because user requested reconnect through s=
ysfs
> > =A0 or system-initiated reconnect) lockdep starts complaining altho=
ugh
> > =A0 the new child port should still have the same "depth" as the ol=
d
> > =A0 one.
> >
>=20
> Well just noticed this issue again in my log - during resume operatio=
n
> - thus no external mouse connection in the game this time:
>=20

External mouse does not have to be connected, the fact that you have
a pass-through serio port is enough to trigger this warning.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
