From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: 2.6.28-rc9: USB Mouse unhappy
Date: Sat, 20 Dec 2008 22:12:53 -0800
Message-ID: <20081220221253.e09b1b1f.akpm@linux-foundation.org>
References: <f7848160812201911k7988221asd095ce873fd8105f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f7848160812201911k7988221asd095ce873fd8105f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Parag Warudkar <parag.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

(cc's added)

On Sat, 20 Dec 2008 22:11:17 -0500 "Parag Warudkar" <parag.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Just installed today's git on my workstation and my Logitech USB Mouse
> only wants to move vertically around the centre of the monitor.
> 
> I have no clue where to look - all  I know is that it works with the
> 2.6.27 and various 2.6.28-rcs prior to this one.
> 
> Parag
> 
> [parag@xw6600 ~]$ diff Xorg.0.log.not.working /var/log/Xorg.0.log |grep Logi
> < (**) Logitech USB Receiver: Device: "/dev/input/event5"
> > (**) Logitech USB Receiver: Device: "/dev/input/event6"
> < (II) config/hal: Adding input device Logitech USB Receiver
> < (**) Logitech USB Receiver: always reports core events
> < (**) Logitech USB Receiver: Device: "/dev/input/event3"
> < (II) Logitech USB Receiver: Found x and y relative axes
> < (II) Logitech USB Receiver: Found mouse buttons
> < (II) Logitech USB Receiver: Configuring as mouse
> < (II) XINPUT: Adding extended input device "Logitech USB Receiver"
> (type: MOUSE)
> > (II) config/hal: Adding input device Logitech USB Receiver
> > (**) Logitech USB Receiver: always reports core events
> > (**) Logitech USB Receiver: Device: "/dev/input/event5"
> > (II) Logitech USB Receiver: Found x and y relative axes
> > (II) Logitech USB Receiver: Found mouse buttons
> > (II) Logitech USB Receiver: Configuring as mouse
> > (II) XINPUT: Adding extended input device "Logitech USB Receiver" (type: MOUSE)

Could be input, could be HID, could even be USB.

You're sure that 2.6.28-rc8 was OK?

2.6.28-rc9 had only a small number of changes.  Nothing I can see in
input or HID.  A few USB changes, but pretty specific ones -
unusual_devs entries and such.

Maybe your mouse has died?  Did you retest with an older kernel?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
