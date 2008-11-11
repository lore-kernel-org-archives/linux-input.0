From: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Subject: USB hid blocks USB port in 2.6.28rc3
Date: Tue, 11 Nov 2008 01:31:17 +0100
Message-ID: <20081111003117.GA10904@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


Hi,

I have a box here which has a couple of USB devices connected.
That includes several HID devices (keyboards, mouse) and a couple
of others including a USB powerswitch driven through a user space
program.

Now what happened is that I changed some of the HID devices
around (moving from a direct port to a hub) and also moved
the USB power switch from one port to another. But after that
the power switch didn't work anymore, just giving a flood 
of

usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1

(sispm is the user space driver)

Kernel is 2.6.28-rc3

Relevant messages from the kernel log (relatively long because
there is a longer history):

...
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xe8304400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00004080
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00004060
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00004040
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: setting latency timer to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00004020
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
...
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
...
usb 2-1: new low speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) as /class/input/input2
generic-usb 0003:045E:0039.0001: input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb-0000:00:1d.0-1/input0
usb 2-2: new low speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
input: Silitek Standard USB Keyboard  as /class/input/input3
generic-usb 0003:047B:0011.0002: input: USB HID v1.00 Keyboard [Silitek Standard USB Keyboard ] on usb-0000:00:1d.0-2/input0
usb 3-1: new low speed USB device using uhci_hcd and address 2
/home/lsrc/linux-2.6.28-rc3/drivers/hid/usbhid/hid-core.c: couldn't find an input interrupt endpoint
...
usb 1-5: new high speed USB device using ehci_hcd and address 5
usb 1-5: configuration #1 chosen from 1 choice
usb-storage: probe of 1-5:1.0 failed with error -5
usb-storage: probe of 1-5:1.1 failed with error -5
usb-storage: probe of 1-5:1.2 failed with error -1
usb-storage: probe of 1-5:1.3 failed with error -1
usbcore: registered new interface driver usbserial
USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial Driver core
USB Serial support registered for GSM modem (1-port)
option 1-5:1.0: GSM modem (1-port) converter detected
usb 1-5: GSM modem (1-port) converter now attached to ttyUSB0
option 1-5:1.1: GSM modem (1-port) converter detected
usb 1-5: GSM modem (1-port) converter now attached to ttyUSB1
usbcore: registered new interface driver option
option: v0.7.2:USB Driver for GSM modems
...
usb 1-5: USB disconnect, address 5
option 1-5:1.0: device disconnected
option 1-5:1.1: device disconnected
option1 ttyUSB0: GSM modem (1-port) converter now disconnected from ttyUSB0
option1 ttyUSB1: GSM modem (1-port) converter now disconnected from ttyUSB1
usb 1-5: new high speed USB device using ehci_hcd and address 6
usb 1-5: configuration #1 chosen from 1 choice
usb-storage: probe of 1-5:1.0 failed with error -1
usb 1-5: USB disconnect, address 6
usb 1-5: new high speed USB device using ehci_hcd and address 7
usb 1-5: configuration #1 chosen from 1 choice
usb-storage: probe of 1-5:1.0 failed with error -5
option 1-5:1.0: GSM modem (1-port) converter detected
usb 1-5: GSM modem (1-port) converter now attached to ttyUSB0
usb-storage: probe of 1-5:1.1 failed with error -5
option 1-5:1.1: GSM modem (1-port) converter detected
usb 1-5: GSM modem (1-port) converter now attached to ttyUSB1
usb-storage: probe of 1-5:1.2 failed with error -1
usb-storage: probe of 1-5:1.3 failed with error -1
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
usb 1-4: new high speed USB device using ehci_hcd and address 8
usb 1-4: configuration #1 chosen from 1 choice
hub 1-4:1.0: USB hub found
hub 1-4:1.0: 4 ports detected
usb 2-1: USB disconnect, address 2
usb 1-4: reset high speed USB device using ehci_hcd and address 8
usb 1-4.2: new low speed USB device using ehci_hcd and address 9
usb 1-4.2: configuration #1 chosen from 1 choice
input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) as /class/input/input4
generic-usb 0003:045E:0039.0004: input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb-0000:00:1d.7-4.2/input0
usb 2-2: USB disconnect, address 3
usb 1-4.3: new low speed USB device using ehci_hcd and address 10
usb 1-4.3: configuration #1 chosen from 1 choice
input: Silitek Standard USB Keyboard  as /class/input/input5
generic-usb 0003:047B:0011.0005: input: USB HID v1.00 Keyboard [Silitek Standard USB Keyboard ] on usb-0000:00:1d.7-4.3/input0
usb 1-4.1: new full speed USB device using ehci_hcd and address 11
usb 1-4.1: configuration #1 chosen from 1 choice
usblp0: USB Bidirectional printer dev 11 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0C17
usbcore: registered new interface driver usblp
usb 1-6: new high speed USB device using ehci_hcd and address 12
usb 1-6: configuration #1 chosen from 1 choice
scsi16 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 12
usb-storage: waiting for device to settle before scanning
scsi 16:0:0:0: Direct-Access     CBM      Flash Disk       4.00 PQ: 0 ANSI: 2
sd 16:0:0:0: [sdc] 255231 512-byte hardware sectors: (130 MB/124 MiB)
sd 16:0:0:0: [sdc] Write Protect is off
sd 16:0:0:0: [sdc] Mode Sense: 00 00 00 00
sd 16:0:0:0: [sdc] Assuming drive cache: write through
sd 16:0:0:0: [sdc] 255231 512-byte hardware sectors: (130 MB/124 MiB)
sd 16:0:0:0: [sdc] Write Protect is off
sd 16:0:0:0: [sdc] Mode Sense: 00 00 00 00
sd 16:0:0:0: [sdc] Assuming drive cache: write through
 sdc: sdc1
