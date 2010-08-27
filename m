From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: HID Belkin lockup with 2.6.36-rc2
Date: Fri, 27 Aug 2010 16:40:03 -0700
Message-ID: <20100827164003.7758354e@nehalam>
References: <20100827163134.7db49039@s6510>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:50026 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893Ab0H0XkH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Aug 2010 19:40:07 -0400
In-Reply-To: <20100827163134.7db49039@s6510>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

On Fri, 27 Aug 2010 16:31:34 -0700
Stephen Hemminger <shemminger@vyatta.com> wrote:

> A couple times now with my cheap Belkin Flip KVM, the system
> has appeared to freeze after changing back.
> 
> Today, I managed to get in over network connection and discovered
> that everything was fine, except no input was coming in (mouse/keyboard).
> Doing rmmod/modprobe on hid_belkin cleared the problem.
> 
> This is new in 2.6.36, haven't seen it in previous releases.

Possibly useful console log.

Aug 27 15:52:49 nehalam kernel: [91228.896344] usb 2-1.1: USB disconnect, address 9
Aug 27 15:52:50 nehalam kernel: [91229.324487] usb 2-1.1: new low speed USB device using ehci_hcd and address 12
Aug 27 15:52:50 nehalam kernel: [91229.444224] input: Belkin Corporation Flip CC as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input12
Aug 27 15:52:50 nehalam kernel: [91229.444489] belkin 0003:050D:3201.000A: input,hiddev0,hidraw0: USB HID v1.10 Device [Belkin Corporation Flip CC] on usb-0000:00:1d.7-1.1/input0
Aug 27 15:52:50 nehalam kernel: [91229.664115] usb 2-1.4: USB disconnect, address 10
Aug 27 15:52:50 nehalam kernel: [91229.920046] usb 2-1.3: USB disconnect, address 11
Aug 27 15:53:24 nehalam kernel: [91263.700573] usb 2-1.1: USB disconnect, address 12
Aug 27 15:53:24 nehalam kernel: [91263.936407] usb 2-1.1: new low speed USB device using ehci_hcd and address 13
Aug 27 15:53:25 nehalam kernel: [91264.054076] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input13
Aug 27 15:53:25 nehalam kernel: [91264.054281] generic-usb 0003:050D:0102.000B: input,hidraw0: USB HID v1.10 Mouse [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input0
Aug 27 15:53:25 nehalam kernel: [91264.058187] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.1/input/input14
Aug 27 15:53:25 nehalam kernel: [91264.058347] generic-usb 0003:050D:0102.000C: input,hidraw1: USB HID v1.10 Keyboard [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input1
Aug 27 15:53:25 nehalam kernel: [91264.412294] usb 2-1.4: new low speed USB device using ehci_hcd and address 14
Aug 27 15:53:25 nehalam kernel: [91264.544111] input: Key Tronic Keytronic USB Keyboard as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.4/2-1.4:1.0/input/input15
Aug 27 15:53:25 nehalam kernel: [91264.544306] generic-usb 0003:03F9:0100.000D: input,hidraw2: USB HID v1.10 Keyboard [Key Tronic Keytronic USB Keyboard] on usb-0000:00:1d.7-1.4/input0
Aug 27 15:53:25 nehalam kernel: [91264.924064] usb 2-1.3: new low speed USB device using ehci_hcd and address 15
Aug 27 15:53:26 nehalam kernel: [91265.023743] input: Kensington      USB/PS2 Wheel Mouse as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.3/2-1.3:1.0/input/input16
Aug 27 15:53:26 nehalam kernel: [91265.024013] generic-usb 0003:047D:1029.000E: input,hidraw3: USB HID v1.10 Mouse [Kensington      USB/PS2 Wheel Mouse] on usb-0000:00:1d.7-1.3/input0
Aug 27 16:03:29 nehalam kernel: [91868.424547] usb 2-1.1: USB disconnect, address 13
Aug 27 16:03:29 nehalam kernel: [91868.770041] usb 2-1.1: new low speed USB device using ehci_hcd and address 16
Aug 27 16:03:30 nehalam kernel: [91868.873869] input: Belkin Corporation Flip CC as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input17
Aug 27 16:03:30 nehalam kernel: [91868.874213] belkin 0003:050D:3201.000F: input,hiddev0,hidraw0: USB HID v1.10 Device [Belkin Corporation Flip CC] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:03:30 nehalam kernel: [91869.192286] usb 2-1.4: USB disconnect, address 14
Aug 27 16:03:30 nehalam kernel: [91869.448163] usb 2-1.3: USB disconnect, address 15
Aug 27 16:14:39 nehalam kernel: [92537.894681] usb 2-1.1: USB disconnect, address 16
Aug 27 16:15:15 nehalam kernel: [92573.724727] usb 2-1.1: new low speed USB device using ehci_hcd and address 17
Aug 27 16:15:23 nehalam kernel: [92581.545944] input: Belkin Corporation Flip CC as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input18
Aug 27 16:15:23 nehalam kernel: [92581.546147] belkin 0003:050D:3201.0010: input,hiddev0,hidraw0: USB HID v1.10 Device [Belkin Corporation Flip CC] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:16:14 nehalam kernel: [92632.070921] usb 2-1.1: USB disconnect, address 17
Aug 27 16:16:35 nehalam kernel: [92654.340903] usb 2-1.1: new low speed USB device using ehci_hcd and address 18
Aug 27 16:16:37 nehalam kernel: [92656.360075] input: Belkin Corporation Flip CC as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input19
Aug 27 16:16:37 nehalam kernel: [92656.360421] belkin 0003:050D:3201.0011: input,hiddev0,hidraw0: USB HID v1.10 Device [Belkin Corporation Flip CC] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:27:10 nehalam kernel: [93289.125634] input: Belkin Corporation Flip CC as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input20
Aug 27 16:27:10 nehalam kernel: [93289.125978] belkin 0003:050D:3201.0011: input,hiddev0,hidraw0: USB HID v1.10 Device [Belkin Corporation Flip CC] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:27:12 nehalam kernel: [93291.048453] usb 2-1.1: USB disconnect, address 18
Aug 27 16:27:12 nehalam kernel: [93291.287128] usb 2-1.1: new low speed USB device using ehci_hcd and address 19
Aug 27 16:27:13 nehalam kernel: [93291.404719] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input21
Aug 27 16:27:13 nehalam kernel: [93291.404922] generic-usb 0003:050D:0102.0012: input,hidraw0: USB HID v1.10 Mouse [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:27:13 nehalam kernel: [93291.408658] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.1/input/input22
Aug 27 16:27:13 nehalam kernel: [93291.408812] generic-usb 0003:050D:0102.0013: input,hidraw1: USB HID v1.10 Keyboard [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input1
Aug 27 16:27:13 nehalam kernel: [93291.758944] usb 2-1.4: new low speed USB device using ehci_hcd and address 20
Aug 27 16:27:13 nehalam kernel: [93291.891222] input: Key Tronic Keytronic USB Keyboard as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.4/2-1.4:1.0/input/input23
Aug 27 16:27:13 nehalam kernel: [93291.891395] generic-usb 0003:03F9:0100.0014: input,hidraw2: USB HID v1.10 Keyboard [Key Tronic Keytronic USB Keyboard] on usb-0000:00:1d.7-1.4/input0
Aug 27 16:27:13 nehalam kernel: [93292.270773] usb 2-1.3: new low speed USB device using ehci_hcd and address 21
Aug 27 16:27:14 nehalam kernel: [93292.370679] input: Kensington      USB/PS2 Wheel Mouse as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.3/2-1.3:1.0/input/input24
Aug 27 16:27:14 nehalam kernel: [93292.370888] generic-usb 0003:047D:1029.0015: input,hidraw3: USB HID v1.10 Mouse [Kensington      USB/PS2 Wheel Mouse] on usb-0000:00:1d.7-1.3/input0
Aug 27 16:27:20 nehalam kernel: [93299.237654] usb 2-1.1: USB disconnect, address 19
Aug 27 16:27:21 nehalam kernel: [93299.624309] usb 2-1.1: new low speed USB device using ehci_hcd and address 22
Aug 27 16:27:21 nehalam kernel: [93299.743608] input: Belkin Corporation Flip CC as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input25
Aug 27 16:27:21 nehalam kernel: [93299.743872] belkin 0003:050D:3201.0016: input,hiddev0,hidraw0: USB HID v1.10 Device [Belkin Corporation Flip CC] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:27:21 nehalam kernel: [93300.005392] usb 2-1.4: USB disconnect, address 20
Aug 27 16:27:21 nehalam kernel: [93300.261414] usb 2-1.3: USB disconnect, address 21
Aug 27 16:31:45 nehalam kernel: [93564.108302] usb 2-1.1: USB disconnect, address 22
Aug 27 16:31:46 nehalam kernel: [93564.348230] usb 2-1.1: new low speed USB device using ehci_hcd and address 23
Aug 27 16:31:46 nehalam kernel: [93564.465987] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input26
Aug 27 16:31:46 nehalam kernel: [93564.466191] generic-usb 0003:050D:0102.0017: input,hidraw0: USB HID v1.10 Mouse [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:31:46 nehalam kernel: [93564.469935] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.1/input/input27
Aug 27 16:31:46 nehalam kernel: [93564.470093] generic-usb 0003:050D:0102.0018: input,hidraw1: USB HID v1.10 Keyboard [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input1
Aug 27 16:31:46 nehalam kernel: [93565.075984] usb 2-1.4: new low speed USB device using ehci_hcd and address 24
Aug 27 16:31:47 nehalam kernel: [93565.208298] input: Key Tronic Keytronic USB Keyboard as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.4/2-1.4:1.0/input/input28
Aug 27 16:31:47 nehalam kernel: [93565.208512] generic-usb 0003:03F9:0100.0019: input,hidraw2: USB HID v1.10 Keyboard [Key Tronic Keytronic USB Keyboard] on usb-0000:00:1d.7-1.4/input0
Aug 27 16:31:47 nehalam kernel: [93565.407865] usb 2-1.3: new low speed USB device using ehci_hcd and address 25
Aug 27 16:31:47 nehalam kernel: [93565.523747] input: Kensington      USB/PS2 Wheel Mouse as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.3/2-1.3:1.0/input/input29
Aug 27 16:31:47 nehalam kernel: [93565.524026] generic-usb 0003:047D:1029.001A: input,hidraw3: USB HID v1.10 Mouse [Kensington      USB/PS2 Wheel Mouse] on usb-0000:00:1d.7-1.3/input0
Aug 27 16:33:32 nehalam kernel: [93671.080207] usb 2-1.1: USB disconnect, address 23
Aug 27 16:33:33 nehalam kernel: [93671.459073] usb 2-1.1: new low speed USB device using ehci_hcd and address 26
Aug 27 16:33:33 nehalam kernel: [93671.578337] input: Belkin Corporation Flip CC as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input30
Aug 27 16:33:33 nehalam kernel: [93671.578601] belkin 0003:050D:3201.001B: input,hiddev0,hidraw0: USB HID v1.10 Device [Belkin Corporation Flip CC] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:33:33 nehalam kernel: [93671.591965] usb 2-1.4: USB disconnect, address 24
Aug 27 16:33:33 nehalam kernel: [93672.103988] usb 2-1.3: USB disconnect, address 25
Aug 27 16:33:43 nehalam kernel: [93681.572639] usb 2-1.1: USB disconnect, address 26
Aug 27 16:33:43 nehalam kernel: [93681.839450] usb 2-1.1: new low speed USB device using ehci_hcd and address 27
Aug 27 16:33:43 nehalam kernel: [93681.957369] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input31
Aug 27 16:33:43 nehalam kernel: [93681.957570] generic-usb 0003:050D:0102.001C: input,hidraw0: USB HID v1.10 Mouse [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:33:43 nehalam kernel: [93681.961781] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.1/input/input32
Aug 27 16:33:43 nehalam kernel: [93681.961940] generic-usb 0003:050D:0102.001D: input,hidraw1: USB HID v1.10 Keyboard [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input1
Aug 27 16:33:44 nehalam kernel: [93682.539179] usb 2-1.4: new low speed USB device using ehci_hcd and address 28
Aug 27 16:33:44 nehalam kernel: [93682.671645] input: Key Tronic Keytronic USB Keyboard as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.4/2-1.4:1.0/input/input33
Aug 27 16:33:44 nehalam kernel: [93682.671813] generic-usb 0003:03F9:0100.001E: input,hidraw2: USB HID v1.10 Keyboard [Key Tronic Keytronic USB Keyboard] on usb-0000:00:1d.7-1.4/input0
Aug 27 16:33:44 nehalam kernel: [93682.871099] usb 2-1.3: new low speed USB device using ehci_hcd and address 29
Aug 27 16:33:44 nehalam kernel: [93682.970598] input: Kensington      USB/PS2 Wheel Mouse as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.3/2-1.3:1.0/input/input34
Aug 27 16:33:44 nehalam kernel: [93682.970852] generic-usb 0003:047D:1029.001F: input,hidraw3: USB HID v1.10 Mouse [Kensington      USB/PS2 Wheel Mouse] on usb-0000:00:1d.7-1.3/input0
Aug 27 16:36:57 nehalam kernel: [93875.299285] usb 2-1.1: USB disconnect, address 27
Aug 27 16:36:57 nehalam kernel: [93875.596023] usb 2-1.1: new low speed USB device using ehci_hcd and address 30
Aug 27 16:36:57 nehalam kernel: [93875.699396] input: Belkin Corporation Flip CC as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input35
Aug 27 16:36:57 nehalam kernel: [93875.699731] belkin 0003:050D:3201.0020: input,hiddev0,hidraw0: USB HID v1.10 Device [Belkin Corporation Flip CC] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:36:57 nehalam kernel: [93875.811053] usb 2-1.4: USB disconnect, address 28
Aug 27 16:36:58 nehalam kernel: [93876.322902] usb 2-1.3: USB disconnect, address 29
Aug 27 16:37:40 nehalam kernel: [93918.548652] usb 2-1.1: USB disconnect, address 30
Aug 27 16:37:40 nehalam kernel: [93918.777112] usb 2-1.1: new low speed USB device using ehci_hcd and address 31
Aug 27 16:37:40 nehalam kernel: [93918.894976] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.0/input/input36
Aug 27 16:37:40 nehalam kernel: [93918.895179] generic-usb 0003:050D:0102.0021: input,hidraw0: USB HID v1.10 Mouse [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input0
Aug 27 16:37:40 nehalam kernel: [93918.899028] input: Belkin Corporation Flip KVM as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.1/2-1.1:1.1/input/input37
Aug 27 16:37:40 nehalam kernel: [93918.899184] generic-usb 0003:050D:0102.0022: input,hidraw1: USB HID v1.10 Keyboard [Belkin Corporation Flip KVM] on usb-0000:00:1d.7-1.1/input1
Aug 27 16:37:41 nehalam kernel: [93919.512834] usb 2-1.4: new low speed USB device using ehci_hcd and address 32
Aug 27 16:37:41 nehalam kernel: [93919.644817] input: Key Tronic Keytronic USB Keyboard as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.4/2-1.4:1.0/input/input38
Aug 27 16:37:41 nehalam kernel: [93919.645010] generic-usb 0003:03F9:0100.0023: input,hidraw2: USB HID v1.10 Keyboard [Key Tronic Keytronic USB Keyboard] on usb-0000:00:1d.7-1.4/input0
Aug 27 16:37:41 nehalam kernel: [93919.856748] usb 2-1.3: new low speed USB device using ehci_hcd and address 33
Aug 27 16:37:41 nehalam kernel: [93919.972665] input: Kensington      USB/PS2 Wheel Mouse as /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1.3/2-1.3:1.0/input/input39
Aug 27 16:37:41 nehalam kernel: [93919.972878] generic-usb 0003:047D:1029.0024: input,hidraw3: USB HID v1.10 Mouse [Kensington      USB/PS2 Wheel Mouse] on usb-0000:00:1d.7-1.3/input0
