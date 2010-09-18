From: Andreas Bombe <aeb-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: OOPS in hiddev_open on connecting "Logitech MX620 Laser
 Cordless Mouse"
Date: Sat, 18 Sep 2010 15:36:11 +0200
Message-ID: <20100918133610.GA4554@amos.infernal>
References: <AANLkTikOowB=8=3cnJ0QgJNfBsVeMUrkNT0E0uH2LDXL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikOowB=8=3cnJ0QgJNfBsVeMUrkNT0E0uH2LDXL-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Riesen <raa.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 18, 2010 at 11:30:56AM +0200, Alex Riesen wrote:
> Happens with Linus' master at 509344b8b4d365b7ff3bce97198d83a57b7c3f31
> The tree is modified, but I doubt the patches I have can cause this. I attach
> then anyway. They never caused a conflict, so just the patches (in case of doubt
> I can push the tree somewhere).

I can confirm the same Oops on an unpatched kernel from Linus' git
(v2.6.36-rc4-134-g03a7ab0). I have a Logitech G500 mouse.

> The oops is reproducable. lsusb hangs (D state) after the oops.

However on my machine lsusb doesn't hang.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
