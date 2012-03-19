From: Aristeu Rozanski <aris@cathedrallabs.org>
Subject: Re: [PATCH] Input: uinput: Fix race condition on read()
Date: Mon, 19 Mar 2012 13:25:28 -0400
Message-ID: <20120319172528.GB4230@cathedrallabs.org>
References: <1331928269-22532-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([173.14.175.98]:42945 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932385Ab2CSRcX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 13:32:23 -0400
Content-Disposition: inline
In-Reply-To: <1331928269-22532-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Fri, Mar 16, 2012 at 09:04:29PM +0100, David Herrmann wrote:
> Consider two threads calling read() on the same uinput-fd, both
> non-blocking. Assume there is data-available so both will simultaneously
> pass:
> 	udev->head == udev->tail
> Then the first thread goes to sleep and the second one pops the message
> from the queue. Now assume udev->head == udev->tail. If the first thread
> wakes up it will call wait_event_*() and sleep in the waitq. This
> effectively turns the non-blocking FD into a blocking one.
> 
> We fix this by never calling wait_event_*() for non-blocking FDs hence we
> will never sleep in the waitq here.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/input/misc/uinput.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 7360568..1526814 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -460,13 +460,15 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
>  	if (udev->state != UIST_CREATED)
>  		return -ENODEV;
>  
> -	if (udev->head == udev->tail && (file->f_flags & O_NONBLOCK))
> -		return -EAGAIN;
> -
> -	retval = wait_event_interruptible(udev->waitq,
> +	if (file->f_flags & O_NONBLOCK) {
> +		if (udev->head == udev->tail)
> +			return -EAGAIN;
> +	} else {
> +		retval = wait_event_interruptible(udev->waitq,
>  			udev->head != udev->tail || udev->state != UIST_CREATED);
> -	if (retval)
> -		return retval;
> +		if (retval)
> +			return retval;
> +	}
>  
>  	retval = mutex_lock_interruptible(&udev->mutex);
>  	if (retval)
makes sense, patch looks good
Acked-by: Aristeu Rozanski <aris@ruivo.org>

-- 
Aristeu

