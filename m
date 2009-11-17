From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bug #14626] oops on boot starting udev
Date: Mon, 16 Nov 2009 17:14:55 -0800
Message-ID: <20091117011455.GA7977@kroah.com>
References: <GUZt44bIwCE.A.vLF.pSdALB@chimera>
 <xXQGFmujPl.A.fpF.zSdALB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <xXQGFmujPl.A.fpF.zSdALB@chimera>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Soeren Sonnenburg <sonne-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 16, 2009 at 11:37:48PM +0100, Rafael J. Wysocki wrote:
> This message has been generated automatically as a part of a report
> of recent regressions.
> 
> The following bug entry is on the current list of known regressions
> from 2.6.31.  Please verify if it still should be listed and let me know
> (either way).
> 
> 
> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14626
> Subject		: oops on boot starting udev
> Submitter	: Soeren Sonnenburg <sonne-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> Date		: 2009-11-14 10:16 (3 days old)
> References	: http://marc.info/?l=linux-kernel&m=125819380206800&w=4

This looks like an input core problem, as the evdev module was just
loaded and died.

Any input developers have any ideas?

thanks,

greg k-h
