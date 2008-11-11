From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: cleanup of hiddev
Date: Wed, 12 Nov 2008 00:53:10 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811120050160.24889@jikos.suse.cz>
References: <200811051252.40133.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:43586 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751902AbYKKXxM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 18:53:12 -0500
In-Reply-To: <200811051252.40133.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 5 Nov 2008, Oliver Neukum wrote:

> this, I think, fixes everything.

Thanks a lot for working on this, Oliver. Could you please add a proper
changelog, describing all the changes that had been done and why they were
needed, so that this can be queued for 2.6.29?

>  				schedule();
> +				if (mutex_lock_interruptible(&list->thread_lock))
> +					return -ERESTARTSYS;

Is ERESTARTSYS really appropriate here? Tail could have already moved from
within other thread, right?

>  	case HIDIOCGSTRING:
> -		return hiddev_ioctl_string(hiddev, cmd, user_arg);
> +		lock_kernel();
> +		if (!hiddev->exist)
> +			r = hiddev_ioctl_string(hiddev, cmd, user_arg);
> +		else
> +			r = -ENODEV;
> +		unlock_kernel();
> +		return r;

Hmm, I know that this is a legacy interface, but I am really hesitant to
add a new synchronization using lock_kernel(), instead of removing it
gradually altogether.

Thanks,

-- 
Jiri Kosina
SUSE Labs
