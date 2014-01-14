From: simon@mungewell.org
Subject: Re: Sony DualShock4 - basic functions work, but looking to improve
 support
Date: Tue, 14 Jan 2014 15:30:22 -0500
Message-ID: <1bf55e83485cccae179a9ad21a85db56.squirrel@mungewell.org>
References: <61a33717137a02a1d0eac5a2d1cb257e.squirrel@mungewell.org>
    <a26fde1f94cf430dd54a5045f82ac260.squirrel@mungewell.org>
    <CANq1E4Q=4DEDFibVtifMVE-2wq7Bt0KOPRRE5nFy9Hu-tgy_Cg@mail.gmail.com>
    <7f868cfea581a565001fe18bb08b8abb.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20140114153022_42377"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:33740 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbaANUaZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jan 2014 15:30:25 -0500
In-Reply-To: <7f868cfea581a565001fe18bb08b8abb.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Antonio Ospite <ospite@studenti.unina.it>

------=_20140114153022_42377
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

>> The report descriptor actually describes a lot more report-IDs than
>> just "0x01" which you describe in hidraw.txt. Are you sure the
>> report-descriptors are the same for USB and BT?
>
> The report descriptor when connected via BT is different, or at least what
> I found at '/sys/bus/hid/devices/0005\:054C\:05C4.0006/report_descriptor'.
>
> Unfortunately I wasn't able to decode it.
> --
> simon@womble:~/dualshock4$ ~/hidrd-0.2.0/src/hidrd-convert des_bt.bin -o
> code
> Failed to read input item at offset 356:
> invalid item encountered
> --

After playing some more with the DS4, I noticed the comment in
'hid-sony.c' that the six-axis adds a trailing zero to it's HID... which
this file has too.

So it actually works after truncating it, see attached.
Simon
------=_20140114153022_42377
Content-Type: text/plain; name="des_bt.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="des_bt.txt"

