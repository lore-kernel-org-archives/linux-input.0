From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 2/2] Input: uinput: Avoid returning 0 on read()
Date: Fri, 30 Mar 2012 23:00:33 -0700
Message-ID: <20120331060033.GA12307@core.coreip.homeip.net>
References: <1333023245-13704-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61244 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2CaGAp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 02:00:45 -0400
Received: by pbcun15 with SMTP id un15so2606064pbc.19
        for <linux-input@vger.kernel.org>; Fri, 30 Mar 2012 23:00:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333023245-13704-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, aris@ruivo.org

Hi David,

On Thu, Mar 29, 2012 at 02:14:04PM +0200, David Herrmann wrote:
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
> Acked-by: Aristeu Rozanski <aris@ruivo.org>
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

I agree that we should return -EINVAL when buffer is too small. I
however do not like the whole "try_again" business; I think it is
perfectly fine to return 0 for blocking reads, we just want to return
-EAGAIN for nonblocking.

I changed around your patches a bit and will post them shortly.

Aristeu, since the patches changed somewhat I dropped your Acked-by so
please Ack the patches you are comfortable with again.

Thanks.

-- 
Dmitry
