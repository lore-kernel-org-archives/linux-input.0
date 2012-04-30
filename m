From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Input: serio_raw - signal EFAULT even if read/write
 partially succeeds
Date: Mon, 30 Apr 2012 11:12:23 +0100
Message-ID: <20120430111223.4941a9f0@pyramind.ukuu.org.uk>
References: <20120430064450.GA29212@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53155 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152Ab2D3KJu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 06:09:50 -0400
In-Reply-To: <20120430064450.GA29212@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>, Che-Liang Chiou <clchiou@chromium.org>, David Herrmann <dh.herrmann@googlemail.com>

On Sun, 29 Apr 2012 23:44:51 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> When copy_to/from_user fails in the middle of transfer we should not
> report to the user that read/write partially succeeded but rather
> report -EFAULT right away, so that application will know that it got
> its buffers all wrong.

Actually POSIX/SuS is quite explicit that if a write or read partially
succeeds you return the partial result. The error will be returned only
if nothing was written or read, or in some cases can be buffered by the
code for the next read/write attempt (eg for sockets).

In the wait_event_interruptible() case it's even more important as a
signal handler and syscall restart needs to do the right thing. Looking
at the patch it looks like a signal interrupting loses you data with this
change appplied. The -EFAULT one is a corner case, the signal handlers
causing data loss one is not.

EFAULT matters for certain crazy software like persistent storage managers
which use -EFAULT and segfault/bus error catching to implement full
persistent storage. Those people may well be somewhat out of their tree.

> -		if (!(file->f_flags & O_NONBLOCK))
> +		if (!(file->f_flags & O_NONBLOCK)) {
>  			error = wait_event_interruptible(serio_raw->wait,
>  					serio_raw->head != serio_raw->tail ||
>  					serio_raw->dead);
> -	} while (!error);
> +			if (error)
> +				return error;

And we lose data as far as I can see, so a timer event will cause the app
to malfunction.

Alan
