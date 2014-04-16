From: simon@mungewell.org
Subject: HID: hid-logitech - missing HID_OUTPUT_REPORT 0
Date: Wed, 16 Apr 2014 18:35:18 -0400
Message-ID: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20140416183518_46613"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:60216 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaDPWfV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2014 18:35:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>

------=_20140416183518_46613
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Kees and all,
I've got a report from an end user that their Logitech F710 wireless
gamepad is not functioning correctly. This device has a switch to select
between 'X' mode (X-Pad, works OK) and 'D' mode (HID using hid-logitech,
doesn't work).

After some discussion off list, Elias and I think that this is related to
checking the report descriptor (attached).

Kernel log shows
--
[15961.607787] usb 5-5: USB disconnect, device number 12
[15962.235373] usb 5-5: new full-speed USB device number 13 using ohci-pci
[15962.412284] usb 5-5: New USB device found, idVendor=046d, idProduct=c219
[15962.412287] usb 5-5: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[15962.412289] usb 5-5: Product: Logitech Cordless RumblePad 2
[15962.412291] usb 5-5: Manufacturer: Logitech
[15962.424343] input: Logitech Logitech Cordless RumblePad 2 as
/devices/pci0000:00/0000:00:13.0/usb5/5-5/5-5:1.0/input/input26
[15962.424477] logitech 0003:046D:C219.0012: input,hidraw5: USB HID v1.11
Gamepad
[Logitech Logitech Cordless RumblePad 2] on usb-0000:00:13.0-5/input0
[15962.424480] logitech 0003:046D:C219.0012: missing HID_OUTPUT_REPORT 0
--

Last message comes from here (I believe):
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-lgff.c?id=refs/tags/v3.15-rc1#n137

Can anyone see what might be wrong with the report, to cause this code to
spit out an error?

Cheers,
Simon.
------=_20140416183518_46613
Content-Type: text/plain; name="report_descriptor.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="report_descriptor.txt"

0x05, 0x01,         /*  Usage Page (Desktop),                   */
0x09, 0x05,         /*  Usage (Gamepad),                        */
0xA1, 0x01,         /*  Collection (Application),               */
0xA1, 0x02,         /*      Collection (Logical),               */
0x85, 0x01,         /*          Report ID (1),                  */
0x75, 0x08,         /*          Report Size (8),                */
0x95, 0x04,         /*          Report Count (4),               */
0x15, 0x00,         /*          Logical Minimum (0),            */
0x26, 0xFF, 0x00,   /*          Logical Maximum (255),          */
0x35, 0x00,         /*          Physical Minimum (0),           */
0x46, 0xFF, 0x00,   /*          Physical Maximum (255),         */
0x09, 0x30,         /*          Usage (X),                      */
0x09, 0x31,         /*          Usage (Y),                      */
0x09, 0x32,         /*          Usage (Z),                      */
0x09, 0x35,         /*          Usage (Rz),                     */
0x81, 0x02,         /*          Input (Variable),               */
0x75, 0x04,         /*          Report Size (4),                */
0x95, 0x01,         /*          Report Count (1),               */
0x25, 0x07,         /*          Logical Maximum (7),            */
0x46, 0x3B, 0x01,   /*          Physical Maximum (315),         */
0x66, 0x14, 0x00,   /*          Unit (Degrees),                 */
0x09, 0x39,         /*          Usage (Hat Switch),             */
0x81, 0x42,         /*          Input (Variable, Null State),   */
0x66, 0x00, 0x00,   /*          Unit,                           */
0x75, 0x01,         /*          Report Size (1),                */
0x95, 0x0C,         /*          Report Count (12),              */
0x25, 0x01,         /*          Logical Maximum (1),            */
0x45, 0x01,         /*          Physical Maximum (1),           */
0x05, 0x09,         /*          Usage Page (Button),            */
0x19, 0x01,         /*          Usage Minimum (01h),            */
0x29, 0x0C,         /*          Usage Maximum (0Ch),            */
0x81, 0x02,         /*          Input (Variable),               */
0x95, 0x01,         /*          Report Count (1),               */
0x75, 0x08,         /*          Report Size (8),                */
0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),             */
0x26, 0xFF, 0x00,   /*          Logical Maximum (255),          */
0x46, 0xFF, 0x00,   /*          Physical Maximum (255),         */
0x09, 0x00,         /*          Usage (00h),                    */
0x81, 0x02,         /*          Input (Variable),               */
0xC0,               /*      End Collection,                     */
0xA1, 0x02,         /*      Collection (Logical),               */
0x85, 0x02,         /*          Report ID (2),                  */
0x95, 0x07,         /*          Report Count (7),               */
0x75, 0x08,         /*          Report Size (8),                */
0x26, 0xFF, 0x00,   /*          Logical Maximum (255),          */
0x46, 0xFF, 0x00,   /*          Physical Maximum (255),         */
0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),             */
0x09, 0x03,         /*          Usage (03h),                    */
0x81, 0x02,         /*          Input (Variable),               */
0xC0,               /*      End Collection,                     */
0xA1, 0x02,         /*      Collection (Logical),               */
0x85, 0x03,         /*          Report ID (3),                  */
0x09, 0x04,         /*          Usage (04h),                    */
0x91, 0x02,         /*          Output (Variable),              */
0xC0,               /*      End Collection,                     */
0xC0                /*  End Collection                          */
------=_20140416183518_46613--


