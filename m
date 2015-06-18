From: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] HID: support i2c write-read and large transfers in hid-cp2112
Date: Thu, 18 Jun 2015 15:44:31 +0800
Message-ID: <CAAj6DX3aFvTdaE8GTh3YvFsnadbtszkyeArnFCuuhbtQnGu9kw@mail.gmail.com>
References: <1434183990-2324-1-git-send-email-ellen@cumulusnetworks.com>
	<CAAj6DX0w2p0h_wS2_T2+kU-zLEDo+adCmosPaUHWPVJeEpsaTw@mail.gmail.com>
	<55821717.2000609@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55821717.2000609-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 18, 2015 at 8:55 AM, Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org> wrote:
> ...
>
> Since the the long-read fix is less controversial, I've split it out and
> sent it as a separate patch.

Hi Ellen,

got it, will check soon

> As for repeated start, it's not that easy for me to check it.  The chip is
> in a rack-mounted network switch.  However, if you really want me to verify
> it, I can pull the box out and hook it up on a bench.
>
> The Silabs datasheet clearly states that the device is supposed to issue a
> repeated start (rev 1.2,
> http://www.silabs.com/Support%20Documents/TechnicalDocs/CP2112.pdf, figure 8
> on page 15).
>
> Is your chip an older rev?  Mine is rev 2 (but as you said, there would have
> been an erratum if they fixed a hardware bug).
>
> usb 1-1.2.3: New USB device found, idVendor=10c4, idProduct=ea90
> usb 1-1.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-1.2.3: Product: CP2112 HID USB-to-SMBus Bridge
> usb 1-1.2.3: Manufacturer: Silicon Laboratories
> usb 1-1.2.3: SerialNumber: 00343E9A
> cp2112 0003:10C4:EA90.0001: hidraw0: USB HID v1.01 Device [Silicon
> Laboratories
>  CP2112 HID USB-to-SMBus Bridge] on usb-0000:00:16.0-1.2.3/input0
> cp2112 0003:10C4:EA90.0001: Part Number: 0x0C Device Version: 0x02

Mine is rev 1 !!!
Found also that in the datasheet chapter 12 reports the differences
between the two revisions.
In 12.1 it states that revision 1 does not implement repeated start. Perfect!
I will try to replace my device with a newer one.
In mean time, feel free to send the patch for write-read. I will check
and test it ignoring the lack of repeated start on my obsolete HW.

Thanks,
Antonio
