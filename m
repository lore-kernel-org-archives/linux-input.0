From: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work
 in xorg or gpm
Date: Sun, 6 May 2012 00:14:29 -0300
Message-ID: <20120506031428.GA20044@hugoo.com.ar>
References: <20120503052000.GC15205@burratino>
 <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from customer-static-210-108-249.iplannetworks.net ([190.210.108.249]:42169
	"EHLO hyperion.ubertech.com.ar" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752857Ab2EFDOc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 5 May 2012 23:14:32 -0400
Content-Disposition: inline
In-Reply-To: <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

Hi,

I apologize for not replying to the last e-mail and replying to an older one instead, I seem to have lost the last couple. :(

Before I begin, let me say I downloaded the kernel sources only a few hours after your previous message, but the patch did not apply (I'm not sure why; I got a "corrupt patch" error).
I applied the changes manually.

Here's the dmesg I got:

[69237.004750] usbcore: deregistering interface driver usbhid
[69243.219600] hid: hid_debug is now used solely for parser and driver debugging.
[69243.219608] debugfs is now used for inspecting the device (report descriptor, reports)
[69350.013383] hid: hid_debug is now used solely for parser and driver debugging.
[69350.013390] debugfs is now used for inspecting the device (report descriptor, reports)
[69358.971680] usbcore: registered new interface driver usbhid
[69358.971692] usbhid: USB HID core driver
<Mouse receiver was plugged in at this point.  Mouse was off.>
[69358.973309] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: Logitech-DJ:logi_dj_init
[69381.670037] usb 4-1: new full-speed USB device number 5 using ohci_hcd
[69381.892043] usb 4-1: New USB device found, idVendor=046d, idProduct=c52b
[69381.892054] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[69381.892060] usb 4-1: Product: USB Receiver
[69381.892065] usb 4-1: Manufacturer: Logitech
[69381.898155] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0
[69381.898311] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 0
[69381.898321] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 0
[69381.898440] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 1
[69381.898537] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 1
[69381.898546] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 1
[69381.898651] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 2
[69381.898750] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 2
[69381.904988] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x1001 wIndex=0x0200 wLength=1792
[69381.907044] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x1101 wIndex=0x0200 wLength=5120
[69381.908029] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x2001 wIndex=0x0200 wLength=3840
[69381.909028] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x2101 wIndex=0x0200 wLength=8192
[69381.911438] logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0001:10:1b.1-1/input2
[69381.918070] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69381.918124] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: delayedwork_callback
[69381.918135] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_recv_add_djhid_device: device list is empty
[69381.920069] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69381.920119] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: delayedwork_callback
[69381.920297] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_ll_parse
[69381.920308] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_ll_start
<Mouse was turned on at this point.>
[69381.920430] logitech-djdevice 0003:046D:C52B.0004: hidraw1: USB HID v1.11 Device [Logitech Unifying Device. Wireless PID:101a] on usb-0001:10:1b.1-1:1
[69395.230032] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.782013] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.782030] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-core.c: undefined report_id 0 received
[69395.782039] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: hid_input_report error
[69395.806001] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.806016] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-core.c: undefined report_id 0 received
[69395.806025] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: hid_input_report error
[69395.813994] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.814009] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-core.c: undefined report_id 0 received
[69395.814017] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: hid_input_report error
[69395.821990] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.822004] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-core.c: undefined report_id 0 received
[69395.822012] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: hid_input_report error
[69395.829989] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.830003] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-core.c: undefined report_id 0 received
[69395.830012] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: hid_input_report error
[69395.837988] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.838002] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-core.c: undefined report_id 0 received
[69395.838011] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: hid_input_report error
[69395.845989] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.846003] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-core.c: undefined report_id 0 received
[69395.846011] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: hid_input_report error
[69395.853990] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.854004] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-core.c: undefined report_id 0 received
[69395.854013] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: hid_input_report error
[69395.861992] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[69395.862006] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-core.c: undefined report_id 0 received
[69395.862014] /build/buildd-linux-2.6_3.3.4-1~experimental.1-powerpc-atUZTv/linux-2.6-3.3.4/debian/build/source_powerpc_none/drivers/hid/hid-logitech-dj.c: hid_input_report error


Here's the capture of the pairing event.
I found four devices in /sys/kernel/debug/hid/, so I tried each one until I found one that produced output upon pairing the mouse.

# mount -t debugfs debugfs /sys/kernel/debug
# ls /sys/kernel/debug/hid/
0003:046D:C52B.0001  0003:046D:C52B.0002  0003:046D:C52B.0003  0003:046D:C52B.0004
# modprobe -r hid_logitech_dj
# modprobe hid_logitech_dj
# cat /sys/kernel/debug/hid/0003\:046D\:C52B.0003/events > events.captured03

I tried all four, because I wasn't sure which one I should cat (/sys/kernel/debug/hid/0003\:046D\:C52B.000{1,2,3,4}/events).
The devices ending in 1,2 and 4 didn't show any output anything.
Reading from 0003:046D:C52B.0003 resulted in the following

<Mouse turned on at this point>
report (size 15) (numbered) =  20 01 42 00 00 00 00 00 00 00 00 00 00 00 00
<Mouse turned off at this point>
report (size 15) (numbered) =  20 01 42 01 00 00 00 00 00 00 00 00 00 00 00
<EOF>

The devices ending in 0003 and 0004 both showed plenty of output when moving the mouse around.

Just in case there any doubt; this was all on the powerpc machine.
Do you need me to rebuild the kernel with that patch and retry on amd64 as well?

Thanks,

Hugo
