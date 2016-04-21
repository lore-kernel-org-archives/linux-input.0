From: Shekhar arya <shadowcat.arya@gmail.com>
Subject: Re: Microsoft wireless usb mouse frequently fails to detect in ubuntu
	15.10/16.04
Date: Thu, 21 Apr 2016 10:26:23 +0530
Message-ID: <CADp7L1txjh_39vwD_xZrqVGbSYtAirker=TT+r3to+ZkczdWkA@mail.gmail.com>
References: <20160421045301.GC7267@grey>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4170438136823841845=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <20160421045301.GC7267@grey>
List-Unsubscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, kernelnewbies@kernelnewbies.org, kernel-bugs@lists.ubuntu.com, kernel-team@lists.ubuntu.com
List-Id: linux-input@vger.kernel.org

--===============4170438136823841845==
Content-Type: multipart/alternative; boundary=001a1139465432a68a0530f788d1

--001a1139465432a68a0530f788d1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

++ adding ubuntu kernel team

On Thu, Apr 21, 2016 at 10:23 AM, rootsr <shadowcat.arya@gmail.com> wrote:

> Hello all,
>
> I am using ubuntu 16.04 (upgraded yesterday from 15.10) on Dell inspiron
> 15 3000 series (core i7). While using Microsoft wireless mouse, it fails =
to
> detect most of the time. The issue is not there when I use the same mouse
> in Windows / other linux distro / TV / PS4 etc.
> Here is the Kernel log for the failure.
> ----------------------------------------------------
> [   74.186391] usb 1-1.3: new full-speed USB device number 7 using ehci-p=
ci
> [   74.258396] usb 1-1.3: device descriptor read/64, error -32
> [   74.434356] usb 1-1.3: device descriptor read/64, error -32
> [   74.610315] usb 1-1.3: new full-speed USB device number 8 using ehci-p=
ci
> [   74.682322] usb 1-1.3: device descriptor read/64, error -32
> [   74.858322] usb 1-1.3: device descriptor read/64, error -32
> [   75.034320] usb 1-1.3: new full-speed USB device number 9 using ehci-p=
ci
> [   75.446330] usb 1-1.3: device not accepting address 9, error -32
> [   75.518334] usb 1-1.3: new full-speed USB device number 10 using
> ehci-pci
> [   75.926331] usb 1-1.3: device not accepting address 10, error -32
> [   75.926400] usb 1-1-port3: unable to enumerate USB device
> [   93.835769] usb 1-1.3: new full-speed USB device number 11 using
> ehci-pci
> [   93.908028] usb 1-1.3: device descriptor read/64, error -32
> [   94.084569] usb 1-1.3: device descriptor read/64, error -32
> [   94.261110] usb 1-1.3: new full-speed USB device number 12 using
> ehci-pci
> [   94.333337] usb 1-1.3: device descriptor read/64, error -32
> [   94.509893] usb 1-1.3: device descriptor read/64, error -32
> [   94.686342] usb 1-1.3: new full-speed USB device number 13 using
> ehci-pci
> [   95.095548] usb 1-1.3: device not accepting address 13, error -32
> [   95.167686] usb 1-1.3: new full-speed USB device number 14 using
> ehci-pci
> [   95.576740] usb 1-1.3: device not accepting address 14, error -32
> [   95.576848] usb 1-1-port3: unable to enumerate USB device
> -----------------------------------------------------------------
>
> After multiple connect/disconnect of the wireless dongle, it finally
> detects. Here is the detection log.
> ------------------------------------------------------
> [  110.221269] usb 1-1.3: new full-speed USB device number 15 using
> ehci-pci
> [  110.319427] usb 1-1.3: New USB device found, idVendor=3D045e,
> idProduct=3D0745
> [  110.319431] usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D0
> [  110.319433] usb 1-1.3: Product: Microsoft=C2=AE 2.4GHz Transceiver v8.=
0
> [  110.319435] usb 1-1.3: Manufacturer: Microsoft
> [  110.361146] usbcore: registered new interface driver usbhid
> [  110.361151] usbhid: USB HID core driver
> [  110.380274] input: Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.0 a=
s
> /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.3/1-1.3:1.0/0003:045E:0745.=
0002/input/input14
> [  110.433886] hid-generic 0003:045E:0745.0002: input,hidraw1: USB HID
> v1.11 Keyboard [Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.0] on
> usb-0000:00:1d.0-1.3/input0
> [  110.434274] input: Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.0 a=
s
> /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.3/1-1.3:1.1/0003:045E:0745.=
0003/input/input15
> [  110.489634] hid-generic 0003:045E:0745.0003: input,hidraw2: USB HID
> v1.11 Mouse [Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.0] on
> usb-0000:00:1d.0-1.3/input1
> [  110.500335] input: Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.0 a=
s
> /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.3/1-1.3:1.2/0003:045E:0745.=
0004/input/input16
> [  110.553640] hid-generic 0003:045E:0745.0004: input,hiddev0,hidraw3: US=
B
> HID v1.11 Device [Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.0] on
> usb-0000:00:1d.0-1.3/input2
> -------------------------------------------------------------
>
> I am not sure of this weird behaviour. Is there some issue with ubuntu
> kernel for input device? or is there a problem with microsoft mouse drive=
r?
>
>
> regards
>  -Shekhar
>

--001a1139465432a68a0530f788d1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:comic sa=
ns ms,sans-serif;color:rgb(11,83,148)">++ adding ubuntu kernel team<br></di=
v><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Apr 21,=
 2016 at 10:23 AM, rootsr <span dir=3D"ltr">&lt;<a href=3D"mailto:shadowcat=
