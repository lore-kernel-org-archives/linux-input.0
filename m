From: Pavel Machek <pavel@ucw.cz>
Subject: Re: May close() return any error code?
Date: Sun, 2 Aug 2015 09:42:20 +0200
Message-ID: <20150802074220.GF3720@amd>
References: <s5hr3nrs0kc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47174 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbHBHmW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2015 03:42:22 -0400
Content-Disposition: inline
In-Reply-To: <s5hr3nrs0kc.wl-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Dr. Werner Fink" <werner@suse.de>

On Wed 2015-07-29 12:46:59, Takashi Iwai wrote:
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
>
http://pubs.opengroup.org/onlinepubs/009695399/functions/close.html


Returning an error from close() would imply that file descriptor is
not closed.... seems like bad idea. Just fix the kernel not to do it.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
