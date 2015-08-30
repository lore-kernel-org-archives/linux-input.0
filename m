From: =?UTF-8?Q?Cl=c3=a9ment_Vuchener?= <clement.vuchener@gmail.com>
Subject: Re: "Super Joy Box 7" gameport adapter
Date: Sun, 30 Aug 2015 15:28:20 +0200
Message-ID: <55E304F4.10402@gmail.com>
References: <1440932312.6135.16.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34793 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbbH3N2X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Aug 2015 09:28:23 -0400
Received: by wizs10 with SMTP id s10so7353062wiz.1
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2015 06:28:22 -0700 (PDT)
In-Reply-To: <1440932312.6135.16.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org

It looks like the kind of thing that would happen if the throttle was reported as a hat switch in the HID descriptor. But I think there should be more than 4 directions. Anyway, you should look what happens at the HID level to know how much the hardware is wrong and if this can be fixed by the kernel.

On 08/30/2015 12:58 PM, Bastien Nocera wrote:
> Hey,
>
> I've recently found my old Gravis Blackhawk again, and bought a "Super
> Joy Box 7" gameport adapter[2] to try and play some Descent or X-Wing
> vs. Tie Fighter.
>
> Problem is that the throttle (just about the tip of "l" in the box
> photo) throws ABS_HAT0X/ABS_HAT0Y values instead of ABS_THROTTLE.
>
> This is me trying to throttle it to the maximum:
> Input driver version is 1.0.1
> Input device ID: bus 0x3 vendor 0x925 product 0x1032 version 0x100
> Input device name: "WiseGroup.,Ltd Gameport to USB Controller"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 288 (BTN_TRIGGER)
>     Event code 289 (BTN_THUMB)
>     Event code 290 (BTN_THUMB2)
>     Event code 291 (BTN_TOP)
>     Event code 292 (BTN_TOP2)
>     Event code 293 (BTN_PINKIE)
>     Event code 294 (BTN_BASE)
>     Event code 295 (BTN_BASE2)
>   Event type 3 (EV_ABS)
>     Event code 0 (ABS_X)
>       Value     81
>       Min        0
>       Max      255
>       Flat      15
>     Event code 1 (ABS_Y)
>       Value     95
>       Min        0
>       Max      255
>       Flat      15
>     Event code 6 (ABS_THROTTLE)
>       Value    128
>       Min        0
>       Max      255
>       Flat      15
>     Event code 7 (ABS_RUDDER)
>       Value    128
>       Min        0
>       Max      255
>       Flat      15
>     Event code 16 (ABS_HAT0X)
>       Value      0
>       Min       -1
>       Max        1
>     Event code 17 (ABS_HAT0Y)
>       Value      0
>       Min       -1
>       Max        1
>   Event type 4 (EV_MSC)
>     Event code 4 (MSC_SCAN)
> Properties:
> Testing ... (interrupt to exit)
> Event: time 1440932110.190636, type 3 (EV_ABS), code 16 (ABS_HAT0X), value -1
> Event: time 1440932110.190636, -------------- SYN_REPORT ------------
> Event: time 1440932110.806587, type 3 (EV_ABS), code 16 (ABS_HAT0X), value 0
> Event: time 1440932110.806587, type 3 (EV_ABS), code 17 (ABS_HAT0Y), value 1
> Event: time 1440932110.806587, -------------- SYN_REPORT ------------
> Event: time 1440932111.174582, type 3 (EV_ABS), code 16 (ABS_HAT0X), value 1
> Event: time 1440932111.174582, type 3 (EV_ABS), code 17 (ABS_HAT0Y), value 0
> Event: time 1440932111.174582, -------------- SYN_REPORT ------------
> Event: time 1440932111.590668, type 3 (EV_ABS), code 16 (ABS_HAT0X), value 0
> Event: time 1440932111.590668, type 3 (EV_ABS), code 17 (ABS_HAT0Y), value -1
> Event: time 1440932111.590668, -------------- SYN_REPORT ------------
>
> Is this something that could be fixed in software, or is the hardware a
> bust? I've attached the same thing captured by evemu-record.
>
> Cheers
>
> [1]: http://www.dpluss.nl/gravis-blackhawk.jpg
> [2]: http://www.amazon.com/Ckeyin-Gameport-Converter-Joystick-Gamepad/dp/B00JGGTM2Q

