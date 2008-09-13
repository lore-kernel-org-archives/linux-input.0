From: Didier Moens <moensd@xs4all.be>
Subject: Force Feedback for Thrustmaster RGT Pro Clutch Pedal Edition racing
 wheel
Date: Sat, 13 Sep 2008 17:09:39 +0200
Message-ID: <48CBD7B3.4070104@xs4all.be>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020709070405060407010100"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.xs4all.be ([195.144.64.135]:57794 "EHLO smtp1.evonet.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbYIMPyc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Sep 2008 11:54:32 -0400
Received: from dmbr042.fvms.UGent.be (195-144-080-226.dyn.adsl.xs4all.be [195.144.80.226])
	(authenticated bits=0)
	by smtp1.evonet.be (8.13.8/8.13.8) with ESMTP id m8DF9iu6014645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Sat, 13 Sep 2008 17:09:45 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------020709070405060407010100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,


I'm trying to get force feedback activated on this quite wonderful 
racing wheel 
(http://www.thrustmaster.com/product.aspx?ProductID=8&PlatformID=5).


Based on the thread started by Gerald Folcher of 16 Jul 2007 (force 
feedback for Thrustmaster FGT Wheel) and subsequent patches, I've added 
following USB id's :

(patches against 2.6.25, but I've already tested with 2.6.26.3)

diff -uNrp kernel-2.6.25.orig/drivers/hid/usbhid/hid-ff.c 
kernel-2.6.25.new/drivers/hid/usbhid/hid-ff.c
--- kernel-2.6.25.orig/drivers/hid/usbhid/hid-ff.c      2008-04-17 
04:49:44.000000000 +0200
+++ kernel-2.6.25.new/drivers/hid/usbhid/hid-ff.c       2008-09-09 
16:56:34.000000000 +0200
@@ -62,11 +62,13 @@ static struct hid_ff_initializer inits[]
 #ifdef CONFIG_PANTHERLORD_FF
        { 0x810, 0x0001, hid_plff_init }, /* "Twin USB Joystick" */
        { 0xe8f, 0x0003, hid_plff_init }, /* "GreenAsia Inc.    USB 
Joystick     " */
+       { 0xe8f, 0x0012, hid_plff_init }, /* "GreenAsia Inc.    USB 
Joystick     " */
 #endif
 #ifdef CONFIG_THRUSTMASTER_FF
        { 0x44f, 0xb300, hid_tmff_init },
        { 0x44f, 0xb304, hid_tmff_init },
        { 0x44f, 0xb651, hid_tmff_init }, /* FGT Rumble Force Wheel */
+       { 0x44f, 0xb653, hid_tmff_init }, /* Thrustmaster RGT Force 
Feedback Pro Clutch Edition */
        { 0x44f, 0xb654, hid_tmff_init }, /* FGT Force Feedback Wheel */
 #endif
 #ifdef CONFIG_ZEROPLUS_FF
diff -uNrp kernel-2.6.25.orig/drivers/hid/usbhid/hid-tmff.c 
kernel-2.6.25.new/drivers/hid/usbhid/hid-tmff.c
--- kernel-2.6.25.orig/drivers/hid/usbhid/hid-tmff.c    2008-04-17 
04:49:44.000000000 +0200
+++ kernel-2.6.25.new/drivers/hid/usbhid/hid-tmff.c     2008-09-09 
17:00:45.000000000 +0200
@@ -58,6 +58,7 @@ static const struct dev_type devices[] =
        { 0x44f, 0xb300, ff_rumble },
        { 0x44f, 0xb304, ff_rumble },
        { 0x44f, 0xb651, ff_rumble },   /* FGT Rumble Force Wheel */
+       { 0x44f, 0xb653, ff_joystick }, /* Thrustmaster RGT Force 
Feedback Pro Clutch Edition */
        { 0x44f, 0xb654, ff_joystick }, /* FGT Force Feedback Wheel */
 };
 

Unfortunately, this yields no improvement : no force feedback is sent to 
the wheel (tested with ff-utils).

/var/log/messages :

Sep 10 08:46:40 moewelstat1 kernel: usb 1-4.3: new low speed USB device 
using ehci_hcd and address 17
Sep 10 08:46:40 moewelstat1 kernel: usb 1-4.3: configuration #1 chosen 
from 1 choice
Sep 10 08:46:40 moewelstat1 kernel: input: Thrustmaster Thrustmaster 
force feedback wheel as /class/input/input13
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0022
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0050
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0022
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0060
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0063
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0022
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0070
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0022
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0079
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: 
ignoring unknown output usage 000f0097
Sep 10 08:46:40 moewelstat1 kernel: drivers/hid/usbhid/hid-tmff.c: Force 
feedback for ThrustMaster devices by Zinx Verituse <zinx@epicsol.org>
Sep 10 08:46:40 moewelstat1 kernel: input,hidraw0: USB HID v1.10 
Joystick [Thrustmaster Thrustmaster force feedback wheel] on 
usb-0000:00:02.1-4.3
Sep 10 08:46:40 moewelstat1 kernel: usb 1-4.3: New USB device found, 
idVendor=044f, idProduct=b653
Sep 10 08:46:40 moewelstat1 kernel: usb 1-4.3: New USB device strings: 
Mfr=3, Product=1, SerialNumber=0
Sep 10 08:46:40 moewelstat1 kernel: usb 1-4.3: Product: Thrustmaster 
force feedback wheel
Sep 10 08:46:40 moewelstat1 kernel: usb 1-4.3: Manufacturer: Thrustmaster


Changing the hid-tmff.c code to forcibly run the THRUSTMASTER_USAGE_FF 
clause (preventing 'ignoring unknown output usage') yields :

Sep 12 20:50:59 moewelstat1 kernel: input: Thrustmaster Thrustmaster 
force feedback wheel as /class/input/input7
Sep 12 20:50:59 moewelstat1 kernel: usbhid: ignoring FF field with 
report_count < 2
Sep 12 20:50:59 moewelstat1 kernel:last message repeated 2 times
Sep 12 20:50:59 moewelstat1 kernel: usbhid: ignoring FF field in other 
report
Sep 12 20:50:59 moewelstat1 kernel: usbhid: ignoring FF field in other 
report
Sep 12 20:50:59 moewelstat1 kernel: usbhid: ignoring FF field with 
report_count < 2
Sep 12 20:51:00 moewelstat1 kernel:last message repeated 4 times
Sep 12 20:50:59 moewelstat1 kernel: usbhid: Force feedback for 
ThrustMaster devices by Zinx Verituse <zinx@epicsol.org>


Please find in attachment kernel DEBUG output from dmesg , 
/var/log/messages and output from the ff-utils evtest application.



Of course, I'm eager to supply test feedback in case anybody feels 
compelled to provide me with some corrective code patches (please note 
I'm not truly acquainted with C code, though).
If required, I could run USB snooping with the Windows Thrustmaster 
drivers through a VMware session.



As I'm not currently subscribed to linux-input, CC: to moensd@xs4all.be 
would be much appreciated.


Best regards and thank you in advance,
Didier


--------------020709070405060407010100
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dmesg.out"

usb 2-6: new low speed USB device using ohci_hcd and address 4
usb 2-6: configuration #1 chosen from 1 choice
drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0
drivers/hid/usbhid/hid-core.c: report descriptor (size 455, read 455) =3D=
  05 01 09 04 a1 01 09 01 a1 00 85 81 06 00 ff 15 00 27 ff ff 00 00 09 01=
 09 02 75 10 95 02 b1 a2 09 03 09 04 85 82 25 7f 75 08 95 02 b1 02 85 01 =
05 09 19 01 29 0a 25 01 75 01 95 0a 81 02 05 01 09 39 25 07 35 00 46 3b 0=
1 65 14 95 01 75 04 81 42 09 30 46 ff 03 16 00 fe 26 ff 01 65 00 75 0a 95=
 01 81 02 09 31 46 ff 00 15 00 26 ff 00 75 08 81 02 09 35 81 02 09 36 81 =
02 09 37 81 02 c0 85 40 09 bb 15 00 26 ff 00 35 00 46 ff 00 75 08 95 04 9=
1 02 05 0f 09 21 a1 02 85 41 09 22 15 01 25 04 75 08 95 01 91 02 09 50 15=
 00 25 7f 35 00 46 c0 1f 75 08 66 03 10 55 0d 95 01 91 02 c0 09 5f a1 02 =
85 43 09 22 15 01 25 04 75 08 95 01 91 02 09 60 09 61 09 62 15 80 25 7f 9=
5 03 91 02 09 63 09 64 09 65 15 00 91 02 c0 09 73 a1 02 85 45 09 22 15 01=
 25 04 75 08 95 01 91 02 09 70 15 80 25 7f 75 08 91 02 c0 09 77 a1 02 85 =
4a 09 22 15 01 25 04 75 08 95 01 91 02 09 78 a1 02 09 79 09 7a 09 7b 25 0=
3 75 08 91 00 c0 c0 09 92 a1 02 85 88 09 22 15 01 25 04 75 08 b1 02 09 94=
 09 a0 09 9f 15 00 25 01 75 01 95 03 b1 02 95 05 b1 03 c0 09 95 a1 02 85 =
4b 09 96 a1 02 09 97 09 98 09 99 09 9a 09 9b 09 9c 15 01 25 06 75 08 95 0=
1 91 00 c0 c0 09 ab a1 02 85 85 09 25 a1 02 09 26 09 40 15 01 25 02 75 08=
 95 01 b1 00 c0 c0 09 89 a1 02 85 86 09 22 15 01 25 04 75 08 95 01 b1 02 =
09 8b a1 02 09 8c 09 8d 09 8e 15 01 25 03 75 08 95 01 b1 00 c0 c0 09 90 a=
1 02 85 87 09 22 15 01 25 04 75 08 95 01 b1 02 c0 c0
drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0=
x0101 wIndex=3D0x0000 wLength=3D8
drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0=
x0381 wIndex=3D0x0000 wLength=3D5
drivers/hid/hid-core.c: report (size 5) (numbered)
drivers/hid/hid-core.c: report 129 (size 4) =3D  01 21 ff ff
drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0=
x0382 wIndex=3D0x0000 wLength=3D3
drivers/hid/hid-core.c: report (size 3) (numbered)
drivers/hid/hid-core.c: report 130 (size 2) =3D  50 5a
drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0=
x0388 wIndex=3D0x0000 wLength=3D3
drivers/hid/hid-core.c: report (size 3) (numbered)
drivers/hid/hid-core.c: report 136 (size 2) =3D  00 02
drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0=
x0385 wIndex=3D0x0000 wLength=3D2
drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0=
x0386 wIndex=3D0x0000 wLength=3D3
drivers/hid/hid-core.c: report (size 3) (numbered)
drivers/hid/hid-core.c: report 134 (size 2) =3D  00 01
drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=3D0=
x0387 wIndex=3D0x0000 wLength=3D2
  INPUT(1)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Usage(10)
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
        Button.0006
        Button.0007
        Button.0008
        Button.0009
        Button.000a
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(10)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        GenericDesktop.HatSwitch
      Logical Minimum(0)
      Logical Maximum(7)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(4)
      Report Count(1)
      Report Offset(10)
      Flags( Variable Absolute NullState )
    Field(2)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        GenericDesktop.X
      Logical Minimum(-512)
      Logical Maximum(511)
      Physical Minimum(0)
      Physical Maximum(1023)
      Report Size(10)
      Report Count(1)
      Report Offset(14)
      Flags( Variable Absolute )
    Field(3)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        GenericDesktop.Y
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(255)
      Report Size(8)
      Report Count(1)
      Report Offset(24)
      Flags( Variable Absolute )
    Field(4)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        GenericDesktop.Rz
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(255)
      Report Size(8)
      Report Count(1)
      Report Offset(32)
      Flags( Variable Absolute )
    Field(5)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        GenericDesktop.Slider
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(255)
      Report Size(8)
      Report Count(1)
      Report Offset(40)
      Flags( Variable Absolute )
    Field(6)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        GenericDesktop.Dial
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(255)
      Report Size(8)
      Report Count(1)
      Report Offset(48)
      Flags( Variable Absolute )
  OUTPUT(64)[OUTPUT]
    Field(0)
      Usage(4)
        GenericDesktop.00bb
        GenericDesktop.00bb
        GenericDesktop.00bb
        GenericDesktop.00bb
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(255)
      Report Size(8)
      Report Count(4)
      Report Offset(0)
      Flags( Variable Absolute )
  OUTPUT(65)[OUTPUT]
    Field(0)
      Logical(PhysicalInterfaceDevice.0021)
      Usage(1)
        PhysicalInterfaceDevice.0022
      Logical Minimum(1)
      Logical Maximum(4)
      Physical Minimum(0)
      Physical Maximum(255)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Logical(PhysicalInterfaceDevice.0021)
      Usage(1)
        PhysicalInterfaceDevice.0050
      Logical Minimum(0)
      Logical Maximum(127)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(8)
      Flags( Variable Absolute )
  OUTPUT(67)[OUTPUT]
    Field(0)
      Logical(PhysicalInterfaceDevice.005f)
      Usage(1)
        PhysicalInterfaceDevice.0022
      Logical Minimum(1)
      Logical Maximum(4)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Logical(PhysicalInterfaceDevice.005f)
      Usage(3)
        PhysicalInterfaceDevice.0060
        PhysicalInterfaceDevice.0061
        PhysicalInterfaceDevice.0062
      Logical Minimum(-128)
      Logical Maximum(127)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(3)
      Report Offset(8)
      Flags( Variable Absolute )
    Field(2)
      Logical(PhysicalInterfaceDevice.005f)
      Usage(3)
        PhysicalInterfaceDevice.0063
        PhysicalInterfaceDevice.0064
        PhysicalInterfaceDevice.0065
      Logical Minimum(0)
      Logical Maximum(127)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(3)
      Report Offset(32)
      Flags( Variable Absolute )
  OUTPUT(69)[OUTPUT]
    Field(0)
      Logical(PhysicalInterfaceDevice.0073)
      Usage(1)
        PhysicalInterfaceDevice.0022
      Logical Minimum(1)
      Logical Maximum(4)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Logical(PhysicalInterfaceDevice.0073)
      Usage(1)
        PhysicalInterfaceDevice.0070
      Logical Minimum(-128)
      Logical Maximum(127)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(8)
      Flags( Variable Absolute )
  OUTPUT(74)[OUTPUT]
    Field(0)
      Logical(PhysicalInterfaceDevice.0077)
      Usage(1)
        PhysicalInterfaceDevice.0022
      Logical Minimum(1)
      Logical Maximum(4)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Logical(PhysicalInterfaceDevice.0078)
      Usage(3)
        PhysicalInterfaceDevice.0079
        PhysicalInterfaceDevice.007a
        PhysicalInterfaceDevice.007b
      Logical Minimum(1)
      Logical Maximum(3)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(8)
      Flags( Array Absolute )
  OUTPUT(75)[OUTPUT]
    Field(0)
      Logical(PhysicalInterfaceDevice.0096)
      Usage(6)
        PhysicalInterfaceDevice.0097
        PhysicalInterfaceDevice.0098
        PhysicalInterfaceDevice.0099
        PhysicalInterfaceDevice.009a
        PhysicalInterfaceDevice.009b
        PhysicalInterfaceDevice.009c
      Logical Minimum(1)
      Logical Maximum(6)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Array Absolute )
  FEATURE(129)[FEATURE]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Usage(2)
        ff00.0001
        ff00.0002
      Logical Minimum(0)
      Logical Maximum(65535)
      Report Size(16)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute NoPreferredState Volatile )
  FEATURE(130)[FEATURE]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Usage(2)
        ff00.0003
        ff00.0004
      Logical Minimum(0)
      Logical Maximum(127)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(136)[FEATURE]
    Field(0)
      Logical(PhysicalInterfaceDevice.0092)
      Usage(1)
        PhysicalInterfaceDevice.0022
      Logical Minimum(1)
      Logical Maximum(4)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Logical(PhysicalInterfaceDevice.0092)
      Usage(3)
        PhysicalInterfaceDevice.0094
        PhysicalInterfaceDevice.00a0
        PhysicalInterfaceDevice.009f
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(1)
      Report Count(3)
      Report Offset(8)
      Flags( Variable Absolute )
  FEATURE(133)[FEATURE]
    Field(0)
      Logical(PhysicalInterfaceDevice.0025)
      Usage(2)
        PhysicalInterfaceDevice.0026
        PhysicalInterfaceDevice.0040
      Logical Minimum(1)
      Logical Maximum(2)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Array Absolute )
  FEATURE(134)[FEATURE]
    Field(0)
      Logical(PhysicalInterfaceDevice.0089)
      Usage(1)
        PhysicalInterfaceDevice.0022
      Logical Minimum(1)
      Logical Maximum(4)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Logical(PhysicalInterfaceDevice.008b)
      Usage(3)
        PhysicalInterfaceDevice.008c
        PhysicalInterfaceDevice.008d
        PhysicalInterfaceDevice.008e
      Logical Minimum(1)
      Logical Maximum(3)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(8)
      Flags( Array Absolute )
  FEATURE(135)[FEATURE]
    Field(0)
      Logical(PhysicalInterfaceDevice.0090)
      Usage(1)
        PhysicalInterfaceDevice.0022
      Logical Minimum(1)
      Logical Maximum(4)
      Physical Minimum(0)
      Physical Maximum(8128)
      Unit Exponent(13)
      Unit(English Linear : Seconds)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
