From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: [PATCH 1/2] Revert "HID: dragonrise: fix HID Descriptor for 0x0006 PID"
Date: Mon, 26 Sep 2016 05:58:38 +0300
Message-ID: <20160926025839.2790-1-adi@adirat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This reverts commit 18339f59c3a6 ("HID: dragonrise: fix HID...")
because the "fix" is bogus. That report descriptor is different in
hardware (see below) and it's the way the hardware works, it can't be
fixed at this level because it reuses axes by design.

What this change tried to fix is a regression caused by commit 20aef664f139
("HID: input: force generic axis to be mapped to their user space axis") by
working around the problem and trying to change the report descriptor in
hid-dr, which obviously can't work and introduces more breakage because it
adds another unnecessary layer of multiplexing/indirection, making the
dragonrise gamepad practically unusable in userspace.

This needs to be fixed where the regression was initially introduced in
hid-input (the next patch does this).

Here's the descriptor taken directly from the device via lsusb:
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode           33 US
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     101
          Report Descriptor: (length is 101)
            Item(Global): Usage Page, data= [ 0x01 ] 1
                            Generic Desktop Controls
            Item(Local ): Usage, data= [ 0x04 ] 4
                            Joystick
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Main  ): Collection, data= [ 0x02 ] 2
                            Logical
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Global): Report Count, data= [ 0x05 ] 5
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
            Item(Global): Physical Minimum, data= [ 0x00 ] 0
            Item(Global): Physical Maximum, data= [ 0xff 0x00 ] 255
            Item(Local ): Usage, data= [ 0x30 ] 48
                            Direction-X
            Item(Local ): Usage, data= [ 0x31 ] 49
                            Direction-Y
            Item(Local ): Usage, data= [ 0x32 ] 50
                            Direction-Z
            Item(Local ): Usage, data= [ 0x32 ] 50
                            Direction-Z
            Item(Local ): Usage, data= [ 0x35 ] 53
                            Rotate-Z
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report Size, data= [ 0x04 ] 4
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Global): Logical Maximum, data= [ 0x07 ] 7
            Item(Global): Physical Maximum, data= [ 0x3b 0x01 ] 315
            Item(Global): Unit, data= [ 0x14 ] 20
                            System: English Rotation, Unit: Degrees
            Item(Local ): Usage, data= [ 0x39 ] 57
                            Hat Switch
            Item(Main  ): Input, data= [ 0x42 ] 66
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State Null_State Non_Volatile Bitfield
            Item(Global): Unit, data= [ 0x00 ] 0
                            System: None, Unit: (None)
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x0c ] 12
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Physical Maximum, data= [ 0x01 ] 1
            Item(Global): Usage Page, data= [ 0x09 ] 9
                            Buttons
            Item(Local ): Usage Minimum, data= [ 0x01 ] 1
                            Button 1 (Primary)
            Item(Local ): Usage Maximum, data= [ 0x0c ] 12
                            (null)
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Usage Page, data= [ 0x00 0xff ] 65280
                            (null)
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x08 ] 8
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Physical Maximum, data= [ 0x01 ] 1
            Item(Local ): Usage, data= [ 0x01 ] 1
                            (null)
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Main  ): Collection, data= [ 0x02 ] 2
                            Logical
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Global): Report Count, data= [ 0x07 ] 7
            Item(Global): Physical Maximum, data= [ 0xff 0x00 ] 255
            Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
            Item(Local ): Usage, data= [ 0x02 ] 2
                            (null)
            Item(Main  ): Output, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
            Item(Main  ): End Collection, data=none

Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
---
 drivers/hid/hid-dr.c | 58 ----------------------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index 8fd4bf7..2523f8a 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -234,58 +234,6 @@ static __u8 pid0011_rdesc_fixed[] = {
 	0xC0                /*  End Collection                  */
 };
 
