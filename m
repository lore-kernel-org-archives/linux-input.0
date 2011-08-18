From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 2/2] Match controllers using vendor_id and product_id instead of HID_NAME
Date: Thu, 18 Aug 2011 16:22:20 +0200
Message-ID: <1313677340-4441-2-git-send-email-ospite@studenti.unina.it>
References: <20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:40934 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755231Ab1HROWw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 10:22:52 -0400
In-Reply-To: <20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>

Maybe controller->name can be filled in from HID_NAME, but for now having it 
hardcoded doesn't hurt.

---
 plugins/sixaxis.c |   42 ++++++++++++++++++++++++++++++------------
 1 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 608474f..fc1cd52 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -426,12 +426,29 @@ static int set_controller_number(int fd, unsigned int n)
 	return set_leds(fd, leds_status);
 }
 
-
-static inline gboolean is_sixaxis(const char *hid_name)
+static inline struct sony_controller *find_sony_controller(const char *hid_id)
 {
-	return g_str_has_suffix(hid_name, "PLAYSTATION(R)3 Controller") ||
-		g_str_has_suffix(hid_name,
-			"Sony Computer Entertainment Wireless Controller");
+	unsigned int array_size = sizeof(controllers)/sizeof(controllers[0]);
+	unsigned int i;
+	int ret;
+	uint16_t protocol;
+	uint16_t vendor_id;
+	uint16_t product_id;
+
+	ret = sscanf(hid_id, "%hx:%hx:%hx", &protocol, &vendor_id, &product_id);
+	if (ret != 3) {
+		error("%s:%s() Parsing HID_ID failed",
+			__FILE__, __func__);
+		return NULL;
+	}
+
+	for (i = 0; i < array_size; i++) {
+		if (controllers[i].vendor_id == vendor_id &&
+		    controllers[i].product_id == product_id)
+			return &controllers[i];
+	}
+
+	return NULL;
 }
 
 static void handle_device_plug(struct udev_device *udevice)
@@ -439,7 +456,7 @@ static void handle_device_plug(struct udev_device *udevice)
 	struct udev_device *hid_parent;
 	struct udev_enumerate *enumerate;
 	struct udev_list_entry *devices, *dev_list_entry;
-	const char *hid_name;
+	const char *hid_id;
 	const char *hid_phys;
 	const char *hidraw_node;
 	unsigned char is_usb = FALSE;
@@ -455,15 +472,16 @@ static void handle_device_plug(struct udev_device *udevice)
 		return;
 	}
 
-	hid_name = udev_device_get_property_value(hid_parent, "HID_NAME");
-	DBG("name: %s", hid_name);
+	hid_id = udev_device_get_property_value(hid_parent, "HID_ID");
+	DBG("HID_ID: %s", hid_id);
 
-	if (!is_sixaxis(hid_name))
+	controller = find_sony_controller(hid_id);
+	if (!controller) {
+		DBG("No supported controller found");
 		return;
+	}
 
-	controller = &controllers[0];
-
-	DBG("Found a Sixaxis device");
+	DBG("Found a Sony controller: %s", controller->name);
 
 	hidraw_node = udev_device_get_devnode(udevice);
 
-- 
1.7.5.4

