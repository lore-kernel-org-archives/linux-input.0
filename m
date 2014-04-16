From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID vendor access from user space
Date: Wed, 16 Apr 2014 16:53:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404161649540.15539@pobox.suse.cz>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com> <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com> <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com> <alpine.LNX.2.00.1404031547580.32122@pobox.suse.cz>
 <CAE7qMrqizfupabTciYfo+gGNG16ZM482y8tBbuQdvZYHdBaV=Q@mail.gmail.com> <CANq1E4TR34FG+vbAeHWv1JT5V0w1k3hq6Kmhx3ngO8+=arMsWA@mail.gmail.com> <CAE7qMrq5if+OovWSq3q6JQMe46VAN9eBZZEDyvcrrQS27e_7eQ@mail.gmail.com> <CAE7qMro259DVdPqDw4CN1hNp8kQ933F6f6ZMa7BPCOXuNWTQ8Q@mail.gmail.com>
 <alpine.LNX.2.00.1404150935300.32344@pobox.suse.cz> <CAE7qMroYKj0rQQ32JMsp-myrESg5V0tkXF2JukhP4aauPapfcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48951 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161621AbaDPOxO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2014 10:53:14 -0400
In-Reply-To: <CAE7qMroYKj0rQQ32JMsp-myrESg5V0tkXF2JukhP4aauPapfcQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Mathieu Meisser <mmeisser@logitech.com>

On Tue, 15 Apr 2014, Nestor Lopez Casado wrote:

> > Frankly, I'd really like to avoid any parsing (deciding about collections)
> > whatsoever around hidraw, as that was the whole point of creating it in
> > parallel to hiddev was simply 'no parsing, raw access'.
> 
> We should avoid naming the new nodes "hidrawX" they could be
> "hidvendorX" for instance, or it could also be "hidcolX" where col
> stands for collection. We will be moving the "raw" one level down.

I am still having trouble seeing how this would work together with current 
hidraw.

In your proposal, there will be both hidrawX and hidcolX existing in 
parallel, right? Who will be deciding what goes to hidcolX instead of 
hidrawX? One of the pain points would be -- /dev/hidrawX will have to stay 
anyway for compatibility reasons, so we can't just divide it to multiple 
/dev/hidcolX all of a sudden and never look back.

-- 
Jiri Kosina
SUSE Labs
