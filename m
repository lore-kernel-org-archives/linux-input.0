From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] HID: let generic driver yield control iff specific driver
 has been enabled (was Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2
 Keyboard no longer works)
Date: Tue, 13 Jun 2017 12:35:33 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706131134380.30709@cbobk.fhfr.pm>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk> <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org> <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com> <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
 <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm> <alpine.LSU.2.20.1706091323270.30709@cbobk.fhfr.pm> <05b492e4-5b76-5665-18a8-4ceddb15d220@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <05b492e4-5b76-5665-18a8-4ceddb15d220-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 9 Jun 2017, Hans de Goede wrote:

> So I've decided to just go ahead and give this patch a second pair
> of eyes, it is mostly good, but I did find some issues, comments
> inline.

Thanks for all the comments, highly appreciated.

[ ... snipped the ones that have been put into v2 ... ]

> Last (wrt logitech) there is an issue with the logitech ff drivers, hid-lg.h /
> hid-lg4ff.h has the following structure:
> 
> #ifdef CONFIG_LOGITECH_FF
> int lgff_init(struct hid_device *hdev);
> #else
> static inline int lgff_init(struct hid_device *hdev) { return -1; }
> #endif
> 
> Notice the return -1 in the inline stub, this causes lg_probe() to fail,
> I believe this should be changed to return 0 for all 4 ff variants, so
> that things will continue to work without ff.

Hm, I see your point, but this is completely unrelated to this change and 
should eventually be fixed separately.

> Last you seem to be missing the following block (already missing before this
> commit):
> 
> #if IS_ENABLED(CONFIG_HID_GFRM
> 	{ HID_USB_DEVICE(0x58, 0x2000) },
> 	{ HID_USB_DEVICE(0x471, 0x2210) },

I think you meant HID_BLUETOOTH_DEVICE() here.

> #endif
> 
> The following entries get removed without showing up somewhere else:
> 
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_LG, USB_DEVICE_ID_LG_MELFAS_MT) },
> 
> It is the only HID_USB_DEVICE entry (instead of MT_USB_DEVICE) in
> hid-multitouch.c,
> as such it probably belongs in a:

Yeah, my script didn't count with this, thanks a lot for catching it.

> #if IS_ENABLED(CONFIG_HID_MULTITOUCH
> 	{ HID_USB_DEVICE(USB_VENDOR_ID_LG, USB_DEVICE_ID_LG_MELFAS_MT) },
> #endif

So I've now pushed the latest version to 'for-4.12/driver-matching-fix' of 
hid.git, and if no more issues are discovered, I'll push that to Linus 
this week so that we finally get rid of this long-lasting PITA (while 
still heading towards 'automatic' proper matching -- Benjamin already had 
some proposals how to tackle this).

Thanks,

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
