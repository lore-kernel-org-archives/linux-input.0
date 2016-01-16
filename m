From: "Allen M." <ase1592@gmail.com>
Subject: Re: adding xpad support for PS-PC Smart Joypad
Date: Fri, 15 Jan 2016 20:18:03 -0600
Message-ID: <CAPMSj_HSv_cYc+fk8-j-7DDrkcE8OtV=962_ytOhJPrEgyToGw@mail.gmail.com>
References: <CAPMSj_FGPyTVtS-F-U6C-Jji8V7_yv9-nqu4=9+1_7wCNP2UnQ@mail.gmail.com>
	<CAKdAkRTjs6r4fE5F3g9qw1kszRkrLQ6L3AVAxLtkRiv16OU9JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34931 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbcAPCSF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 21:18:05 -0500
Received: by mail-oi0-f41.google.com with SMTP id p187so128794828oia.2
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 18:18:04 -0800 (PST)
In-Reply-To: <CAKdAkRTjs6r4fE5F3g9qw1kszRkrLQ6L3AVAxLtkRiv16OU9JQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Jan 15, 2016 at 6:43 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Allen,
>
> On Fri, Jan 15, 2016 at 9:42 AM, Allen M. <ase1592@gmail.com> wrote:
>> Hello, I have a Playstation 1 to USB device I'd like to request to be added
>> as an xpad supported device. verbose lsusb output for the device can be
>> found here: http://ix.io/nq3
>>
>> The device currently works fine as a generic joystick. However, it needs
>> the MAP_DPAD_AS_BUTTONS option in order for it to be used with a dance pad.
>> Let me know if I need to do anything further or if I need to provide more
>> info for the device.
>
> This looks like a generic HID device, not Xbox device, so xpad driver
> would be wrong one to add it to. Can you have UDEV rule to remap
> buttons form userspace when the device is discovered, similarly to
> what we do for keyboards?
>
> Thanks.
>
> --
> Dmitry

Can UDEV remap a joystick axis to buttons? I wasn't aware it had that
ability. Currently I cannot simultaneously hit the left and right buttons
on the dance pad, as that simply does not work for an axis-mapped device.

I'll look into how keyboards are handled though, thanks!
