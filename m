From: Andy Ross <andy.ross-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH 1/4] asus-laptop: Device detection for
	Pegatron Lucid tablets
Date: Mon, 24 Jan 2011 14:48:05 -0800
Message-ID: <1295909288-32650-2-git-send-email-andy.ross@windriver.com>
References: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1295909288-32650-1-git-send-email-andy.ross-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Corentin Chary <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Recognize the Pegatron Lucid tablet devices (which share the same
"\_SB.ATKD" namespace) by the result of their INIT method and the
presence of some specific methods.

Signed-off-by: Andy Ross <andy.ross-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
---
 drivers/platform/x86/asus-laptop.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index d235f44..6f542af 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2002-2005 Julien Lerouge, 2003-2006 Karol Kozimor
  *  Copyright (C) 2006-2007 Corentin Chary
+ *  Copyright (C) 2011 Wind River Systems
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -210,6 +211,18 @@ static char *display_get_paths[] = {
 #define METHOD_KBD_LIGHT_SET	"SLKB"
 #define METHOD_KBD_LIGHT_GET	"GLKB"
 
+/* For Pegatron Lucid tablet */
+#define DEVICE_NAME_PEGA	"Lucid"
+
+#define METHOD_PEGA_ENABLE	"ENPR"
+#define METHOD_PEGA_DISABLE	"DAPR"
+#define PEGA_ALS	0x04
+#define PEGA_ALS_POWER	0x05
+
+#define METHOD_PEGA_READ	"RDLN"
+#define PEGA_READ_ALS_H	0x02
+#define PEGA_READ_ALS_L	0x03
+
 /*
  * Define a specific led structure to keep the main structure clean
  */
@@ -246,6 +259,7 @@ struct asus_laptop {
 
 	int wireless_status;
 	bool have_rsts;
+	bool have_pega_lucid;
 	int lcd_state;
 
 	struct rfkill *gps_rfkill;
@@ -361,6 +375,14 @@ static int acpi_check_handle(acpi_handle handle, const char *method,
 	return 0;
 }
 
+static bool asus_check_pega_lucid(struct asus_laptop *asus)
+{
+	return !strcmp(asus->name, DEVICE_NAME_PEGA) &&
+	   !acpi_check_handle(asus->handle, METHOD_PEGA_ENABLE, NULL) &&
+	   !acpi_check_handle(asus->handle, METHOD_PEGA_DISABLE, NULL) &&
+	   !acpi_check_handle(asus->handle, METHOD_PEGA_READ, NULL);
+}
+
 /* Generic LED function */
 static int asus_led_set(struct asus_laptop *asus, const char *method,
 			 int value)
@@ -1334,7 +1356,6 @@ static mode_t asus_sysfs_is_visible(struct kobject *kobj,
 		   attr == &dev_attr_ls_level.attr) {
 		supported = !acpi_check_handle(handle, METHOD_ALS_CONTROL, NULL) &&
 			    !acpi_check_handle(handle, METHOD_ALS_LEVEL, NULL);
-
 	} else if (attr == &dev_attr_gps.attr) {
 		supported = !acpi_check_handle(handle, METHOD_GPS_ON, NULL) &&
 			    !acpi_check_handle(handle, METHOD_GPS_OFF, NULL) &&
@@ -1605,6 +1626,8 @@ static int __devinit asus_acpi_add(struct acpi_device *device)
 	if (result)
 		goto fail_rfkill;
 
+	asus->have_pega_lucid = asus_check_pega_lucid(asus);
+
 	asus_device_present = true;
 	return 0;
 
-- 
1.7.1


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
