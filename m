From: Norbert Veber <nveber@tamariongroup.com>
Subject: Corsair keyboards and the pipe/backslash key
Date: Sun, 23 Feb 2014 19:44:21 -0500
Message-ID: <20140224004421.GA9558@pyre.virge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 24-246-30-130.cable.teksavvy.com ([24.246.30.130]:45124 "EHLO
	pyre.virge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbaBXAwG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 19:52:06 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi,

I'm having a weird issue with both the Corsair K65 and K70 USB
keyboards.  If I release shift before the backslash key when typing a
pipe | character it ends up writing |\\.  In windows it works fine even
though there is no special driver or software that needs to be
installed..

Others have reported the same thing for the corsair K60 and K90 as well,
so it seems to impact their entire keyboard line..  see:

http://forum.corsair.com/v3/showthread.php?t=119654

In the thread above someone posted a patch which ignores the spurious
key release message from the keyboard.  I've tested it and it works
great, but I guess it would cause problems with other brands of
keyboards.  Any idea what the 'propper' fix might be?

It shows up in dmesg like this (kernel 3.12.13):
usb 7-1.3: new full-speed USB device number 18 using ehci-pci
usb 7-1.3: New USB device found, idVendor=1b1c, idProduct=1b09
usb 7-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 7-1.3: Product: Corsair K70R Gaming Keyboard [12900.943155] usb 7-1.3: Manufacturer: Corsair
input: Corsair Corsair K70R Gaming Keyboard as /devices/pci0000:00/0000:00:1a.7/usb7/7-1/7-1.3/7-1.3:1.0/input/input51
hid-generic 0003:1B1C:1B09.0006: input,hidraw0: USB HID v1.11 Keyboard [Corsair Corsair K70R Gaming Keyboard] on usb-0000:00:1a.7-1.3/input0
input: Corsair Corsair K70R Gaming Keyboard as /devices/pci0000:00/0000:00:1a.7/usb7/7-1/7-1.3/7-1.3:1.1/input/input52
hid-generic 0003:1B1C:1B09.0007: input,hidraw2: USB HID v1.11 Device [Corsair Corsair K70R Gaming Keyboard] on usb-0000:00:1a.7-1.3/input1
input: Corsair Corsair K70R Gaming Keyboard as /devices/pci0000:00/0000:00:1a.7/usb7/7-1/7-1.3/7-1.3:1.2/input/input53
hid-generic 0003:1B1C:1B09.0008: input,hidraw3: USB HID v1.11 Keyboard [Corsair Corsair K70R Gaming Keyboard] on usb-0000:00:1a.7-1.3/input2

Below is a copy of 'Beijmn's post in the above forum:

---------------------------------------------------------------------
I purchased a Corsair Vengeance K70B keyboard the other day and noticed
the same issues in Arch Linux. I don't know a lot about the Linux
kernel, HID, or keyboards in general so bear with me.

In HID it seems there is a constant flow of updates for keys informing
if they are pressed or not. All of the keys seem ok but the one
exception is the backslash key. After depressing the key, a message
update is sent saying it was depressed but IMMEDIATELY after another
message is sent saying it is lifted up. It seems backslash is the only
key that does this.

I have whipped up a quick hack for hid-core.c in the linux kernel. All
it does is ignore this message. A more permanent and cleaner solution is
to provide a custom hid-vengeance driver. Posting messes the whole
format up but you get the idea.


--- drivers/hid/hid-core.c 2014-01-19 16:27:37.674829730 -0500
+++ hid-core_patched.c 2014-01-19 16:24:39.992006709 -0500
@@ -1130,6 +1130,14 @@
{
struct hid_driver *hdrv = hid->driver;
int ret;
+ static bool skip = false;
+
+ if (skip) {
+ skip = false;
+ return;
+ }
+ if (usage->code == KEY_BACKSLASH && value == 1)
+ skip = true;

if (!list_empty(&hid->debug_list))
hid_dump_input(hid, usage, value);
---------------------------------------------------------------------

Thanks,

Norbert
