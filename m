From: Peter Wu <lekensteyn@gmail.com>
Subject: Re: [PATCH 1/2] Revert "Revert "HID: Fix logitech-dj: missing Unifying device issue""
Date: Mon, 12 Aug 2013 23:54:40 +0200
Message-ID: <2324751.QaRpZppUQy@al>
References: <1374153691-25100-1-git-send-email-nlopezcasad@logitech.com> <51E84FD1.4050400@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51E84FD1.4050400@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, jkosina@suse.cz, benjamin.tissoires@gmail.com, adlr@chromium.org, joseph.salisbury@canonical.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sarah Sharp <sarah.a.sharp@linux.intel.com>, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday 18 July 2013 16:28:01 Peter Hurley wrote:
> Before we revert to using the workaround, I'd like to suggest that
> this new "hidden" problem may be an interaction with the xhci_hcd host
> controller driver only.
> 
> Looking at the related bug, the OP indicates the machine only has
> USB3 ports. Additionally, comments #7, #100, and #104 of the original
> bug report add additional information that would seem to confirm
> this suspicion.
> 
> Let me add I have this USB device running on the uhci_hcd driver
> with or without this workaround on v3.10.

This problem does not seem specific to xhci, uhci seems also effected. Today I 
upgraded a system (running Arch Linux) from kernel 3.9.9 to 3.10.5. After a 
reboot to 3.10.5, things broke. The setup:

- There are two USB receivers plugged into USB 1.1 ports (different buses 
according to lsusb, uhci), each receiver is paired to a K360 keyboard.
- One of the receivers are passed to a QEMU guest with -usbdevice host:$busid.
$devid. This keyboard is working (probably because QEMU performed a reset).
- Since 3.10.5, the keyboard that is *not* passed to the QEMU guest is not 
functioning on reboot.

After closing the QEMU guest, the USB bus gets reset(?) after which the other 
keyboard suddenly gets detected. I had only booted 3.10.5 twice before rolling 
back to 3.9.9, both boots triggered the issue. Do I need to provide a usbmon, 
lsusb, dmesg and/ or other details from 3.10.5?


Note that there are other Arch Linux users who have reported issues[1][2] 
since upgrading to 3.10.z. Triggering a re-enumeration by writing the magic 
HID++ message[3] makes the paired devices appear again (as reported in 
forums[1], I haven't tried this on the affected UHCI machine).

While the underlying bug is fixed, can this patch be forwarded to stable? I see 
that 3.10.6 has been released, but still without this patch.

Regards,
Peter

 [1]: https://bbs.archlinux.org/viewtopic.php?id=167210
 [2]: https://bugs.archlinux.org/task/35991
 [3]: https://bbs.archlinux.org/viewtopic.php?pid=1309535#p1309535