drivers/hid/hid-input.c: Mapping: Button.0001 ---> Key.Trigger
drivers/hid/hid-input.c: Mapping: Button.0002 ---> Key.ThumbBtn
drivers/hid/hid-input.c: Mapping: Button.0003 ---> Key.ThumbBtn2
drivers/hid/hid-input.c: Mapping: Button.0004 ---> Key.TopBtn
drivers/hid/hid-input.c: Mapping: Button.0005 ---> Key.TopBtn2
drivers/hid/hid-input.c: Mapping: Button.0006 ---> Key.PinkieBtn
drivers/hid/hid-input.c: Mapping: Button.0007 ---> Key.BaseBtn
drivers/hid/hid-input.c: Mapping: Button.0008 ---> Key.BaseBtn2
drivers/hid/hid-input.c: Mapping: Button.0009 ---> Key.BaseBtn3
drivers/hid/hid-input.c: Mapping: Button.000a ---> Key.BaseBtn4
drivers/hid/hid-input.c: Mapping: GenericDesktop.HatSwitch ---> Absolute.=
Hat0X
drivers/hid/hid-input.c: Mapping: GenericDesktop.X ---> Absolute.X
drivers/hid/hid-input.c: Mapping: GenericDesktop.Y ---> Absolute.Y
drivers/hid/hid-input.c: Mapping: GenericDesktop.Rz ---> Absolute.Rz
drivers/hid/hid-input.c: Mapping: GenericDesktop.Slider ---> Absolute.Thr=
ottle
drivers/hid/hid-input.c: Mapping: GenericDesktop.Dial ---> Absolute.Rudde=
r
drivers/hid/hid-input.c: Mapping: GenericDesktop.00bb --->  [non-LED outp=
ut field] IGNORED
drivers/hid/hid-input.c: Mapping: GenericDesktop.00bb --->  [non-LED outp=
ut field] IGNORED
drivers/hid/hid-input.c: Mapping: GenericDesktop.00bb --->  [non-LED outp=
ut field] IGNORED
drivers/hid/hid-input.c: Mapping: GenericDesktop.00bb --->  [non-LED outp=
ut field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0022 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0050 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0022 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0060 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0061 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0062 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0063 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0064 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0065 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0022 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0070 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0022 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0079 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.007a --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.007b --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0097 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0098 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.0099 --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.009a --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.009b --->  [non=
-LED output field] IGNORED
drivers/hid/hid-input.c: Mapping: PhysicalInterfaceDevice.009c --->  [non=
-LED output field] IGNORED
input: Thrustmaster Thrustmaster force feedback wheel as /class/input/inp=
ut8
usbhid: ignoring FF field with report_count < 2
usbhid: ignoring FF field with report_count < 2
usbhid: ignoring FF field with report_count < 2
usbhid: ignoring FF field in other report
usbhid: ignoring FF field in other report
usbhid: ignoring FF field with report_count < 2
usbhid: ignoring FF field with report_count < 2
usbhid: ignoring FF field with report_count < 2
usbhid: ignoring FF field with report_count < 2
usbhid: ignoring FF field with report_count < 2
usbhid: Force feedback for ThrustMaster devices by Zinx Verituse <zinx@ep=
icsol.org>
input,hidraw0: USB HID v1.10 Joystick [Thrustmaster Thrustmaster force fe=
edback wheel] on usb-0000:00:02.0-6
usb 2-6: New USB device found, idVendor=3D044f, idProduct=3Db653
usb 2-6: New USB device strings: Mfr=3D3, Product=3D1, SerialNumber=3D0
usb 2-6: Product: Thrustmaster force feedback wheel
usb 2-6: Manufacturer: Thrustmaster


--------------020709070405060407010100
Content-Type: text/plain;
 name="messages.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages.out"

Sep 13 14:18:43 moewelstat1 kernel: usb 2-6: new low speed USB device using ohci_hcd and address 4
Sep 13 14:18:44 moewelstat1 kernel: usb 2-6: configuration #1 chosen from 1 choice
Sep 13 14:18:44 moewelstat1 kernel:  25 04 75 08 b1 02 09 94 09 a0 09 9f 15 00 25 01 75 01 95 03 b1 02 95 05 b1 03 c0 09 95 a1 02 85 4b 09 96 a1 02 09 97 09 98 09 99 09 9a 09 9b 09 9c 15 01 25 06 75 08 95 01 91 00 c0 c0 09 ab a1 02 85 85 09 25 a1 02 09 26 09 40 15 01 25 02 75 08 95 01 b1 00 c0 c0 09 89 a1 02 85 86 09 22 15 01 25 04 75 08 95 01 b1 02 09 8b a1 02 09 8c 09 8d 09 8e 15 01 25 03 75 08 95 01 b1 00 c0 c0 09 90 a1 02 85 87 09 22 15 01 25 04 75 08 95 01 b1 02 c0 c0
Sep 13 14:18:44 moewelstat1 kernel: input: Thrustmaster Thrustmaster force feedback wheel as /class/input/input8
Sep 13 14:18:44 moewelstat1 kernel: usbhid: ignoring FF field with report_count < 2
Sep 13 14:18:44 moewelstat1 kernel:last message repeated 2 times
Sep 13 14:18:44 moewelstat1 kernel: usbhid: ignoring FF field in other report
Sep 13 14:18:44 moewelstat1 kernel: usbhid: ignoring FF field in other report
Sep 13 14:18:44 moewelstat1 kernel: usbhid: ignoring FF field with report_count < 2
Sep 13 14:18:44 moewelstat1 kernel:last message repeated 4 times
Sep 13 14:18:44 moewelstat1 kernel: usbhid: Force feedback for ThrustMaster devices by Zinx Verituse <zinx@epicsol.org>
Sep 13 14:18:44 moewelstat1 kernel: input,hidraw0: USB HID v1.10 Joystick [Thrustmaster Thrustmaster force feedback wheel] on usb-0000:00:02.0-6
Sep 13 14:18:44 moewelstat1 kernel: usb 2-6: New USB device found, idVendor=044f, idProduct=b653
Sep 13 14:18:44 moewelstat1 kernel: usb 2-6: New USB device strings: Mfr=3, Product=1, SerialNumber=0
Sep 13 14:18:44 moewelstat1 kernel: usb 2-6: Product: Thrustmaster force feedback wheel
Sep 13 14:18:44 moewelstat1 kernel: usb 2-6: Manufacturer: Thrustmaster


--------------020709070405060407010100
Content-Type: text/plain;
 name="evtest.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="evtest.out"

Input driver version is 1.0.0
Input device ID: bus 0x3 vendor 0x44f product 0xb653 version 0x110
Input device name: "Thrustmaster Thrustmaster force feedback wheel"
Supported events:
  Event type 0 (Reset)
    Event code 0 (Reset)
    Event code 1 (Key)
    Event code 3 (Absolute)
    Event code 4 (?)
    Event code 21 (ForceFeedback)
  Event type 1 (Key)
    Event code 288 (Trigger)
    Event code 289 (ThumbBtn)
    Event code 290 (ThumbBtn2)
    Event code 291 (TopBtn)
    Event code 292 (TopBtn2)
    Event code 293 (PinkieBtn)
    Event code 294 (BaseBtn)
    Event code 295 (BaseBtn2)
    Event code 296 (BaseBtn3)
    Event code 297 (BaseBtn4)
  Event type 3 (Absolute)
    Event code 0 (X)
      Value      0
      Min     -512
      Max      511
      Fuzz       3
      Flat      63
    Event code 1 (Y)
      Value      0
      Min        0
      Max      255
      Flat      15
    Event code 5 (Rz)
      Value      0
      Min        0
      Max      255
      Flat      15
    Event code 6 (Throttle)
      Value      0
      Min        0
      Max      255
      Flat      15
    Event code 7 (Rudder)
      Value      0
      Min        0
      Max      255
      Flat      15
    Event code 16 (Hat0X)
      Value      0
      Min       -1
      Max        1
    Event code 17 (Hat0Y)
      Value      0
      Min       -1
      Max        1
  Event type 4 (?)
    Event code 4 (?)
  Event type 21 (ForceFeedback)
    Event code 82 (?)
    Event code 96 (?)
Testing ... (interrupt to exit)
Event: time 1221308641.483012, type 4 (?), code 4 (?), value 589834
Event: time 1221308641.483018, type 1 (Key), code 297 (BaseBtn4), value 1
Event: time 1221308641.483022, type 3 (Absolute), code 0 (X), value 39
Event: time 1221308641.483025, type 3 (Absolute), code 1 (Y), value 243
Event: time 1221308641.483027, type 3 (Absolute), code 5 (Rz), value 4
Event: time 1221308641.483030, type 3 (Absolute), code 6 (Throttle), value 253
Event: time 1221308641.483033, type 0 (Reset), code 0 (Reset), value 0
Event: time 1221308641.498997, type 4 (?), code 4 (?), value 589834
Event: time 1221308641.499002, type 1 (Key), code 297 (BaseBtn4), value 0
Event: time 1221308641.499005, type 3 (Absolute), code 0 (X), value 8
Event: time 1221308641.499007, type 3 (Absolute), code 1 (Y), value 255
Event: time 1221308641.499010, type 3 (Absolute), code 5 (Rz), value 255
Event: time 1221308641.499012, type 3 (Absolute), code 6 (Throttle), value 255
Event: time 1221308641.499014, type 3 (Absolute), code 7 (Rudder), value 255
Event: time 1221308641.499016, type 0 (Reset), code 0 (Reset), value 0
Event: time 1221308641.514999, type 3 (Absolute), code 0 (X), value -512
Event: time 1221308641.515005, type 0 (Reset), code 0 (Reset), value 0

[snip]
...


--------------020709070405060407010100--
