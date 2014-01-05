From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: Another ALPS touchpad
Date: Sun, 5 Jan 2014 10:53:52 +0800
Message-ID: <CA+F6ckMzRnP2E--nimZA+-cfR_wmbsN4hPvr4AONt4J_c_X4kw@mail.gmail.com>
References: <20140103045915.GB30008@whitehail.bostoncoop.net>
	<5612072.Tm4gq8bhLq@dtor-d630.eng.vmware.com>
	<CA+F6ckPRj0NrerBC7j41QOE6ZsV7tPQ35gZEfk8cFZws7sT1vg@mail.gmail.com>
	<20140104133108.GA7296@whitehail.bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50344 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaAECxx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jan 2014 21:53:53 -0500
Received: by mail-lb0-f171.google.com with SMTP id w7so8972738lbi.16
        for <linux-input@vger.kernel.org>; Sat, 04 Jan 2014 18:53:52 -0800 (PST)
In-Reply-To: <20140104133108.GA7296@whitehail.bostoncoop.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dylan Paul Thurston <dpthurst@indiana.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org

2014/1/4 Dylan Paul Thurston <dpthurst@indiana.edu>:
>
> I didn't quite follow this or the following discussion. One thing I
> wanted to look into was whether it was possible to have a middle mouse
> click in addition to the left and right clicks.

Normally, clickpad only supports Left/Right click. I'm afraid middle
click would not be supported as standard.
However, if you have interest in middle click, based on our patch, you
can support that by yourself.
# Since it's a clickpad with only one button, you can report any
button event as you like by detecting the finger area when clicking.

> I had reported spurious clicks with the generic driver; I'm quite sure I'm not
> actually touching the pad when this happens, in case that's relevant.

I'm not sure where is wrong with generic driver. We would check the
behavior with latest kernel later.


-- 
Best Regards,
Tommy
