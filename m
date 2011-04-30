From: "Adi J. Sieker" <adi@sieker.io>
Subject: USB keyboard recognized as HID keyboard but doesn't work
Date: Sat, 30 Apr 2011 22:23:05 +0200
Message-ID: <4DBC6FA9.3080008@sieker.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

the lovely folks from #kernelnewbies suggested I write this mail since 
they are at a loss.
I recently got a new USB keyboard which works fine in the BIOS and also 
in VBox Windows guests, but not on the host.

The keyboard is a Keysonic KSK-8003 UX product details here: 
http://maxpoint.de/de/products/keyboards.php?pid=1_3_7&we_objectID=1220

The menu key and the backspace keys do work. The num lock led is on, 
though I can't switch num lock off.
If I attch the keyboard to a VirtualBox VM running WindowsXP as a guest, 
it works as expected in the VM.

I'm running 2.6.32-27-generic #49-Ubuntu. I tried the Ubuntu 10.10 
LiveCD and that also didn't work. I haven't tried 11.04 yet though.

The output of lsusb -v  is available here http://pastie.org/1851416

The relevant part of dmesg output:
[    6.501902] input: KB USB Keyboard as 
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3:1.0/input/input9
[    6.502028] generic-usb 0003:060B:0230.0001: input,hidraw0: USB HID 
v1.10 Keyboard [KB USB Keyboard] on usb-0000:00:1d.0-1.3/input0
[    6.503408] Bluetooth: Generic Bluetooth USB driver ver 0.6
[    6.503508] usbcore: registered new interface driver btusb
[    6.516681] generic-usb: probe of 0003:060B:0230.0002 failed with 
error -22

I'd be grateful for any help and or pointers in the right to get this 
keyboard to work.

Regards
    Adi
