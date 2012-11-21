From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Wed, 21 Nov 2012 14:36:33 +0100
Message-ID: <50ACD8E1.8030001@gmail.com>
References: <8159607.SRZZrRIPNF@orthese> <CAN+gG=Ho7c6B27B5Lqo2T-qKT8PQH1Xr+kLVnr1nCOStPatfqA@mail.gmail.com> <2539870.ZuUQxCIqZO@orthese>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53038 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab2KUNgm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 08:36:42 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2923289bkw.19
        for <linux-input@vger.kernel.org>; Wed, 21 Nov 2012 05:36:40 -0800 (PST)
In-Reply-To: <2539870.ZuUQxCIqZO@orthese>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan-Matthias Braun <jan_braun@gmx.net>
Cc: linux-input@vger.kernel.org

Hi Jan-Matthias,

On 11/21/2012 10:33 AM, Jan-Matthias Braun wrote:
> Hi Benjamin,
> 
> thanks for looking into the issue.
> 
> Am Dienstag, 20. November 2012, 13:47:23 schrieben Sie:
>> Hi Jan-Matthias,
>>
>> On Mon, Nov 19, 2012 at 12:58 PM, Jan-Matthias Braun <jan_braun@gmx.net> wrote:
>>> Dear List,
>>>
>>> using the current (Linux v2.6.7) hid-multitouch driver I have the problem, that the touchscreen works fine after a fresh boot, but after a suspend the touchscreen does not come back to live and I am asking for assistance to get this working. As I can reproduce this problem on a standard tty device without X (see below) I am suspecting a driver problem, but I might as well be wrong.
>>
>> I assume you are talking about v3.6.7...
> 
> You are right, of course. Sorry for the distraction.
> 
>>> The device in question is the Touchscreen of a Dell Inspron Duo convertable, a USB device with id 0eef:725e (D-WAV Scientific Co., Ltd), found and registered as an input device by the kernel as
>>> [    6.931638] usb 4-1: Manufacturer: eGalax Inc.
>>> [   16.186272] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input/input10
>>> [   16.187162] hid-multitouch 0003:0EEF:725E.0001: input,hiddev0,hidraw0: USB HID v2.10 Pointer
>>>                   [eGalax Inc. USB TouchController] on usb-0000:00:1d.2-1/input0
>>>
>>> I have tested the behaviour with and without X11. Without X11 I was using a standard tty and using cat on the input device.
>>> After boot the input device gives lot of output while touching the screen, after resume the device stays silent.
>>
>> strange. I have tested the procedure with the eGalax 0x72FA I got, and
>> I'm not seeing this problem on a 3.6 kernel.
>>
>> Is the config symbol CONFIG_PM set to "y" in your .config file?
> 
> Yes.
> 
>> Also, can you try to rmmod / modprobe hid-multitouch when the device
>> is not responding and see if this solves things.
> 
> This is not working for me. On modprobe the Kernel log says
> 
> [12537.335946] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input
> /input13
> [12537.336875] hid-multitouch 0003:0EEF:725E.0001: input,hiddev0,hidraw0: USB HID v2.10 Pointer [eGalax Inc. USB TouchController] on usb-0000:00:1d.2-1/input0
> 
> but /dev/input/event13 is not created. To be honest, I don't even know, if it should be created.

no, the input13 here has nothing to do with the device node /dev/input/eventX

> What happens is, that /dev/input/event10 vanishes on removal of the hid-multitouch module and then reappears after modprobe. But a cat on it wont show a reaction while touching the screen's surface.

the event10 vanishing is normal, you removed the driver, so the device is not here outside of the kernel.
When you modprobe, it's back!
However events should come from this node.

> 
>>> I have this problem since moving to hid-multitouch for handling this device.
>>
>> What kind of driver did you use before?
> 
> I think, there was a separate usb touchscreen driver for egalax devices before something like kernel version 3.2. This one I used. Long story short: I have never used the vendor supplied drivers, but those coming with the kernel.

Ok, so either you must have patched hid-egalax to handle your device, either you used an other usb driver (it would be great if you can find out which).
The weird thing is that hid-egalax does not do anything at resume, so I doubt we should look there.

Anyway, can you try the following patch which is already include in the next 3.7 release?

Cheers,
Benjamin

>From 4e3265da686f6ff4b02fcba4c124c4af51265375 Mon Sep 17 00:00:00 2001
From: Scott Liu <scott.liu@emc.com.tw>
Date: Wed, 15 Aug 2012 17:21:55 +0800
Subject: [PATCH] HID: multitouch: Add ELAN production request when resume.

Add ELAN production request when resume.

Some Elan legacy devices require SET_IDLE to be set on resume.
It should be safe to send it to other devices too.
Tested on 3M, Stantum, Cypress, Zytronic, eGalax, and Elan panels.

Suggested by Benjamin Tissoires <benjamin.tissoires@enac.fr>

Signed-off-by: Scott Liu <scott.liu@emc.com.tw>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-multitouch.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 59c8b5c..e824c37 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -767,6 +767,32 @@ static int mt_reset_resume(struct hid_device *hdev)
 	mt_set_input_mode(hdev);
 	return 0;
 }
+
+static int mt_resume(struct hid_device *hdev)
+{
+	struct usb_interface *intf;
+	struct usb_host_interface *interface;
+	struct usb_device *dev;
+
+	if (hdev->bus != BUS_USB)
+		return 0;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	interface = intf->cur_altsetting;
+	dev = hid_to_usb_dev(hdev);
+
+	/* Some Elan legacy devices require SET_IDLE to be set on resume.
+	 * It should be safe to send it to other devices too.
+	 * Tested on 3M, Stantum, Cypress, Zytronic, eGalax, and Elan panels. */
+
+	usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			HID_REQ_SET_IDLE,
+			USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			0, interface->desc.bInterfaceNumber,
+			NULL, 0, USB_CTRL_SET_TIMEOUT);
+
+	return 0;
+}
 #endif
 
 static void mt_remove(struct hid_device *hdev)
@@ -1092,6 +1118,7 @@ static struct hid_driver mt_driver = {
 	.event = mt_event,
 #ifdef CONFIG_PM
 	.reset_resume = mt_reset_resume,
+	.resume = mt_resume,
 #endif
 };
 
-- 
1.8.0

