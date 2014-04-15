From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: HID vendor access from user space
Date: Tue, 15 Apr 2014 04:16:11 +0200
Message-ID: <CANq1E4Q=DC6OvtvgBtqDoYb4ZWVWSf9KXBo3=4jwS-AWzFhCiw@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
	<CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
	<CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
	<alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz>
	<CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com>
	<CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com>
	<CAE7qMrq5if+OovWSq3q6JQMe46VAN9eBZZEDyvcrrQS27e_7eQ@mail.gmail.com>
	<CAE7qMro259DVdPqDw4CN1hNp8kQ933F6f6ZMa7BPCOXuNWTQ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45177 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbaDOCQL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 22:16:11 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so8906476iec.37
        for <linux-input@vger.kernel.org>; Mon, 14 Apr 2014 19:16:11 -0700 (PDT)
In-Reply-To: <CAE7qMro259DVdPqDw4CN1hNp8kQ933F6f6ZMa7BPCOXuNWTQ8Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

Hi

On Mon, Apr 14, 2014 at 12:00 PM, Nestor Lopez Casado
<nlopezcasad@logitech.com> wrote:
> David, Jiri,
>
> After considering our discussion here, which is your position on
> extending the hidraw nodes to include separate nodes for top level
> vendor collections ?

Patches, patches, patches!

I am currently on the road, but it's always easier to see real code
than just the theory. I have no real objections to provide multiple
hidraw interfaces. However, I think that doesn't solve your problem.
For instance, you still need to set proper access-rights on the hidraw
node. However, some other devices might export unsafe interfaces via
vendor-extensions, and you don't wanna make those hidraw nodes
user-accessible. Therefore, you still need a udev-rule to match on
Logitech-stuff. You could do that as a small Logitech-driver in the
kernel. But ok, I'm fine with moving those whitelists to user-space.

Thanks
David
