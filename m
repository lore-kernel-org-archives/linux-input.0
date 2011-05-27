From: Pablo Cases <pablo.cases@flatfrog.com>
Subject: g_hid and hid-multitouch compatibility?
Date: Fri, 27 May 2011 17:33:26 +0200
Message-ID: <8B252890F5150E47AD8B8AEC92FDBA2201118CAC80@fg-dc1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:46822
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753965Ab1E0Pda convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2011 11:33:30 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


Hi all,

I have searched the net and the archives of linux-input for information=
 on how to use the Linux g_hid kernel module on a device and the hid-mu=
ltitouch kernel module on a host to communicate multitouch events. But =
unfortunately I can only get single touch working.=20

Q: Has anyone successfully completed a g_hid <-> hid-multitouch setup? =
And is there a description somewhere of such setup?
Q: Is the Windows 7 multitouch USB HID descriptor the correct one to us=
e also for Linux hid-multitouch? Or is some tweaking necessary?

DETAILED DESCRIPTION BELOW
The device is a Linux device that uses g_hid (currently 2.6.37 kernel) =
and a USB HID Report Descriptor for multitouch using two-touch parallel=
 mode according to Microsoft document http://msdn.microsoft.com/en-us/w=
indows/hardware/gg487437.=20

On the host (ubuntu 11.04, 2.6.38 kernel) I register dynamically accord=
ing to the description at http://lii-enac.fr/en/architecture/linux-inpu=
t/multitouch-ubuntu-howto.html. Using the events/rdesc files in debugfs=
 on Ubuntu 11.04 I have validated the parsing of the report descriptor =
and the input reports.

Example multitouch input report from /sys/kernel/debug/hid/0003:xxxx:yy=
yy.0002/events looks correct:
report (size 14) (numbered) =3D  05 03 00 a5 12 32 0e 03 01 99 14 32 0e=
 02=20
Digitizers.TipSwitch =3D 1=20
Digitizers.InRange =3D 1=20
Digitizers.ContactID =3D 0=20
GenericDesktop.X =3D 4773=20
GenericDesktop.Y =3D 3634=20
Digitizers.TipSwitch =3D 1=20
Digitizers.InRange =3D 1=20
Digitizers.ContactID =3D 1=20
GenericDesktop.X =3D 5273=20
GenericDesktop.Y =3D 3634=20
Digitizers.ContactCount =3D 2

The first touch in the report is correctly presented both on Windows an=
d on Ubuntu 11.04 (using ENAC's mtdiag tool with a minor tweak to displ=
ay data from all devices not just multitouch ones). I can see in the de=
bugfs files that the data for the second touch data is correctly transf=
erred and interpreted (see above), but the mapping to the linux input s=
ystem seems a bit strange though (see below). My guess is that I have n=
ot been correctly registered as a multitouch device. I'm assuming this =
also because I cannot see any activity from the hid-multitouch module o=
ther than it being initialized when I connect my device (probably anoth=
er reason for the needed tweak in mtdiag above).

Example mapping from /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rdesc th=
at does not look entirely correct for the second touch:
Digitizers.TipSwitch ---> Key.Touch
Digitizers.InRange ---> Key.ToolPen
Digitizers.ContactID ---> Absolute.Misc
GenericDesktop.X ---> Absolute.X
GenericDesktop.Y ---> Absolute.Y
Digitizers.TipSwitch ---> Key.Touch
Digitizers.InRange ---> Key.ToolRubber
Digitizers.ContactID ---> Absolute.?
GenericDesktop.X ---> Absolute.Z
GenericDesktop.Y ---> Absolute.Rx
Digitizers.ContactCount ---> Absolute.?
Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
Button.0003 ---> Key.MiddleBtn
GenericDesktop.X ---> Relative.X
GenericDesktop.Y ---> Relative.Y
GenericDesktop.Wheel ---> Relative.Wheel


Regards,
Pablo Cases

-------------------------
Pablo Cases, M.Sc.
Development Engineer Software
=46latFrog Laboratories AB
Magistratsv=E4gen 10
22643 Lund
Sweden
Tel: +46 708 393816
Mail: pc@flatfrog.com
Web: www.flatfrog.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
