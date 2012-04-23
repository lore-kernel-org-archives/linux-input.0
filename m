From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Mon, 23 Apr 2012 10:21:36 +0200
Message-ID: <201204231021.36621.oneukum@suse.de>
References: <201204212128.08991.oliver@neukum.org> <Pine.LNX.4.44L0.1204211717310.3981-100000@netrider.rowland.org> <CACVXFVNz8uuiXWVfg3rqhE_bazCSsH1mGANc5rJCJbbejTc1dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35927 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921Ab2DWIZj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 04:25:39 -0400
In-Reply-To: <CACVXFVNz8uuiXWVfg3rqhE_bazCSsH1mGANc5rJCJbbejTc1dQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Am Sonntag, 22. April 2012, 12:51:26 schrieb Ming Lei:
> On Sun, Apr 22, 2012 at 5:49 AM, Alan Stern <stern@rowland.harvard.edu> wrote:

> > Although the kerneldoc doesn't actually say so, it should be safe to
> > assume that usb_unlink_urb calls the completion routine directly _only_
> > in cases where the unlink succeeded.  (We could add this to the
> > kerneldoc.)
> >
> > Therefore: If the URB completes with status other than -ECONNRESET then
> > you can safely take the lock for resubmission.  If the URB completes
> > with status == -ECONNRESET then you know it was unlinked, so you don't
> > need to take the lock -- the race has already been lost.
> >
> > Does that solve your problem?
> 
> Not sure if that does work.

I am afraid it does not work.

> If the URB completes asynchronously after unlinking, its status is still
>  -ECONNRESET, so extra race may be caused without holding the lock
> because complete handler will access some global data.

That is the race. And you need not invoke global data. The original
race opens again if you are submitting a new URB without the lock
held.
This is because we cannot be sure that the same URB is unlinked
only once. A subsequent timeout may kill the wrong URB if the
first is unlinked so that the callback really comes in interrupt.

But the basic idea is brilliant. It's just that the one way logical implication:
recursive direct call of the callback -> status == -ECONNRESET
is not strong enough. But that is very easy to fix. As we know whether
the callback is directly called or not, all we need to do is differentiate
the cases in urb->status, by introducing a new error code.

	Regards
		Oliver
