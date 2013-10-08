From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster-A1zFtI14ZBulVyrhU4qvOw@public.gmane.org>
Subject: Re: [PATCH] HID: logitech - lg2ff: Add IDs for Formula Vibration Feedback Wheel
Date: Tue, 08 Oct 2013 12:00:02 +0200
Message-ID: <4607275.ItDsRbK9eM@geidi-prime>
References: <1381164492-27145-1-git-send-email-anssi.hannula@iki.fi> <CADbOyBSry1eFsCycM-BaDEhaA7_+JUBpYZEqA4s5s-g2vq5whg@mail.gmail.com> <fa1af5a9ba814114ddf5ee8fe65b8b4b.squirrel@www.mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fa1af5a9ba814114ddf5ee8fe65b8b4b.squirrel-uf5OtEnyChf6gvvhDbwh+ti2O/JbrIOy@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Cc: Elias Vanderstuyft <elias.vds-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anssi Hannula <anssi.hannula-X3B1VOXEql0@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hey guys,

I assume that we're talking about this wheel (http://www.logitech.com/en-roeu/support/298)?

Does the wheel have an actual FFB servo or does it have just a rumble motor that shakes the wheel? If it's the latter, supporting it in lg2ff is a way to go. Description in KConfig should probably be updated to reflect this.

As for the HID descriptors, Simon's suggestion will work just fine. Alternatively you can use Wireshark which can use usbmon to capture USB traffic. (Wireshark must run as root and usbmon module must be loaded before Wireshark starts). We can hack the descriptor in hid-logitech just like we did it for DFP. If we come across more wheels that need a hacked descriptor, perhaps we should consider handling the raw data ourselves (check out the Wii remote driver for details)...

Michal.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
