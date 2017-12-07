From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: add quirk for another PIXART OEM mouse used by
 HP
Date: Thu, 7 Dec 2017 11:09:11 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1712071109020.3572@cbobk.fhfr.pm>
References: <20171201121934.GA3352@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171201121934.GA3352@dhcp-128-65.nay.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <dyoung@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 1 Dec 2017, Dave Young wrote:

> This mouse keep disconnecting in runleve 3 like below, add it needs the
> quirk to mute the anoying messages.
> 
> [  111.230555] usb 2-2: USB disconnect, device number 6
> [  112.718156] usb 2-2: new low-speed USB device number 7 using xhci_hcd
> [  112.941594] usb 2-2: New USB device found, idVendor=03f0, idProduct=094a
> [  112.984866] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [  113.027731] usb 2-2: Product: HP USB Optical Mouse
> [  113.069977] usb 2-2: Manufacturer: PixArt
> [  113.113500] input: PixArt HP USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/0003:03F0:094A.0002/input/input14
> [  113.156787] hid-generic 0003:03F0:094A.0002: input: USB HID v1.11 Mouse [PixArt HP USB Optical Mouse] on usb-0000:00:14.0-2/input0
> [  173.262642] usb 2-2: USB disconnect, device number 7
> [  174.750244] usb 2-2: new low-speed USB device number 8 using xhci_hcd
> [  174.935740] usb 2-2: New USB device found, idVendor=03f0, idProduct=094a
> [  174.990435] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [  175.014984] usb 2-2: Product: HP USB Optical Mouse
> [  175.037886] usb 2-2: Manufacturer: PixArt
> [  175.061794] input: PixArt HP USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/0003:03F0:094A.0003/input/input15
> [  175.084946] hid-generic 0003:03F0:094A.0003: input: USB HID v1.11 Mouse [PixArt HP USB Optical Mouse] on usb-0000:00:14.0-2/input0

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
