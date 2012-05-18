From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: allocate event circular buffer separately
Date: Fri, 18 May 2012 08:22:13 -0700
Message-ID: <20120518152213.GA2646@core.coreip.homeip.net>
References: <1337085984-5811-1-git-send-email-mika.kuoppala@nokia.com>
 <20120516194018.GB15920@core.coreip.homeip.net>
 <1337331174.28599.22.camel@rosetta.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62667 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab2ERPWU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 May 2012 11:22:20 -0400
Received: by pbbrp8 with SMTP id rp8so4078272pbb.19
        for <linux-input@vger.kernel.org>; Fri, 18 May 2012 08:22:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337331174.28599.22.camel@rosetta.research.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Kuoppala <mika.kuoppala@nokia.com>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se

On Fri, May 18, 2012 at 11:52:54AM +0300, Mika Kuoppala wrote:
> On ke, 2012-05-16 at 12:40 -0700, ext Dmitry Torokhov wrote:
> > Hi Mika,
> > 
> > On Tue, May 15, 2012 at 03:46:24PM +0300, Mika Kuoppala wrote:
> > > If struct evdev_client is added to the already power of two
> > > buffer allocation and the buffer is large, for multitouch devices,
> > > the allocation will spill over into the the next page.
> > > Alloc buffer separately instead of binding it to evdev_client struct
> > > to avoid multipage kmalloc.
> > 
> > Not counting the event buffer, size of evdev_client is fairly small
> > (under 100 bytes?) so I wonder how often this split actually helps (i.e.
> > buffer and client each are less than page size but combined are more).
> 
> With normal input devices this never happens as the default event buffer
> size seem to be 1024 (64 * 16) bytes. But the event buffer size
> heuristics for multi touch devices this happens very easily. The
> heuristics will look for ABS_MT_TRACKING_ID min and max values to
> determine the amount of contacts delivered between two syn events. With
> 10 contacts and moderate amount of ABS_MT* events between MT_SYNS, you
> end up easily to more than a page worth of stuff.
> 
> See driver/input/input.c:input_estimate_events_per_packet()

That was not my question. I was askig how often it happens that not
only input_estimate_events_per_packet() * <packet size> produces large
value, but it is less than 4K, but close enough to 4K so that
event_client allocated together with the buffer pushes it up over 4K.

Thanks.

-- 
Dmitry
