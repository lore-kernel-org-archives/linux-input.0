From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Mon, 8 Nov 2010 15:33:45 -0800
Message-ID: <AANLkTin+263LofAuUcELeZxnye4Xvoo_pt-gegojhstC@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<20101108035121.GA4630@barra.bne.redhat.com>
	<4CD7B012.1030809@cena.fr>
	<AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36123 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab0KHXdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 18:33:47 -0500
Received: by wyb36 with SMTP id 36so4114843wyb.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 15:33:45 -0800 (PST)
In-Reply-To: <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Benjamin Tissoires <tissoire@cena.fr>, Peter Hutterer <peter.hutterer@who-t.net>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Nov 8, 2010 at 1:54 PM, Chris Bagwell <chris@cnpbagwell.com> wr=
ote:
> I think we may be mixing some topics and so I'd like to try to
> re-frame the discussion.
>
> There are two different cases and they may have different answers
> because of it.

I'd like to cover both cases with an unified answer. There is only one
physical device no matter which case we are in, especially in the
kernel. The only difference is whether it is a serial or USB device.
So, my comments applies to both types of devices.

> Case 1) 1 input device can support multiple tools that are in
> proximity at same time.
>
> I believe this is currently a theoretical example (no driver exists l=
ike this).
>
> In RFC example, this input devices has a pen and 2 finger touches.
> They all share ABS_X/Y/PRESSURE values. =A0The single touch (ST) inpu=
t
> filtering breaks being able to support this case and what multitouch
> events (MT) were added for.
>
> To date, when converting drivers over to MT events the guideline is
> *always* send MT events (because what app wants to randomly switch
> between MT event processing and ST event processing for same
> X/Y/PRESSURE?) and send something sane for ST events to be backwards
> compatible with older apps.
>
> I think everyone is happy in this thread to always send pen+touch MT
> events and let X drivers or similar filter/arbitrate out unwanted
> touch events as needed.

Ok, the done deal so far is: we'll send MT events regardless of pen pos=
ition.

> The ideal "sane" behavior for touch ST events has been leaning toward=
s
> tracking 1st touch and continue sending 1st touch during multi-touch
> but there is some debate because tracking can be expensive in kernel.
> In case of pen+touch, the sane may change to prefer pen over touch an=
d
> prefer first touch when 2 touches exist.
>
> Or "sane" can mean let the ST values go crazy during multi-touch and
> hope user can use GUI enough after new kernel install to get a
> MT-aware X driver.
>
> Its easy to implement preferring pen then preferring 1st touch so I
> suggest doing that. =A0This is for backwards compatibility only
> (un-modified xf86-input-wacom/synaptics/evdev/etc). =A0The future is =
MT
> events, in which case the ST events are meaningless and we are hiding
> nothing to applications that look at MT events.
>
> Case 2) 2 input devices can support multiple tools in proximity at sa=
me time.
>
> I believe it was Rafi that brought up point that dual pen+touch
> interfaces will have different properties. =A0Touch will be lower
> resolution then Pen and maybe different fuzz factor. =A0Also, on tabl=
ets
> I would think pretty easy to have different dimensions (one tool work=
s
> over larger area of tablet). =A0This is easy to expose to user when 2
> input devices.

Kernel driver doesn't need to worry about this detail. X server driver
or clients should take care of them. Each tool has . Dual pen+touch
(ST) has been supported for a while....

> Combining into single input to user would be nice but at least when
> dimensions are different, we probably do not want to remove that
> visibility to user and so must keep 2 input devices.
>
> In this case, the RFC example becomes 2 touches on 1 input device and
> 1 pen on another input device.
>
> So using same MT guidelines, the touch input device would always send
> MT events and always send ST events tracking the first touch.
>
> For pen input, ST-only events are OK because its not competing with
> anything being in proximity at same time. =A0But we may wish to also
> send MT events for this 1 tool/slot as a hint to X drivers that
> somehow this input corresponds with another input device and so it
> needs to do filtering/arbitration. =A0We also need to somehow give in=
fo
> to applications so they can bind these 2 inputs.
>
> Also, non-MT ware drivers are also same apps that will not know how t=
o
> bind 2 input devices and so can't filter/arbitrate the unwanted
> touches. =A0So problem, we do want to filter ST events on touch input
> when pen is in proximity.

=46iltering touch events when pen is in prox is reasonable for existing
apps. We will add a new property in the X driver so future MT-aware
apps can turn ST/cursor events on/off when necessary. By default, the
ST/cursor will be on to support backward compatibility.

> There are lots of things needing to be addressed for this 2nd case so
> I'll not really give a personal opinion. =A0My opinion is likely to
> change as we make individual decisions.

You'll see that my opinion changes too. That's why we need this [RFC] ;=
).

I still have one decision to make though:

Do we really want to repeat the pen data with MT_TOOL_PEN? It is
already reported by ST events.

=46rom my comments for proposal #4, you can tell that I was in favor of
repeating them. After comparing #2 with #4 a bit further, I see both
options have its pros and cons.

Which way should we go? #2 or #4?

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
