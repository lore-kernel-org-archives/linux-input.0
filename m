From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio_raw - signal EFAULT even if read/write
 partially succeeds
Date: Mon, 30 Apr 2012 09:34:42 -0700
Message-ID: <20120430163442.GA2316@core.coreip.homeip.net>
References: <20120430064450.GA29212@core.coreip.homeip.net>
 <20120430111223.4941a9f0@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61634 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab2D3Qet (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 12:34:49 -0400
Received: by pbbrp8 with SMTP id rp8so3441863pbb.19
        for <linux-input@vger.kernel.org>; Mon, 30 Apr 2012 09:34:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120430111223.4941a9f0@pyramind.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>, Che-Liang Chiou <clchiou@chromium.org>, David Herrmann <dh.herrmann@googlemail.com>

Hi Alan,

On Mon, Apr 30, 2012 at 11:12:23AM +0100, Alan Cox wrote:
> On Sun, 29 Apr 2012 23:44:51 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > When copy_to/from_user fails in the middle of transfer we should not
> > report to the user that read/write partially succeeded but rather
> > report -EFAULT right away, so that application will know that it got
> > its buffers all wrong.
> 
> Actually POSIX/SuS is quite explicit that if a write or read partially
> succeeds you return the partial result. The error will be returned only
> if nothing was written or read, or in some cases can be buffered by the
> code for the next read/write attempt (eg for sockets).

Could you please point me to that particular part of the spec? My
reading of

http://pubs.opengroup.org/onlinepubs/9699919799/functions/read.html

leads me to conclusion that we are only required to report short reads
when interrupted (or don't have enough data) and that severe errors may
be reported at any time:

"Upon successful completion, where nbyte is greater than 0, read() shall
mark for update the last data access timestamp of the file, and shall
return the number of bytes read. This number shall never be greater than
nbyte. The value returned may be less than nbyte if the number of bytes
left in the file is less than nbyte, if the read() request was
interrupted by a signal, or if the file is a pipe or FIFO or special
file and has fewer than nbyte bytes immediately available for reading.
For example, a read() from a file associated with a terminal may return
one typed line of data.

If a read() is interrupted by a signal before it reads any data, it
shall return -1 with errno set to [EINTR].

If a read() is interrupted by a signal after it has successfully read
some data, it shall return the number of bytes read."

> 
> In the wait_event_interruptible() case it's even more important as a
> signal handler and syscall restart needs to do the right thing. Looking
> at the patch it looks like a signal interrupting loses you data with this
> change appplied.

No, it should not as we do not wait for more data once some data is
read.

> The -EFAULT one is a corner case, the signal handlers
> causing data loss one is not.
> 
> EFAULT matters for certain crazy software like persistent storage managers
> which use -EFAULT and segfault/bus error catching to implement full
> persistent storage. Those people may well be somewhat out of their tree.

I do not think persistent storage applicable to character devices, in
particular PS/2 port.

> 
> > -		if (!(file->f_flags & O_NONBLOCK))
> > +		if (!(file->f_flags & O_NONBLOCK)) {
> >  			error = wait_event_interruptible(serio_raw->wait,
> >  					serio_raw->head != serio_raw->tail ||
> >  					serio_raw->dead);
> > -	} while (!error);
> > +			if (error)
> > +				return error;
> 
> And we lose data as far as I can see, so a timer event will cause the app
> to malfunction.

No, we'd only go into wait_event_interruptible() if we haven't read
anything yet so we won't lose any data here.

Thanks.

-- 
Dmitry