sd 16:0:0:0: [sdc] Attached SCSI removable disk
sd 16:0:0:0: Attached scsi generic sg3 type 0
usb-storage: device scan complete
usb 1-6: USB disconnect, address 12
usb 1-5: USB disconnect, address 7
option1 ttyUSB0: GSM modem (1-port) converter now disconnected from ttyUSB0
option 1-5:1.0: device disconnected
option 1-5:1.1: device disconnected
option1 ttyUSB1: GSM modem (1-port) converter now disconnected from ttyUSB1
usb 1-5: new high speed USB device using ehci_hcd and address 13
usb 1-5: configuration #1 chosen from 1 choice
usb-storage: probe of 1-5:1.0 failed with error -1
usb 1-5: USB disconnect, address 13
usb 1-5: new high speed USB device using ehci_hcd and address 14
usb 1-5: configuration #1 chosen from 1 choice
usb-storage: probe of 1-5:1.0 failed with error -5
option 1-5:1.0: GSM modem (1-port) converter detected
usb 1-5: GSM modem (1-port) converter now attached to ttyUSB0
usb-storage: probe of 1-5:1.1 failed with error -5
option 1-5:1.1: GSM modem (1-port) converter detected
usb 1-5: GSM modem (1-port) converter now attached to ttyUSB1
usb-storage: probe of 1-5:1.2 failed with error -1
usb-storage: probe of 1-5:1.3 failed with error -1
usb 1-4.1: USB disconnect, address 11
usblp0: removed
usb 1-4.1: new full speed USB device using ehci_hcd and address 15
usb 1-4.1: configuration #1 chosen from 1 choice
usblp0: USB Bidirectional printer dev 15 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0C17
usb 3-1: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 3-1: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 3-1: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 3-1: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 3-1: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 3-1: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 3-1: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 3-1: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 3-1: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 3-1: USB disconnect, address 2
usb 1-4: USB disconnect, address 8
usb 1-4.1: USB disconnect, address 15
usblp0: removed
usb 1-4.2: USB disconnect, address 9
usb 1-4.3: USB disconnect, address 10
usb 2-2: new low speed USB device using uhci_hcd and address 4
usb 2-2: configuration #1 chosen from 1 choice
/home/lsrc/linux-2.6.28-rc3/drivers/hid/usbhid/hid-core.c: couldn't find an input interrupt endpoint
usb 1-4: new high speed USB device using ehci_hcd and address 17
usb 1-4: configuration #1 chosen from 1 choice
hub 1-4:1.0: USB hub found
hub 1-4:1.0: 4 ports detected
usb 1-4.1: new full speed USB device using ehci_hcd and address 18
usb 1-4.1: configuration #1 chosen from 1 choice
usblp0: USB Bidirectional printer dev 18 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0C17
usb 1-4.2: new low speed USB device using ehci_hcd and address 19
usb 1-4.2: configuration #1 chosen from 1 choice
input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) as /class/input/input6
generic-usb 0003:045E:0039.0007: input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb-0000:00:1d.7-4.2/input0
usb 1-4.3: new low speed USB device using ehci_hcd and address 20
usb 1-4.3: configuration #1 chosen from 1 choice
input: Silitek Standard USB Keyboard  as /class/input/input7
generic-usb 0003:047B:0011.0008: input: USB HID v1.00 Keyboard [Silitek Standard USB Keyboard ] on usb-0000:00:1d.7-4.3/input0
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 1-4: USB disconnect, address 17
usb 1-4.1: USB disconnect, address 18
usblp0: removed
usb 1-4.2: USB disconnect, address 19
usb 1-4.3: USB disconnect, address 20
usb 1-4: new high speed USB device using ehci_hcd and address 21
usb 1-4: configuration #1 chosen from 1 choice
hub 1-4:1.0: USB hub found
hub 1-4:1.0: 4 ports detected
usb 1-4.1: new full speed USB device using ehci_hcd and address 22
usb 1-4.1: configuration #1 chosen from 1 choice
usblp0: USB Bidirectional printer dev 22 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0C17
usb 1-4.2: new low speed USB device using ehci_hcd and address 23
usb 1-4.2: configuration #1 chosen from 1 choice
input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) as /class/input/input8
generic-usb 0003:045E:0039.0009: input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb-0000:00:1d.7-4.2/input0
usb 1-4.3: new low speed USB device using ehci_hcd and address 24
usb 1-4.3: configuration #1 chosen from 1 choice
input: Silitek Standard USB Keyboard  as /class/input/input9
generic-usb 0003:047B:0011.000A: input: USB HID v1.00 Keyboard [Silitek Standard USB Keyboard ] on usb-0000:00:1d.7-4.3/input0
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
hub 1-4:1.0: port 1 disabled by hub (EMI?), re-enabling...
usb 1-4.1: USB disconnect, address 22
usblp0: removed
usb 1-4.1: new full speed USB device using ehci_hcd and address 25
usb 1-4.1: configuration #1 chosen from 1 choice
usblp0: USB Bidirectional printer dev 25 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0C17
usb 4-2: new low speed USB device using uhci_hcd and address 2
usb 4-2: configuration #1 chosen from 1 choice
input: CHESEN USB Keyboard as /class/input/input10
generic-usb 0003:0A81:0103.000B: input: USB HID v1.10 Keyboard [CHESEN USB Keyboard] on usb-0000:00:1d.2-2/input0
input: CHESEN USB Keyboard as /class/input/input11
generic-usb 0003:0A81:0103.000C: input: USB HID v1.10 Mouse [CHESEN USB Keyboard] on usb-0000:00:1d.2-2/input1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: USB disconnect, address 4
usb 2-2: new low speed USB device using uhci_hcd and address 5
usb 2-2: configuration #1 chosen from 1 choice
/home/lsrc/linux-2.6.28-rc3/drivers/hid/usbhid/hid-core.c: couldn't find an input interrupt endpoint
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
usb 2-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1
... more messages like this ....

-Andi

-- 
ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
