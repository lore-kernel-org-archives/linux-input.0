From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: May close() return any error code?
Date: Wed, 29 Jul 2015 07:45:11 -0700
Message-ID: <20150729144511.GA11233@dtor-ws>
References: <s5hr3nrs0kc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hr3nrs0kc.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Dr. Werner Fink" <werner@suse.de>
List-Id: linux-input@vger.kernel.org

HI Takashi,

On Wed, Jul 29, 2015 at 12:46:59PM +0200, Takashi Iwai wrote:
> Hi,
> 
> while debugging a problem of X and gdm with the old systemd-210, we
> encountered a sudden death of systemd-logind, and this turned out to
> be an unexpected errno from close().  The close() call for input
> devices returns ENODEV error.  The logind in systemd-210 treats this
> error code as fatal, triggers assert() and eventually kills itself.
> The details are found in an openSUSE bugzilla thread:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=939571
> 
> This seems coming from evdev_flush().  As there is no fd leak, it's no
> big problem per se.  But, now the question is whether returning such
> an error code is correct behavior at all.  At least, it doesn't seem
> defined in POSIX:
>   http://pubs.opengroup.org/onlinepubs/009695399/functions/close.html

Hmm, if I checked the right version of the code close_nointr_nofail()
expects only 0 as the return code so even if we change the kernel to
use more conforming -EIO instead of -ENODEV systemd will still die...

The question is whether we really need to propagate return value from
f_op->flush() up to userspace in filp_close(). Why don't we ask Al?

Thanks.

-- 
Dmitry
