From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Thu, 8 Jun 2017 15:49:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170608203904.73abb5e1-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 8 Jun 2017, Alan Cox wrote:

> > Normally in this situation I'd recommend bisection.  However, this case
> > may be simple enough for a usbmon trace to provide the answer.
> 
> With a shared file system between the T100TA and a big machine it's not
> too hard to do some builds:
> 
> commit 76dd1fbebbaebab294dc09230960238746b883b1

That's "HID: asus: Add support for T100 keyboard", written by Hans de
Goede.

> is the offending commit, but I'm not sure it's a "bug" as such. Without
> this commit my keyboard works without CONFIG_HID_ASUS, with it you need
> the config entry enabled.

And the mouse behaves the same as the keyboard?

> If you grab a default Ubuntu kernel .config and make oldconfig it's off.

So maybe CONFIG_HID_ASUS should default to Y?  I'll leave it up to Hans
to straighten this out.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
