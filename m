From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Strange regression in hid_llogitech_dj (was: Re: Linux
 5.2-rc4)
Date: Wed, 12 Jun 2019 00:02:21 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906112358580.27227@cbobk.fhfr.pm>
References: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com> <2268131.Lc39eCoc3j@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2268131.Lc39eCoc3j@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 11 Jun 2019, Rafael J. Wysocki wrote:

> I noticed that the cordless mouse used by me with one of the machines here
> stopped to work in 5.2-rc (up to and including the -rc4).
> 
> Bisection turned up commit 74808f9115ce ("HID: logitech-dj: add support for non
> unifying receivers").
> 
> Of course, that commit does not revert cleanly from 5.2-rc4, but I have reverted
> the changes made by it in hid/hid-ids.h and I took the version of hid/hid-logitech-dj.c
> from commit b6aeeddef68d ("HID: logitech-dj: add logi_dj_recv_queue_unknown_work
> helper"), which is the parent of commit 74808f9115ce, and that made the mouse
> work again for me.
> 
> Here's the output of "dmesg | grep -i logitech" from 5.2-rc4 with the above changes:
> 
> [    4.288905] usb 1-2: Manufacturer: Logitech
> [    5.444621] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:046D:C52F.0002/input/input23
> [    5.446960] hid-generic 0003:046D:C52F.0002: input,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-2/input0
> [    5.451265] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C52F.0003/input/input24
> [    5.507545] hid-generic 0003:046D:C52F.0003: input,hiddev96,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-2/input1

Hi Rafael,

0x046d/0xc52f is known to have issues in 5.2-rcX. There is a patch queued 
[1] that is believed to fix all this; my plan is to send it to Linus in 
the coming 1-2 days. If you could report whether it fixes the issues 
you've been seeing yourself as well, it'd be helpful.

Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.2/fixes&id=3ed224e273ac5880eeab4c3043a6b06b0478dd56

-- 
Jiri Kosina
SUSE Labs
