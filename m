From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] evdev: discard oldest event on buffer overflow
Date: Sat, 30 Oct 2010 00:33:48 -0700
Message-ID: <20101030073347.GB9878@core.coreip.homeip.net>
References: <1288199398-7198-1-git-send-email-bgat@billgatliff.com>
 <20101027235704.GA12179@core.coreip.homeip.net>
 <AANLkTimLK=UJRGQ_M9=4o5R4v_P6YPbJtPybCzfVqSND@mail.gmail.com>
 <20101028003048.GB12179@core.coreip.homeip.net>
 <AANLkTi=mSMSYR-FuqvRp6cW3PBuVaKgRKez5qZ0aQsEy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57423 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab0J3Hdy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Oct 2010 03:33:54 -0400
Received: by iwn10 with SMTP id 10so4706236iwn.19
        for <linux-input@vger.kernel.org>; Sat, 30 Oct 2010 00:33:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=mSMSYR-FuqvRp6cW3PBuVaKgRKez5qZ0aQsEy@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 27, 2010 at 09:25:23PM -0700, Bill Gatliff wrote:
> On Wed, Oct 27, 2010 at 5:30 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Oct 27, 2010 at 05:11:28PM -0700, Bill Gatliff wrote:
> >> I still think my patch is a genuine improvement as-is, however.
> >
> > Sorry, I am unconvinced that it is an improvement.
> 
> The current code clobbers the queue suddenly and entirely on overflow,
> and replaces all the events therein with the current one.  My version
> simply discards the oldest event to make room for the newest one.
> I'll agree that my patch doesn't utterly and completely fix the
> problem, but I have verified that at least with a flood of incoming
> multitouch packets, the system still generally behaves itself--- which
> is far more than it was able to do with the code that I replaced.
> 

Is it still the case with 2.6.36? We added a code there to properly size
the length of evdev queues depending on the expected number of input
events in a packet.

-- 
Dmitry
