From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Posiflex 0d3a:a000 touchscreen press not recognized in kernel 3.9.4
Date: Wed, 19 Jun 2013 09:50:19 +0200
Message-ID: <CAN+gG=HCREVXCsQjGjyJApR=U=TO4Kvaa1s+X-UEVe6akyj-7Q@mail.gmail.com>
References: <51C159C5.7070702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:37596 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab3FSHuV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jun 2013 03:50:21 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so4462912lbd.32
        for <linux-input@vger.kernel.org>; Wed, 19 Jun 2013 00:50:19 -0700 (PDT)
In-Reply-To: <51C159C5.7070702@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Jan,

On Wed, Jun 19, 2013 at 9:12 AM, Jan Kandziora <jjj@gmx.de> wrote:
> Hello,
>
> I have a Posiflex 7215 POS system which has a USB touchscreen controller
> onboard. I've done a kernel update from 2.6.35.4 to 3.9.4 and the touch
> stopped working correctly. I tried with the generic usb hid driver, the
> usbtouchscreen driver doesn't support this usb id. Evtest says:
>

If your device is handled through hid-generic, it should be easy to
debug it remotely.

>
> # evtest /dev/input/event4
> Input driver version is 1.0.1
> Input device ID: bus 0x3 vendor 0xd3a product 0xa000 version 0x110
> Input device name: "Posiflex Inc. USB TOUCH V390"
> Supported events:
>   Event type 0 (Sync)
>   Event type 1 (Key)
>     Event code 272 (LeftBtn)
>     Event code 273 (RightBtn)
>     Event code 274 (MiddleBtn)
>   Event type 3 (Absolute)
>     Event code 0 (X)
>       Value   2184
>       Min        0
>       Max     4095
>     Event code 1 (Y)
>       Value   3801
>       Min        0
>       Max     4095
>   Event type 4 (Misc)
>     Event code 4 (ScanCode)
> Testing ... (interrupt to exit)
>
> Event: time 1371798299.337455, type 3 (Absolute), code 0 (X), value 1596
> Event: time 1371798299.337455, type 3 (Absolute), code 1 (Y), value 1969
> Event: time 1371798299.337455, -------------- Report Sync ------------
>
>
> There is no indication of pressure, so X is moving the cursor, but not
> reporting anything pressed. With 2.6.35.4, there was a LeftBtn event
> sent with each report block. Now it's gone.
>

Ok, I will need at least the dmesg log and the output of hid-recorder
[1] if your device is handled through hid-generic.
Hid-replay will then allow me to virtually plug your device on my
laptop so that I can replay and find out why the btn_left events are
not emitted anymore.

Cheers,
Benjamin

[1] http://bentiss.github.io/hid-replay-docs/

> What to do to make it work again?
>
>
> Kind regards
>
>         Jan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
