From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ASUS N550JK Touchpad recognized wrongly as PS/2 mouse
Date: Tue, 21 Oct 2014 08:26:53 +0200
Message-ID: <5445FCAD.7020406@redhat.com>
References: <CAJ_4JbZWLXVRGwwuYnzoVvTOM-fUE4vb9jeZLQJ2LUD+fOhs-Q@mail.gmail.com>	<CAN+gG=E6c9eK51RxMQU_1tkxk08WtXfpSt7eyiz4fZqOd258OQ@mail.gmail.com>	<54454CD7.80406@redhat.com> <CAN+gG=Eeqg-Htr8WmxiCrrwxOztdaqRCTS5f3tFncf+Z69dnRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaJUG05 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Oct 2014 02:26:57 -0400
In-Reply-To: <CAN+gG=Eeqg-Htr8WmxiCrrwxOztdaqRCTS5f3tFncf+Z69dnRw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Carla Rosenfield <c.rosenfield@gmail.com>, linux-input <linux-input@vger.kernel.org>

Hi,

On 10/20/2014 09:48 PM, Benjamin Tissoires wrote:
> On Mon, Oct 20, 2014 at 1:56 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 10/20/2014 05:38 PM, Benjamin Tissoires wrote:
>>> Hi Carla,
>>>
>>> just FYI, I have the same laptop model than you, and can reproduce
>>> your bug report in the same way. I'll work on that to make it working
>>> properly.
>>>
>>> Hans, (unfortunately,) this laptop has a ETD0105 touchpad from Elan.
>>> That means that we do not have the X550 touchpad in house, but also
>>> means that we should be able to get in working faster than the X550
>>> one :)
>>
>> Ok, so 2 things:
>>
>> 1) On the ETD0105 touchpad not working, does the kernel you're using
>> already have this patch ? :
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/input/mouse/elantech.c?id=271329b3c798b2102120f5df829071c211ef00ed
> 
> I tried the RHEL 6.6 kernel (the only I had on a usb disk handy at that time).
> The Fedora 21 snapshot (3.17.0) makes it detected properly :)

Good.

> However, landing 8 fingers on the touchpad makes it completely lost
> (waiting few seconds without touching it is enough to get it back
> alive).

Hmm, might be a firmware bug, but this also might mean it can detect
more fingers then previous versions, and sends a new packet type when
more then X fingers are present, we should probably end a mail to
our contacts at elantech about this. Since you've the hardware I
assume you will be sending such a mail ?

Regards,

Hans
