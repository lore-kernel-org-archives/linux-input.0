From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: hid-gfrm: avoid warning for input_configured API
 change
Date: Thu, 5 Nov 2015 10:23:10 -0800
Message-ID: <20151105182310.GB36023@dtor-ws>
References: <14835877.IL6ArpWV8Q@wuerfel>
 <CAGXr9JGO_dcAuTyO2vjvbBwJ7xqcEZ1kWh7WAtxaQiKsdzr1+A@mail.gmail.com>
 <20151103234802.GC29032@dtor-ws>
 <alpine.LNX.2.00.1511041030420.22567@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36656 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965645AbbKESXO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Nov 2015 13:23:14 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1511041030420.22567@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Petri Gynther <pgynther@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Wed, Nov 04, 2015 at 10:32:24AM +0100, Jiri Kosina wrote:
> On Tue, 3 Nov 2015, Dmitry Torokhov wrote:
> 
> > > > The input_configured callback was recently changed to return
> > > > an 'int', but the newly added driver uses the old API:
> > > >
> > > > drivers/hid/hid-gfrm.c:151:22: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> > > >
> > > > This changes the driver like the other ones.
> > > >
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Acked-by: Petri Gynther <pgynther@google.com>
> > 
> > Hmm, the question is how to merge this, given that one change is in
> > Jiri's tree and another in mine...
> 
> In this case probably the best course of action is you cherry-picking 
> b2c68a2f1bab from my tree into yours, and proceeding further. git can 
> handle doubled commits (that will end up in Linus' tree eventually) 
> easily.
> 
> Another option would be to create a joint merge tree that'd contain both 
> branches merged together and proceed further from that, but I don't think 
> it's worth the hassle for simple case like this.
> 
> Works for you?

I went the cherry-pick route.

Thanks.

-- 
Dmitry
