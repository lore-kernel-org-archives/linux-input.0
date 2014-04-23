From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: HID vendor access from user space
Date: Wed, 23 Apr 2014 11:27:26 +0200
Message-ID: <CANq1E4RWPVth0dpDtPwPSUk-oEvZvfpB7tAsCNo+x6ua4UKPrA@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
	<CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
	<CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
	<alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz>
	<CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com>
	<CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com>
	<CAE7qMrq5if+OovWSq3q6JQMe46VAN9eBZZEDyvcrrQS27e_7eQ@mail.gmail.com>
	<CAE7qMro259DVdPqDw4CN1hNp8kQ933F6f6ZMa7BPCOXuNWTQ8Q@mail.gmail.com>
	<alpine.LNX.2.00.1404150935300.32344@pobox.suse.cz>
	<CAE7qMroYKj0rQQ32JMsp-myrESg5V0tkXF2JukhP4aauPapfcQ@mail.gmail.com>
	<alpine.LNX.2.00.1404161649540.15539@pobox.suse.cz>
	<CAE7qMro1UVGW-T5CiYv3+vE=_diar9SE9+r=WYrwOfk82PyweA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:54243 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286AbaDWJ11 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 05:27:27 -0400
Received: by mail-ig0-f176.google.com with SMTP id uy17so4104432igb.9
        for <linux-input@vger.kernel.org>; Wed, 23 Apr 2014 02:27:26 -0700 (PDT)
In-Reply-To: <CAE7qMro1UVGW-T5CiYv3+vE=_diar9SE9+r=WYrwOfk82PyweA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

Hi

On Wed, Apr 23, 2014 at 11:14 AM, Nestor Lopez Casado
<nlopezcasad@logitech.com> wrote:
> A device with one mouse collection and one vendor collection would
> give something like this:
> /dev/input/eventX  (no change) this comes via hid-input
> /dev/mouse           (no change)
> /dev/hidrawX         (no change) (all reports still show up here)
> /dev/hidcolX          (reports from corresponding colX will show up here)
>
> So only top level vendor collections which are not parsed (claimed) by
> any hid-xx module today would appear under hidcolX.

I still think you should do that in user-space. That is, whatever
daemon opens the input-device should provide this abstraction (like
via XInput2 etc.). Otherwise, someone else pops up and tells us a
specific non-vendor extension is also unprivileged and wants them as
separate interface. There is no clear split how fine-grained the
access-control should be. Yes, you might have a specific example, but
we don't want to make that a generic interface.

Thanks
David
