From: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Fri, 18 Dec 2009 00:18:58 +0100
Message-ID: <4B2ABC62.2030600@physik.uni-muenchen.de>
References: <4B26B824.8010403@physik.uni-muenchen.de> <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060302070202090204030003"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:57020 "EHLO
	mail.physik.uni-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751477AbZLQXtg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2009 18:49:36 -0500
In-Reply-To: <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302070202090204030003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Jiri,

I have looked into the problems some more, and have found that the cause
of the crash was a change I made because I misunderstood the code
(LO(cmd) is the number of bytes in in the message, and is not
transferred on USB - i had removed it from the message...)

First, the changes in the normal input, the joystick axis+buttons message:
* Prefix is 0x06 instead of 0x01 (joystick) or 0x03 (gamepad)
* Throttle is not inverted (data[4] instead of 255-data[4])
* Rudder is present and unsigned (not signed, as in iforce)

I have attached a patch that I think fixes this (it works for me :)
Since saitek uses a different protocol byte, this can be done without
adding per-device flags to the driver.

It also adds a button map btn_saitek_cyborg that switches button 1&2 to
make the button number the same as printed on the device, and
abs_saitek_cyborg for a joystick with rudder but only one hat.

The fftest effects seem to work, but some are feeble and feel strange -
I suspect there are some subtle changes, for example I am quite sure
that the Saitek uses signed (twos complement) numbers for effect
strength (this could perhaps explain the 'strange' behavior for 0x80
byte values in the current code)...

Cheers,
Johannes


Jiri Kosina wrote:
> On Mon, 14 Dec 2009, Johannes Ebke wrote:
> 
>> I own a Saitek Cyborg Evo Force which works fine with the HID driver on
>> Linux. However, i could not find a force feedback driver for it, and
>> just adding the USB id and spec to the IForce driver does not work (and
>> crashes the kernel)
> 
> Hi Johannes,
> 
> thanks for your e-mail. I hope you don't mind adding a few relevant CCs.
> 
> First, kernel crashing means that we are probably lacking some error 
> handling in the iforce driver, which we should add if possible. Could you 
> please post the oops message preceeding the crash?
> 
>> After that, I have reverse-engineered the protocol using usb snoops from 
>> a kvm virtual machine with XP on it. Using libusb, I have verified that 
>> I understand the protocol, and it actually looks quite similar to the 
>> iforce protocol (no wonder, it just implements the DirectInput interface 
>> in hardware)
> 
> Good job, thanks a lot for doing this.
> 
>> My question: Would it make sense to adapt the iforce modules to include 
>> this slightly modified protocol (other initialization strings, other 
>> magic bytes) or would it be better to copy & modify?
> 
> It really depends how much different the protocols really are. iforce 
> driver currently doesn't support any per-device flags which would allow 
> for introducing slight differences between individual models.
> 
> Maybe it would help if you could just summarize the most important 
> differences to iforce protocol, so that we could see what aproach would be 
> the best.
> 
> Thanks,
> 

--------------060302070202090204030003
Content-Type: text/x-patch;
 name="saitek.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="saitek.patch"

diff -ru iforce_orig/iforce-main.c iforce/iforce-main.c
--- iforce_orig/iforce-main.c	2009-12-03 04:51:21.000000000 +0100
+++ iforce/iforce-main.c	2009-12-17 23:55:10.000000000 +0100
@@ -35,6 +35,10 @@
 { BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_TOP2, BTN_BASE,
   BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_BASE5, BTN_A, BTN_B, BTN_C, -1 };
 
+static signed short btn_saitek_cyborg[] =
+{ BTN_TRIGGER, BTN_THUMB, BTN_TOP, BTN_TOP2, BTN_BASE,
+  BTN_BASE2, BTN_BASE3, BTN_BASE4, BTN_BASE5, BTN_A, BTN_B, BTN_C, -1 };
+
 static signed short btn_avb_pegasus[] =
 { BTN_TRIGGER, BTN_TOP, BTN_THUMB, BTN_TOP2, BTN_BASE,
   BTN_BASE2, BTN_BASE3, BTN_BASE4, -1 };
@@ -54,6 +58,9 @@
 static signed short abs_joystick[] =
 { ABS_X, ABS_Y, ABS_THROTTLE, ABS_HAT0X, ABS_HAT0Y, -1 };
 
+static signed short abs_saitek_cyborg[] =
+{ ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, ABS_HAT0X, ABS_HAT0Y, -1 };
+
 static signed short abs_avb_pegasus[] =
 { ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, ABS_HAT0X, ABS_HAT0Y,
   ABS_HAT1X, ABS_HAT1Y, -1 };
@@ -79,6 +86,7 @@
 	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce }, //?
 	{ 0x06d6, 0x29bc, "Trust Force Feedback Race Master",		btn_wheel, abs_wheel, ff_iforce },
+	{ 0x06a3, 0xffb5, "Saitek Cyborg Evo Force",			btn_saitek_cyborg, abs_saitek_cyborg, ff_iforce }, //?
 	{ 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",		btn_joystick, abs_joystick, ff_iforce }
 };
 
diff -ru iforce_orig/iforce-packets.c iforce/iforce-packets.c
--- iforce_orig/iforce-packets.c	2009-12-03 04:51:21.000000000 +0100
+++ iforce/iforce-packets.c	2009-12-18 00:10:08.000000000 +0100
@@ -182,16 +182,24 @@
 
 		case 0x01:	/* joystick position data */
 		case 0x03:	/* wheel position data */
-			if (HI(cmd) == 1) {
-				input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
-				input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
-				input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
-				if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
-					input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
-			} else {
+		case 0x06:	/* saitek position data */
+			if (HI(cmd) == 3) {
 				input_report_abs(dev, ABS_WHEEL, (__s16) (((__s16)data[1] << 8) | data[0]));
 				input_report_abs(dev, ABS_GAS,   255 - data[2]);
 				input_report_abs(dev, ABS_BRAKE, 255 - data[3]);
+			} else {
+				input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
+				input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
+				if (HI(cmd) == 6) {
+					input_report_abs(dev, ABS_THROTTLE, data[4]);
+					if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+						input_report_abs(dev, ABS_RUDDER, data[7]);
+				} else {
+					input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
+					if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+						input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
+				}
+
 			}
 
 			input_report_abs(dev, ABS_HAT0X, iforce_hat_to_axis[data[6] >> 4].x);
diff -ru iforce_orig/iforce-usb.c iforce/iforce-usb.c
--- iforce_orig/iforce-usb.c	2009-12-03 04:51:21.000000000 +0100
+++ iforce/iforce-usb.c	2009-12-15 22:46:11.000000000 +0100
@@ -227,6 +227,7 @@
 	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Wheel */
 	{ USB_DEVICE(0x06f8, 0xa302) },		/* Guillemot Jet Leader 3D */
+	{ USB_DEVICE(0x06a3, 0xffb5) },		/* Saitek Cyborg Evo Force */
 	{ }					/* Terminating entry */
 };
 

--------------060302070202090204030003--
