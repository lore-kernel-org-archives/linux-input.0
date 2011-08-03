From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC] Wiimote userspace interface
Date: Wed, 3 Aug 2011 16:49:50 +0200
Message-ID: <CANq1E4QgF6i2UJQpaRDkOf-vwGH9vMfU9HfL8O8Rt38uup3qew@mail.gmail.com>
References: <CANq1E4S3VY_xxzcjuJDHJc57VPb_uiFrx1B3wR9Xnw5ddx6HJg@mail.gmail.com>
	<20110803061744.GB23399@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55644 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab1HCOtv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 10:49:51 -0400
Received: by vxh35 with SMTP id 35so671022vxh.19
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 07:49:50 -0700 (PDT)
In-Reply-To: <20110803061744.GB23399@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "Gustavo F. Padovan" <padovan@profusion.mobi>, Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oneukum@suse.de>

Hi Dmitry

On Wed, Aug 3, 2011 at 8:17 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi David,
>
> On Sat, Jul 30, 2011 at 06:34:37PM +0200, David Herrmann wrote:
>> There is also the other side. Sending data to the wiimote. 4 LEDs can
>> be set, the rumble motor can be enabled/disabled and audio data can be
>> streamed. I think my current approach to use sysfs attributes for the
>> LEDs
>
> Depending on what exactly it is you may try registering LEDs as LED
> class devices. Having a sysfs attribute to light one of 4 leds is an
> option too.

I already looked at the API. Although the 4 LEDs of the wiimote can
only be switched on/off (no brightness modulation) I think I could
register 4 led_classdev structures. This would also allow software
blinking.

>> and RUMBLE motor is ok? I can't figure out any better way here.
>
> One of the input devices should be registered as ForceFeedback device
> (or you create a separate FF input device).

Ok, I will add that.

>> Reference-counting doesn't make sense. If multiple devices use them,
>> then they will always have conflicts, however, it still works.
>> Audio streaming is not yet implemented, but I think I could register
>> an alsa device so this needs not to be discussed here.
>>
>>
>> Currently I think Interface #2 would be the best way but I don't want
>> to spend time implementing that if you tell me it isn't acceptable.
>> Any comments on this are appreciated.
>
> I believe you should try presenting physical objects as input devices so
> I'd try presenting wiimote (with optional motion+ events) as one device
> and accessory (nunchuck, classic extension) as another device.

Yes, but the problem is, that this would enable all peripherals of the
wiimote, even though userspace may not need them. But if that is the
recommended way, I will implement it.

> The IR Cam data is a concern. Could you please describe a bit more what
> is being reported by the cam?

The IR cam tracks IR-LEDs. Up to 4 leds. It reports them as 2D
coordinates. The values can be used to use the wiimote with the
integrated cam as pointing device, but may also be used for other
purposes so I don't want to handle the IR values in the driver but
rather provide them to userspace.

> Thanks.
>
> --
> Dmitry

Regards
David
