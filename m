From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: HID vendor access from user space
Date: Tue, 15 Apr 2014 09:36:55 +0200
Message-ID: <CAE7qMrqt+0XNQ+GrtSqDPBmKwRnZGwLoVC--HS69_cAW-YM=sg@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
 <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
 <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
 <alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz> <CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com>
 <CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com>
 <CAE7qMrq5if+OovWSq3q6JQMe46VAN9eBZZEDyvcrrQS27e_7eQ@mail.gmail.com>
 <CAE7qMro259DVdPqDw4CN1hNp8kQ933F6f6ZMa7BPCOXuNWTQ8Q@mail.gmail.com> <CANq1E4Q=DC6OvtvgBtqDoYb4ZWVWSf9KXBo3=4jwS-AWzFhCiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:60650 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750853AbaDOHhe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2014 03:37:34 -0400
Received: by mail-vc0-f178.google.com with SMTP id im17so8543992vcb.23
        for <linux-input@vger.kernel.org>; Tue, 15 Apr 2014 00:37:27 -0700 (PDT)
In-Reply-To: <CANq1E4Q=DC6OvtvgBtqDoYb4ZWVWSf9KXBo3=4jwS-AWzFhCiw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

Ok, thanks David.

-nestor

On Tue, Apr 15, 2014 at 4:16 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Mon, Apr 14, 2014 at 12:00 PM, Nestor Lopez Casado
> <nlopezcasad@logitech.com> wrote:
>> David, Jiri,
>>
>> After considering our discussion here, which is your position on
>> extending the hidraw nodes to include separate nodes for top level
>> vendor collections ?
>
> Patches, patches, patches!
>
> I am currently on the road, but it's always easier to see real code
> than just the theory. I have no real objections to provide multiple
> hidraw interfaces. However, I think that doesn't solve your problem.
> For instance, you still need to set proper access-rights on the hidraw
> node. However, some other devices might export unsafe interfaces via
> vendor-extensions, and you don't wanna make those hidraw nodes
> user-accessible. Therefore, you still need a udev-rule to match on
> Logitech-stuff. You could do that as a small Logitech-driver in the
> kernel. But ok, I'm fine with moving those whitelists to user-space.
>
> Thanks
> David
