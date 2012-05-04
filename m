From: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work
 in xorg or gpm
Date: Fri, 4 May 2012 05:10:32 -0300
Message-ID: <20120504081031.GA30509@hugoo.com.ar>
References: <20120503052000.GC15205@burratino>
 <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120503130821.GB16978@burratino>
 <20120503131356.GC16978@burratino>
 <20120504024054.GA19355@hugoo.com.ar>
 <20120504074137.GB6451@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from customer-static-210-108-249.iplannetworks.net ([190.210.108.249]:59974
	"EHLO hyperion.ubertech.com.ar" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751679Ab2EDIKh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 4 May 2012 04:10:37 -0400
Content-Disposition: inline
In-Reply-To: <20120504074137.GB6451@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-input@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

On 2012.05.04 02:41, Jonathan Nieder wrote:
> Hugo Osvaldo Barrera wrote:
>=20
> > Here goes, I'm pretty sure a few of the first lines aren't relevant=
, but I
> > prefer to send a couple too many instead of a couple to few :)
>=20
> Thanks!  That was fast.  I'd also be interested in the corresponding
> output from an Intel architecture machine with the same kernel versio=
n
> for comparison.
>=20
> I'm hoping some obvious difference will jump out --- otherwise I or
> some other reader will have to look at the actual code. ;-)
>=20
> Hope that helps,
> Jonathan

Here you go - *I* certainly can't make anything out of it, but hope it =
helps :)

$ uname -a
Linux hyperion 3.3.2-1-ARCH #1 SMP PREEMPT Sat Apr 14 09:48:37 CEST 201=
2 x86_64 AMD Phenom(tm) II X4 945 Processor AuthenticAMD GNU/Linux

dmesg:

<The following ONE line repeated itself 272 times.  I've snipped it for=
 readability>
[335294.173474] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335294.173485] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335294.277432] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335294.277442] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
<The following ONE line repeated itself 94 times.  I've snipped it for =
readability>
[335295.841399] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335295.841407] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335295.945386] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335295.945395] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
<The following ONE line repeated itself 110 times.  I've snipped it for=
 readability>
[335307.282816] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15

<snipped some nvidia related stuff>

<The following ONE line repeated itself 71 times.  I've snipped it for =
readability>
[335313.294547] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335313.294559] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589827
[335313.446544] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335313.446558] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589827
<The following ONE line repeated itself 65 times.  I've snipped it for =
readability>
[335317.788350] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335317.788360] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
<The following ONE line repeated itself 22 times.  I've snipped it for =
readability>
[335318.044338] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335318.044350] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
<The following ONE line repeated itself 52 times.  I've snipped it for =
readability>
[335324.738080] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335324.738089] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589827
<The following ONE line repeated itself 32 times.  I've snipped it for =
readability>
[335325.068018] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335325.068030] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589827
<The following ONE line repeated itself 30 times.  I've snipped it for =
readability>
[335325.544000] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335325.544012] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
<The following ONE line repeated itself 60 times.  I've snipped it for =
readability>
[335326.485953] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335326.485964] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
<The following ONE line repeated itself 418 times.  I've snipped it for=
 readability>
[335344.725114] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335344.725123] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335344.821117] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335344.821127] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
<The following ONE line repeated itself 60 times.  I've snipped it for =
readability>
[335346.279100] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335346.279110] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335346.351039] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335346.351050] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
<The following ONE line repeated itself 138 times.  I've snipped it for=
 readability>
[335348.654984] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335348.654992] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335348.710989] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335348.710998] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335348.774979] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335348.774990] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335348.854978] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335348.854988] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335348.910977] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335348.910986] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335348.992970] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335348.992979] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
<The following ONE line repeated itself 19 times.  I've snipped it for =
readability>
[335350.006867] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335350.006876] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589827
[335350.152884] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335350.152896] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589827
<The following ONE line repeated itself 12 times.  I've snipped it for =
readability>
[335356.852559] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335356.852571] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589827
[335356.998614] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335356.998626] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589827
<The following ONE line repeated itself 105 times.  I've snipped it for=
 readability>
[335362.902289] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335362.902298] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335362.950333] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335362.950340] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335363.006379] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335363.006387] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335363.102399] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335363.102407] drivers/hid/hid-logitech-dj.c: logi_dj_ll_input_event: =
usb-0000:00:12.1-3:1, type:4 | code:4 | value:589825
[335367.086712] drivers/hid/hid-logitech-dj.c: Logitech-DJ:logi_dj_exit
[335367.094861] drivers/hid/hid-logitech-dj.c: logi_dj_ll_close:usb-000=
0:00:12.1-3:1
[335367.095400] drivers/hid/hid-logitech-dj.c: logi_dj_ll_stop
[335367.095422] drivers/hid/hid-logitech-dj.c: logi_dj_remove
[335367.097236] usbcore: deregistering interface driver usbhid
[335367.127468] hid: hid_debug is now used solely for parser and driver=
 debugging.