.arya@gmail.com" target=3D"_blank">shadowcat.arya@gmail.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Hello all,<br>
<br>
I am using ubuntu 16.04 (upgraded yesterday from 15.10) on Dell inspiron 15=
 3000 series (core i7). While using Microsoft wireless mouse, it fails to d=
etect most of the time. The issue is not there when I use the same mouse in=
 Windows / other linux distro / TV / PS4 etc.<br>
Here is the Kernel log for the failure.<br>
----------------------------------------------------<br>
[=C2=A0 =C2=A074.186391] usb 1-1.3: new full-speed USB device number 7 usin=
g ehci-pci<br>
[=C2=A0 =C2=A074.258396] usb 1-1.3: device descriptor read/64, error -32<br=
>
[=C2=A0 =C2=A074.434356] usb 1-1.3: device descriptor read/64, error -32<br=
>
[=C2=A0 =C2=A074.610315] usb 1-1.3: new full-speed USB device number 8 usin=
g ehci-pci<br>
[=C2=A0 =C2=A074.682322] usb 1-1.3: device descriptor read/64, error -32<br=
>
[=C2=A0 =C2=A074.858322] usb 1-1.3: device descriptor read/64, error -32<br=
>
[=C2=A0 =C2=A075.034320] usb 1-1.3: new full-speed USB device number 9 usin=
g ehci-pci<br>
[=C2=A0 =C2=A075.446330] usb 1-1.3: device not accepting address 9, error -=
32<br>
[=C2=A0 =C2=A075.518334] usb 1-1.3: new full-speed USB device number 10 usi=
ng ehci-pci<br>
[=C2=A0 =C2=A075.926331] usb 1-1.3: device not accepting address 10, error =
-32<br>
[=C2=A0 =C2=A075.926400] usb 1-1-port3: unable to enumerate USB device<br>
[=C2=A0 =C2=A093.835769] usb 1-1.3: new full-speed USB device number 11 usi=
ng ehci-pci<br>
[=C2=A0 =C2=A093.908028] usb 1-1.3: device descriptor read/64, error -32<br=
>
[=C2=A0 =C2=A094.084569] usb 1-1.3: device descriptor read/64, error -32<br=
>
[=C2=A0 =C2=A094.261110] usb 1-1.3: new full-speed USB device number 12 usi=
ng ehci-pci<br>
[=C2=A0 =C2=A094.333337] usb 1-1.3: device descriptor read/64, error -32<br=
>
[=C2=A0 =C2=A094.509893] usb 1-1.3: device descriptor read/64, error -32<br=
>
[=C2=A0 =C2=A094.686342] usb 1-1.3: new full-speed USB device number 13 usi=
ng ehci-pci<br>
[=C2=A0 =C2=A095.095548] usb 1-1.3: device not accepting address 13, error =
-32<br>
[=C2=A0 =C2=A095.167686] usb 1-1.3: new full-speed USB device number 14 usi=
ng ehci-pci<br>
[=C2=A0 =C2=A095.576740] usb 1-1.3: device not accepting address 14, error =
-32<br>
[=C2=A0 =C2=A095.576848] usb 1-1-port3: unable to enumerate USB device<br>
-----------------------------------------------------------------<br>
<br>
After multiple connect/disconnect of the wireless dongle, it finally detect=
s. Here is the detection log.<br>
------------------------------------------------------<br>
[=C2=A0 110.221269] usb 1-1.3: new full-speed USB device number 15 using eh=
ci-pci<br>
[=C2=A0 110.319427] usb 1-1.3: New USB device found, idVendor=3D045e, idPro=
duct=3D0745<br>
[=C2=A0 110.319431] usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2=
, SerialNumber=3D0<br>
[=C2=A0 110.319433] usb 1-1.3: Product: Microsoft=C2=AE 2.4GHz Transceiver =
v8.0<br>
[=C2=A0 110.319435] usb 1-1.3: Manufacturer: Microsoft<br>
[=C2=A0 110.361146] usbcore: registered new interface driver usbhid<br>
[=C2=A0 110.361151] usbhid: USB HID core driver<br>
[=C2=A0 110.380274] input: Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.=
0 as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.3/1-1.3:1.0/0003:045E:07=
45.0002/input/input14<br>
[=C2=A0 110.433886] hid-generic 0003:045E:0745.0002: input,hidraw1: USB HID=
 v1.11 Keyboard [Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.0] on usb-=
0000:00:1d.0-1.3/input0<br>
[=C2=A0 110.434274] input: Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.=
0 as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.3/1-1.3:1.1/0003:045E:07=
45.0003/input/input15<br>
[=C2=A0 110.489634] hid-generic 0003:045E:0745.0003: input,hidraw2: USB HID=
 v1.11 Mouse [Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.0] on usb-000=
0:00:1d.0-1.3/input1<br>
[=C2=A0 110.500335] input: Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.=
0 as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.3/1-1.3:1.2/0003:045E:07=
45.0004/input/input16<br>
[=C2=A0 110.553640] hid-generic 0003:045E:0745.0004: input,hiddev0,hidraw3:=
 USB HID v1.11 Device [Microsoft Microsoft=C2=AE 2.4GHz Transceiver v8.0] o=
n usb-0000:00:1d.0-1.3/input2<br>
-------------------------------------------------------------<br>
<br>
I am not sure of this weird behaviour. Is there some issue with ubuntu kern=
el for input device? or is there a problem with microsoft mouse driver?<br>
<br>
<br>
regards<br>
=C2=A0-Shekhar<br>
</blockquote></div><br></div></div>

--001a1139465432a68a0530f788d1--


--===============4170438136823841845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============4170438136823841845==--
