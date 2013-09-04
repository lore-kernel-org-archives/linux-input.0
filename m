From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Correct the USB IDs for the new Macbook Air 6
Date: Wed, 4 Sep 2013 10:51:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041051060.3684@pobox.suse.cz>
References: <1378042304-1400-1-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1309021329510.3796@pobox.suse.cz> <20130903180416.GB25985@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130903180416.GB25985@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 3 Sep 2013, Dmitry Torokhov wrote:

> > > A recent patch (9d9a04ee) added support for the new machine, but got
> > > the sequence of USB ids wrong. Reports from both Ian and Linus T show
> > > that the 0x0291 id is for ISO, not ANSI, which should have the missing
> > > number 0x0290. This patchs moves the three numbers accordingly, fixing
> > > the problem.
> > > 
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Reported-and-tested-by: Ian Munsie <darkstarsword@gmail.com>
> > > Tested-by: Linus G Thiel <linus@hanssonlarsson.se>
> > > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > > ---
> > > Hi Jiri, Dmitry,
> > > 
> > > it looks like this change has been sufficiently tested now, in
> > > addition to making perfect sense. Jiri, would you mind taking it, if
> > > Dmitry approves?
> > 
> > Absolutely ... waiting for Dmitry's Ack.
> 
> And here it is:
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Perfect, thanks. Will push it to Linus this merge window.

-- 
Jiri Kosina
SUSE Labs