[335367.127469] debugfs is now used for inspecting the device (report d=
escriptor, reports)
[335367.129430] drivers/hid/usbhid/hid-core.c: HID probe called for ifn=
um 0
[335367.129506] drivers/hid/usbhid/hid-core.c: HID probe called for ifn=
um 1
[335367.129619] drivers/hid/usbhid/hid-core.c: HID probe called for ifn=
um 0
[335367.129704] drivers/hid/usbhid/hid-core.c: HID probe called for ifn=
um 1
[335367.129752] drivers/hid/usbhid/hid-core.c: HID probe called for ifn=
um 2
[335367.131579] usbcore: registered new interface driver usbhid
[335367.131581] usbhid: USB HID core driver
[335367.132675] drivers/hid/hid-logitech-dj.c: Logitech-DJ:logi_dj_init
[335367.132685] drivers/hid/hid-logitech-dj.c: logi_dj_probe called for=
 ifnum 0
[335367.132687] drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring =
ifnum 0
[335367.132693] drivers/hid/hid-logitech-dj.c: logi_dj_probe called for=
 ifnum 1
[335367.132695] drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring =
ifnum 1
[335367.132699] drivers/hid/hid-logitech-dj.c: logi_dj_probe called for=
 ifnum 2
[335367.135370] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get=
_Report wValue=3D0x0110 wIndex=3D0x0002 wLength=3D7
[335367.137143] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get=
_Report wValue=3D0x0111 wIndex=3D0x0002 wLength=3D20
[335367.138149] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get=
_Report wValue=3D0x0120 wIndex=3D0x0002 wLength=3D15
[335367.139224] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get=
_Report wValue=3D0x0121 wIndex=3D0x0002 wLength=3D32
[335367.139557] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Set=
_Report wValue=3D0x0200 wIndex=3D0x0000 wLength=3D1
[335367.139653] input: Microsoft Microsoft=AE Digital Media Keyboard 30=
00 as /devices/pci0000:00/0000:00:13.0/usb5/5-2/5-2:1.0/input/input38
[335367.139781] microsoft 0003:045E:0730.0001: input,hidraw0: USB HID v=
1.11 Keyboard [Microsoft Microsoft=AE Digital Media Keyboard 3000] on u=
sb-0000:00:13.0-2/input0
[335367.140378] logitech-djreceiver 0003:046D:C52B.0005: hiddev0,hidraw=
1: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:12.1-3/i=
nput2
[335367.141292] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Set=
_Report wValue=3D0x0200 wIndex=3D0x0000 wLength=3D1
[335367.143343] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Set=
_Report wValue=3D0x0200 wIndex=3D0x0000 wLength=3D1
[335367.146085] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335367.146098] drivers/hid/hid-logitech-dj.c: delayedwork_callback
[335367.146146] drivers/hid/hid-logitech-dj.c: logi_dj_ll_parse
[335367.146148] drivers/hid/hid-logitech-dj.c: logi_dj_ll_parse: sendin=
g a mouse descriptor, reports_supported: 4
[335367.146247] drivers/hid/hid-logitech-dj.c: logi_dj_ll_start
[335367.146333] input: Logitech Unifying Device. Wireless PID:101a as /=
devices/pci0000:00/0000:00:12.1/usb4/4-3/4-3:1.2/0003:046D:C52B.0005/in=
put/input39
[335367.146544] logitech-djdevice 0003:046D:C52B.0006: input,hidraw2: U=
SB HID v1.11 Mouse [Logitech Unifying Device. Wireless PID:101a] on usb=
-0000:00:12.1-3:1
[335367.148082] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:=
15
[335367.148094] drivers/hid/hid-logitech-dj.c: delayedwork_callback
[335367.148096] drivers/hid/hid-logitech-dj.c: logi_dj_recv_add_djhid_d=
evice: device list is empty
[335367.155470] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get=
_Report wValue=3D0x0101 wIndex=3D0x0001 wLength=3D8
[335367.157289] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get=
_Report wValue=3D0x0103 wIndex=3D0x0001 wLength=3D2
[335367.158479] input: Microsoft Microsoft=AE Digital Media Keyboard 30=
00 as /devices/pci0000:00/0000:00:13.0/usb5/5-2/5-2:1.1/input/input40
[335367.158659] microsoft 0003:045E:0730.0002: input,hidraw3: USB HID v=
1.11 Device [Microsoft Microsoft=AE Digital Media Keyboard 3000] on usb=
-0000:00:13.0-2/input1
[335367.176697] drivers/hid/hid-logitech-dj.c: logi_dj_ll_open:usb-0000=
:00:12.1-3:1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
