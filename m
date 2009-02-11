From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: dead USB devices after resume [mmotm 2009-02-10-16-35]
Date: Wed, 11 Feb 2009 10:53:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902111009260.3056-100000@iolanthe.rowland.org>
References: <49928FDB.5020007@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49928FDB.5020007-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 11 Feb 2009, Jiri Slaby wrote:

> On 02/11/2009 01:36 AM, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> > The mm-of-the-moment snapshot 2009-02-10-16-35 has been uploaded
> 
> Hi,
> 
> when I resume from suspend, USB mouse and kbd are not responding anymore, no
> LEDs, nothing. I need to unplug and replug to get it working. This is a
> regression since mmotm based on 2.6.29-rc2 which is fine.
> 
> Any ideas before I start bisection?

In theory the lack of S4 support shouldn't cause this to happen.

You might want to build a kernel with CONFIG_USB_DEBUG enabled.  The 
extra debugging information should help find the problem.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
