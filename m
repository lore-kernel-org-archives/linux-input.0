Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121A44F54D
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314828; cv=none; b=o+bDjbwe1YdLJI/WVXBfB+7CsRhoaMf38Wyc5/x3lkHMPzTrD5Lhhoou6/cBuyrEaWPTeSpXGMZjrCvWGx6JDc0yqz82Ho/kjcUciJm3tVatKEe6jmVeQByxXxYPsyyBzqMlE1tQk9sdMC7ZdsuNEQ6mU6EfEQM13AIb5/S09xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314828; c=relaxed/simple;
	bh=s4Kn4SN4wfnbEYVaRjPSS85XwAMkY30h72dShwkKDIo=;
	h=Date:From:To:Cc:Message-ID:References:Subject:MIME-Version:
	 Content-Type; b=Yk1tNkUpFKQf4l1gtPcgnc0KFgtkrpg9kloiB4FN9Rmxz50XOOuDs0Y+HLWazVfGhCTV7jAME7RfO+bAj6qdausreIJItQuskXiajfFpElKWYFwHsX/CnKk/UKJOI5HOxEYEYmyDPufgIkIvF+zRgqxSTxT5+Y3llwkrWZDJBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=QqKvPRfC; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="QqKvPRfC"
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 255F8193F3750
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 11:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792314819;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=3Dm0jMVazmmo9bQulkGdxbMWyv0IOUddbUPNy26mxwY=;
	b=QqKvPRfCIYOP/zLGe5torJVsKum5eM25bjdbYNFh0fRW6gRMcSauQ3gyhXEJ0GPA
	peL9ii+CDnaAPY5FIMl1vgYvPhzq4dJH3hf/WgWN2rKhUZLCn6YYbDNX62zCzHc0wdH
	5A5CZ/BC8baJ9aChbBBm4rMtUauVoFKOe8DENiKHh5HAJoWdzDvVIqUBLhKe1juSB9m
	Km8HLYyGl4CPr/GnC55slk5AX1xjtnWoMsIlpGw7Xs7Fa33TL8MPp+jkEDlc0T3m/VA
	JvW4RwN0e9D2VpuVJimBGyNqWs+s95/dSzX12S9Vc2J5wOr452wHeqv1crBoKh04a2b
	qzrEw2J+Sg==
Date: Sun, 18 Oct 2026 11:13:39 +0200 (CEST)
From: willowswaving@tutamail.com
To: Linux Input <linux-input@vger.kernel.org>
Cc: Jikos <jikos@kernel.org>, Bentiss <bentiss@kernel.org>
Message-ID: <P4DHMrF--F-9@tutamail.com>
References: <P46njqS--N-9@tutamail.com>
Subject: FWD: [RFC] HID: uclogic: Add support for Xencelabs Pen Display
 (28bd:520d) and request for switch-to-vendor-mode sequence
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8613_1402475429.1792314819145"
Feedback-ID: 015fe4ab774a31809b4b05b8c610ead356bcc03e5c866e6007fd3e8866c7c0a22bb5af78b76e2b2d682867fe72df3c2e2eae226386f9c0a8fc7fe2cb63b896dd32:TurnOnPrivacy!:tutamail

------=_Part_8613_1402475429.1792314819145
Content-Type: multipart/alternative; 
	boundary="----=_Part_8614_1153692763.1792314819145"

------=_Part_8614_1153692763.1792314819145
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


fyi
=E6=97=A5=E6=9C=9F: 2026/10/17 11:02
=E5=8F=91=E4=BB=B6=E4=BA=BA: willowswaving@tutamail.com
=E5=8F=91=E9=80=81=E8=87=B3: linux-input@vger.kernel.org
=E4=B8=BB=E9=A2=98: [RFC] HID: uclogic: Add support for Xencelabs Pen Displ=
ay (28bd:520d) and request for switch-to-vendor-mode sequence


