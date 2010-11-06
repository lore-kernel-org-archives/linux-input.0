From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Evdev uniq id
Date: Sat, 6 Nov 2010 08:39:24 -0700
Message-ID: <20101106153924.GA17780@core.coreip.homeip.net>
References: <4CD38B2B.3080200@netspace.net.au>
 <20101106094541.GA16663@core.coreip.homeip.net>
 <4CD524C3.10300@netspace.net.au>
 <AANLkTi=HUAPfy=OChB+TqYmF8k_YkbzNionAzWK7NSYH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42565 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab0KFPjd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 11:39:33 -0400
Received: by iwn41 with SMTP id 41so2096359iwn.19
        for <linux-input@vger.kernel.org>; Sat, 06 Nov 2010 08:39:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=HUAPfy=OChB+TqYmF8k_YkbzNionAzWK7NSYH@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Russell Shaw <rjshaw@netspace.net.au>, linux-input <linux-input@vger.kernel.org>

On Sat, Nov 06, 2010 at 09:47:30AM -0500, Chris Bagwell wrote:
> On Sat, Nov 6, 2010 at 4:49 AM, Russell Shaw <rjshaw@netspace.net.au>=
 wrote:
> > On 06/11/10 20:45, Dmitry Torokhov wrote:
> >>
> >> Hi Russell,
> >>
> >> On Fri, Nov 05, 2010 at 03:42:19PM +1100, Russell Shaw wrote:
> >>>
> >>> Hi,
> >>> In X, i want an application program to apply settings to a specif=
ic
> >>> mouse/puck device, regardless of how many other devices have been
> >>> plugged in since the last session.
> >>>
> >>> Prefereably, a manufacturer-model-serial_number call would be ava=
ilable
> >>> from evdev.
> >>>
> >>> Minimally, a uniq non-changing ID could be useful. I found this i=
n
> >>> linux-2.6.31.1/drivers/input/evdev.c:
> >>>
> >>> =A0 if (_IOC_NR(cmd) =3D=3D _IOC_NR(EVIOCGUNIQ(0)))
> >>> =A0 =A0 return str_to_user(dev->uniq, _IOC_SIZE(cmd), p);
> >>>
> >>> How is "dev->uniq" constructed?
> >>
> >> USB HID devices populate this field with data from
> >> descriptor.iSerialNumber.
> >> I suppose we should do that in other USB drivers as well, patches =
are
> >> welcome.
> >
> > Hi Dmitry.T,
> > I was just getting around to seeing if i could add manufacturer-mod=
el-
> > serial_number ioctl functionality.
>=20
> I'm looking for similar feature so that X app and X driver can tell
> that inputs from two USB end points are from same device.  For config
> GUI case, unique value lets it show it as a whole device.  It would b=
e
> best for GUI if the value lasted across reboots as well.
>=20
> In my case of Wacom, the hardware does not report a serial # and it
> sounds like thats pretty common.  So I do not have a good way to
> generate this uniq string.

Yep, I think most of them do not have serial number filled in.

>=20
> I guess as a fall back when uniq is empty string then the response
> from EVIOCGPHYS could be used for both our cases?  At least as long a=
s
> users are not moving cables around.  For my case, take off the last
> ".x" value if it exists and if strings are same then its same device.

You could add heuristics to your algorithm, yes. In case where there is
only one device VID/PID is enough and you can even handle moving to
different port. Otherwise you'd have to add phys into the mix and try
matching again, hoping that the device is still plugged into the same
port.

All such schemes will fail in general case...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
