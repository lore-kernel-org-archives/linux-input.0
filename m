From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/6] Input: uinput - fix race that can block nonblocking
 read
Date: Tue, 3 Apr 2012 09:41:29 -0700
Message-ID: <20120403164128.GB24832@core.coreip.homeip.net>
References: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
 <1333173983-19949-2-git-send-email-dmitry.torokhov@gmail.com>
 <20120403162840.GA26580@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:37463 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab2DCQlf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 12:41:35 -0400
Received: by dake40 with SMTP id e40so3866130dak.11
        for <linux-input@vger.kernel.org>; Tue, 03 Apr 2012 09:41:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120403162840.GA26580@cathedrallabs.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aristeu Rozanski <aris@ruivo.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On Tue, Apr 03, 2012 at 12:28:40PM -0400, Aristeu Rozanski wrote:
> On Fri, Mar 30, 2012 at 11:06:19PM -0700, Dmitry Torokhov wrote:
> > From: David Herrmann <dh.herrmann@googlemail.com>
> > 
> > Consider two threads calling read() on the same uinput-fd, both
> > non-blocking. Assume there is data-available so both will simultaneously
> > pass:
> > 	udev->head == udev->tail
> > 
> > Then the first thread goes to sleep and the second one pops the message
> > from the queue. Now assume udev->head == udev->tail. If the first thread
> > wakes up it will call wait_event_*() and sleep in the waitq. This
> > effectively turns the non-blocking FD into a blocking one.
> > 
> > We fix this by never calling wait_event_*() for non-blocking FDs hence we
> > will never sleep in the waitq here.
> > 
> > Also, if we fail to retrieve an event because it was "stolen" by another
> > thread, we will return -EAGAIN instead of 0 in case of nonblocking read.
> > 
> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> >  drivers/input/misc/uinput.c |   26 ++++++++++++++------------
> >  1 files changed, 14 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > index eb9723a..5339c1d 100644
> > --- a/drivers/input/misc/uinput.c
> > +++ b/drivers/input/misc/uinput.c
> > @@ -460,16 +460,13 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
> >  	if (count < input_event_size())
> >  		return -EINVAL;
> >  
> > -	if (udev->state != UIST_CREATED)
> > -		return -ENODEV;
> > -
> > -	if (udev->head == udev->tail && (file->f_flags & O_NONBLOCK))
> > -		return -EAGAIN;
> > -
> > -	retval = wait_event_interruptible(udev->waitq,
> > -			udev->head != udev->tail || udev->state != UIST_CREATED);
> > -	if (retval)
> > -		return retval;
> > +	if (!(file->f_flags & O_NONBLOCK)) {
> > +		retval = wait_event_interruptible(udev->waitq,
> > +						  udev->head != udev->tail ||
> > +						  udev->state != UIST_CREATED);
> > +		if (retval)
> > +			return retval;
> > +	}
> no. if the state is not UIST_CREATED, it should return ENODEV, not EAGAIN.
> and you're not checking it if O_NONBLOCK is present.

Actually this condition is checked again one we take the mutex. Anyway,
please take a look at the updated version I posted; it looks differently
now.

Thanks.

-- 
Dmitry
