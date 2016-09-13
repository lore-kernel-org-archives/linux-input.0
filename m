From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/9] HID: Remove broken links to tablet descriptions
Date: Tue, 13 Sep 2016 17:08:35 +0300
Message-ID: <20160913140843.25567-2-spbnick@gmail.com>
References: <20160913140843.25567-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35479 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbcIMOJH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 10:09:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id c131so3168822wmh.2
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2016 07:09:06 -0700 (PDT)
In-Reply-To: <20160913140843.25567-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

Remove comments with broken links to tablet descriptions from
hid-kye/uclogic/waltop drivers.

They pointed to now dead DIGImend project wiki at sf.net. Even though
the DIGImend project still hosts descriptions, now at
digimend.github.io, it's better to avoid them going stale again, and let
anyone interested search the web instead.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-kye.c     | 15 ---------------
 drivers/hid/hid-uclogic.c | 27 ---------------------------
 drivers/hid/hid-waltop.c  | 36 ------------------------------------
 3 files changed, 78 deletions(-)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index 32e6d8d..a3b70df 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -19,11 +19,6 @@
 
 #include "hid-ids.h"
 
-/*
- * See EasyPen i405X description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=KYE_EasyPen_i405X
- */
-
 /* Original EasyPen i405X report descriptor size */
 #define EASYPEN_I405X_RDESC_ORIG_SIZE	476
 
@@ -82,11 +77,6 @@ static __u8 easypen_i405x_rdesc_fixed[] = {
 	0xC0              /*  End Collection                  */
 };
 
-/*
- * See MousePen i608X description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=KYE_MousePen_i608X
- */
-
 /* Original MousePen i608X report descriptor size */
 #define MOUSEPEN_I608X_RDESC_ORIG_SIZE	476
 
@@ -186,11 +176,6 @@ static __u8 mousepen_i608x_rdesc_fixed[] = {
 	0xC0              /*  End Collection                  */
 };
 
-/*
- * See EasyPen M610X description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=KYE_EasyPen_M610X
- */
-
 /* Original EasyPen M610X report descriptor size */
 #define EASYPEN_M610X_RDESC_ORIG_SIZE	476
 
diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 85ac435..6a59f6a 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -21,13 +21,6 @@
 
 #include "hid-ids.h"
 
-/*
- * See WPXXXXU model descriptions, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=UC-Logic_Tablet_WP4030U
- * http://sf.net/apps/mediawiki/digimend/?title=UC-Logic_Tablet_WP5540U
- * http://sf.net/apps/mediawiki/digimend/?title=UC-Logic_Tablet_WP8060U
- */
-
 /* Size of the original descriptor of WPXXXXU tablets */
 #define WPXXXXU_RDESC_ORIG_SIZE	212
 
@@ -221,11 +214,6 @@ static __u8 wp8060u_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See WP1062 description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=UC-Logic_Tablet_WP1062
- */
-
 /* Size of the original descriptor of WP1062 tablet */
 #define WP1062_RDESC_ORIG_SIZE	254
 
@@ -274,11 +262,6 @@ static __u8 wp1062_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See PF1209 description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=UC-Logic_Tablet_PF1209
- */
-
 /* Size of the original descriptor of PF1209 tablet */
 #define PF1209_RDESC_ORIG_SIZE	234
 
@@ -356,11 +339,6 @@ static __u8 pf1209_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See TWHL850 description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=UC-Logic_Wireless_Tablet_TWHL850
- */
-
 /* Size of the original descriptors of TWHL850 tablet */
 #define TWHL850_RDESC_ORIG_SIZE0	182
 #define TWHL850_RDESC_ORIG_SIZE1	161
@@ -469,11 +447,6 @@ static __u8 twhl850_rdesc_fixed2[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See TWHA60 description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=UC-Logic_Tablet_TWHA60
- */
-
 /* Size of the original descriptors of TWHA60 tablet */
 #define TWHA60_RDESC_ORIG_SIZE0 254
 #define TWHA60_RDESC_ORIG_SIZE1 139
diff --git a/drivers/hid/hid-waltop.c b/drivers/hid/hid-waltop.c
index 059931d..a91aabe 100644
--- a/drivers/hid/hid-waltop.c
+++ b/drivers/hid/hid-waltop.c
@@ -42,11 +42,6 @@
  * 02 16 02     ink
  */
 
-/*
- * See Slim Tablet 5.8 inch description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Slim_Tablet_5.8%22
- */
-
 /* Size of the original report descriptor of Slim Tablet 5.8 inch */
 #define SLIM_TABLET_5_8_INCH_RDESC_ORIG_SIZE	222
 
@@ -98,11 +93,6 @@ static __u8 slim_tablet_5_8_inch_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See Slim Tablet 12.1 inch description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Slim_Tablet_12.1%22
- */
-
 /* Size of the original report descriptor of Slim Tablet 12.1 inch */
 #define SLIM_TABLET_12_1_INCH_RDESC_ORIG_SIZE	269
 
@@ -154,11 +144,6 @@ static __u8 slim_tablet_12_1_inch_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See Q Pad description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Q_Pad
- */
-
 /* Size of the original report descriptor of Q Pad */
 #define Q_PAD_RDESC_ORIG_SIZE	241
 
@@ -210,11 +195,6 @@ static __u8 q_pad_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See description, device and HID report descriptors of tablet with PID 0038 at
- * http://sf.net/apps/mediawiki/digimend/?title=Waltop_PID_0038
- */
-
 /* Size of the original report descriptor of tablet with PID 0038 */
 #define PID_0038_RDESC_ORIG_SIZE	241
 
@@ -268,11 +248,6 @@ static __u8 pid_0038_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See Media Tablet 10.6 inch description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Media_Tablet_10.6%22
- */
-
 /* Size of the original report descriptor of Media Tablet 10.6 inch */
 #define MEDIA_TABLET_10_6_INCH_RDESC_ORIG_SIZE	300
 
@@ -386,11 +361,6 @@ static __u8 media_tablet_10_6_inch_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See Media Tablet 14.1 inch description, device and HID report descriptors at
- * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Media_Tablet_14.1%22
- */
-
 /* Size of the original report descriptor of Media Tablet 14.1 inch */
 #define MEDIA_TABLET_14_1_INCH_RDESC_ORIG_SIZE	309
 
@@ -502,12 +472,6 @@ static __u8 media_tablet_14_1_inch_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * See Sirius Battery Free Tablet description, device and HID report descriptors
- * at
- * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Sirius_Battery_Free_Tablet
- */
-
 /* Size of the original report descriptor of Sirius Battery Free Tablet */
 #define SIRIUS_BATTERY_FREE_TABLET_RDESC_ORIG_SIZE	335
 
-- 
2.9.3

