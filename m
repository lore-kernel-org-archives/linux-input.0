From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 22/22] input: ads7846: introduce platform specific way to  synchronize sampling
Date: Fri, 13 Mar 2009 18:09:40 -0700
Message-ID: <200903131809.40400.david-b@pacbell.net>
References: <200903041959.n24JxDIQ028495@imap1.linux-foundation.org> <F71A24FDAED97E4CB6D3A8E8A97D5C544A38E1D6@SC-VEXCH1.marvell.com> <f17812d70903121950h768fb7d0t234e040f34656f0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:24498 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751090AbZCNBKK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Mar 2009 21:10:10 -0400
In-Reply-To: <f17812d70903121950h768fb7d0t234e040f34656f0c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Eric Miao <ymiao3@marvell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thursday 12 March 2009, Eric Miao wrote:
> >
> > This should be a workaround for broken hardware and I don't expect
> > this sync time on every boards.
> >
> 
> The sync time depends on the moment of this sync between two HSYNC,
> I don't expect that to be very long,

But how long is that?  1/(50 KHz) or so?


> yet the hardware is broken enough to 
> endure this latency.

Actually I heard from someone else this morning that it's not just
"broken" hardware that sees touchscreen ADC sampling noise related
to hsync.  So this patch makes sense ... although there's no way to
guarantee the SPI requests won't have queueing delays before they
arrive at the touchscreen controller, possibly hitting the next
hsync interval.

It seems that it's surprisingly tricky to get clean samples from
touchscreens.  There's physical oscillation to compensate, which
changes capacitance until it damps down.  There's also electrical
oscillation from charging the various sense lines.  Add to that a
bunch of honest-to-goodness noise associated with hsync and vsync...
yeech!  It would be a Good Thing if someone were to split out the
sample filtering logic from this driver so it could be used with
other touchscreen drivers.

- Dave

