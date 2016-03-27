From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: uinput: ioctls for UI_BEGIN_FF_UPLOAD fails (returns -1). How to debug?
Date: Sun, 27 Mar 2016 21:11:51 +0200
Message-ID: <CAM4jgCp_t_mvayUbBnz_1aznbvZJz8jFLxbD49r=qLZCdOhH7Q@mail.gmail.com>
References: <56F82C42.6020002@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32912 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbcC0TLw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2016 15:11:52 -0400
Received: by mail-ig0-f172.google.com with SMTP id i19so4873210igt.0
        for <linux-input@vger.kernel.org>; Sun, 27 Mar 2016 12:11:52 -0700 (PDT)
In-Reply-To: <56F82C42.6020002@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>

2016-03-27 20:53 GMT+02:00 Manuel Reimer <mail+linux-input@m-reimer.de>:
> Hello,
>
> I'm writing on an usermode input driver.
>
> Currently my force feedback support just consists of some printf's as a
> first try.
>
> My problem is, that it seems like as soon as I first sent something to my
> open uinput device (some buttons that were pressed on the device) the uinput
> backend seems to get into some bad state.
>
> My "force feedback thread" gets the "EV_UINPUT" event trigger, but if I try
> to call
>
> ioctl(args->fduinput, UI_BEGIN_FF_UPLOAD, &upload);
>
> in this case, then the return value is "-1"...

Check the value of errno just after the failed call (and use strerror
to get a nice error message).

>
> The same code works without any problem if no buttons are pressed and
> "fftest" is called directly after startup of the driver application.
>
> Can someone help me with debugging this problem? My understanding is, that
> this call shouldn't return -1 if the "EV_UINPUT" event was successfully
> received, right?

You also need to check the event code, it must be UI_FF_UPLOAD.

>
> My system:
>
> $ uname -a
> Linux manuelspc 4.4.5-1-ARCH #1 SMP PREEMPT Thu Mar 10 07:38:19 CET 2016
> x86_64 GNU/Linux
>
> Thank you very much in advance.
>
> Manuel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
