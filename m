From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] HID: let generic driver yield control iff specific
 driver has been enabled (was Re: Two regressions on BYT/T ASUS T100TA
 4.12-rc: #2 Keyboard no longer works)
Date: Tue, 13 Jun 2017 15:41:28 +0200
Message-ID: <20170613134128.GE29589@mail.corp.redhat.com>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
 <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
 <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
 <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm>
 <alpine.LSU.2.20.1706091323270.30709@cbobk.fhfr.pm>
 <05b492e4-5b76-5665-18a8-4ceddb15d220@redhat.com>
 <alpine.LSU.2.20.1706131134380.30709@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1706131134380.30709-YHPUNQjx9ReKbouaWp301Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Jun 13 2017 or thereabouts, Jiri Kosina wrote:
> So I've now pushed the latest version to 'for-4.12/driver-matching-fix' of 
> hid.git, and if no more issues are discovered, I'll push that to Linus 
> this week so that we finally get rid of this long-lasting PITA (while 
> still heading towards 'automatic' proper matching -- Benjamin already had 
> some proposals how to tackle this).

Hi Jiri,

I tried to cook some script that formats the list in the same way than
yours.

I just noticed that you have in CONFIG_HID_CHICONY:
	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
while in v4.12-rc5 it's:
	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
                                                              ^^^^^^^

Rest is almost OK with respect to device/driver allocation:

Also, comparing the raw number of devices, there are 356 devices in
4.12-rc5, and you have 360 in your patch:
- { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL) }
  is added twice (the one in CONFIG_HID_LOGITECH should be dropped IMO).
- { HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_HUION_TABLET) },
  appeared, which is fine according to hid-uclogic.c
- The two bluetooth devices for hid-gfrm.c are legitimate too.

So fixing the extra USB_DEVICE_ID_LOGITECH_G920_WHEEL and the messed up
USB_DEVICE_ID_CHICONY_AK1D should be enough to have it in Linus' tree.

BTW, the merge with your for-next branch is going to be tricky :(

Cheers,
Benjamin

> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
