From: Chris Moeller <kode54@gmail.com>
Subject: Re: [PATCH 2.6.38] xpad: fix for player indicator and rumble support
Date: Wed, 18 May 2011 13:36:33 -0700
Message-ID: <BANLkTin2T3x_asLt6oVzFMkBEfndFM-t9g@mail.gmail.com>
References: <201105141929.00404.kode54@morbo.org>
	<20110516193757.GA18110@core.coreip.homeip.net>
	<BANLkTinNQ+gHyR==QvYdxLuFL554VX7ORw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49838 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab1ERUge convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2011 16:36:34 -0400
Received: by pzk9 with SMTP id 9so873106pzk.19
        for <linux-input@vger.kernel.org>; Wed, 18 May 2011 13:36:34 -0700 (PDT)
In-Reply-To: <BANLkTinNQ+gHyR==QvYdxLuFL554VX7ORw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Mon, May 16, 2011 at 12:37 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> It is OK if patches are dependent upon each other. In this case I'd
> recommend adding XBox360 Wireless rumble first, keeping the rest of t=
he
> driver structure, and then reworking LED support, which requires more
> changes.

Implementing rumble alone for the 360 Wireless pad will probably be a
lot easier, and may even make it in. I'll step up to do that, assuming
you don't plan to just take the command structure I posted and post a
patch yourself. Maybe a lack of hardware prevents this, or maybe this
should be a collaborative effort and I can do it? Hmm...


> As long as the code was not used I think this should be OK.

Yeah, I only used the command structure, which I presume belongs to
Microsoft anyway, since it's their hardware.


> I'd prefer the "command" calculation be hidden in
> xpad_send_led_command(), i.e. it should accept led number and figure =
out
> the proper command byte based on device type.

Yeah, I can do that too.


> This should probably be:
>
> =A0 =A0 =A0 =A0if (xpad->xtype =3D=3D XTYPE_UNKNOWN)

Makes sense. I was only accounting for the possibility of other device
types making it into the known devices set and making it through that
condition check. Of course, that's not a problem at this point.


> No, this conditional locking will not do. What happens if
> xpad_send_led_command() gets called from both xpad360w_process_packet=
()
> and xpad_led_set()? There is also bigger problem - we are using the s=
ame
> URB/buffers as FF playback so we need to make sure we do not stomp on
> each other toes.

Yeah, maybe I should have made another IRQ output buffer for the LED
commands. I just could not make the bulk output work at all. Although
I'm not sure if that matters, if both the external LED interface and
the FF playback lock the output buffer before using it.

Also, the reason for the conditional locking is because the LED
setting function needs to be called from within the driver itself for
the player assignment that occurs when a wireless pad is added.
Locking in that case causes the driver to hang when a wireless pad is
connected. If you'll check, the condition to lock is cleared when
called from within the driver lock in that case, but set so it always
attempts to lock when it's called from the external interface
functions.

There's probably a better way of doing that, though.

-Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
