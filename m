From: Amordea Whiteoak <amordea@gmail.com>
Subject: Re: PROBLEM: [HP Stream Notebook - 11-d010nr] clickpad malfunctions
 after performing a hardware click
Date: Wed, 17 Dec 2014 18:23:19 -0500
Message-ID: <CALmnu0ZEL9sRPfOwj7Fy38E5NQmD680tD4OfjubyXU8dkmDFsA@mail.gmail.com>
References: <CAN+gG=E+8277zg3LLW-eFWZb8bNyU_Umf9M2w6+t7Y3sSkkSFg@mail.gmail.com>
	<CALmnu0bPLi4skqUxvjd9DWrZJysvqX-+nxNHdx5APGsoNZsnKA@mail.gmail.com>
	<CAN+gG=Emz8r=17OpUETpVQyjCMDMX=aNEFFHZo3ivGS=xTZHXA@mail.gmail.com>
	<CALmnu0agW-mN9RON1FT9DCxE9POiwS2Jhj7hXZaW+6escc7OGw@mail.gmail.com>
	<CALmnu0aMX8RuDJFozCwP6GmP11Uep=R6bc0EqPYzBknwpHBmpA@mail.gmail.com>
	<CAN+gG=E=3kG9t9XTNe0X1kFumdkQ3CfM-ViXnOBGThmyJDNJ4g@mail.gmail.com>
	<CALmnu0Yg1vd4FOD5vtW39cbbcsRYiPuiiMD0A+obLyrkvKO+jA@mail.gmail.com>
	<CALmnu0Y0kvU-yqrKvNAQmjUgFJQ-v0NESyV6o_=CuVzc2dx=YQ@mail.gmail.com>
	<CAN+gG=GucHKyGB0Z=qP+G2KSej0yoVe3vpa3AzRbBDeP2jw9Qg@mail.gmail.com>
	<CALmnu0a_HmgJXa9aYbCpyRhAb5h_FrLyhVUeeojMJa0tPUTHTg@mail.gmail.com>
	<20141217010936.GA6906@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51977 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaLQXXT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 18:23:19 -0500
Received: by mail-pd0-f174.google.com with SMTP id fp1so91401pdb.19
        for <linux-input@vger.kernel.org>; Wed, 17 Dec 2014 15:23:19 -0800 (PST)
In-Reply-To: <20141217010936.GA6906@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>

> there are at least two options in there that are non-default, so maybe other
> options are different too. an xorg.log would be more useful here, or make
> sure that you don't have any custom configs in /etc/X11/xorg.conf.d/
> or an xorg.conf

Okay, to be absolutely, positively sure that I did not have any
remaining custom configurations from all my tinkering with the
clickpad, I decided just to reinstall Lubuntu from scratch. Then I
re-patched my system with Andrew's patch. The result is the same, the
right-click is still not working.

> * use libevdev's touchpad-edge-detector tool to scope out the min/max ranges
>   of your touchpad

Here is the output of the touchpad-edge-detector tool. I pretty
thoroughly wove my finger around the touchpad several times until the
coordinates stopped changing completely.

Touchpad SYN1EDE:00 06CB:7442 on /dev/input/event9
Move one finger around the touchpad to detect the actual edges
Kernel says: x [1..4008], y [1..2266]
Touchpad sends: x [10..4008], y [0..2262]

Thanks again for all your help.


On Tue, Dec 16, 2014 at 8:09 PM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Mon, Dec 15, 2014 at 03:05:04PM -0500, Amordea Whiteoak wrote:
>> > Strictly speaking, there is no right click button on clickpads. We
>> > emulate one with the software buttons in Xorg.
>> > IIRC, there were some "workarounds" in your original bugs which
>> > consist in disabling the software buttons area. Can you make sure that
>> > there is no left over from this?
>>
>> I learn new things about clickpads every day. :)
>>
>> To my knowledge, those configurations changes should reset upon reboot
>> and I never committed any of those lines to any of my startup files.
>> So we should be good there, I think. Just in case, I am enclosing the
>> output of my synclient -l, which should be the default configuration.
>
> there are at least two options in there that are non-default, so maybe other
> options are different too. an xorg.log would be more useful here, or make
> sure that you don't have any custom configs in /etc/X11/xorg.conf.d/
> or an xorg.conf
>
>> > If this still doesn't work, we wil need to check that the X and Y
>> > ranges reported by your clickpad are accurate and that the software
>> > buttons are properly activated.
>>
>> I don't know the testing methodology to use to provide positioning
>> data for my trackpad, but let me know if you need that and how you
>> want me to get it and I will be happy to provide.
>
> Two options:
> * use evtest or evemu-record to record the data and look at the output, or
>   simpler
> * use libevdev's touchpad-edge-detector tool to scope out the min/max ranges
>   of your touchpad
>
> Cheers,
>    Peter
>
