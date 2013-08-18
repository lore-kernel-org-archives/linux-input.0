From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 26/49] input: cm109: prepare for enabling irq in
 complete()
Date: Sun, 18 Aug 2013 11:05:53 -0700
Message-ID: <20130818180553.GA17144@kroah.com>
References: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
 <1376756714-25479-27-git-send-email-ming.lei@canonical.com>
 <20130818033745.GC11553@core.coreip.homeip.net>
 <CACVXFVMTAYZR43pk=sc=ZDMqgS_8iSzPo880CEATNj+0SEz0aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42736 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab3HRSEI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Aug 2013 14:04:08 -0400
Content-Disposition: inline
In-Reply-To: <CACVXFVMTAYZR43pk=sc=ZDMqgS_8iSzPo880CEATNj+0SEz0aQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-usb <linux-usb@vger.kernel.org>, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org

On Sun, Aug 18, 2013 at 10:10:15PM +0800, Ming Lei wrote:
> Hi Dmitry,
> 
> On Sun, Aug 18, 2013 at 11:37 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Ming,
> >
> > On Sun, Aug 18, 2013 at 12:24:51AM +0800, Ming Lei wrote:
> >> Complete() will be run with interrupt enabled, so change to
> >> spin_lock_irqsave().
> >
> > I think cm109 needs some love in it's URB handling, but this patch does
> > not change anything, so:
> >
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thank you.
> 
> >
> > Or do you want me to pick it up for my tree?
> 
> IMO, it might be easier to merge these patches via one tree, so
> 
> Greg, would you like to manage all these patches via your tree?

Yes, I can take them all.

thanks,

greg k-h