0x05, 0x01,         /*  Usage Page (Desktop),               */
0x09, 0x05,         /*  Usage (Gamepad),                    */
0xA1, 0x01,         /*  Collection (Application),           */
0x85, 0x01,         /*      Report ID (1),                  */
0x09, 0x30,         /*      Usage (X),                      */
0x09, 0x31,         /*      Usage (Y),                      */
0x09, 0x32,         /*      Usage (Z),                      */
0x09, 0x35,         /*      Usage (Rz),                     */
0x15, 0x00,         /*      Logical Minimum (0),            */
0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
0x75, 0x08,         /*      Report Size (8),                */
0x95, 0x04,         /*      Report Count (4),               */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x39,         /*      Usage (Hat Switch),             */
0x15, 0x00,         /*      Logical Minimum (0),            */
0x25, 0x07,         /*      Logical Maximum (7),            */
0x75, 0x04,         /*      Report Size (4),                */
0x95, 0x01,         /*      Report Count (1),               */
0x81, 0x42,         /*      Input (Variable, Null State),   */
0x05, 0x09,         /*      Usage Page (Button),            */
0x19, 0x01,         /*      Usage Minimum (01h),            */
0x29, 0x0E,         /*      Usage Maximum (0Eh),            */
0x15, 0x00,         /*      Logical Minimum (0),            */
0x25, 0x01,         /*      Logical Maximum (1),            */
0x75, 0x01,         /*      Report Size (1),                */
0x95, 0x0E,         /*      Report Count (14),              */
0x81, 0x02,         /*      Input (Variable),               */
0x75, 0x06,         /*      Report Size (6),                */
0x95, 0x01,         /*      Report Count (1),               */
0x81, 0x01,         /*      Input (Constant),               */
0x05, 0x01,         /*      Usage Page (Desktop),           */
0x09, 0x33,         /*      Usage (Rx),                     */
0x09, 0x34,         /*      Usage (Ry),                     */
0x15, 0x00,         /*      Logical Minimum (0),            */
0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
0x75, 0x08,         /*      Report Size (8),                */
0x95, 0x02,         /*      Report Count (2),               */
0x81, 0x02,         /*      Input (Variable),               */
0x06, 0x04, 0xFF,   /*      Usage Page (FF04h),             */
0x85, 0x02,         /*      Report ID (2),                  */
0x09, 0x24,         /*      Usage (24h),                    */
0x95, 0x24,         /*      Report Count (36),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0xA3,         /*      Report ID (163),                */
0x09, 0x25,         /*      Usage (25h),                    */
0x95, 0x30,         /*      Report Count (48),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x05,         /*      Report ID (5),                  */
0x09, 0x26,         /*      Usage (26h),                    */
0x95, 0x28,         /*      Report Count (40),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x06,         /*      Report ID (6),                  */
0x09, 0x27,         /*      Usage (27h),                    */
0x95, 0x34,         /*      Report Count (52),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x07,         /*      Report ID (7),                  */
0x09, 0x28,         /*      Usage (28h),                    */
0x95, 0x30,         /*      Report Count (48),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x08,         /*      Report ID (8),                  */
0x09, 0x29,         /*      Usage (29h),                    */
0x95, 0x2F,         /*      Report Count (47),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x06, 0x03, 0xFF,   /*      Usage Page (FF03h),             */
0x85, 0x03,         /*      Report ID (3),                  */
0x09, 0x21,         /*      Usage (21h),                    */
0x95, 0x26,         /*      Report Count (38),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x04,         /*      Report ID (4),                  */
0x09, 0x22,         /*      Usage (22h),                    */
0x95, 0x2E,         /*      Report Count (46),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0xF0,         /*      Report ID (240),                */
0x09, 0x47,         /*      Usage (47h),                    */
0x95, 0x3F,         /*      Report Count (63),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0xF1,         /*      Report ID (241),                */
0x09, 0x48,         /*      Usage (48h),                    */
0x95, 0x3F,         /*      Report Count (63),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0xF2,         /*      Report ID (242),                */
0x09, 0x49,         /*      Usage (49h),                    */
0x95, 0x0F,         /*      Report Count (15),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
0x85, 0x11,         /*      Report ID (17),                 */
0x09, 0x20,         /*      Usage (20h),                    */
0x15, 0x00,         /*      Logical Minimum (0),            */
0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
0x75, 0x08,         /*      Report Size (8),                */
0x95, 0x4D,         /*      Report Count (77),              */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x21,         /*      Usage (21h),                    */
0x91, 0x02,         /*      Output (Variable),              */
0x85, 0x12,         /*      Report ID (18),                 */
0x09, 0x22,         /*      Usage (22h),                    */
0x95, 0x8D,         /*      Report Count (141),             */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x23,         /*      Usage (23h),                    */
0x91, 0x02,         /*      Output (Variable),              */
0x85, 0x13,         /*      Report ID (19),                 */
0x09, 0x24,         /*      Usage (24h),                    */
0x95, 0xCD,         /*      Report Count (205),             */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x25,         /*      Usage (25h),                    */
0x91, 0x02,         /*      Output (Variable),              */
0x85, 0x14,         /*      Report ID (20),                 */
0x09, 0x26,         /*      Usage (26h),                    */
0x96, 0x0D, 0x01,   /*      Report Count (269),             */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x27,         /*      Usage (27h),                    */
0x91, 0x02,         /*      Output (Variable),              */
0x85, 0x15,         /*      Report ID (21),                 */
0x09, 0x28,         /*      Usage (28h),                    */
0x96, 0x4D, 0x01,   /*      Report Count (333),             */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x29,         /*      Usage (29h),                    */
0x91, 0x02,         /*      Output (Variable),              */
0x85, 0x16,         /*      Report ID (22),                 */
0x09, 0x2A,         /*      Usage (2Ah),                    */
0x96, 0x8D, 0x01,   /*      Report Count (397),             */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x2B,         /*      Usage (2Bh),                    */
0x91, 0x02,         /*      Output (Variable),              */
0x85, 0x17,         /*      Report ID (23),                 */
0x09, 0x2C,         /*      Usage (2Ch),                    */
0x96, 0xCD, 0x01,   /*      Report Count (461),             */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x2D,         /*      Usage (2Dh),                    */
0x91, 0x02,         /*      Output (Variable),              */
0x85, 0x18,         /*      Report ID (24),                 */
0x09, 0x2E,         /*      Usage (2Eh),                    */
0x96, 0x0D, 0x02,   /*      Report Count (525),             */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x2F,         /*      Usage (2Fh),                    */
0x91, 0x02,         /*      Output (Variable),              */
0x85, 0x19,         /*      Report ID (25),                 */
0x09, 0x30,         /*      Usage (30h),                    */
0x96, 0x22, 0x02,   /*      Report Count (546),             */
0x81, 0x02,         /*      Input (Variable),               */
0x09, 0x31,         /*      Usage (31h),                    */
0x91, 0x02,         /*      Output (Variable),              */
0x06, 0x80, 0xFF,   /*      Usage Page (FF80h),             */
0x85, 0x82,         /*      Report ID (130),                */
0x09, 0x22,         /*      Usage (22h),                    */
0x95, 0x3F,         /*      Report Count (63),              */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x83,         /*      Report ID (131),                */
0x09, 0x23,         /*      Usage (23h),                    */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x84,         /*      Report ID (132),                */
0x09, 0x24,         /*      Usage (24h),                    */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x90,         /*      Report ID (144),                */
0x09, 0x30,         /*      Usage (30h),                    */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x91,         /*      Report ID (145),                */
0x09, 0x31,         /*      Usage (31h),                    */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x92,         /*      Report ID (146),                */
0x09, 0x32,         /*      Usage (32h),                    */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0x93,         /*      Report ID (147),                */
0x09, 0x33,         /*      Usage (33h),                    */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0xA0,         /*      Report ID (160),                */
0x09, 0x40,         /*      Usage (40h),                    */
0xB1, 0x02,         /*      Feature (Variable),             */
0x85, 0xA4,         /*      Report ID (164),                */
0x09, 0x44,         /*      Usage (44h),                    */
0xB1, 0x02,         /*      Feature (Variable),             */
0xC0                /*  End Collection                      */
------=_20140114153022_42377--


