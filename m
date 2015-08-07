From: Ari Entlich <atrigent@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Fri, 7 Aug 2015 12:35:33 -0400
Message-ID: <CANULwrTm0XEdKfC7Shx5VLpvHmkzRt5mOUjbFSm8ck86Ci=iKQ@mail.gmail.com>
References: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
	<20150807132639.GB21627@pali>
	<CANULwrSnV=JvbUzkq2PCnpyWw3H9gFE1Z+HB-ntBZteF=AUE9g@mail.gmail.com>
	<20150807141214.GD21627@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34079 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbbHGQff convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 12:35:35 -0400
Received: by wicne3 with SMTP id ne3so66573249wic.1
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2015 09:35:34 -0700 (PDT)
In-Reply-To: <20150807141214.GD21627@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Aug 7, 2015 at 10:12 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> For some old ALPS devices which use V1 and V2 protocols (with flag
> ALPS_PASS) there is something like that. On that devices touchpad is
> behind trackpoint HW. But you cannot wait for data or poll for both
> devices at same time -- you need to choose if tou want to talk direct=
ly
> to touchpad (via passthrough mode) or just to trackpoint. I think
> because of this limitation ALPS driver implement all logic in one
> driver...
>
> Above was for old ALPS devices. New ALPS devices with V3 or V5 protoc=
ols
> have trackpoint behind touchpad, so normally OS communicate with
> touchpad (and not with trackstick like before). But here touchpad sen=
ds
> data for both touchpad and trackstick events and so OS does not have
> normal access to "hidden" trackstick.
>
> There is a way "jump" into passthrough mode and talk directly to
> trackpoint. But it is used only for configuring trackstick and curren=
tly
> it is used to configure trackstick so it send data (via touchpad) in
> format which is supported by our ALPS driver.
>
> On the other hand, synaptics driver and devices support full
> "encapsulation" or how can I call it of serio PS/2 device and in this
> case you can use full set of PS/2 commands directly with trackstick
> (behind synaptics touchpad). ALPS devices do not support something li=
ke
> that.

It looks to me like the Synaptics passthrough is implemented primarily
via the ability to write directly to the trackpoint. Events coming
from the trackpoint are implemented similarly to the ALPS driver - by
redirecting trackpoint events to the second device which the driver
creates for the trackpoint.

> Note I just wrote information which I understand from driver source c=
ode
> and with "playing" with touchpads. There can be some mistakes (so
> somebody can correct me), but this is how I understand this situation=
=2E
>
> I do not have access and I have never seen any "official" documentati=
on.
> I can say, that current ALPS driver in kernel does not support it for
> 100% sure. But maybe we just missing some information which allows us=
 to
> do it.
>
> But in my opinion ALPS firmware which is running in ALPS touchpad doe=
s
> not support something like full passthrough to trackpoint device like
> synaptics. For me it does not make sense to add such function into
> firmware, because it already send all needed data for OS to allow
> processing both touchpad and trackpoint data.

The issue isn't so much getting information from the trackpoint but
sending information TO it. The trackpoint driver is able to send
special commands to the trackpoint to modify its behavior. As far as I
can tell, this is pretty much the only thing it does. See
drivers/input/mouse/trackpoint.c for details.

> Questions are: Do we need full access to trackpoint hardware? Do we k=
now
> if trackpoint (used by ALPS input solutions) supports configuring spe=
ed
> or acceleration in hardware? It is really not easier to do it in
> software?

As I mentioned in my first email, I'm aware that mouse behavior can be
modified in userspace. However, that's not what I'm asking about. I
want to have the same capabilities with this device as I had with the
old one, if at all possible. And anyways, there are some things that
the trackpoint driver can do that cannot be done in software.

Ari

> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
