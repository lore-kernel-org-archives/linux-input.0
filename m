From: Florian Echtler <floe@butterbrot.org>
Subject: Inactive keyboard on Acer Aspire Switch 11
Date: Fri, 27 Feb 2015 00:18:39 +0100
Message-ID: <54EFA9CF.6000100@butterbrot.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VkrUcptSO4BoS5Lvl8rh1SSsPkxiXTcPM"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:58292 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976AbbBZXSl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 18:18:41 -0500
Received: from [192.168.178.34] (ppp-212-114-237-254.dynamic.mnet-online.de [212.114.237.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by butterbrot.org (Postfix) with ESMTPSA id B9F0D5C005FF
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2015 00:18:40 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VkrUcptSO4BoS5Lvl8rh1SSsPkxiXTcPM
Content-Type: multipart/mixed;
 boundary="------------070704080103010104040007"

This is a multi-part message in MIME format.
--------------070704080103010104040007
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I've recently bought an Acer Aspire Switch 11 convertible
tablet/notebook hybrid device. Ubuntu 14.04.2 with kernel 3.16 runs
almost perfectly, with one notable exception: on the keyboard dock, only
the touchpad works, not the keyboard itself. I've done a bit of digging
in the logs, and found the following error messages relating to HID:

[    8.790574] hidraw: raw HID events driver (C) Jiri Kosina
[    8.796341] hid (null): usage index exceeded
[    8.845668] usbcore: registered new interface driver usbhid
[    8.845671] usbhid: USB HID core driver
[   19.593717] hid-multitouch 0003:06CB:2991.0002:
input,hiddev0,hidraw0: USB HID v1.10 Mouse [ITE Tech. Inc. ITE
Device(8595)] on usb-0000:00:14.0-4.3/input1
[   19.594268] hid-rmi 0003:06CB:2991.0001: usage index exceeded
[   19.594274] hid-rmi 0003:06CB:2991.0001: item 0 2 2 2 parsing failed
[   19.594288] hid-rmi 0003:06CB:2991.0001: parse failed
[   19.594301] hid-rmi: probe of 0003:06CB:2991.0001 failed with error -2=
2
[   19.609228] hid-multitouch 0018:06CB:77B2.0004: input,hidraw1:
<UNKNOWN> HID v1.00 Mouse [SYNA7508:00 06CB:77B2] on
[   19.924619] i2c_hid i2c-ITE8380:00: error in i2c_hid_init_report
size:19 / ret_size:18

The device in question has two endpoints:

T:  Bus=3D02 Lev=3D02 Prnt=3D04 Port=3D02 Cnt=3D01 Dev#=3D  7 Spd=3D12  M=
xCh=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D06cb ProdID=3D2991 Rev=3D00.06
S:  Manufacturer=3DITE Tech. Inc.
S:  Product=3DITE Device(8595)
C:  #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Driver=
=3Dusbhid
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Driver=
=3Dusbhid

According to lsusb, the second one is a mouse (=3D touchpad), while the
first one is a keyboard (see attached lsusb.txt). Judging from the
dmesg, this is also the one which fails to initialize. Can anyone
suggest any quirks/fixes to try here?

Thanks & best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL

--------------070704080103010104040007
Content-Type: text/plain; charset=UTF-8;
 name="lsusb.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lsusb.txt"

QnVzIDAwMiBEZXZpY2UgMDA3OiBJRCAwNmNiOjI5OTEgU3luYXB0aWNzLCBJbmMuIApEZXZp
Y2UgRGVzY3JpcHRvcjoKICBiTGVuZ3RoICAgICAgICAgICAgICAgIDE4CiAgYkRlc2NyaXB0
b3JUeXBlICAgICAgICAgMQogIGJjZFVTQiAgICAgICAgICAgICAgIDIuMDAKICBiRGV2aWNl
Q2xhc3MgICAgICAgICAgICAwIChEZWZpbmVkIGF0IEludGVyZmFjZSBsZXZlbCkKICBiRGV2
aWNlU3ViQ2xhc3MgICAgICAgICAwIAogIGJEZXZpY2VQcm90b2NvbCAgICAgICAgIDAgCiAg
Yk1heFBhY2tldFNpemUwICAgICAgICA2NAogIGlkVmVuZG9yICAgICAgICAgICAweDA2Y2Ig
U3luYXB0aWNzLCBJbmMuCiAgaWRQcm9kdWN0ICAgICAgICAgIDB4Mjk5MSAKICBiY2REZXZp
Y2UgICAgICAgICAgICAwLjA2CiAgaU1hbnVmYWN0dXJlciAgICAgICAgICAgMSBJVEUgVGVj
aC4gSW5jLgogIGlQcm9kdWN0ICAgICAgICAgICAgICAgIDIgSVRFIERldmljZSg4NTk1KQog
IGlTZXJpYWwgICAgICAgICAgICAgICAgIDAgCiAgYk51bUNvbmZpZ3VyYXRpb25zICAgICAg
MQogIENvbmZpZ3VyYXRpb24gRGVzY3JpcHRvcjoKICAgIGJMZW5ndGggICAgICAgICAgICAg
ICAgIDkKICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDIKICAgIHdUb3RhbExlbmd0aCAg
ICAgICAgICAgNjYKICAgIGJOdW1JbnRlcmZhY2VzICAgICAgICAgIDIKICAgIGJDb25maWd1
cmF0aW9uVmFsdWUgICAgIDEKICAgIGlDb25maWd1cmF0aW9uICAgICAgICAgIDAgCiAgICBi
bUF0dHJpYnV0ZXMgICAgICAgICAweGUwCiAgICAgIFNlbGYgUG93ZXJlZAogICAgICBSZW1v
dGUgV2FrZXVwCiAgICBNYXhQb3dlciAgICAgICAgICAgICAgMTAwbUEKICAgIEludGVyZmFj
ZSBEZXNjcmlwdG9yOgogICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5CiAgICAgIGJE
ZXNjcmlwdG9yVHlwZSAgICAgICAgIDQKICAgICAgYkludGVyZmFjZU51bWJlciAgICAgICAg
MAogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAgICAwCiAgICAgIGJOdW1FbmRwb2ludHMg
ICAgICAgICAgIDEKICAgICAgYkludGVyZmFjZUNsYXNzICAgICAgICAgMyBIdW1hbiBJbnRl
cmZhY2UgRGV2aWNlCiAgICAgIGJJbnRlcmZhY2VTdWJDbGFzcyAgICAgIDEgQm9vdCBJbnRl
cmZhY2UgU3ViY2xhc3MKICAgICAgYkludGVyZmFjZVByb3RvY29sICAgICAgMSBLZXlib2Fy
ZAogICAgICBpSW50ZXJmYWNlICAgICAgICAgICAgICAwIAogICAgICAgIEhJRCBEZXZpY2Ug
RGVzY3JpcHRvcjoKICAgICAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgIDkKICAgICAg
ICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgMzMKICAgICAgICAgIGJjZEhJRCAgICAgICAg
ICAgICAgIDEuMTAKICAgICAgICAgIGJDb3VudHJ5Q29kZSAgICAgICAgICAgIDAgTm90IHN1
cHBvcnRlZAogICAgICAgICAgYk51bURlc2NyaXB0b3JzICAgICAgICAgMQogICAgICAgICAg
YkRlc2NyaXB0b3JUeXBlICAgICAgICAzNCBSZXBvcnQKICAgICAgICAgIHdEZXNjcmlwdG9y
TGVuZ3RoICAgICAxODgKICAgICAgICAgUmVwb3J0IERlc2NyaXB0b3JzOiAKICAgICAgICAg
ICAqKiBVTkFWQUlMQUJMRSAqKgogICAgICBFbmRwb2ludCBEZXNjcmlwdG9yOgogICAgICAg
IGJMZW5ndGggICAgICAgICAgICAgICAgIDcKICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAg
ICAgICA1CiAgICAgICAgYkVuZHBvaW50QWRkcmVzcyAgICAgMHg4MSAgRVAgMSBJTgogICAg
ICAgIGJtQXR0cmlidXRlcyAgICAgICAgICAgIDMKICAgICAgICAgIFRyYW5zZmVyIFR5cGUg
ICAgICAgICAgICBJbnRlcnJ1cHQKICAgICAgICAgIFN5bmNoIFR5cGUgICAgICAgICAgICAg
ICBOb25lCiAgICAgICAgICBVc2FnZSBUeXBlICAgICAgICAgICAgICAgRGF0YQogICAgICAg
IHdNYXhQYWNrZXRTaXplICAgICAweDAwNDAgIDF4IDY0IGJ5dGVzCiAgICAgICAgYkludGVy
dmFsICAgICAgICAgICAgICAgNAogICAgSW50ZXJmYWNlIERlc2NyaXB0b3I6CiAgICAgIGJM
ZW5ndGggICAgICAgICAgICAgICAgIDkKICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAg
NAogICAgICBiSW50ZXJmYWNlTnVtYmVyICAgICAgICAxCiAgICAgIGJBbHRlcm5hdGVTZXR0
aW5nICAgICAgIDAKICAgICAgYk51bUVuZHBvaW50cyAgICAgICAgICAgMgogICAgICBiSW50
ZXJmYWNlQ2xhc3MgICAgICAgICAzIEh1bWFuIEludGVyZmFjZSBEZXZpY2UKICAgICAgYklu
dGVyZmFjZVN1YkNsYXNzICAgICAgMSBCb290IEludGVyZmFjZSBTdWJjbGFzcwogICAgICBi
SW50ZXJmYWNlUHJvdG9jb2wgICAgICAyIE1vdXNlCiAgICAgIGlJbnRlcmZhY2UgICAgICAg
ICAgICAgIDEgSVRFIFRlY2guIEluYy4KICAgICAgICBISUQgRGV2aWNlIERlc2NyaXB0b3I6
CiAgICAgICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5CiAgICAgICAgICBiRGVzY3Jp
cHRvclR5cGUgICAgICAgIDMzCiAgICAgICAgICBiY2RISUQgICAgICAgICAgICAgICAxLjEw
CiAgICAgICAgICBiQ291bnRyeUNvZGUgICAgICAgICAgICAwIE5vdCBzdXBwb3J0ZWQKICAg
ICAgICAgIGJOdW1EZXNjcmlwdG9ycyAgICAgICAgIDEKICAgICAgICAgIGJEZXNjcmlwdG9y
VHlwZSAgICAgICAgMzQgUmVwb3J0CiAgICAgICAgICB3RGVzY3JpcHRvckxlbmd0aCAgICAg
Mzc5CiAgICAgICAgIFJlcG9ydCBEZXNjcmlwdG9yczogCiAgICAgICAgICAgKiogVU5BVkFJ
TEFCTEUgKioKICAgICAgRW5kcG9pbnQgRGVzY3JpcHRvcjoKICAgICAgICBiTGVuZ3RoICAg
ICAgICAgICAgICAgICA3CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNQogICAg
ICAgIGJFbmRwb2ludEFkZHJlc3MgICAgIDB4ODIgIEVQIDIgSU4KICAgICAgICBibUF0dHJp
YnV0ZXMgICAgICAgICAgICAzCiAgICAgICAgICBUcmFuc2ZlciBUeXBlICAgICAgICAgICAg
SW50ZXJydXB0CiAgICAgICAgICBTeW5jaCBUeXBlICAgICAgICAgICAgICAgTm9uZQogICAg
ICAgICAgVXNhZ2UgVHlwZSAgICAgICAgICAgICAgIERhdGEKICAgICAgICB3TWF4UGFja2V0
U2l6ZSAgICAgMHgwMDQwICAxeCA2NCBieXRlcwogICAgICAgIGJJbnRlcnZhbCAgICAgICAg
ICAgICAgIDEKICAgICAgRW5kcG9pbnQgRGVzY3JpcHRvcjoKICAgICAgICBiTGVuZ3RoICAg
ICAgICAgICAgICAgICA3CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNQogICAg
ICAgIGJFbmRwb2ludEFkZHJlc3MgICAgIDB4MDMgIEVQIDMgT1VUCiAgICAgICAgYm1BdHRy
aWJ1dGVzICAgICAgICAgICAgMwogICAgICAgICAgVHJhbnNmZXIgVHlwZSAgICAgICAgICAg
IEludGVycnVwdAogICAgICAgICAgU3luY2ggVHlwZSAgICAgICAgICAgICAgIE5vbmUKICAg
ICAgICAgIFVzYWdlIFR5cGUgICAgICAgICAgICAgICBEYXRhCiAgICAgICAgd01heFBhY2tl
dFNpemUgICAgIDB4MDA0MCAgMXggNjQgYnl0ZXMKICAgICAgICBiSW50ZXJ2YWwgICAgICAg
ICAgICAgICAxCkRldmljZSBTdGF0dXM6ICAgICAweDAwMDEKICBTZWxmIFBvd2VyZWQK
--------------070704080103010104040007--

--VkrUcptSO4BoS5Lvl8rh1SSsPkxiXTcPM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTvqc8ACgkQ7CzyshGvatgzjgCgsWMeFHV0zhcA+PtyxWqV6v/K
fVIAnjjNQHPc9BPCBgBqCBb/PBh9exAN
=pvpO
-----END PGP SIGNATURE-----

--VkrUcptSO4BoS5Lvl8rh1SSsPkxiXTcPM--
