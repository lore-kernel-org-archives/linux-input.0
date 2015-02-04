From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: evdev - add EVIOCREVOKE ioctl
Date: Wed, 4 Feb 2015 14:16:35 +0100
Message-ID: <CANq1E4SRSJmFG27PXLC2SL4cjFoP9H_cYzsr0A-SLoPTCQqitw@mail.gmail.com>
References: <1377602704-23301-1-git-send-email-dh.herrmann@gmail.com>
	<20150204141206.59b73fce@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:42023 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965521AbbBDNQg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 08:16:36 -0500
Received: by mail-ig0-f180.google.com with SMTP id b16so3798394igk.1
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 05:16:36 -0800 (PST)
In-Reply-To: <20150204141206.59b73fce@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <hoegsberg@gmail.com>, Hans de Goede <hdegoede@redhat.com>

Hi

On Wed, Feb 4, 2015 at 2:12 PM, Bruno Pr=C3=A9mont <bonbons@linux-vserv=
er.org> wrote:
> Hi David,
>
> Sorry for reviving this old thread (I didn't find more recent patch s=
eries
> at first glance or have not been using the proper keyword while searc=
hing).
>
> At FOSDEM 2015 last Sunday Hans presented libinput X input driver and=
 mentioned
> evdev FD revoking.
>
> A question I raise was how are input devices to be put in a reasonabl=
e
> state on FD revoking?
> The specific case of force-feedback game-pads/wheels and the like tha=
t libinput
> is expected to pass through to games was the main trigger.
>
> Assume:
> - Game triggers some force-feedback event like vibrating device
> - Game looses focus and gets its evdev FD revoked
> - Newly focused application does not care about the game-pad/wheel
>
> How should the force-feedback activity get stopped on that focus chan=
ge
> and thus FD revoking?
> Is the game expected to react before the FD being revoked (how long t=
o
> wait?) or should the kernel somehow reset the device to a sane state =
on
> revoke (and if so, under which conditions?).
>
> Should some other evdev devices also receive a special treatment to r=
eset
> them into a known/idle state (eventually LEDs on keyboards, beep, ...=
)?

We call input_device_flush() on EVIOCREVOKE, which stops any ongoing
=46F owned by this handle. Same should be done for any per-handle state=
=2E
However, LEDs are not associated with a handle, so it will stay the
same. Applications are expected to re-sync their LEDs after they
revoked a file-descriptor of someone else.

Thanks
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
