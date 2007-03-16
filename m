From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Linux-usb-users] reset low speed USB device using uhci_hcd
 (fwd)
Date: Fri, 16 Mar 2007 09:56:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0703160953100.3349-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Claas Langbehn <claas@rootdir.de>
List-Id: linux-input@vger.kernel.org

Take a look at the message below.  It turned out that the USB errors went 
away when Claas removed a USB extension cable, but that doesn't explain 
the peculiar keyboard-mouse interaction -- especially since it's a PS/2 
keyboard.  Any ideas?

Alan Stern

---------- Forwarded message ----------
Date: Fri, 16 Mar 2007 10:43:22 +0100
From: Claas Langbehn <claas@rootdir.de>
To: linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] reset low speed USB device using uhci_hcd

Hello,

I've got the same problem. I get this message a lot in dmesg:
usb 2-2: reset low speed USB device using uhci_hcd and address 3

$ lsusb
Bus 003 Device 001: ID 0000:0000 
Bus 002 Device 003: ID 046d:c001 Logitech, Inc. N48/M-BB48 [FirstMouse Plus]
Bus 002 Device 002: ID 03f0:0317 Hewlett-Packard LaserJet 1200
Bus 002 Device 001: ID 0000:0000 
Bus 004 Device 001: ID 0000:0000 
Bus 001 Device 001: ID 0000:0000

I already recompiled my kernel to not use CONFIG_PREEMPT_NONE=y, but that
did not help.

My mainboard is a VIA EPIA-EX15000G with the CX700M2 chipset, see:
$ lspci | grep USB
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 90)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 90)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 90)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90)

$ dmesg | grep -i USB
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
usb 2-2: new low speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 
alt 1 proto 2 vid 0x03F0 pid 0x0317
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usbcore: registered new interface driver hiddev
input: USB HID v1.00 Mouse [Logitech] on usb-0000:00:10.1-2
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usb 2-2: reset low speed USB device using uhci_hcd and address 3
usb 2-2: reset low speed USB device using uhci_hcd and address 3 (this 
message is repeated a lot of times!)


Another problem I have is:
When pressing and releasing a key, the computer 
<http://forums.viaarena.com/messageview.aspx?catid=28&threadid=76926&enterthread=y#> 
does not realize the key release and therefore the key is repeated until 
I press a key again. That's very annoying. My keyboard is connected 
using PS/2. I know it's not USB, but I read that Gordon Messmer has the 
same problems, so maybe mentioning it may be useful.


I am using kernel 2.6.21-rc3 with 
x86_64-mm-add-an-option-for-the-via-c7-which-sets-appropriate-l1-cache.patch.

I am going to post usbmon outputs with a second email (after a reboot)


Claas

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page^join.php&p^sourceforge&CID^DEVDEV
_______________________________________________
Linux-usb-users@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-users
