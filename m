From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID vendor access from user space
Date: Tue, 15 Apr 2014 09:39:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404150935300.32344@pobox.suse.cz>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com> <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com> <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com> <alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz>
 <CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com> <CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com> <CAE7qMrq5if+OovWSq3q6JQMe46VAN9eBZZEDyvcrrQS27e_7eQ@mail.gmail.com>
 <CAE7qMro259DVdPqDw4CN1hNp8kQ933F6f6ZMa7BPCOXuNWTQ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48498 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbaDOHjJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2014 03:39:09 -0400
In-Reply-To: <CAE7qMro259DVdPqDw4CN1hNp8kQ933F6f6ZMa7BPCOXuNWTQ8Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

On Mon, 14 Apr 2014, Nestor Lopez Casado wrote:

> After considering our discussion here, which is your position on
> extending the hidraw nodes to include separate nodes for top level
> vendor collections ?

The exact usecase is still a bit unclear to me. Has there been any 
explanation how you are going to deal with the fact that X protocol 
exposes all the events to X session owner anyway? (sorry if it was and I 
missed it).

Frankly, I'd really like to avoid any parsing (deciding about collections) 
whatsoever around hidraw, as that was the whole point of creating it in 
parallel to hiddev was simply 'no parsing, raw access'.

Thanks,

-- 
Jiri Kosina
SUSE Labs
