From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: HID vendor access from user space
Date: Wed, 23 Apr 2014 11:14:55 +0200
Message-ID: <CAE7qMro1UVGW-T5CiYv3+vE=_diar9SE9+r=WYrwOfk82PyweA@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
 <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
 <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
 <alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz> <CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com>
 <CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com>
 <CAE7qMrq5if+OovWSq3q6JQMe46VAN9eBZZEDyvcrrQS27e_7eQ@mail.gmail.com>
 <CAE7qMro259DVdPqDw4CN1hNp8kQ933F6f6ZMa7BPCOXuNWTQ8Q@mail.gmail.com>
 <alpine.LNX.2.00.1404150935300.32344@pobox.suse.cz> <CAE7qMroYKj0rQQ32JMsp-myrESg5V0tkXF2JukhP4aauPapfcQ@mail.gmail.com>
 <alpine.LNX.2.00.1404161649540.15539@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:57217 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753206AbaDWJP2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 05:15:28 -0400
Received: by mail-ve0-f173.google.com with SMTP id oy12so803148veb.32
        for <linux-input@vger.kernel.org>; Wed, 23 Apr 2014 02:15:26 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1404161649540.15539@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

On Wed, Apr 16, 2014 at 4:53 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 15 Apr 2014, Nestor Lopez Casado wrote:
>
>> > Frankly, I'd really like to avoid any parsing (deciding about collections)
>> > whatsoever around hidraw, as that was the whole point of creating it in
>> > parallel to hiddev was simply 'no parsing, raw access'.
>>
>> We should avoid naming the new nodes "hidrawX" they could be
>> "hidvendorX" for instance, or it could also be "hidcolX" where col
>> stands for collection. We will be moving the "raw" one level down.
>
> I am still having trouble seeing how this would work together with current
> hidraw.
>
> In your proposal, there will be both hidrawX and hidcolX existing in
> parallel, right?
Yes.

> Who will be deciding what goes to hidcolX instead of
> hidrawX?
The additional code that we will put in place.
Having said that, hidrawX will still get the same reports as before,
nothing will change for those nodes.

> One of the pain points would be -- /dev/hidrawX will have to stay
> anyway for compatibility reasons, so we can't just divide it to multiple
> /dev/hidcolX all of a sudden and never look back.
That's true.

A device with one mouse collection and one vendor collection would
give something like this:
/dev/input/eventX  (no change) this comes via hid-input
/dev/mouse           (no change)
/dev/hidrawX         (no change) (all reports still show up here)
/dev/hidcolX          (reports from corresponding colX will show up here)

So only top level vendor collections which are not parsed (claimed) by
any hid-xx module today would appear under hidcolX.

Unless you have a major blocker, as David said, I think the best would
be to come up with some code and post a proposal patch for
consideration.

>
> --
> Jiri Kosina
> SUSE Labs

Cheers,
-nestor
