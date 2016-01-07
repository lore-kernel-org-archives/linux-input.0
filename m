From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@devoid-pointer.net>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech
 G920 Wheel
Date: Fri, 08 Jan 2016 00:05:11 +0100
Message-ID: <1452207911.7572.9.camel@devoid-pointer.net>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
	 <1447345535-2912-2-git-send-email-simon@mungewell.org>
	 <alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
	 <20151119183106.GC24773@dtor-ws>
	 <CAKdAkRTaTA8KFQripYP0ZcFb+5G7OC_Ecnhrwum4L9hsQ-PVxg@mail.gmail.com>
	 <CAKdAkRRBtVfTss9AV+DgTtCXf8PVks5pCB4VnR5sQvgW=S3HyA@mail.gmail.com>
	 <20151210170853.GC16026@mail.corp.redhat.com>
	 <CAKdAkRSBTBTW8ma79hh+0sr4izJ70SnvUb1gmPFy3MoVWYaUbA@mail.gmail.com>
	 <20160104095524.GB20222@mail.corp.redhat.com>
	 <alpine.LNX.2.00.1601061535440.3402@cbobk.fhfr.pm>
	 <20160107014721.GA35823@dtor-ws>
	 <1452207016.7572.7.camel@devoid-pointer.net>
	 <CAKdAkRSyPed3_K6jhqODvi5o61X-WTgSE6OTia-RXBXb+iZn4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gitweb.devoid-pointer.net ([31.31.77.140]:34330 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbcAGXFO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2016 18:05:14 -0500
In-Reply-To: <CAKdAkRSyPed3_K6jhqODvi5o61X-WTgSE6OTia-RXBXb+iZn4w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <Edwin@velds.nl>, elias vanderstuyft <elias.vds@gmail.com>

On Thu, 2016-01-07 at 14:53 -0800, Dmitry Torokhov wrote:
> On Thu, Jan 7, 2016 at 2:50 PM, Michal Mal=C3=BD
> <madcatxster@devoid-pointer.net> wrote:
> > On Wed, 2016-01-06 at 17:47 -0800, Dmitry Torokhov wrote:
> > > On Wed, Jan 06, 2016 at 03:36:57PM +0100, Jiri Kosina wrote:
> > > > On Mon, 4 Jan 2016, Benjamin Tissoires wrote:
> > > >=20
> > > > > Jiri, I *think* this commit still is in your next pull
> > > > > request
> > > > > for
> > > > > Linus. We might want to drop it before it hits Linus' tree.
> > > >=20
> > > > What exactly would be the reasoning for dropping it?
> > >=20
> > > It is wrong. Aside form the fact that IMO xpad.c is the wrong
> > > place
> > > for
> > > this code to be in, why are we waiting for the input device to be
> > > opened by userspace before we do the switch instead of doing it
> > > immediately?
> > >=20
> >=20
> > Hi all,
> >=20
> > I have to disagree with the xpad driver being the wrong place to
> > handle
> > this. The xpad driver matches devices it should handle by interface
> > class, subclass and protocol. When G920 first appears on the USB
> > bus,
> > it for all intents and purposes looks like a Xbox One controller so
> > the
> > xpad driver picks it up even if there is no G920-specific code in
> > the
> > driver. Unless there is a way how to blacklist certain idProduct
> > values, the switch from XBone mode to HID mode will have to be done
> > in
> > the xpad driver.
> >=20
> > I'm pretty much done with the simple switching module but it will
> > be of
> > no use if we cannot make the xpad module ignore G920 first.
>=20
> I see that Simon's patch added:
>=20
> XPAD_XBOXONE_VENDOR(0x046d),
>=20
> to the xpad driver. Are you saying that we latch onto the controller
> even without this addition?
>=20
> Thanks.

Sorry, my bad, I missed that change in the patch. Handling the switch
elsewhere should be no problem then.

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
