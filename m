From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] Input: evdev - add EVIOCREVOKE ioctl
Date: Wed, 4 Feb 2015 15:55:22 +0100
Message-ID: <20150204155522.2997477e@neptune.home>
References: <1377602704-23301-1-git-send-email-dh.herrmann@gmail.com>
	<20150204141206.59b73fce@neptune.home>
	<CANq1E4SRSJmFG27PXLC2SL4cjFoP9H_cYzsr0A-SLoPTCQqitw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:43650 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965083AbbBDOz3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 09:55:29 -0500
In-Reply-To: <CANq1E4SRSJmFG27PXLC2SL4cjFoP9H_cYzsr0A-SLoPTCQqitw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kristian =?UTF-8?B?SMO4Z3NiZXJn?= <hoegsberg@gmail.com>, Hans de Goede <hdegoede@redhat.com>

Hi David,

On Wed, 04 February 2015 David Herrmann wrote:
> On Wed, Feb 4, 2015 at 2:12 PM, Bruno Pr=C3=A9mont wrote:
> > Hi David,
> >
> > Sorry for reviving this old thread (I didn't find more recent patch=
 series
> > at first glance or have not been using the proper keyword while sea=
rching).
> >
> > At FOSDEM 2015 last Sunday Hans presented libinput X input driver a=
nd mentioned
> > evdev FD revoking.
> >
> > A question I raise was how are input devices to be put in a reasona=
ble
> > state on FD revoking?
> > The specific case of force-feedback game-pads/wheels and the like t=
hat libinput
> > is expected to pass through to games was the main trigger.
> >
> > Assume:
> > - Game triggers some force-feedback event like vibrating device
> > - Game looses focus and gets its evdev FD revoked
> > - Newly focused application does not care about the game-pad/wheel
> >
> > How should the force-feedback activity get stopped on that focus ch=
ange
> > and thus FD revoking?
> > Is the game expected to react before the FD being revoked (how long=
 to
> > wait?) or should the kernel somehow reset the device to a sane stat=
e on
> > revoke (and if so, under which conditions?).
> >
> > Should some other evdev devices also receive a special treatment to=
 reset
> > them into a known/idle state (eventually LEDs on keyboards, beep, .=
=2E.)?
>=20
> We call input_device_flush() on EVIOCREVOKE, which stops any ongoing
> FF owned by this handle. Same should be done for any per-handle state=
=2E
> However, LEDs are not associated with a handle, so it will stay the
> same. Applications are expected to re-sync their LEDs after they
> revoked a file-descriptor of someone else.

Thanks for the explanation!
It answers my question.

So all that's needed should be there unless a specific kernel-side driv=
er
does not properly have state associated to handles.

> Thanks
> David

Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
