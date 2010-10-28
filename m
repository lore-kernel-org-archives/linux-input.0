From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] evdev: discard oldest event on buffer overflow
Date: Wed, 27 Oct 2010 21:25:23 -0700
Message-ID: <AANLkTi=mSMSYR-FuqvRp6cW3PBuVaKgRKez5qZ0aQsEy@mail.gmail.com>
References: <1288199398-7198-1-git-send-email-bgat@billgatliff.com>
	<20101027235704.GA12179@core.coreip.homeip.net>
	<AANLkTimLK=UJRGQ_M9=4o5R4v_P6YPbJtPybCzfVqSND@mail.gmail.com>
	<20101028003048.GB12179@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52369 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab0J1EZZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Oct 2010 00:25:25 -0400
Received: by ewy7 with SMTP id 7so1273120ewy.19
        for <linux-input@vger.kernel.org>; Wed, 27 Oct 2010 21:25:23 -0700 (PDT)
In-Reply-To: <20101028003048.GB12179@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 27, 2010 at 5:30 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Oct 27, 2010 at 05:11:28PM -0700, Bill Gatliff wrote:
>> I still think my patch is a genuine improvement as-is, however.
>
> Sorry, I am unconvinced that it is an improvement.

The current code clobbers the queue suddenly and entirely on overflow,
and replaces all the events therein with the current one.  My version
simply discards the oldest event to make room for the newest one.
I'll agree that my patch doesn't utterly and completely fix the
problem, but I have verified that at least with a flood of incoming
multitouch packets, the system still generally behaves itself--- which
is far more than it was able to do with the code that I replaced.

How else would you be convinced?  You can't possibly believe that the
current code needs to stay in place, can you?

The thing with touch events specifically is that they contain tons of
redundant information, so losing a few old ones here and there
generally doesn't cause problems--- but losing a whole bunch of them
at the moment of overflow DOES seem to cause problems.  And touch
events tend to be bursty, making them more likely to trigger such
overflows in the first place.

With keycodes, on the other hand, you don't want to lose any of them.
Ever.  But such devices don't tend to generate events as fast, and the
recent versions of the evdev queue did such a poor job on overflow
that it's pretty clear that overflows must not have happened that
often.  Never, perhaps.

That's why even in its imperfect state, my patch seems to improve
things--- because it makes a difference under conditions where
dropping portions of a packet don't seem to matter as much.  It
doesn't get triggered in cases where dropping an event will almost
certainly lead to problems.

The alternative, of course, is to smarten-up the evdev queues so that
they work at the level of entire packets, rather than individual
events.  In the meantime, I'll proffer my patch as a small step in the
right direction.  Especially considering where we are coming from.


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
