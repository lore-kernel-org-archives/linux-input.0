From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v3] input: tablet: add Pegasus Notetaker tablet driver
Date: Mon, 23 May 2016 15:00:47 +0200
Message-ID: <1464008447.12181.58.camel@suse.com>
References: <1464003592-24043-1-git-send-email-martink@posteo.de>
	 <1464006414.12181.53.camel@suse.com> <5742FB0F.5070508@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5742FB0F.5070508-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 2016-05-23 at 14:43 +0200, Martin Kepplinger wrote:
> Am 2016-05-23 um 14:26 schrieb Oliver Neukum:
> > On Mon, 2016-05-23 at 13:39 +0200, Martin Kepplinger wrote:
> > 
> >> It's *really* fun to use as an input tablet though! So let's support this
> >> for everybody.
> > 
> > Hi,
> > 
> > I am afraid there are a few issues.
> 
> Thanks for having a look, comments below.
> 
> > 
> > 1. Why the kernel thread?
> 
> I provide switching to the xy tablet mode by pressing a button during
> runtime. So usb_control_msg() is called from the thread, not the
> interrupt routine.
> 
> We don't get in the way of any user app. If we leave that functionality
> out, users may have to un- and replug in the device after using
> userspace apps that transfer data or the like.

The functionality is OK, but the implementation, though creative,
is buggy.

a - multiple devices will fail
b - you have a race condition that will fail to wake the thread
    if it is still running when the button is pressed again

Kernel threads are wasteful. Using the normal system work queue might be
much easier

> > 2. This driver has questionable power management.
> 
> I think I do it how others do it. Suspend/resume works. Anything
> specific required here?

Runtime PM is missing.

	Regards
		Oliver
