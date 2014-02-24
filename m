From: loody <miloody@gmail.com>
Subject: Re: is it possible to temporarily not let user mode get hid input event
Date: Mon, 24 Feb 2014 20:34:12 +0800
Message-ID: <CANudz+t3uNCH0WxN-QU0aB78WWfS+Q-N-TDONGfmYdmucZbDoQ@mail.gmail.com>
References: <CANudz+smSLiEtTRC4t7VxzshDAdR6D4E=zYVJHT8xw0w4JiwGw@mail.gmail.com>
	<CANq1E4SJDz2q0Rgn1f7u_b0w-mjVTte8=G2_qL38QnahDkUC1Q@mail.gmail.com>
	<CANudz+tdWrCLpARFQznQfhkF-r2J-STY68xdBJc+BK5C=tKsjA@mail.gmail.com>
	<CANq1E4QrVNQ1xjT7N5OPY1R3fM8Mc45B2GtpMjhYsKinCptZvg@mail.gmail.com>
	<CANudz+t4SXeWsDZ6jbVwYs9YxjXyBAfErnAUhiDf3FNOMyV+ww@mail.gmail.com>
	<CANq1E4QH7BRpfd_nDZ4JGE9xSHcDWpuWRK4BFhPRO4kbkKB_3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:46511 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbaBXMeN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Feb 2014 07:34:13 -0500
In-Reply-To: <CANq1E4QH7BRpfd_nDZ4JGE9xSHcDWpuWRK4BFhPRO4kbkKB_3Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

hi David:


2014-02-24 19:35 GMT+08:00 David Herrmann <dh.herrmann@gmail.com>:
> Hi
>
> On Mon, Feb 24, 2014 at 12:20 PM, loody <miloody@gmail.com> wrote:
>> hi David:
>>
>> 2014-02-23 23:16 GMT+08:00 David Herrmann <dh.herrmann@gmail.com>:
>>> Hi
>>>
>>> On Sun, Feb 23, 2014 at 7:52 AM, loody <miloody@gmail.com> wrote:
>>>> hi David:
>>>>
>>>> Thanks for your suggestion.
>>>> 2014-02-23 0:56 GMT+08:00 David Herrmann <dh.herrmann@gmail.com>:
>>>>> Hi
>>>>>
>>>>> On Sat, Feb 22, 2014 at 5:35 PM, loody <miloody@gmail.com> wrote:
>>>>>> hi all:
>>>>>> is there any kernel hid module parameter or test program can
>>>>>> temporarily not letting user mode program not receiving hid event?
>>>>>> 1. My hid kos are still inserted in.
>>>>>> 2. the kernel usb driver is working well; that mean kernel usb driver
>>>>>> still handle interrupt transaction.
>>>>>>
>>>>>> I just not want user mode program see the hid event for a while,
>>>>>
>>>>> For each connected HID device, there is a driver bound to it that
>>>>> reads the events and forwards them to HID core. What you can do, is to
>>>>> unbind a driver on a given device:
>>>>>   echo "<your-device-name>" >/sys/bus/hid/drivers/<driver-name>/unbind
>>>>> The device-name is the directory name in:
>>>>>   /sys/bus/hid/devices/
>>>>> The driver name is usually "hid-generic" but can be figured out for
>>>>> each device by looking at the "driver" symlink in it's directry.
>>>>> However, this is *really* just meant for debugging. This is not
>>>>> recommended for anything serious. There is no support for that and if
>>>>> you don't know what all this does, you shouldn't use it.
>>>>>
>>>>> There is no proper way to disable a single device in the kernel.
>>>>> User-space is supposed to control device-access so we probably won't
>>>>> add such features to the kernel. If you describe your use-case in more
>>>>> details, we can try to give hints how to get that working.
>>>>
>>>> Sorry for not describing our situation clearer previously,
>>>>
>>>> The problem we met like below
>>>> a. once plug in usb hid mouse and fast moving mouse
>>>> b. the screen will get blur.
>>>>
>>>> We want to know whether the screen blur is caused by
>>>> 1. the interrupt frequency of usb mouse is too high for our embedded
>>>> system that make video decode slow
>>>> 2. something wrong between hw cursor and video overlay.
>>>>
>>>> if we can deceive user mode program there is no mouse event, but
>>>> kernel usb level still get hid interrupt transaction.
>>>> We may clarify whether above 1) conclusion is correct.
>>>>
>>>> Appreciate your kind help :-)
>>>
>>> You can unload the HID driver as described above, but that's unlikely
>>> to fix any interrupt issues. How about you compile your kernel without
>>> usbhid support? (CONFIG_USB_HID)
>>
>> BTW, is there any fake virtual mouse to use?
>> That mean user doesn't plug in any usb hid mouse, but user mode
>> program can receive hid mouse event?
>
> Yes. For instance, you can run ./samples/uhid/uhid-example.c via ssh
> to emulate a mouse. ssh keyboard input can then be used to generate
> mouse-movement events.
There is one embarrassing question :-)
Would you please let me know how to cross-compile it ?
I try below commands but failed
#cd samples/uhid/
#make CROSS_COMPILE=arm-v7a8v4r2-linux-gnueabi-
make: *** No targets.  Stop.

Thanks for your kind help,
