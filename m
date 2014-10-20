From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: ASUS N550JK Touchpad recognized wrongly as PS/2 mouse
Date: Mon, 20 Oct 2014 15:48:20 -0400
Message-ID: <CAN+gG=Eeqg-Htr8WmxiCrrwxOztdaqRCTS5f3tFncf+Z69dnRw@mail.gmail.com>
References: <CAJ_4JbZWLXVRGwwuYnzoVvTOM-fUE4vb9jeZLQJ2LUD+fOhs-Q@mail.gmail.com>
	<CAN+gG=E6c9eK51RxMQU_1tkxk08WtXfpSt7eyiz4fZqOd258OQ@mail.gmail.com>
	<54454CD7.80406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42203 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbaJTTsV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Oct 2014 15:48:21 -0400
Received: by mail-qc0-f174.google.com with SMTP id m20so4302023qcx.33
        for <linux-input@vger.kernel.org>; Mon, 20 Oct 2014 12:48:20 -0700 (PDT)
In-Reply-To: <54454CD7.80406@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Carla Rosenfield <c.rosenfield@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Mon, Oct 20, 2014 at 1:56 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 10/20/2014 05:38 PM, Benjamin Tissoires wrote:
>> Hi Carla,
>>
>> just FYI, I have the same laptop model than you, and can reproduce
>> your bug report in the same way. I'll work on that to make it working
>> properly.
>>
>> Hans, (unfortunately,) this laptop has a ETD0105 touchpad from Elan.
>> That means that we do not have the X550 touchpad in house, but also
>> means that we should be able to get in working faster than the X550
>> one :)
>
> Ok, so 2 things:
>
> 1) On the ETD0105 touchpad not working, does the kernel you're using
> already have this patch ? :
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/mouse/elantech.c?id=271329b3c798b2102120f5df829071c211ef00ed

I tried the RHEL 6.6 kernel (the only I had on a usb disk handy at that time).
The Fedora 21 snapshot (3.17.0) makes it detected properly :)

However, landing 8 fingers on the touchpad makes it completely lost
(waiting few seconds without touching it is enough to get it back
alive).

>
> If not, try that, if it does, it may need some tweaks to that patch,
> or something similar.
>
> 2) On not having an X550 style touchpad, I got a report from a user
> in the bugzilla tracking that, telling us that he is busy reverse
> engineering the protocol, and is making good progress, so that one
> should hopefully get sorted out soon-ish too :)

I saw that on the bug too. Hopefully, it will work out well.

Cheers,
Benjamin
