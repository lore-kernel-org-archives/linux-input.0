From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: bcm5974: report ABS_MT events
Date: Mon, 12 Oct 2009 23:12:20 -0700
Message-ID: <20091013061220.GI2887@core.coreip.homeip.net>
References: <1255386223-4109-1-git-send-email-rydberg@euromail.se> <1255386223-4109-2-git-send-email-rydberg@euromail.se> <20091012154528.6830da60.akpm@linux-foundation.org> <4AD3B6E2.9020703@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:56379 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945AbZJMGNc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 02:13:32 -0400
Content-Disposition: inline
In-Reply-To: <4AD3B6E2.9020703@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 13, 2009 at 01:08:18AM +0200, Henrik Rydberg wrote:
> Andrew Morton wrote:
> > On Tue, 13 Oct 2009 00:23:43 +0200
> > "Henrik Rydberg" <rydberg@euromail.se> wrote:
> > 
> >> This patch makes bcm5974 report raw multi-touch (MT) data in the form
> >> of ABS_MT events. The module parameter (nomt) may be used to turn off
> >> the effect of this patch.
> >>
> > 
> > Why do we need a module parameter to disable the newly-added feature?
> 
> All MT events bypass the input filtering and gets sent directly to the X driver.
> Although it works as intended, without visible side effects, the stream of
> events is rather large, and since the bypassing is completely new behavior, I
> felt compelled to provide an option to turn it all off. Perhaps it is just me
> being paranoid.
> 

What is the expected rate of the events when user touches the pad with
2-3 fingers? Could you giove me estimate?

> > 
> > IMO, your first patch ("input: bcm5974: retract efi-broken
> > suspend_resume") is 2.6.32 material whereas this one is 2.6.33
> > material?
> > 
> > This assumes that the two patches can be safely separated in this
> > manner, which does appear to be the case.
> > 
> 
> I was imagining both for 2.6.33; the efi booting is just beginning to work, and
> since no distro is using it fully so far the problem currently only hits the
> adventure-seekers anyways.

I'd wait then - it works fine in non-efi mode and maybe by the time EFI
is ready reset_resume will start working as well.

-- 
Dmitry
