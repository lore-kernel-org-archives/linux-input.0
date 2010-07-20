From: Oliver Neukum <oneukum@suse.de>
Subject: Re: ACRUX gamepads not happy with autosuspend?
Date: Tue, 20 Jul 2010 10:07:04 +0200
Message-ID: <201007201007.04518.oneukum@suse.de>
References: <4C3F8A90.3020308@dv-life.ru> <4C44E3A2.8080301@dv-life.ru> <20100720001745.GA17910@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_okVRMgFJar1uxlo"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44707 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757906Ab0GTIHq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jul 2010 04:07:46 -0400
In-Reply-To: <20100720001745.GA17910@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, x0r <x0r@dv-life.ru>, Linux Input <linux-input@vger.kernel.org>, Linux USB <linux-usb@vger.kernel.org>

--Boundary-00=_okVRMgFJar1uxlo
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Am Dienstag, 20. Juli 2010, 02:17:45 schrieb Dmitry Torokhov:
> Jiri, Oliver,
> 
> It looks like ACRUX game controllers do not like autopm. There is
> a bug report over at Ubuntu's launchpad:
> 
> 	https://bugs.launchpad.net/ubuntu/+source/joystick/+bug/448446

That report shows that the symptoms are consistent with autosuspend,
but it doesn't show that autosuspend was on.

> that states that once device is plugged in the light ion it turns on
> briefly and then goes off and from that point on nothing comes from
> the device. They deal with it by having an application open the jsX
> device as soon as it appears and that makes gamepad work - but it
> is obviously not a solution.

If autosuspend is enabled simply opening the device file will keep the
device active as it does not suport remote wakeup.

Something like
sleep 5000 </dev/input/js0
should fix the issue.

> It looks like we either need to disable autosuspend for these devices
> or maybe kick the device harder when userspace tries to open it so
> that it wakes up if it went to sleep.

You can try the attached patch. I doubt it works.

	Regards
		Oliver

--Boundary-00=_okVRMgFJar1uxlo
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-USB-quirk-for-ACRUX-USB-GAMEPAD-8116.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-USB-quirk-for-ACRUX-USB-GAMEPAD-8116.patch"

=46rom d7fb44af446eaf9f2a200d3645b72f7f98029b57 Mon Sep 17 00:00:00 2001
=46rom: Oliver Neukum <oliver@neukum.org>
Date: Tue, 20 Jul 2010 10:04:47 +0200
Subject: [PATCH] USB: quirk for ACRUX USB GAMEPAD 8116

This needs to be reset as the system wakes up and
for runtime power management.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
=2D--
 drivers/usb/core/quirks.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f22d03d..cb2e985 100644
=2D-- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -75,6 +75,9 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	{ USB_DEVICE(0x1908, 0x1315), .driver_info =3D
 			USB_QUIRK_HONOR_BNUMINTERFACES },
=20
+	/* ACRUX USB GAMEPAD 8116 */
+	{ USB_DEVICE(0x1a34, 0x0802), .driver_info =3D USB_QUIRK_RESET_RESUME },
+
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info =3D USB_QUIRK_RESET_RESUME },
=20
=2D-=20
1.7.1


--Boundary-00=_okVRMgFJar1uxlo--
