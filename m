From: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: not supported hardware: Gigabyte K8100 Aivia USB Gaming Keyboard
Date: Thu, 26 Jan 2012 15:39:40 -0600
Message-ID: <20120126213939.GA5179@burratino>
References: <4D55AE81.3030805@freemail.hu>
 <20120126002100.GA4495@burratino>
 <4F21C49D.2010906@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F21C49D.2010906-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: zitev <zitev-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

zitev wrote:

> Thanks for your respond! I did try to probe again with the latest
> sid kernel (Linux version 3.2.0-1-686-pae (Debian 3.2.1-2)
> (ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org) (gcc version 4.6.2 (Debian 4.6.2-12) ) #1 SMP
> Tue Jan 24 06:09:30 UTC 2012), but the problem's very same.
> What more can I help you?

Here's some context.

Csaba noticed[1] that his keyboard (a "Gigabyte K8100 Aivia USB Gaming
Keyboard") does not work correctly on Linux.  It is claimed by the
usbhid driver and:

> all keys absolutely not working, but led's does light.

When I search for information about Linux support for this keyboard
elsewhere, I see that the backspace key and multimedia keys are said
to work but nothing else[2]:

| papibe	June 4th, 2011, 09:51 PM
|
| Try to see if xev registers an event while pressing the backspace key:
| $ xev
| Regards.
|
| Peckles	June 4th, 2011, 10:07 PM
| Thanks for the command, very useful. Thats going in the memory bank...
|
| The backspace key registers a backspace. Also all of the multimedia
| keys and special 5 mappable keys work as well. (very strange...)

The question becomes: where to go from here?  Any idea about how we
can find out what how to drive this device?  Does it have a driver for
Windows we could investigate?  Is there perhaps some way to trace what
it sends over the wire in order to mock something up?

Csaba, please attach "lsusb -v" output.

Others: hints?

Thanks,
Jonathan

[1] http://bugs.debian.org/610467
[2] http://ubuntuforums.org/archive/index.php/t-1775541.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
