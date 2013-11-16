From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 04/13] Input: add motion-tracking ABS_* bits and docs
Date: Sat, 16 Nov 2013 18:53:37 +0100
Message-ID: <20131116185337.0d2c80ff184ea582d69858ed@studenti.unina.it>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
	<1383336984-26601-5-git-send-email-dh.herrmann@gmail.com>
	<20131115111135.1548dc0a4effdad8f672ff24@studenti.unina.it>
	<CANq1E4Szv+0-GSkekH_Q5HXDv+hq7LS6tYbZFTtmxsUp1-ALkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:41088 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab3KPRxp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Nov 2013 12:53:45 -0500
In-Reply-To: <CANq1E4Szv+0-GSkekH_Q5HXDv+hq7LS6tYbZFTtmxsUp1-ALkA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Fri, 15 Nov 2013 11:17:31 +0100
David Herrmann <dh.herrmann@gmail.com> wrote:

> Hi Antonio
> 
> On Fri, Nov 15, 2013 at 11:11 AM, Antonio Ospite
> <ospite@studenti.unina.it> wrote:
> > On Fri,  1 Nov 2013 21:16:15 +0100
> > David Herrmann <dh.herrmann@gmail.com> wrote:
> >
> >> Motion sensors are getting quite common in mobile devices. To avoid
> >> returning accelerometer data via ABS_X/Y/Z and irritating the Xorg
> >> mouse-driver, this adds separate ABS_* bits for that.
> >>
> >> This is needed if gaming devices want to report their normal data plus
> >> accelerometer/gyro data. Usually, ABS_X/Y are already used by analog
> >> sticks, so need separate definitions, anyway.
> >>
> >> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> >
> > Hi, what's the status of this patch?
> > I cannot see it in Dmitry's repository, David maybe you have another
> > repository I can pull from?
> 
> Please see patch 1/13 and 2/13. They fix the kernel ABI to support new
> ABS_* bits (the current ABI is broken in that regard). As this is
> quite critical and caused breaks during the last merge-window, we
> haven't merged it yet. I hope to get it into 3.14, though. The current
> patches seem fine and work for me. I will try to get the user-space
> part working in the next weeks.
> 
> Any help is welcome!
> 

I can try updating evtest, any idea about how I should check at
runtime whether ABS_MAX2 is supported or not?

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
