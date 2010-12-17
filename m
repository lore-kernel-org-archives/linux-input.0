From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] WeTab device ID
Date: Fri, 17 Dec 2010 13:03:22 +0100
Message-ID: <20101217120322.GA3873@polaris>
References: <4D0AA66F.6080506@plausible.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D0AA66F.6080506@plausible.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Ross <andy@plausible.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Andy,

> > > Hi.  I'm looking at getting a WeTab running right now and just
> > > found this patch set.  It's a few weeks old now and not upstream
> > > yet, so before I start hacking at it I thought I should check with
> > > you to make sure there isn't a more current one available.
> >
> > You find the tip of the mt work at
> > git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git
> 
> Thanks much.  It works great, though on our WeTab it's missing the
> device ID of the part on the board.  Patch below:

Thanks for the patch. Does the one below work for you?

Henrik
---
>From a8b4613b6d7e7cf04a7335930e9c5c2fb44302d0 Mon Sep 17 00:00:00 2001
From: Andy Ross <andy@plausible.org>
Date: Thu, 16 Dec 2010 15:53:19 -0800
Subject: [PATCH] hid: egalax: Add support for Wetab (726b)

This patch adds support for another Wetab device (726b), and grabs it
accordingly in hid-core.

[rydberg@euromail.se: rename and log message changes]
Signed-off-by: Andy Ross <andy@plausible.org>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-core.c   |    1 +
 drivers/hid/hid-egalax.c |    2 ++
 drivers/hid/hid-ids.h    |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f4a37f8..88668ae 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1302,6 +1302,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR) },
diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
index 8787850..16566fc 100644
--- a/drivers/hid/hid-egalax.c
+++ b/drivers/hid/hid-egalax.c
@@ -242,6 +242,8 @@ static const struct hid_device_id egalax_devices[] = {
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, egalax_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a95719b..0f150c7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -198,6 +198,7 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1	0x720c
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2	0x72a1
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3	0x480e
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4	0x726b
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
-- 
1.7.2.3
