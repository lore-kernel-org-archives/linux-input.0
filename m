From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: AM335x touchscreen issues
Date: Tue, 26 May 2015 13:11:57 -0500
Message-ID: <20150526181157.GA8009@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org, bgriffis-l0cyMroinI0@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Greetings,

I have been porting Linux to a new AM3554 based SoM and have found issues
with the touchscreen reporting touch releases repeatedly to userspace
without actually touching the screen when running ts_calibrate, ts_test
or other graphical touchscreen applications.

This started happening after updating pulling recent changes.

It has also been confirmed to be happening on the beagle bone black:
http://www.spinics.net/lists/linux-iio/msg18580.html

If you look further into this thread you will see a workaround patch that
I came up with:
http://www.spinics.net/lists/linux-iio/msg18583.html

Though this fix stops the reported events in userspace, interrupts are
still occuring repeatedly.

Does anyone have any suggestions beyond what I have done to remedy this
issue?

Regards,

Michael
