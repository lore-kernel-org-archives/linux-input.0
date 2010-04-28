From: Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Actual code fixing Sixaxis
Date: Thu, 29 Apr 2010 00:05:37 +0100
Message-ID: <l2u54bbe4e01004281605l85d02f71l2023db70d04927fd@mail.gmail.com>
References: <1272318628.3269.44.camel@zony.bied.prout.be>
	 <1272361924.17421.6787.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272361924.17421.6787.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 27 April 2010 10:52, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org> wrote:
> Separate the sixaxis changes from the hid core changes.
Sixaxis changes does not mean anything without the ability to modify
the descriptor ... but sure if it helps I can separate them.

> Add a documentation file for that, don't put it in the commit log.
The documentation will need to grow for some time:
https://code.google.com/p/ghid/
https://code.google.com/p/ghid/wiki/HowTo

> Won't that trigger udev's firmware code and popup PackageKit's firmware
> downloader for each and every HID device?
I do not use this, but the solution is probably to ask PackageKit' to
ignore firmware/hid/ requests

> Can't this be done for the BT one as well, rather than requiring a
> modified firmware? (although the firmware hack could be useful as a
> debugging tool).
Sixaxis has broken HID report description(firmware?) and the only
solution to fix this is to replace it, replacing firmware works for BT
or USB devices in the same way (and sixaxis has got both descriptors
broken) (well the other way is to write a dedicated driver mirroring
the code from the general case)

The main advantage of modifying HidRD is the kernel itself does all
translations, thus it is possible to reconfigure the device by simply
changing the descriptor.
How to actually modify the descriptor? Some info and tools are on
https://code.google.com/p/ghid/ and the rest on the
http://www.usb.org/developers/hidpage/
