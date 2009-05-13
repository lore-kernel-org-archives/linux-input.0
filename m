From: Mohamed Ikbel Boulabiar <boulabiar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: To add a device support it should be BlackListed ?
Date: Wed, 13 May 2009 19:04:57 +0200
Message-ID: <45cc95260905131004x186e4ff3ga79cc943f63680d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Rafi Rubin <rafi-hkHJxBBPWjbG6jMu9gPlYQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

I am trying with my professor St=E9phane Chatty to add support to a
Stantum multitouch tablet that is a HID device.

We tried copying hid-ntrig.c and applying modification to get
supported but we haven't reached something functional.

Should we add more information to some place to reach our goals ?
I have read this and we maybe need to blacklist the stantum somewhere
(hid-quirks.c ?)

"This patch is required for N-trig support for the Linux Environment.
It requests the USBHID driver to ignore an N-trig device, when
connected to the USB bus."
http://kerneltrap.org/index.php?q=3Dmailarchive/linux-usb/2009/1/20/477=
2014/thread


Is this true ? How should we do it ? And why (because we have at least
3 to 4 other devices from other constructors and we want to add
support) ?


Thanks
______________________________
Mohamed-Ikbel BOULABIAR
=C9l=E8ve Ing=E9nieur ENSI - Tunisie
Stagiaire au LII - ENAC, Toulouse
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
