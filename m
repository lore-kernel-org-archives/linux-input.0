From: Gerald Folcher <geraldf2@free.fr>
Subject: Re: Force Feedback: Thrustmaster FGT Wheel quick-and-dirty in hid-lgff.c
 or hid-tmff.c
Date: Mon, 16 Jul 2007 20:37:58 +0200
Message-ID: <469BBB06.2020507@free.fr>
References: <469B7721.9070705@free.fr>    <d120d5000707160905l214a6ec3yaefc73be5644e1b1@mail.gmail.com>    <469BA787.8080700@free.fr> <57857.84.250.84.4.1184606500.squirrel@mail.onse.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050406090804020701080005"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <57857.84.250.84.4.1184606500.squirrel@mail.onse.fi>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi@mandriva.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------050406090804020701080005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Anssi Hannula wrote:
> Could you perhaps provide the kernel log output when you plug your device
> in with CONFIG_HID_DEBUG enabled in kernel configuration?

Ok, after setting CONFIG_HID_DEBUG=y here's what got appended in the
'/var/log/kern.log' file when I plugged the device (see attachment).

(Btw it's from the kernel with my little modification if that would make 
any difference)

-- 
Gerald Folcher

--------------050406090804020701080005
Content-Type: text/plain;
 name="ThrustmasterFGTFF_plug_kernlog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ThrustmasterFGTFF_plug_kernlog.txt"

