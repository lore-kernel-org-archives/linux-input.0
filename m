From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: keyboard leds not restored after s2ram in
	2.6.32-rc6-00166-g799dd75
Date: Wed, 11 Nov 2009 14:14:14 -0800
Message-ID: <20091111215029.GA13390@core.coreip.homeip.net>
References: <761296.29412.qm@web58402.mail.re3.yahoo.com> <20091111095218.GA3654@core.coreip.homeip.net> <800885.42568.qm@web58401.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:51857 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759472AbZKKWOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 17:14:14 -0500
Content-Disposition: inline
In-Reply-To: <800885.42568.qm@web58401.mail.re3.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 11, 2009 at 12:05:42PM -0800, Mikko Vinni wrote:
> Hi,
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> > > my laptop shows the caps lock and scroll lock leds as being on after s2ram
> > > (and resume), even though they are off. If I press the caps lock key, the caps
> > > lock led stays on, the num lock led turns off, and the screen unlock screen
> > > warns about the caps lock being on.
> > > 
> > 
> > Thank you for the report. Could youplease tell me if the patch below
> > fixes the problem?
> 
> Yes, it does. Thanks, now my HP-dv5 is happy.
> 
> I did some tests suspending with the caps lock actually on, and it seems that
> in that case the user might still be confused (caps lock is on but led is off).
> At least on this machine this patch doesn't affect this theoretical problem
> either way (2.6.31 behaves similarly), so it is ok.
> 

Umm... so you are saying that even with .31 if you suspend with capslock
on it is off when you resume? Does it happen only in X or in console as
well?

-- 
Dmitry
