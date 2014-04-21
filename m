From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Issues with hid-multitouch driver
Date: Mon, 21 Apr 2014 09:47:37 -0400
Message-ID: <CAN+gG=FYNZBpOngy1xfRUu-Q2jEfuNcCmezC9ccLzeS9KwR_=w@mail.gmail.com>
References: <CAEQQWc5My-QBoiX7Yqx_-Rer-OdaD7OxJgci5DScJf012s15Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:49239 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaDUNrj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2014 09:47:39 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so3187499lab.37
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2014 06:47:37 -0700 (PDT)
In-Reply-To: <CAEQQWc5My-QBoiX7Yqx_-Rer-OdaD7OxJgci5DScJf012s15Aw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomas Sokorai <tsokorai@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Thomas,

Can you install hid-recorder from here:
http://bentiss.github.io/hid-replay-docs/

and give me the following hid-recorder logs:
- normal usage (when it is working fine)
- multi-touch taps which breaks the driver,
- normal usage (which should be broken now)

I should be able to understand where the problem lies.

Thanks,
Benjamin

On Sat, Apr 19, 2014 at 7:02 PM, Tomas Sokorai <tsokorai@gmail.com> wrote:
> Hi guys,
>
> I'm having issues with the hid-multitouch driver in kernel 3.14.
> I have the following touchscreen device:
>
> Bus 001 Device 003: ID 03fc:05d8 Elitegroup Computer Systems
>
> The thing is that the driver detects the device correctly and even
> works seemingly OK, until you start doing multi-touch taps on the
> screen.
>
> At some point, the input to the Xorg server stops.
>
> I investigated this further, and using evtest, I can see that the events
> ABS_X and ABS_Y stop being generated, and also that BTN_TOUCH event
> gets a "value 1" for the touch before the freeze, but it is never
> released: no "value 0" for the touch release event, ever.
>
> After the driver gets braindamaged, it only generates
> ABS_MT_POSITION_Y, ABS_MT_POSITION_X and ABS_MT_TRACKING_ID events,
> and therefore no further clicks or normal Xorg pointer movement
> on-screen.
>
> I even tried backporting the lastest version from the HID git, with
> the same results.
>
> Thanks in advance,
> --
> Tomas J. Sokorai Sch.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
