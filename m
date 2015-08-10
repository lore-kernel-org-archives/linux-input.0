From: Orivej Desh <orivej@gmx.fr>
Subject: Missing axis on Gembird JPD-DUALFORCE2 since Linux 3.18
Date: Mon, 10 Aug 2015 08:26:42 +0000
Message-ID: <20150810082642.3a0880ab@orivej.orivej.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46884 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070AbbHJIaG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 04:30:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1ZOiT6-0002xp-K7
	for linux-input@vger.kernel.org; Mon, 10 Aug 2015 10:30:04 +0200
Received: from 151.236.17.66 ([151.236.17.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2015 10:30:04 +0200
Received: from orivej by 151.236.17.66 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2015 10:30:04 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have one of those gamepads, and since Linux 3.18 the kernel hides one
of its axes.

In Linux 3.17 jstest reports it as

     Joystick (PC Game Controller       ) has 7 axes (X, Y, Z, Rx, Rz, =
Hat0X, Hat0Y)

and in Linux 3.18 as

     Joystick (PC Game Controller       ) has 6 axes (X, Y, Z, Rz, Hat0=
X, Hat0Y)

It has 6 physical axes (X, Y, Rx, Ry, Hat0X, Hat0Y), but Ry is reported
as Rz, and Z emits noise (which had to be silenced with jscal).

I bisected disappearing axis to the following commit [1], but if I
understand correctly, it is the device that is wrong by misreporting
some property of Rx.

I can remap Rz to Ry in userspace with ioctl(fd, JSIOCSAXMAP, ...),
though I never had to.  Can I likewise restore Rx in userspace (and als=
o
delete Z)?  If not, or if this device justifies a quirk, how should it
be added?

usb-devices report: [2].

[1]
commit 79346d620e9de87912de73337f6df8b7f9a46888
Author: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon Aug 25 13:07:10 2014 -0400

    HID: input: force generic axis to be mapped to their user space axi=
s

    Atmel 840B digitizer presents a stylus interface which reports twic=
e
    the X coordinate and then twice the Y coordinate. In its current
    implementation, hid-input assign the first X to X, then the second =
to Y,
    then the first Y to Z, then the second one to RX.

    This is wrong, and X should always be mapped to X, no matter what.
    A solution consists in forcing X, Y, Z, RX, RY, RZ to be mapped to =
their
    correct user space counter part.

    Reported-by: =C3=89ric Brunet <Eric.Brunet@lps.ens.fr>
    Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
    Signed-off-by: Jiri Kosina <jkosina@suse.cz>

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2619f7f..2df7fdd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -599,6 +599,12 @@ static void hidinput_configure_usage(struct hid_in=
put *hidinput, struct hid_fiel
                /* These usage IDs map directly to the usage codes. */
                case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
                case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
+                       if (field->flags & HID_MAIN_ITEM_RELATIVE)
+                               map_rel(usage->hid & 0xf);
+                       else
+                               map_abs_clear(usage->hid & 0xf);
+                       break;
+
                case HID_GD_SLIDER: case HID_GD_DIAL: case HID_GD_WHEEL=
:
                        if (field->flags & HID_MAIN_ITEM_RELATIVE)
                                map_rel(usage->hid & 0xf);

[2]
T:  Bus=3D09 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  2 Spd=3D1.5=
 MxCh=3D 0
D:  Ver=3D 1.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  =
1
P:  Vendor=3D11ff ProdID=3D3331 Rev=3D01.07
S:  Product=3DPC Game Controller
C:  #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D500mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D03(HID  ) Sub=3D00 Prot=3D00 Driv=
er=3Dusbhid


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
