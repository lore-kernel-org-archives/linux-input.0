From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] USBHID: Make Boot Protocol drivers depend on EMBEDDED
Date: Sun, 21 Dec 2008 14:02:00 -0800
Message-ID: <20081221140200.40c1fec1.akpm@linux-foundation.org>
References: <f7848160812201911k7988221asd095ce873fd8105f@mail.gmail.com>
	<20081220221253.e09b1b1f.akpm@linux-foundation.org>
	<f7848160812202226w1f930c86vfd17a2b0163bfc56@mail.gmail.com>
	<494E20F7.7050106@gmail.com>
	<f7848160812210717w5e5cc7a2uc5571710f755ec99@mail.gmail.com>
	<alpine.LRH.1.10.0812211824350.11630@twin.jikos.cz>
	<alpine.DEB.2.00.0812211441300.7101@parag-desktop>
	<alpine.LNX.1.10.0812212247090.26265@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.1.10.0812212247090.26265-YCXOAqNspd+N3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Parag Warudkar <parag.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anssi Hannula <anssi.hannula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 21 Dec 2008 22:48:21 +0100 (CET) Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:

> On Sun, 21 Dec 2008, Parag Warudkar wrote:
> 
> > The usbmouse and usbkbd modules are not supposed to be used with regular 
> > USB mice and keyboards. Make them depend on EMBEDDED to prevent them from 
> > being built and loaded on non-EMBEDDED configs.
> > 
> > Signed-off-by: Parag Warudkar <parag.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > diff --git a/drivers/hid/usbhid/Kconfig b/drivers/hid/usbhid/Kconfig
> > index 5d9aa95..4edb3be 100644
> > --- a/drivers/hid/usbhid/Kconfig
> > +++ b/drivers/hid/usbhid/Kconfig
> > @@ -45,7 +45,7 @@ config USB_HIDDEV
> >  	  If unsure, say Y.
> >  
> >  menu "USB HID Boot Protocol drivers"
> > -	depends on USB!=n && USB_HID!=y
> > +	depends on USB!=n && USB_HID!=y && EMBEDDED
> >  
> >  config USB_KBD
> >  	tristate "USB HIDBP Keyboard (simple Boot) support"
> 
> So do I get it right that the only reason of the problem you were seeing 
> was that in the 2.6.27 kernel you have compiled usbhid module, which was 
> then used for driving your mouse,but in 2.6.28-rcX you compiled and used 
> 'usbmouse' instead, and therefore this is not a regression?
> 

Shouldn't usbmouse support two-dimensional mice as well?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
