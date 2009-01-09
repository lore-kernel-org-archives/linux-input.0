From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: 2.6.28-rc9: USB Mouse unhappy
Date: Sat, 10 Jan 2009 00:19:06 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901100014450.5377@jikos.suse.cz>
References: <f7848160812201911k7988221asd095ce873fd8105f@mail.gmail.com> <alpine.LRH.1.10.0812211824350.11630@twin.jikos.cz> <alpine.LRH.1.10.0812211939170.11630@twin.jikos.cz> <200901100011.35332.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200901100011.35332.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Parag Warudkar <parag.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anssi Hannula <anssi.hannula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 10 Jan 2009, Rafael J. Wysocki wrote:

> > >   usbmouse on 2.6.28-rc with the exact same mouse? (either check 
> > >   /sys/bus/usb/devices or even lsusb shouldn't ideally show usbmouse 
> > >   loaded at all)
> > Sorry for the above typo, 'lsusb' should of course be 'lsmod' here.
> Can you tell me what the status of this issue is, please?

Parag was using incorrect driver -- usbmouse -- (which is intended to be 
used only under very special circumstances) instead of standard HID 
driver.

Kconfig help text clearly states how special the usbmouse driver is, but 
many people still try to use it, probably because of its name. Therefore 
we now have

Author: Parag Warudkar <parag.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date:   Mon Dec 22 22:50:52 2008 +0100

    HID: make boot protocol drivers depend on EMBEDDED

which is already in Linus tree and which makes the possibility of chosing 
this special driver dependent on CONFIG_EMBEDDED.

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
