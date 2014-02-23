From: loody <miloody@gmail.com>
Subject: Re: is it possible to temporarily not let user mode get hid input event
Date: Sun, 23 Feb 2014 14:52:56 +0800
Message-ID: <CANudz+tdWrCLpARFQznQfhkF-r2J-STY68xdBJc+BK5C=tKsjA@mail.gmail.com>
References: <CANudz+smSLiEtTRC4t7VxzshDAdR6D4E=zYVJHT8xw0w4JiwGw@mail.gmail.com>
	<CANq1E4SJDz2q0Rgn1f7u_b0w-mjVTte8=G2_qL38QnahDkUC1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:57536 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaBWGw6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 01:52:58 -0500
In-Reply-To: <CANq1E4SJDz2q0Rgn1f7u_b0w-mjVTte8=G2_qL38QnahDkUC1Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

hi David:

Thanks for your suggestion.
2014-02-23 0:56 GMT+08:00 David Herrmann <dh.herrmann@gmail.com>:
> Hi
>
> On Sat, Feb 22, 2014 at 5:35 PM, loody <miloody@gmail.com> wrote:
>> hi all:
>> is there any kernel hid module parameter or test program can
>> temporarily not letting user mode program not receiving hid event?
>> 1. My hid kos are still inserted in.
>> 2. the kernel usb driver is working well; that mean kernel usb driver
>> still handle interrupt transaction.
>>
>> I just not want user mode program see the hid event for a while,
>
> For each connected HID device, there is a driver bound to it that
> reads the events and forwards them to HID core. What you can do, is to
> unbind a driver on a given device:
>   echo "<your-device-name>" >/sys/bus/hid/drivers/<driver-name>/unbind
> The device-name is the directory name in:
>   /sys/bus/hid/devices/
> The driver name is usually "hid-generic" but can be figured out for
> each device by looking at the "driver" symlink in it's directry.
> However, this is *really* just meant for debugging. This is not
> recommended for anything serious. There is no support for that and if
> you don't know what all this does, you shouldn't use it.
>
> There is no proper way to disable a single device in the kernel.
> User-space is supposed to control device-access so we probably won't
> add such features to the kernel. If you describe your use-case in more
> details, we can try to give hints how to get that working.

Sorry for not describing our situation clearer previously,

The problem we met like below
a. once plug in usb hid mouse and fast moving mouse
b. the screen will get blur.

We want to know whether the screen blur is caused by
1. the interrupt frequency of usb mouse is too high for our embedded
system that make video decode slow
2. something wrong between hw cursor and video overlay.

if we can deceive user mode program there is no mouse event, but
kernel usb level still get hid interrupt transaction.
We may clarify whether above 1) conclusion is correct.

Appreciate your kind help :-)
