From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: May close() return any error code?
Date: Sun, 2 Aug 2015 15:07:06 +0100
Message-ID: <20150802140706.GD17109@ZenIV.linux.org.uk>
References: <s5hr3nrs0kc.wl-tiwai@suse.de>
 <20150729144511.GA11233@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51170 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbHBOHI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2015 10:07:08 -0400
Content-Disposition: inline
In-Reply-To: <20150729144511.GA11233@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Dr. Werner Fink" <werner@suse.de>

On Wed, Jul 29, 2015 at 07:45:11AM -0700, Dmitry Torokhov wrote:
> > This seems coming from evdev_flush().  As there is no fd leak, it's no
> > big problem per se.  But, now the question is whether returning such
> > an error code is correct behavior at all.  At least, it doesn't seem
> > defined in POSIX:
> >   http://pubs.opengroup.org/onlinepubs/009695399/functions/close.html
> 
> Hmm, if I checked the right version of the code close_nointr_nofail()
> expects only 0 as the return code so even if we change the kernel to
> use more conforming -EIO instead of -ENODEV systemd will still die...
> 
> The question is whether we really need to propagate return value from
> f_op->flush() up to userspace in filp_close(). Why don't we ask Al?

That's the whole damn point of having ->flush().  And yes, we do need that -
things like NFS (not to mention tapes, etc.) do rely on that.

Whether it makes sense to do this kind of "do something that might have
a failure to report on each close()" for evdev is up to driver, obviously.
