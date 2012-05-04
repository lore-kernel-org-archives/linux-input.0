From: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Subject: Bug#671292: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does
	not work in xorg or gpm
Date: Thu, 3 May 2012 23:40:55 -0300
Message-ID: <20120504024054.GA19355@hugoo.com.ar>
References: <20120503052000.GC15205@burratino>
 <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120503130821.GB16978@burratino>
 <20120503131356.GC16978@burratino>
Reply-To: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>, 671292@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.671292.B671292.133609926131710@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20120503131356.GC16978@burratino>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org
List-Id: linux-input@vger.kernel.org

Hi,

On 2012.05.03 08:13, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
> 
> > An alternative method would be to boot with "hid.hid_debug=1
> > log_buf_len=2097152" and run dmesg.
> 
> Apparently I can't spell.  An alternative method would be to run with
> "hid.debug=1 log_buf_len=..." or to do
> 
> 	modprobe -r hid-logitech-dj
> 	modprobe -r usbhid
> 	modprobe -r hid
> 	modprobe hid debug=1
> 	modprobe hid-logitech-dj
> 	dmesg
> 
> Sorry for the confusion.

No problem

> Jonathan

Here goes, I'm pretty sure a few of the first lines aren't relevant, but I prefer to send a couple too many instead of a couple to few :)

[ 1244.617478] usb 4-1: USB disconnect, device number 2
[77892.290041] usb 4-1: new full-speed USB device number 3 using ohci_hcd
[77892.512057] usb 4-1: New USB device found, idVendor=046d, idProduct=c52b
[77892.512817] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[77892.513584] usb 4-1: Product: USB Receiver
[77892.514280] usb 4-1: Manufacturer: Logitech
[77892.540356] logitech-djreceiver 0003:046D:C52B.000B: hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0001:10:1b.1-1/input2
[77892.550769] logitech-djdevice 0003:046D:C52B.000C: hidraw1: USB HID v1.11 Device [Logitech Unifying Device. Wireless PID:101a] on usb-0001:10:1b.1-1:1
[77912.356716] usbcore: deregistering interface driver usbhid
[77927.421876] usbcore: registered new interface driver usbhid
[77927.422859] usbhid: USB HID core driver
[77927.461256] logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0001:10:1b.1-1/input2
[77927.473593] logitech-djdevice 0003:046D:C52B.0004: hidraw1: USB HID v1.11 Device [Logitech Unifying Device. Wireless PID:101a] on usb-0001:10:1b.1-1:1
[77985.718533] usbcore: deregistering interface driver usbhid
[77985.843593] hid: hid_debug is now used solely for parser and driver debugging.
[77985.843602] debugfs is now used for inspecting the device (report descriptor, reports)
[77985.890194] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0
[77985.891586] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 1
[77985.893142] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 2
[77985.895398] usbcore: registered new interface driver usbhid
[77985.896491] usbhid: USB HID core driver
[77985.914131] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: Logitech-DJ:logi_dj_init
[77985.914189] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 0
[77985.914198] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 0
[77985.914224] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 1
[77985.914233] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 1
[77985.914250] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 2
[77985.919851] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x1001 wIndex=0x0200 wLength=1792
[77985.921771] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x1101 wIndex=0x0200 wLength=5120
[77985.922775] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x2001 wIndex=0x0200 wLength=3840
[77985.923763] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x2101 wIndex=0x0200 wLength=8192
[77985.927818] logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0001:10:1b.1-1/input2
[77985.937799] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[77985.939796] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[77985.939809] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_recv_queue_notification: did not schedule the work item, was already queued
[77985.942193] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: delayedwork_callback
[77985.942406] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_ll_parse
[77985.942417] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_ll_start
[77985.943226] logitech-djdevice 0003:046D:C52B.0004: hidraw1: USB HID v1.11 Device [Logitech Unifying Device. Wireless PID:101a] on usb-0001:10:1b.1-1:1
[77985.945640] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: delayedwork_callback
[77985.945651] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_recv_add_djhid_device: device list is empty
