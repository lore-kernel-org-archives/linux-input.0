From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Complete support for the new unibody macbooks
Date: Thu, 20 Nov 2008 11:37:31 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811201135100.19853@jikos.suse.cz>
References: <49109C91.6090207@euromail.se> <alpine.LNX.1.10.0811111835540.24889@jikos.suse.cz> <4919C979.3000501@euromail.se> <alpine.LNX.1.10.0811112347260.24889@jikos.suse.cz> <20081119113753.ZZRA012@mailhub.coreip.homeip.net> <alpine.LNX.1.10.0811191803320.19853@jikos.suse.cz>
 <49249431.9040104@euromail.se> <alpine.LNX.1.10.0811192339560.19853@jikos.suse.cz> <49249CCB.7060807@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:47019 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753245AbYKTKhd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2008 05:37:33 -0500
In-Reply-To: <49249CCB.7060807@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 20 Nov 2008, Henrik Rydberg wrote:

> > If this is not the case, I'll then revert the hid_mouse_ignore_list[] 
> > addition peformed in a96d6ef34 and will push it for 2.6.29, so that it 
> > goes in together with bcm5974 driver modifications.
> Yes, I think that is best.

OK, so I have queued this for 2.6.28

From: Jiri Kosina <jkosina@suse.cz>
Subject: HID: unignore mouse on unibody macbooks

In commit a96d6ef34, the mouse interfaces on the unibody macbooks were
put into hid mouse ignore list. This was a little bit too premature
though, as the corresponding bcm5974 changes are scheduled for 2.6.29.

Remove these devices from the ignore list for now, in order to provide at
least basic functionality with the HID driver.

Will be reintroduced in 2.6.29

Reported-by: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-core.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 69b1ce8..5000711 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1576,9 +1576,6 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ISO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_JIS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 	{ }



And this for 2.6.29


From: Jiri Kosina <jkosina@suse.cz>
Subject: HID: ignore mouse interface for unibody macbooks

The mouse interface on unibody macbooks is going to be handled by
bcm59743 driver in 2.6.29.

Reported-by: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5000711..69b1ce8 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1576,6 +1576,9 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING2_JIS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ANSI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_ISO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING3_JIS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 	{ }

Thanks,

-- 
Jiri Kosina
SUSE Labs
