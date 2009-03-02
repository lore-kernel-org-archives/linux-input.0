From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: PATCH [1/3] drivers/input/xpad.c: Improve Xbox 360 wireless
	support and add sysfs interface
Date: Mon, 2 Mar 2009 14:39:16 -0800
Message-ID: <20090302223916.GA31381@kroah.com>
References: <5aa163d00902282053h38b0febbyb37fc30855fdc985@mail.gmail.com> <20090302130425.23cc628d.akpm@linux-foundation.org> <20090302211820.GA21489@kroah.com> <20090302133551.1266f725.akpm@linux-foundation.org> <5aa163d00903021359x3a4693f5tbb7f1e3fec4d88b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5aa163d00903021359x3a4693f5tbb7f1e3fec4d88b8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 02, 2009 at 04:59:48PM -0500, Mike Murphy wrote:
> As I was coding this interface, I found myself wishing for a
> macro-based system like module parameters have. For example, it would
> be nice to be able to do something like the following:
> 
> DECLARE_SYSFS_INTERFACE(&xpad->dead_zone, uint, &check_dead_zone);
> 
> which would create the needed show/store functions that worked with an
> unsigned int. The check_dead_zone function would be a validator
> function inside the module that would check the validity on a
> user-supplied value on store (in this case, to be sure it was at least
> 1024 below the stick limit) and return an error code if the value were
> out of range. Yes, the validator would be an extra function call, but
> this code doesn't run in an interrupt context, so the benefit of being
> able to centralize the functionality and simplify drivers might be
> worth the extra overhead.

I tried to create such an interface years ago, and the macro tricks
involved ended up being horrible, and in the end, it didn't work.  But
if you can come up with something, I'd love to see it.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