-static __u8 pid0006_rdesc_fixed[] = {
-	0x05, 0x01,        /* Usage Page (Generic Desktop)	*/
-	0x09, 0x04,        /* Usage (Joystick)			*/
-	0xA1, 0x01,        /* Collection (Application)		*/
-	0xA1, 0x02,        /*   Collection (Logical)		*/
-	0x75, 0x08,        /*     Report Size (8)		*/
-	0x95, 0x05,        /*     Report Count (5)		*/
-	0x15, 0x00,        /*     Logical Minimum (0)		*/
-	0x26, 0xFF, 0x00,  /*     Logical Maximum (255)		*/
-	0x35, 0x00,        /*     Physical Minimum (0)		*/
-	0x46, 0xFF, 0x00,  /*     Physical Maximum (255)	*/
-	0x09, 0x30,        /*     Usage (X)			*/
-	0x09, 0x33,        /*     Usage (Ry)			*/
-	0x09, 0x32,        /*     Usage (Z)			*/
-	0x09, 0x31,        /*     Usage (Y)			*/
-	0x09, 0x34,        /*     Usage (Ry)			*/
-	0x81, 0x02,        /*     Input (Variable)		*/
-	0x75, 0x04,        /*     Report Size (4)		*/
-	0x95, 0x01,        /*     Report Count (1)		*/
-	0x25, 0x07,        /*     Logical Maximum (7)		*/
-	0x46, 0x3B, 0x01,  /*     Physical Maximum (315)	*/
-	0x65, 0x14,        /*     Unit (Centimeter)		*/
-	0x09, 0x39,        /*     Usage (Hat switch)		*/
-	0x81, 0x42,        /*     Input (Variable)		*/
-	0x65, 0x00,        /*     Unit (None)			*/
-	0x75, 0x01,        /*     Report Size (1)		*/
-	0x95, 0x0C,        /*     Report Count (12)		*/
-	0x25, 0x01,        /*     Logical Maximum (1)		*/
-	0x45, 0x01,        /*     Physical Maximum (1)		*/
-	0x05, 0x09,        /*     Usage Page (Button)		*/
-	0x19, 0x01,        /*     Usage Minimum (0x01)		*/
-	0x29, 0x0C,        /*     Usage Maximum (0x0C)		*/
-	0x81, 0x02,        /*     Input (Variable)		*/
-	0x06, 0x00, 0xFF,  /*     Usage Page (Vendor Defined)	*/
-	0x75, 0x01,        /*     Report Size (1)		*/
-	0x95, 0x08,        /*     Report Count (8)		*/
-	0x25, 0x01,        /*     Logical Maximum (1)		*/
-	0x45, 0x01,        /*     Physical Maximum (1)		*/
-	0x09, 0x01,        /*     Usage (0x01)			*/
-	0x81, 0x02,        /*     Input (Variable)		*/
-	0xC0,              /*   End Collection			*/
-	0xA1, 0x02,        /*   Collection (Logical)		*/
-	0x75, 0x08,        /*     Report Size (8)		*/
-	0x95, 0x07,        /*     Report Count (7)		*/
-	0x46, 0xFF, 0x00,  /*     Physical Maximum (255)	*/
-	0x26, 0xFF, 0x00,  /*     Logical Maximum (255)		*/
-	0x09, 0x02,        /*     Usage (0x02)			*/
-	0x91, 0x02,        /*     Output (Variable)		*/
-	0xC0,              /*   End Collection			*/
-	0xC0               /* End Collection			*/
-};
-
 static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				unsigned int *rsize)
 {
@@ -296,12 +244,6 @@ static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(pid0011_rdesc_fixed);
 		}
 		break;
-	case 0x0006:
-		if (*rsize == sizeof(pid0006_rdesc_fixed)) {
-			rdesc = pid0006_rdesc_fixed;
-			*rsize = sizeof(pid0006_rdesc_fixed);
-		}
-		break;
 	}
 	return rdesc;
 }
-- 
2.10.0
