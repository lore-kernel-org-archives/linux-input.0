From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-gfrm: avoid warning for input_configured API
 change
Date: Wed, 4 Nov 2015 10:32:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511041030420.22567@pobox.suse.cz>
References: <14835877.IL6ArpWV8Q@wuerfel> <CAGXr9JGO_dcAuTyO2vjvbBwJ7xqcEZ1kWh7WAtxaQiKsdzr1+A@mail.gmail.com> <20151103234802.GC29032@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49119 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755209AbbKDJcZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Nov 2015 04:32:25 -0500
In-Reply-To: <20151103234802.GC29032@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Petri Gynther <pgynther@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, 3 Nov 2015, Dmitry Torokhov wrote:

> > > The input_configured callback was recently changed to return
> > > an 'int', but the newly added driver uses the old API:
> > >
> > > drivers/hid/hid-gfrm.c:151:22: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> > >
> > > This changes the driver like the other ones.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Acked-by: Petri Gynther <pgynther@google.com>
> 
> Hmm, the question is how to merge this, given that one change is in
> Jiri's tree and another in mine...

In this case probably the best course of action is you cherry-picking 
b2c68a2f1bab from my tree into yours, and proceeding further. git can 
handle doubled commits (that will end up in Linus' tree eventually) 
easily.

Another option would be to create a joint merge tree that'd contain both 
branches merged together and proceed further from that, but I don't think 
it's worth the hassle for simple case like this.

Works for you?

Thanks,

-- 
Jiri Kosina
SUSE Labs

