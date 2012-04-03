From: Aristeu Rozanski <aris@ruivo.org>
Subject: Re: [PATCH 2/6] Input: uinput - fix race that can block nonblocking
 read
Date: Tue, 3 Apr 2012 12:28:40 -0400
Message-ID: <20120403162840.GA26580@cathedrallabs.org>
References: <1333173983-19949-1-git-send-email-dmitry.torokhov@gmail.com>
 <1333173983-19949-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([173.14.175.98]:34913 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab2DCQhh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Apr 2012 12:37:37 -0400
Content-Disposition: inline
In-Reply-To: <1333173983-19949-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On Fri, Mar 30, 2012 at 11:06:19PM -0700, Dmitry Torokhov wrote:
> From: David Herrmann <dh.herrmann@googlemail.com>
> 
> Consider two threads calling read() on the same uinput-fd, both
> non-blocking. Assume there is data-available so both will simultaneously
> pass:
> 	udev->head == udev->tail
> 
> Then the first thread goes to sleep and the second one pops the message
> from the queue. Now assume udev->head == udev->tail. If the first thread
> wakes up it will call wait_event_*() and sleep in the waitq. This
> effectively turns the non-blocking FD into a blocking one.
> 
> We fix this by never calling wait_event_*() for non-blocking FDs hence we
> will never sleep in the waitq here.
> 
> Also, if we fail to retrieve an event because it was "stolen" by another
> thread, we will return -EAGAIN instead of 0 in case of nonblocking read.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/input/misc/uinput.c |   26 ++++++++++++++------------
>  1 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index eb9723a..5339c1d 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -460,16 +460,13 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
>  	if (count < input_event_size())
>  		return -EINVAL;
>  
> -	if (udev->state != UIST_CREATED)
> -		return -ENODEV;
> -
> -	if (udev->head == udev->tail && (file->f_flags & O_NONBLOCK))
> -		return -EAGAIN;
> -
> -	retval = wait_event_interruptible(udev->waitq,
> -			udev->head != udev->tail || udev->state != UIST_CREATED);
> -	if (retval)
> -		return retval;
> +	if (!(file->f_flags & O_NONBLOCK)) {
> +		retval = wait_event_interruptible(udev->waitq,
> +						  udev->head != udev->tail ||
> +						  udev->state != UIST_CREATED);
> +		if (retval)
> +			return retval;
> +	}
no. if the state is not UIST_CREATED, it should return ENODEV, not EAGAIN.
and you're not checking it if O_NONBLOCK is present.

-- 
Aristeu