Jul 16 20:19:41 starship kernel: usb 4-1: new full speed USB device using uhci_hcd and address 2
Jul 16 20:19:41 starship kernel: usb 4-1: configuration #1 chosen from 1 choice
Jul 16 20:19:41 starship kernel: drivers/hid/usbhid/hid-core.c: report descriptor (size 144, read 144) =  05 01 09 04 a1 01 09 01 a1 00 85 81 06 00 ff 15 00 27 ff ff 00 00 09 01 09 02 75 10 95 02 b1 a2 85 82 09 03 09 04 25 7f 75 08 95 02 b1 02 85 01 05 09 19 01 29 0a 25 01 75 01 95 0a 81 02 75 08 95 01 81 01 05 01 09 39 25 07 35 00 46 3b 01 65 14 75 04 81 42 09 30 46 ff 03 16 00 fe 26 ff 01 65 00 75 0a 95 01 81 02 09 31 46 ff 00 15 00 26 ff 00 75 08 81 02 09 35 81 02 c0 85 40 09 bb 15 00 26 ff 00 35 00 46 ff 00 75 08 95 04 91 02 c0
Jul 16 20:19:41 starship kernel: drivers/hid/hid-core.c: report (size 1) (numbered)
Jul 16 20:19:41 starship kernel: drivers/hid/hid-core.c: report 1 (size 0) = 
Jul 16 20:19:41 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:19:41 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:19:41 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:19:41 starship kernel: hid-debug: input Button.0004 = 0
Jul 16 20:19:41 starship kernel: hid-debug: input Button.0005 = 0
Jul 16 20:19:41 starship kernel: hid-debug: input Button.0006 = 0
Jul 16 20:19:41 starship kernel: hid-debug: input Button.0007 = 0
Jul 16 20:19:41 starship kernel: hid-debug: input Button.0008 = 0
Jul 16 20:19:41 starship kernel: hid-debug: input Button.0009 = 0
Jul 16 20:19:41 starship kernel: hid-debug: input Button.000a = 0
Jul 16 20:19:41 starship kernel: hid-debug: input GenericDesktop.HatSwitch = 0
Jul 16 20:19:41 starship kernel: hid-debug: input GenericDesktop.X = 0
Jul 16 20:19:41 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:19:41 starship kernel: hid-debug: input GenericDesktop.Rz = 0
Jul 16 20:19:41 starship kernel:   INPUT(1)[INPUT]
Jul 16 20:19:41 starship kernel:     Field(0)
Jul 16 20:19:41 starship kernel:       Physical(GenericDesktop.Pointer)
Jul 16 20:19:41 starship kernel:       Usage(10)
Jul 16 20:19:41 starship kernel:         Button.0001
Jul 16 20:19:41 starship kernel:         Button.0002
Jul 16 20:19:41 starship kernel:         Button.0003
Jul 16 20:19:41 starship kernel:         Button.0004
Jul 16 20:19:41 starship kernel:         Button.0005
Jul 16 20:19:41 starship kernel:         Button.0006
Jul 16 20:19:41 starship kernel:         Button.0007
Jul 16 20:19:41 starship kernel:         Button.0008
Jul 16 20:19:41 starship kernel:         Button.0009
Jul 16 20:19:41 starship kernel:         Button.000a
Jul 16 20:19:41 starship kernel:       Logical Minimum(0)
Jul 16 20:19:41 starship kernel:       Logical Maximum(1)
Jul 16 20:19:41 starship kernel:       Report Size(1)
Jul 16 20:19:41 starship kernel:       Report Count(10)
Jul 16 20:19:41 starship kernel:       Report Offset(0)
Jul 16 20:19:41 starship kernel:       Flags( Variable Absolute )
Jul 16 20:19:41 starship kernel:     Field(1)
Jul 16 20:19:41 starship kernel:       Physical(GenericDesktop.Pointer)
Jul 16 20:19:41 starship kernel:       Usage(1)
Jul 16 20:19:41 starship kernel:         GenericDesktop.HatSwitch
Jul 16 20:19:41 starship kernel:       Logical Minimum(0)
Jul 16 20:19:41 starship kernel:       Logical Maximum(7)
Jul 16 20:19:41 starship kernel:       Physical Minimum(0)
Jul 16 20:19:41 starship kernel:       Physical Maximum(315)
Jul 16 20:19:41 starship kernel:       Unit(English Rotation : Degrees)
Jul 16 20:19:41 starship kernel:       Report Size(4)
Jul 16 20:19:41 starship kernel:       Report Count(1)
Jul 16 20:19:41 starship kernel:       Report Offset(18)
Jul 16 20:19:41 starship kernel:       Flags( Variable Absolute NullState )
Jul 16 20:19:41 starship kernel:     Field(2)
Jul 16 20:19:41 starship kernel:       Physical(GenericDesktop.Pointer)
Jul 16 20:19:41 starship kernel:       Usage(1)
Jul 16 20:19:41 starship kernel:         GenericDesktop.X
Jul 16 20:19:41 starship kernel:       Logical Minimum(-512)
Jul 16 20:19:41 starship kernel:       Logical Maximum(511)
Jul 16 20:19:41 starship kernel:       Physical Minimum(0)
Jul 16 20:19:41 starship kernel:       Physical Maximum(1023)
Jul 16 20:19:41 starship kernel:       Report Size(10)
Jul 16 20:19:41 starship kernel:       Report Count(1)
Jul 16 20:19:41 starship kernel:       Report Offset(22)
Jul 16 20:19:41 starship kernel:       Flags( Variable Absolute )
Jul 16 20:19:41 starship kernel:     Field(3)
Jul 16 20:19:41 starship kernel:       Physical(GenericDesktop.Pointer)
Jul 16 20:19:41 starship kernel:       Usage(1)
Jul 16 20:19:41 starship kernel:         GenericDesktop.Y
Jul 16 20:19:41 starship kernel:       Logical Minimum(0)
Jul 16 20:19:41 starship kernel:       Logical Maximum(255)
Jul 16 20:19:41 starship kernel:       Physical Minimum(0)
Jul 16 20:19:41 starship kernel:       Physical Maximum(255)
Jul 16 20:19:41 starship kernel:       Report Size(8)
Jul 16 20:19:41 starship kernel:       Report Count(1)
Jul 16 20:19:41 starship kernel:       Report Offset(32)
Jul 16 20:19:41 starship kernel:       Flags( Variable Absolute )
Jul 16 20:19:41 starship kernel:     Field(4)
Jul 16 20:19:41 starship kernel:       Physical(GenericDesktop.Pointer)
Jul 16 20:19:41 starship kernel:       Usage(1)
Jul 16 20:19:41 starship kernel:         GenericDesktop.Rz
Jul 16 20:19:41 starship kernel:       Logical Minimum(0)
Jul 16 20:19:41 starship kernel:       Logical Maximum(255)
Jul 16 20:19:41 starship kernel:       Physical Minimum(0)
Jul 16 20:19:41 starship kernel:       Physical Maximum(255)
Jul 16 20:19:41 starship kernel:       Report Size(8)
Jul 16 20:19:41 starship kernel:       Report Count(1)
Jul 16 20:19:41 starship kernel:       Report Offset(40)
Jul 16 20:19:41 starship kernel:       Flags( Variable Absolute )
Jul 16 20:19:41 starship kernel:   OUTPUT(64)[OUTPUT]
Jul 16 20:19:41 starship kernel:     Field(0)
Jul 16 20:19:41 starship kernel:       Usage(4)
Jul 16 20:19:41 starship kernel:         GenericDesktop.00bb
Jul 16 20:19:41 starship last message repeated 3 times
Jul 16 20:19:41 starship kernel:       Logical Minimum(0)
Jul 16 20:19:41 starship kernel:       Logical Maximum(255)
Jul 16 20:19:41 starship kernel:       Physical Minimum(0)
Jul 16 20:19:41 starship kernel:       Physical Maximum(255)
Jul 16 20:19:41 starship kernel:       Report Size(8)
Jul 16 20:19:41 starship kernel:       Report Count(4)
Jul 16 20:19:41 starship kernel:       Report Offset(0)
Jul 16 20:19:41 starship kernel:       Flags( Variable Absolute )
Jul 16 20:19:41 starship kernel:   FEATURE(129)[FEATURE]
Jul 16 20:19:41 starship kernel:     Field(0)
Jul 16 20:19:41 starship kernel:       Physical(GenericDesktop.Pointer)
Jul 16 20:19:41 starship kernel:       Usage(2)
Jul 16 20:19:41 starship kernel:         ff00.0001
Jul 16 20:19:41 starship kernel:         ff00.0002
Jul 16 20:19:41 starship kernel:       Logical Minimum(0)
Jul 16 20:19:41 starship kernel:       Logical Maximum(65535)
Jul 16 20:19:41 starship kernel:       Report Size(16)
Jul 16 20:19:41 starship kernel:       Report Count(2)
Jul 16 20:19:41 starship kernel:       Report Offset(0)
Jul 16 20:19:41 starship kernel:       Flags( Variable Absolute NoPrefferedState Volatile )
Jul 16 20:19:41 starship kernel:   FEATURE(130)[FEATURE]
Jul 16 20:19:41 starship kernel:     Field(0)
Jul 16 20:19:41 starship kernel:       Physical(GenericDesktop.Pointer)
Jul 16 20:19:41 starship kernel:       Usage(2)
Jul 16 20:19:41 starship kernel:         ff00.0003
Jul 16 20:19:41 starship kernel:         ff00.0004
Jul 16 20:19:41 starship kernel:       Logical Minimum(0)
Jul 16 20:19:41 starship kernel:       Logical Maximum(127)
Jul 16 20:19:41 starship kernel:       Report Size(8)
Jul 16 20:19:41 starship kernel:       Report Count(2)
Jul 16 20:19:41 starship kernel:       Report Offset(0)
Jul 16 20:19:41 starship kernel:       Flags( Variable Absolute )
Jul 16 20:19:41 starship kernel: Mapping: Button.0001 ---> Key.Trigger
Jul 16 20:19:41 starship kernel: Mapping: Button.0002 ---> Key.ThumbBtn
Jul 16 20:19:41 starship kernel: Mapping: Button.0003 ---> Key.ThumbBtn2
Jul 16 20:19:41 starship kernel: Mapping: Button.0004 ---> Key.TopBtn
Jul 16 20:19:41 starship kernel: Mapping: Button.0005 ---> Key.TopBtn2
Jul 16 20:19:41 starship kernel: Mapping: Button.0006 ---> Key.PinkieBtn
Jul 16 20:19:41 starship kernel: Mapping: Button.0007 ---> Key.BaseBtn
Jul 16 20:19:41 starship kernel: Mapping: Button.0008 ---> Key.BaseBtn2
Jul 16 20:19:41 starship kernel: Mapping: Button.0009 ---> Key.BaseBtn3
Jul 16 20:19:41 starship kernel: Mapping: Button.000a ---> Key.BaseBtn4
Jul 16 20:19:41 starship kernel: Mapping: GenericDesktop.HatSwitch ---> Absolute.Hat0X
Jul 16 20:19:41 starship kernel: Mapping: GenericDesktop.X ---> Absolute.X
Jul 16 20:19:41 starship kernel: Mapping: GenericDesktop.Y ---> Absolute.Y
Jul 16 20:19:41 starship kernel: Mapping: GenericDesktop.Rz ---> Absolute.Rz
Jul 16 20:19:41 starship kernel: Mapping: GenericDesktop.00bb ---> Absolute.Misc
Jul 16 20:19:41 starship kernel: Mapping: GenericDesktop.00bb ---> Absolute.?
Jul 16 20:19:41 starship last message repeated 2 times
Jul 16 20:19:41 starship kernel: input: Thrustmaster Thrustmasterforce feedback wheel as /class/input/input6
Jul 16 20:19:41 starship kernel: Force feedback for Logitech force feedback devices by Johann Deneux <johann.deneux@it.uu.se>
Jul 16 20:19:41 starship kernel: input: USB HID v1.10 Joystick [Thrustmaster Thrustmasterforce feedback wheel] on usb-0000:00:13.1-1
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe 01 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 01 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe fe 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 fe ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -2
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:11 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff ff 00
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:11 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff ff 00
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff ff 00
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 00 ff 00
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.X = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 ff 00 00
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.X = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Y = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Wheel = 0
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report (size 4) (unnumbered)
Jul 16 20:20:12 starship kernel: drivers/hid/hid-core.c: report 0 (size 4) =  00 00 ff 00
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0001 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0002 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input Button.0003 = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.X = 0
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Y = -1
Jul 16 20:20:12 starship kernel: hid-debug: input GenericDesktop.Wheel = 0

--------------050406090804020701080005--
