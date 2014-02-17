From: Daniel J Blueman <daniel-JCXMqzvhRcvYtjvyW6yDsg@public.gmane.org>
Subject: USB keyboard occasional key stuck
Date: Mon, 17 Feb 2014 21:23:25 +0800
Message-ID: <CAMVG2ss9nA4zcOT3c47EwEMrR7Z_gAQU-HTYGjdWcdYzihSnbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Across 5+ years of kernels, I've been seeing occasional (1-2 times per
day) key-stuck issues where eg a fn+delete combo repeats delete until
I press delete again. I've seen this happen with fn+ctrl+left, leaving
left held and likewise with right.

This has occurred on Apple laptops, external USB keyboards and Dell
laptops, so seems like a linux USB input issue, as I haven't seen
occur on Windows or MacOS on the same hardware.

It seems a good move for me to rebuild and run a kernel with some USB
HID instrumentation to locate this issue over time. Without apriori
knowledge of the linux USB input stack, what is a good initial
approach?

Thanks,
  Daniel
-- 
Daniel J Blueman
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