> Hello,
>
> I would like to report a missing device support in the hid-uclogic
> driver, and ask for guidance on how to properly add it.
>
> Device information
> ------------------
> =C2=A0 Name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Xencelabs Pen Display
> =C2=A0 Vendor ID:=C2=A0 0x28bd (Hanvon Ugee / XP-Pen)
> =C2=A0 Product ID: 0x520d
> =C2=A0 Firmware:=C2=A0=C2=A0 20250121(230322)
> =C2=A0 Model:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UG902_LPH2412_P10
>
> Problem
> -------
> The device is not handled by hid-uclogic. With hid-generic, the device
> is registered only as a mouse and no pen events (ABS_X, ABS_Y,
> ABS_PRESSURE, ABS_TILT) are reported to userspace.
>
> When I add the device ID to hid-uclogic-core.c, the driver binds, but
> the resulting interface is still a mouse. evtest shows no pen events.
> This suggests the device is still in "firmware mode" and never gets
> switched into the vendor reporting mode that exposes the pen interface.
>
> Key observations from testing
> -----------------------------
> 1. lsusb reports only one interface (bNumInterfaces =3D 1, interface 0,
> =C2=A0=C2=A0 HID class, mouse). It has only two interrupt endpoints:
> =C2=A0=C2=A0=C2=A0=C2=A0 - 0x81 (IN, 64 bytes)
> =C2=A0=C2=A0=C2=A0=C2=A0 - 0x01 (OUT, 64 bytes)
> =C2=A0=C2=A0 Note: There is NO endpoint 0x03, which is the endpoint used =
by
> =C2=A0=C2=A0 uclogic_ugee_v2_probe_endpoint in hid-uclogic-params.c. Any =
attempt
> =C2=A0=C2=A0 to send magic bytes to 0x03 fails with "Invalid endpoint add=
ress".
>
> 2. Reading the string descriptor at index 0x64 under LANGID 0x0409
> =C2=A0=C2=A0 successfully returns a 14-byte binary blob (13 bytes of cont=
ent).
> =C2=A0=C2=A0 Raw HEX: 0e03289a78e60300ff1fd8130100
> =C2=A0=C2=A0 (Other indexes return normal strings like the serial number =
and
> =C2=A0=C2=A0 "hanvon ugee Tech"). Reading index 0x64 does NOT switch the =
device.
>
> 3. Sending the UGEE v2 magic bytes (02 b0 04 00 00 00 00 00 00 00)
> =C2=A0=C2=A0 via SET_REPORT (Feature 0x02, Output 0x02, Feature 0x03) ret=
urns
> =C2=A0=C2=A0 success, but the device never re-enumerates.
>
> 4. A vendor-specific control request (bRequest 0xb0, wValue 0x0402)
> =C2=A0=C2=A0 times out.
>
> 5. Note: Sending unexpected control transfers to this device can cause
> =C2=A0=C2=A0 the USB HID interface to hang. It requires a complete power =
cycle
> =C2=A0=C2=A0 (unplugging USB and power) to recover.
>
> Request
> -------
> Could someone with access to the Xencelabs USB documentation, or
> someone who has reverse-engineered the 520d, share the correct
> sequence to switch this device into vendor mode?
>
> Specifically:
> =C2=A0 - Is the 0x64 string descriptor read the right trigger, or is a
> =C2=A0=C2=A0=C2=A0 specific control transfer required?
> =C2=A0 - If a control transfer is needed, what is the correct bRequest,
> =C2=A0=C2=A0=C2=A0 wValue, wIndex, and endpoint?
> =C2=A0 - Are there known quirks for this device?
>
> If a capture from the Windows driver is needed, I can provide one.
> If you have any hints, I will be happy to prepare a proper patch
> with hid-uclogic-params.c changes and re-test.
>
> I am attaching the text files with:
> =C2=A0 - lsusb -v output for 28bd:520d
> =C2=A0 - the raw HID report descriptor (usbhid-dump)
> =C2=A0 - the string descriptor enumeration (showing 0x64)
> =C2=A0 - dmesg logs showing the binding behavior.
>
> Thank you very much for your time.
>
> Best regards,
> Willows
>
> --
> =C2=A0> https://tuta.com/free-email
>


------=_Part_8614_1153692763.1792314819145
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
<div dir=3D"auto"><br></div><div dir=3D"auto">fyi</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">=E6=97=A5=E6=9C=9F: 2026/10/17 11:02<br></div><di=
v dir=3D"auto">=E5=8F=91=E4=BB=B6=E4=BA=BA: willowswaving@tutamail.com<br><=
/div><div dir=3D"auto">=E5=8F=91=E9=80=81=E8=87=B3: linux-input@vger.kernel=
.org<br></div><div dir=3D"auto">=E4=B8=BB=E9=A2=98: [RFC] HID: uclogic: Add=
 support for Xencelabs Pen Display (28bd:520d) and request for switch-to-ve=
