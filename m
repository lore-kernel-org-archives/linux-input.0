From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.4
Date: Thu, 28 Jan 2010 08:24:26 +0100
Message-ID: <20100128072425.GA25633@atrey.karlin.mff.cuni.cz>
References: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu> <201001202219.12058.oliver@neukum.org> <acd6dfcf4391c081f861d430c0b45311.squirrel@intranet.cs.nmsu.edu> <alpine.LNX.2.00.1001251758230.30977@pobox.suse.cz> <8512e098224714ed7d54c62b46346796.squirrel@intranet.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755001Ab0A1HY3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8512e098224714ed7d54c62b46346796.squirrel@intranet.cs.nmsu.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

Hi!

> is because it appears there are two conditions that fb_sys_write() will
> continue on to the copy_from_user() but still return an error code. In
> these cases -EFBIG and -ENOSPEC are returned but it is possible the buffer
> has still been modified.
> 
> Again, like I said, I don't have a problem changing it. If it's wrong,
> it's wrong no matter how many other drivers may take the same
> approach.

I believe it is wrong.

> My intuition tells me it's wrong, but at the same time I'd like to know if
> there's a reason behind the other drivers also ignoring the EFAULT. Or,
> perhaps it simply started in one driver and everyone else patterned after
> it just like I did the g13 driver.

I guess it is indeed a copy&paste problem...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
