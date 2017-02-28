From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: input_set_abs max
Date: Tue, 28 Feb 2017 08:17:45 -0800
Message-ID: <CAEc3jaB5SSE-0Ti99kKFH560Zw+5vzBvHgpmPqNXWa34cwucuw@mail.gmail.com>
References: <CAH9_wROD04FGhDjg471t4oYLtJkWeW2atrAvMSznokftkFMNpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33470 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdB1QRr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 11:17:47 -0500
Received: by mail-yw0-f177.google.com with SMTP id l138so11959340ywc.0
        for <linux-input@vger.kernel.org>; Tue, 28 Feb 2017 08:17:46 -0800 (PST)
In-Reply-To: <CAH9_wROD04FGhDjg471t4oYLtJkWeW2atrAvMSznokftkFMNpw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sriram V <vshrirama@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi,

The Android input layer is responsible for touch to screen resolution
transformations. It is guided by settings reported through evdev (e.g.
INPUT_PROP_DIRECT) to tell the touch device is attached to the
display. Android also has some override layer through config files.
The whole system is quite involved, but is well documented all the way
from evdev up to the higher Android layers, so I would recommend to
read:
https://source.android.com/devices/input/touch-devices.html

The first thing I would verify based on that document is whether your
evdev driver is setting the correct properties, so Android is able to
detect your device type properly.

Thanks,
Roderick

On Tue, Feb 28, 2017 at 5:02 AM, Sriram V <vshrirama@gmail.com> wrote:
> Hi,
>
> I have a 480x800 LCD and the touchscreen driver gives 0 to 4095 and
> max value is X=4095, Y = 4095
> I am using android. Currently, with this setup. I am not able to see
> the effects on my touchscreen on the
> LCD.
>
> I use the call input_set_abs_params with ABS_X and ABS_Y to tell the
> upper layer that my touchscreen
> gives 0 to 4095.
>
> Eventhough, i am able to see the events generated using evtest.
>
> I wanted to check who maps these values 0 to 4095 to the Appropriate
> pixel on the LCD.
>
> Regards,
> Sriram
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