ndor-mode sequence<br></div><div dir=3D"auto"><br></div><blockquote class=
=3D"tutanota_quote" style=3D"border-left: 1px solid #93A3B8; padding-left: =
10px; margin-left: 5px;"><div dir=3D"auto">Hello,<br></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">I would like to report a missing device suppo=
rt in the hid-uclogic<br></div><div dir=3D"auto">driver, and ask for guidan=
ce on how to properly add it.<br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Device information<br></div><div dir=3D"auto">------------------<=
br></div><div dir=3D"auto">&nbsp; Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Xencelabs Pen Display<br></div><div dir=3D"auto">&nbsp; Vendor ID:&nbsp; 0=
x28bd (Hanvon Ugee / XP-Pen)<br></div><div dir=3D"auto">&nbsp; Product ID: =
0x520d<br></div><div dir=3D"auto">&nbsp; Firmware:&nbsp;&nbsp; 20250121(230=
322)<br></div><div dir=3D"auto">&nbsp; Model:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 UG902_LPH2412_P10<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">P=
roblem<br></div><div dir=3D"auto">-------<br></div><div dir=3D"auto">The de=
vice is not handled by hid-uclogic. With hid-generic, the device<br></div><=
div dir=3D"auto">is registered only as a mouse and no pen events (ABS_X, AB=
S_Y,<br></div><div dir=3D"auto">ABS_PRESSURE, ABS_TILT) are reported to use=
rspace.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">When I add t=
he device ID to hid-uclogic-core.c, the driver binds, but<br></div><div dir=
=3D"auto">the resulting interface is still a mouse. evtest shows no pen eve=
nts.<br></div><div dir=3D"auto">This suggests the device is still in "firmw=
are mode" and never gets<br></div><div dir=3D"auto">switched into the vendo=
r reporting mode that exposes the pen interface.<br></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Key observations from testing<br></div><div di=
r=3D"auto">-----------------------------<br></div><div dir=3D"auto">1. lsus=
b reports only one interface (bNumInterfaces =3D 1, interface 0,<br></div><=
div dir=3D"auto">&nbsp;&nbsp; HID class, mouse). It has only two interrupt =
endpoints:<br></div><div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp; - 0x81 (IN, =
64 bytes)<br></div><div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp; - 0x01 (OUT, =
64 bytes)<br></div><div dir=3D"auto">&nbsp;&nbsp; Note: There is NO endpoin=
t 0x03, which is the endpoint used by<br></div><div dir=3D"auto">&nbsp;&nbs=
p; uclogic_ugee_v2_probe_endpoint in hid-uclogic-params.c. Any attempt<br><=
/div><div dir=3D"auto">&nbsp;&nbsp; to send magic bytes to 0x03 fails with =
"Invalid endpoint address".<br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">2. Reading the string descriptor at index 0x64 under LANGID 0x040=
9<br></div><div dir=3D"auto">&nbsp;&nbsp; successfully returns a 14-byte bi=
nary blob (13 bytes of content).<br></div><div dir=3D"auto">&nbsp;&nbsp; Ra=
w HEX: 0e03289a78e60300ff1fd8130100<br></div><div dir=3D"auto">&nbsp;&nbsp;=
 (Other indexes return normal strings like the serial number and<br></div><=
div dir=3D"auto">&nbsp;&nbsp; "hanvon ugee Tech"). Reading index 0x64 does =
NOT switch the device.<br></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">3. Sending the UGEE v2 magic bytes (02 b0 04 00 00 00 00 00 00 00)<br></=
div><div dir=3D"auto">&nbsp;&nbsp; via SET_REPORT (Feature 0x02, Output 0x0=
2, Feature 0x03) returns<br></div><div dir=3D"auto">&nbsp;&nbsp; success, b=
ut the device never re-enumerates.<br></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">4. A vendor-specific control request (bRequest 0xb0, wValue =
0x0402)<br></div><div dir=3D"auto">&nbsp;&nbsp; times out.<br></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">5. Note: Sending unexpected control =
transfers to this device can cause<br></div><div dir=3D"auto">&nbsp;&nbsp; =
the USB HID interface to hang. It requires a complete power cycle<br></div>=
<div dir=3D"auto">&nbsp;&nbsp; (unplugging USB and power) to recover.<br></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Request<br></div><div dir=
=3D"auto">-------<br></div><div dir=3D"auto">Could someone with access to t=
he Xencelabs USB documentation, or<br></div><div dir=3D"auto">someone who h=
as reverse-engineered the 520d, share the correct<br></div><div dir=3D"auto=
">sequence to switch this device into vendor mode?<br></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Specifically:<br></div><div dir=3D"auto">&nb=
sp; - Is the 0x64 string descriptor read the right trigger, or is a<br></di=
v><div dir=3D"auto">&nbsp;&nbsp;&nbsp; specific control transfer required?<=
br></div><div dir=3D"auto">&nbsp; - If a control transfer is needed, what i=
s the correct bRequest,<br></div><div dir=3D"auto">&nbsp;&nbsp;&nbsp; wValu=
e, wIndex, and endpoint?<br></div><div dir=3D"auto">&nbsp; - Are there know=
n quirks for this device?<br></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">If a capture from the Windows driver is needed, I can provide one.<br=
></div><div dir=3D"auto">If you have any hints, I will be happy to prepare =
a proper patch<br></div><div dir=3D"auto">with hid-uclogic-params.c changes=
 and re-test.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">I am a=
