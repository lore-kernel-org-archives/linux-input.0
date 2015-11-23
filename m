From: Dmitry Oboukhov <linuxover@gmail.com>
Subject: Macbook 12'' 2015: can't start keyboard
Date: Mon, 23 Nov 2015 19:17:58 +0300
Message-ID: <CAEL52Vr_gaihgXoG8YtqPD-qfenGgpUBjgcryxrcABk+yU8zWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38094 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbbKWQR7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 11:17:59 -0500
Received: by wmec201 with SMTP id c201so112355029wme.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2015 08:17:58 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=108331

I've tried to start linux on Macbook 2015.

But keyboard doesn't work (kernel starts, etc, but local keyboard doesn't work)

/proc/bus/input/devices doesnt contain any keyboard records.

dmesg contains several xhci_hcd timeouts:

dmesg|egrep 'xhci|hub'
[    2.340822] usbcore: registered new interface driver hub
[    2.341882] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.341888] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    2.342962] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
version 0x100 quirks 0x00009810
[    2.342969] xhci_hcd 0000:00:14.0: cache line size of 256 is not supported
[    2.343143] usb usb1: Manufacturer: Linux
4.4.0-rc1unera-next-20151123+ xhci-hcd
[    2.343287] hub 1-0:1.0: USB hub found
[    2.343299] hub 1-0:1.0: 11 ports detected
[    2.343582] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.343587] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    2.343619] usb usb2: Manufacturer: Linux
4.4.0-rc1unera-next-20151123+ xhci-hcd
[    2.343756] hub 2-0:1.0: USB hub found
[    2.343763] hub 2-0:1.0: 4 ports detected
[    2.651787] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    7.559578] xhci_hcd 0000:00:14.0: Command completion event does
not match command
[    7.559584] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
device command
[   12.567382] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
device command
[   12.567394] usb 1-1: hub failed to enable device, error -62
[   17.575183] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
device command
[   17.687152] usb 1-1: new high-speed USB device number 3 using xhci_hcd
[   17.820478] hub 1-1:1.0: USB hub found
[   17.820948] hub 1-1:1.0: 2 ports detected
[   18.095138] usb 1-1.1: new high-speed USB device number 4 using xhci_hcd
[   18.259134] usb 1-1.2: new low-speed USB device number 5 using xhci_hcd


I've seen the patch
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=dbe08116b87cdc2217f11a78b5b70e29068b7efd
It is applied and compiled, but keyboard don't work yet.
Unfortunately I can't find ticket about keyboard and macbook 2015.
