From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Thu, 2 Dec 2010 15:34:20 -0600
Message-ID: <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
	<20101202212223.GA9864@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35215 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab0LBVeW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Dec 2010 16:34:22 -0500
Received: by eye27 with SMTP id 27so4649037eye.19
        for <linux-input@vger.kernel.org>; Thu, 02 Dec 2010 13:34:20 -0800 (PST)
In-Reply-To: <20101202212223.GA9864@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Guys:



On Thu, Dec 2, 2010 at 3:22 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> We do not have such fine granularity as per-read. Input drivers get
> notified when first application opens one of the interfaces (by
> implementing input->open()). We expect that applications that open
> input interfaces will read the data from them.

Right, I know that applications will ultimately read from the interface.  :)

I have noticed that several Android ports (among others) call read on
/dev/input/eventX inside of a delayed loop--- as if they want to pace
the rate of incoming events themselves.  In fact, in those ports the
length of each delay is controlled by how often Android applications
a.k.a. Activities want events streamed to them.

This is a great idea in theory, especially for things like
accelerometers which can go much, much faster than an activity might
need the data.  But I just haven't seen anywhere in those
aforementioned ports where the pacing information gets conveyed over
to the kernel-side driver.  You have answered my basic question,
however: if such information gets conveyed back to a driver, it
doesn't get there through the evdev interface!

Would a patch that adds a read callback, similar to how open works
now, be well-received?  I can see it being very useful for certain
situations...


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
