From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input/joystick: add driver fortius 1942
Date: Thu, 19 Mar 2009 15:39:54 +0200
Message-ID: <20090319133953.GB18295@scadufax.research.nokia.com>
References: <739e73230903190651w4fff7aaen818a42540ffbdc8d@mail.gmail.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <739e73230903190651w4fff7aaen818a42540ffbdc8d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Peta Blaha <blahapeta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 19, 2009 at 02:51:07PM +0100, ext Peta Blaha wrote:
> Driver for Fortius 1942 device.
> 
> Signed-off-by: Petr Blaha <blahapeta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

It's not that long. you can send it to the list.

It also makes our life easier when trying to comment on the patch. Just
run scripts/checkpatch.pl --strict on your patch file before sending it
and solve any issues reported by that tool.

Also, that Signed-off-by line is not needed in the driver itself.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
