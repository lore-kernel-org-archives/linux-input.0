From: Aristeu Rozanski <aris@cathedrallabs.org>
Subject: Re: [PATCH] Input: uinput: Avoid returning 0 on read()
Date: Mon, 19 Mar 2012 13:31:02 -0400
Message-ID: <20120319173102.GC4230@cathedrallabs.org>
References: <1331929435-22872-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lobo.ruivo.org ([173.14.175.98]:42944 "EHLO lobo.ruivo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932385Ab2CSRbh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 13:31:37 -0400
Content-Disposition: inline
In-Reply-To: <1331929435-22872-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Fri, Mar 16, 2012 at 09:23:55PM +0100, David Herrmann wrote:
> Consider the output-queue to be almost full. A thread inside read() will
> pass the wait_event_*() call and reach the while() loop. Now assume a new
> message was added to the output-queue and the queue overruns, i.e.,
> we now have udev->head == udev->tail.
> The thread now passes the while() loop without fetching any message and
> returns 0. However, at least for blocking FDs there is really no reason to
> wake up user-space and for non-blocking FDs we should return -EAGAIN now.
> Therefore, simply retry the read() if we didn't fetch any message.
> 
> We also check whether the user-supplied buffer is actually big enough and
> return -EINVAL if it is not. This differs from current behavior which
> caused 0 to be returned which actually does not make any sense. This may
> break ABI since user-space programs might be used to get 0 if the buffer
> is to small. However, 0 means the FD was closed so returning -EINVAL
> *must* be handled similar in user-space, otherwise the programs are
> broken.
> Anyway, we need this check, otherwise we would have a never-returning
> loop here because retval would always be 0.
> 
> Also note that an queue-overrun is not the only situation where this bug
> occurs. We might also have a race between multiple threads here so we
> definitely need to handle it this way.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> Hi Dmitry
> 
> Please note that this is based on my previous fix so you might get some
> (trivial) conflicts if you didn't apply the previous one. They should be easy to
> solve, though.
> Also, the issue with returning -EINVAL if the buffer is too small and hence
> breaking API can be resolved by moving the check down directly before running
> "goto try_again;". However, I think returning -EINVAL is the better fix. Feel
> free to change this, though.
> To be honest, I also don't know whether read() actually returns 0 to user-space
> if our handler returns 0 or if it changes this to anything else.
> 
> Regards
> David
> 
>  drivers/input/misc/uinput.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 1526814..bf5cd7b 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -457,6 +457,10 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
>  	struct uinput_device *udev = file->private_data;
>  	int retval = 0;
>  
> +	if (count < input_event_size())
> +		return -EINVAL;
not very likely there'll be applications doing short reads to get just part of the structure

> +
> +try_again:
>  	if (udev->state != UIST_CREATED)
>  		return -ENODEV;
>  
> @@ -490,6 +494,8 @@ static ssize_t uinput_read(struct file *file, char __user *buffer, size_t count,
>  
>   out:
>  	mutex_unlock(&udev->mutex);
> +	if (!retval)
> +		goto try_again;
>  
>  	return retval;
>  }
Acked-by: Aristeu Rozanski <aris@ruivo.org>

-- 
Aristeu

