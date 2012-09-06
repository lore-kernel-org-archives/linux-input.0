From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/5] Input: wacom - handle split-sensor devices with internal hubs
Date: Thu,  6 Sep 2012 15:53:27 -0700
Message-ID: <1346972010-1330-2-git-send-email-killertofu@gmail.com>
References: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51702 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab2IFWxo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 18:53:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so3164584pbb.19
        for <linux-input@vger.kernel.org>; Thu, 06 Sep 2012 15:53:44 -0700 (PDT)
In-Reply-To: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com
Cc: Jason Gerecke <killertofu@gmail.com>

Like our other pen-and-touch products, the Cintiq 24HD touch
needs data to be shared between its two sensors to facilitate
proximity-based palm rejection.

Unlike other tablets that report sensor data through separate
interfaces of the same USB device, the Cintiq 24HD touch has
separate USB devices that are connected to an internal USB hub.

This patch makes it possible to designate the USB VID/PID of
the other device so that the two may share data. To ensure
we don't accidentally link to a sensor from a physically separate
device (if several have been plugged in), we limit the search
to siblings (i.e., devices directly connected to the same
hub).

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_sys.c | 31 ++++++++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.c |  3 ++-
 drivers/input/tablet/wacom_wac.h |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 0d3219f..d67a996 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -546,6 +546,29 @@ struct wacom_usbdev_data {
 static LIST_HEAD(wacom_udev_list);
 static DEFINE_MUTEX(wacom_udev_list_lock);
 
+static struct usb_device *wacom_get_sibling(struct usb_device *dev, int vendor, int product)
+{
+	struct usb_device **sibling;
+
+	if (vendor == 0 && product == 0)
+		return dev;
+
+	if (dev->parent == NULL)
+		return NULL;
+
+	sibling = dev->parent->children;
+	while (sibling != NULL && *sibling != NULL) {
+		struct usb_device_descriptor d = (*sibling)->descriptor;
+
+		if (d.idVendor == vendor && d.idProduct == product)
+			return *sibling;
+
+		sibling++;
+	}
+
+	return NULL;
+}
+
 static struct wacom_usbdev_data *wacom_get_usbdev_data(struct usb_device *dev)
 {
 	struct wacom_usbdev_data *data;
@@ -1190,13 +1213,19 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
 
 	if (features->quirks & WACOM_QUIRK_MULTI_INPUT) {
+		struct usb_device *other_dev;
+
 		/* Append the device type to the name */
 		strlcat(wacom_wac->name,
 			features->device_type == BTN_TOOL_PEN ?
 				" Pen" : " Finger",
 			sizeof(wacom_wac->name));
 
-		error = wacom_add_shared_data(wacom_wac, dev);
+
+		other_dev = wacom_get_sibling(dev, features->oVid, features->oPid);
+		if (other_dev == NULL || wacom_get_usbdev_data(other_dev) == NULL)
+			other_dev = dev;
+		error = wacom_add_shared_data(wacom_wac, other_dev);
 		if (error)
 			goto fail3;
 	}
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index a8bc6c9..9f52ba0 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1327,7 +1327,8 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 
 	/* these device have multiple inputs */
 	if (features->type >= WIRELESS ||
-	    (features->type >= INTUOS5S && features->type <= INTUOS5L))
+	    (features->type >= INTUOS5S && features->type <= INTUOS5L) ||
+	    (features->oVid && features->oPid))
 		features->quirks |= WACOM_QUIRK_MULTI_INPUT;
 
 	/* quirk for bamboo touch with 2 low res touches */
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 96c185c..3f926ec 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -109,6 +109,8 @@ struct wacom_features {
 	int distance_fuzz;
 	unsigned quirks;
 	unsigned touch_max;
+	int oVid;
+	int oPid;
 };
 
 struct wacom_shared {
-- 
1.7.12

