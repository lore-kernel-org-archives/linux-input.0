From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Fri, 14 Nov 2014 10:17:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411141008020.1043-100000@iolanthe.rowland.org>
References: <CANLzEksHgo_tQiwJoUtXd0iV7tDXq0ieNrAXgtXwPtxxPBWrgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANLzEksHgo_tQiwJoUtXd0iV7tDXq0ieNrAXgtXwPtxxPBWrgw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sameer Nanda <snanda-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 13 Nov 2014, Benson Leung wrote:

> Hi Alan,
> 
> On Thu, Nov 13, 2014 at 2:11 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> > Wait a minute -- in your previous email you said this approach didn't
> > work.  So does it work or doesn't it?
> 
> Sorry for the confusion. The approach *does* work.
> 
> That was actually my original idea to fix the problem, but I saw other
> places in the kernel where it was done with a get/put.

The reason for the get/put is to force a call to autosuspend_check().  
But in this case, if killing the interrupt URB causes 
autosuspend_check() to run then the get/put isn't needed.

On the other hand, I don't see why killing the interrupt URB would 
cause autosuspend_check() to run.  Can you explain that?

Alan Stern



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
