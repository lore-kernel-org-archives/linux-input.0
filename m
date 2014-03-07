From: Derya <derya.kiran@yahoo.de>
Subject: [PATCH 0/2 ] Surface Pro 2 HID sensor, wacom, keyboard/multitouch
 composite device
Date: Fri, 07 Mar 2014 16:53:32 +0100
Message-ID: <5319EB7C.5070209@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm31-vm5.bullet.mail.ir2.yahoo.com ([212.82.97.92]:40999 "EHLO
	nm31-vm5.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752116AbaCGQAH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Mar 2014 11:00:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz

The MS Surface Pro 2 has a very annoying USB composite device on port 2=
=2E3.
It has 3 interfaces:
- Interface 0 is the sensor-hub
- Interface 1 is the wacom digitizer=B2 (it's one without finger input,=
=20
there is an atmel digitizer on port 2.4 for finger input)
- Interface 2 is the keyboard, if a keyboard cover is attached.

This USB composite device changes it product id depending if and which=20
keyboard cover is attached.
Each of this hid devices contains several collections, this complicated=
=20
everything.
I have uploaded a lsusb output to: http://pastebin.com/Jun5sa2t

I have to say, that I'm neither a developer nor a programmer, this mean=
s=20
this things are beyond my ken, please excuse if my remarks aren't accur=
ate.

The Touch and Type Covers (2) didn't work out of the box. Someone one=20
the ubuntuforums made a patch which adds them to the microsoft special=20
driver, but this leads to loading that driver for all the 3 interfaces=20
and prevents loading of hid-sensor-hub for interface 0, if a keyboard=20
cover is attached. Sadly this patch is submitted to the upstream kernel=
=20
source.
Without that patch the keyboard covers are loading hid-multitouch=20
instead of hid-generic. This misbehaviour is a result of the fancy hid=20
collections, that the keyboards have. With hid-multitouch neither the=20
keyboard nor the touchpad of the cover works=B2. I added an if clause t=
o=20
hid_scan_input_usage to prevent loading of hid-multitouch for the=20
keyboards. With hid-generic keyboard and touchpad are working (they com=
e=20
up as one input)

We also need the HID_QUIRK_NOGET for this usb composite device, without=
=20
it hid-sensor-hub fails with a submit urb failure evertime a keyboard=20
cover is (de)attached and it takes some seconds until the keyboard and=20
wacom digitizer responds.

The second patch adds HID_SENSOR_HUB_ENUM_QUIRK for the Surface Pro 2's=
=20
sensor-hub. There is still a bug with the sensors and the Surface Pro 2=
,=20
but I didn't dig into it yet (hid-sensor-magn-3d fails to setup attribu=
tes)

Regards,

Derya



1 I'm also working to get the wacom driver working. At the moment the=20
stylus works with hid-generic(if my patch is applied, without it use=20
hid-microsoft). I got it working with wacom driver without disturbing=20
the other interfaces, but the wacom interface contains also some fancy=20
collection. The wacom driver doesn't care of them, this leads to losing=
=20
the on device volume and left meta keys. With hid-generic they work, bu=
t=20
the input events get distorted after the use of the eraser. But, this i=
s=20
another story...

2 @Benjamin Tissoires
I have tried your patches for fancy collection in hid-multitouch. It=20
seems to be the right way to solve the problem with the keyboard (bette=
r=20
than my approach to exclude this devices in hid_scan_input_usage), but=20
it has the some drawbacks at the moment. It splits the input into 5=20
pieces. 2 seperate keyboard inputs that leads into losing the caps lock=
=20
led. The touchpad is mapped as a mouse. There is also a consumer device=
,=20
which gives me no input and an unkown device, but no multitouch device.=
=20
There is a HID_DG_INPUTMODE out of range error in dmesg. Please, contac=
t=20
me, if you need some logs.



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