ttaching the text files with:<br></div><div dir=3D"auto">&nbsp; - lsusb -v =
output for 28bd:520d<br></div><div dir=3D"auto">&nbsp; - the raw HID report=
 descriptor (usbhid-dump)<br></div><div dir=3D"auto">&nbsp; - the string de=
scriptor enumeration (showing 0x64)<br></div><div dir=3D"auto">&nbsp; - dme=
sg logs showing the binding behavior.<br></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Thank you very much for your time.<br></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Best regards,<br></div><div dir=3D"auto">W=
illows<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">--<br></div><=
div dir=3D"auto">&nbsp;<a href=3D"https://tuta.com/free-email" rel=3D"noope=
ner noreferrer" target=3D"_blank">https://tuta.com/free-email</a><br></div>=
</blockquote><div dir=3D"auto"><br></div>  </body>
</html>

------=_Part_8614_1153692763.1792314819145--

------=_Part_8613_1402475429.1792314819145
Content-Type: text/plain; charset=us-ascii; name=lsusb-v-520d.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lsusb-v-520d.txt


Bus 004 Device 013: ID 28bd:520d XP-Pen Xencelabs Pen Display
Negotiated speed: Full Speed (12Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x28bd XP-Pen
  idProduct          0x520d Xencelabs Pen Display
  bcdDevice            0.00
  iManufacturer           1 hanvon ugee
  iProduct                2 Xencelabs Pen Display
  iSerial                 3 XP317BV1003174
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0029
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      0 
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     143
          Report Descriptors: 
            ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

------=_Part_8613_1402475429.1792314819145
Content-Type: text/plain; charset=UTF-8; name=string-descriptors.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=string-descriptors.txt

Found device: Bus 4 Device 13
Supported LANGIDs: ['0x409']

--- LANGID 0x0409 ---
  Index 0x00 (4 bytes): '=D0=89'
  Index 0x01 (24 bytes): 'hanvon ugee'
  Index 0x02 (44 bytes): 'Xencelabs Pen Display'
  Index 0x03 (38 bytes): 'XP317BV1003174'
  Index 0x04 (36 bytes): 'UG902_LPH2412_P10'
  Index 0x05 (34 bytes): '20250121(230322)'
  Index 0x64 (14 bytes): '=E9=A8=A8\ue678\x03\u1fff=E1=8F=98\x01'
    RAW HEX: 0e03289a78e60300ff1fd8130100
  Index 0x66 (34 bytes): 'hanvon ugee Tech'
    RAW HEX: 2203680061006e0076006f006e002000750067006500650020005400650063=
006800
  Index 0x67 (8 bytes): '=E9=9A=B1=E3=90=B3=E3=90=B0'
    RAW HEX: 0803b19633343034
  Index 0x68 (6 bytes): '=C4=82!'
  Index 0x69 (4 bytes): '\x02'
  Index 0x6e (10 bytes): '\u3000\x00\x00=E4=90=83'
  Index 0x83 (6 bytes): '=D0=81\u2000'

------=_Part_8613_1402475429.1792314819145
Content-Type: text/plain; charset=us-ascii; name=usbhid-dump-descriptor.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=usbhid-dump-descriptor.txt

004:013:000:DESCRIPTOR         1792205225.769689
 06 0A FF 09 01 A1 01 85 02 09 02 75 08 95 1F 15
 00 26 FF 00 81 02 09 03 75 08 95 20 15 00 26 FF
 00 91 02 C0 05 0D 09 02 A1 01 85 07 09 20 A1 00
 09 42 09 44 09 45 09 46 09 3C 15 00 25 01 75 01
 95 05 81 02 09 32 95 01 81 02 95 02 81 03 75 10
 95 01 35 00 A4 05 01 09 30 65 13 55 0D 46 64 CC
 26 50 57 81 02 09 31 46 A0 73 26 92 36 81 02 B4
 09 30 45 00 26 FF 1F 81 42 09 3D 15 81 25 7F 75
 08 95 01 81 02 09 3E 15 81 25 7F 81 02 C0 C0


------=_Part_8613_1402475429.1792314819145
Content-Type: text/plain; charset=us-ascii; name=dmesg-binding.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg-binding.txt

[    2.723183] hid-generic 0003:09DA:6406.0001: input,hidraw0: USB HID v1.11 Keyboard [A4tech A4tech KB] on usb-0000:00:14.0-3/input0
[    2.778037] hid-generic 0003:09DA:6406.0002: input,hiddev96,hidraw1: USB HID v1.11 Device [A4tech A4tech KB] on usb-0000:00:14.0-3/input1
[    3.016559] hid-generic 0003:23E5:A2F9.0003: hiddev97,hidraw2: USB HID v1.11 Device [Antelope Audio Zen Quadro SC] on usb-0000:00:14.0-4/input3
[    3.030171] hid-generic 0003:2022:0522.0004: hiddev98,hidraw3: USB HID v1.10 Device [DINK_HID_DEVICE DINK_HID_DEVICE] on usb-0000:00:1a.0-1.2/input0
[    3.408966] hid-generic 0003:0403:6030.0005: hidraw4: USB HID v1.11 Device [FTDI FT260] on usb-0000:00:1d.0-1.7.1/input0
[    3.411009] hid-generic 0003:0403:6030.0006: hidraw5: USB HID v1.11 Device [FTDI FT260] on usb-0000:00:1d.0-1.7.1/input1
[  671.015347] hid-generic 0005:046D:B036.0007: input,hidraw4: BLUETOOTH HID v0.06 Mouse [Pebble M350s] on ec:ed:04:94:96:15
[ 1662.091759] usb 4-1.8.3: New USB device found, idVendor=28bd, idProduct=520d, bcdDevice= 0.00
[ 1662.093419] input: hanvon ugee Xencelabs Pen Display as /devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.8/4-1.8.3/4-1.8.3:1.0/0003:28BD:520D.000A/input/input21
[ 1662.093514] input: hanvon ugee Xencelabs Pen Display Stylus as /devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.8/4-1.8.3/4-1.8.3:1.0/0003:28BD:520D.000A/input/input22
[ 1662.093729] hid-generic 0003:28BD:520D.000A: input,hiddev99,hidraw5: USB HID v1.00 Device [hanvon ugee Xencelabs Pen Display] on usb-0000:00:1d.0-1.8.3/input0
[ 1662.164066] input: hanvon ugee Xencelabs Pen Display Mouse as /devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.8/4-1.8.3/4-1.8.3:1.0/0003:28BD:520D.000A/input/input23
[ 1662.164270] uclogic 0003:28BD:520D.000A: input,hidraw5: USB HID v1.00 Mouse [hanvon ugee Xencelabs Pen Display] on usb-0000:00:1d.0-1.8.3/input0
[ 1965.125557] input: hanvon ugee Xencelabs Pen Display Mouse as /devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.8/4-1.8.3/4-1.8.3:1.0/0003:28BD:520D.000B/input/input24
[ 1965.125803] uclogic 0003:28BD:520D.000B: input,hidraw5: USB HID v1.00 Mouse [hanvon ugee Xencelabs Pen Display] on usb-0000:00:1d.0-1.8.3/input0

------=_Part_8613_1402475429.1792314819145--
