From: Forest Bond <forest@forestbond.com>
Subject: [PATCH 1/2] HID: don't ignore eGalax/D-Wav/EETI HIDs
Date: Mon, 21 Oct 2013 12:38:02 -0400
Message-ID: <20131021163802.GA30240@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:55597 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3JUQxv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Oct 2013 12:53:51 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Sebastian =?iso-8859-1?Q?Dalfu=DF?= <sd@sedf.de>, Daniel Ritz <daniel.ritz@gmx.ch>, Max Weninger <max.weninger@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christian Engelmayer <christian.engelmayer@frequentis.com>

From: Forest Bond <forest.bond@rapidrollout.com>

Certain devices with class HID, protocol None did not work with the HID
driver at one point, and as a result were bound to usbtouchscreen
instead as of commit 139ebe8 ("Input: usbtouchscreen - fix eGalax HID
ignoring").  This change was prompted by the following report:

https://lkml.org/lkml/2009/1/25/127

Unfortunately, the device mentioned in this report is no longer
available for testing.

We've recently discovered that some devices with class HID, protocol
None do not work with usbtouchscreen, but do work with usbhid.  Here is
the report that made this evident:

http://comments.gmane.org/gmane.linux.kernel.input/31710

Driver binding for these devices has flip-flopped a few times, so both
of the above reports were regressions.

This situation would appear to leave us with no easy way to bind every
device to the right driver.  However, in my own testing with several
devices I have not found a device with class HID that does not work with
the current HID driver.  It is my belief that changes to the HID driver
since the original report have likely fixed the issue(s) that made it
unsuitable at the time, and that we should prefer it over usbtouchscreen
for these devices.  In particular, HID quirks affecting these devices
were added/removed in the following commits since then:

fe6065d HID: add multi-input quirk for eGalax Touchcontroller
77933c3 Merge branch 'egalax' into for-linus
ebd11fe HID: Add quirk for eGalax touch controler.
d34c4aa HID: add no-get quirk for eGalax touch controller

This patch makes the HID driver no longer ignore eGalax/D-Wav/EETI
devices with class HID.  If there are in fact devices with class HID
that still do not work with the HID driver, we will see another round of
regressions.  In that case I propose we investigate why the device is
not working with the HID driver rather than re-introduce regressions for
functioning HID devices by again binding them to usbtouchscreen.

The corresponding change to usbtouchscreen will be made separately.

Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
---
 drivers/hid/hid-core.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5a8c011..dfcd67f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2374,15 +2374,6 @@ bool hid_ignore(struct hid_device *hdev)
 				hdev->type == HID_TYPE_USBNONE)
 			return true;
 		break;
-	case USB_VENDOR_ID_DWAV:
-		/* These are handled by usbtouchscreen. hdev->type is probably
-		 * HID_TYPE_USBNONE, but we say !HID_TYPE_USBMOUSE to match
-		 * usbtouchscreen. */
-		if ((hdev->product == USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER ||
-		     hdev->product == USB_DEVICE_ID_DWAV_TOUCHCONTROLLER) &&
-		    hdev->type != HID_TYPE_USBMOUSE)
-			return true;
-		break;
 	case USB_VENDOR_ID_VELLEMAN:
 		/* These are not HID devices.  They are handled by comedi. */
 		if ((hdev->product >= USB_DEVICE_ID_VELLEMAN_K8055_FIRST &&
-- 
1.7.9.5
