From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Mon, 20 Feb 2012 23:29:00 +0200
Message-ID: <1329773340-14066-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43932 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab2BTV3Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Feb 2012 16:29:16 -0500
Received: by wics10 with SMTP id s10so3123984wic.19
        for <linux-input@vger.kernel.org>; Mon, 20 Feb 2012 13:29:15 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>

Add "have_special_driver" hid module parameter - a list of additional HID
devices which have specialized driver on HID bus. Needed to support out-of-tree
HID drivers.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---

I plan to use this with a DKMS package of my tablet drivers, which haven't yet
appeared in the end-user distributions. I'll be submitting them to the kernel
once they are tested, as usual.

 drivers/hid/hid-core.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index af08ce7..829d9a1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -50,6 +50,21 @@ module_param_named(debug, hid_debug, int, 0600);
 MODULE_PARM_DESC(debug, "toggle HID debugging messages");
 EXPORT_SYMBOL_GPL(hid_debug);
 
+#define MAX_HAVE_SPECIAL_DRIVER_EXTRA 4
+
+static char *hid_have_special_driver_param[MAX_HAVE_SPECIAL_DRIVER_EXTRA] = {
+		NULL,
+};
+module_param_array_named(have_special_driver, hid_have_special_driver_param,
+			 charp, NULL, 0444);
+MODULE_PARM_DESC(have_special_driver,
+		 "A comma-separated list of additional HID devices which have "
+		 "specialized driver; each device is described as BUS:VID:PID, "
+		 "where BUS is either \"usb\" or \"bluetooth\" and both VID "
+		 "and PID are 0x-prefixed hex numbers, e.g. "
+		 "have_special_driver=bluetooth:0x1234:0x1234,"
+		 "usb:0x4321:0x4321");
+
 /*
  * Register a new report for a device.
  */
@@ -1578,6 +1593,13 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ }
 };
 
+/*
+ * An additional, load-time supplied list of devices which have specialized
+ * driver on HID bus.
+ */
+static struct hid_device_id hid_have_special_driver_extra[
+				MAX_HAVE_SPECIAL_DRIVER_EXTRA + 1] = { { } };
+
 struct hid_dynid {
 	struct list_head list;
 	struct hid_device_id id;
@@ -1668,7 +1690,8 @@ static int hid_bus_match(struct device *dev, struct device_driver *drv)
 
 	/* generic wants all that don't have specialized driver */
 	if (!strncmp(hdrv->name, "generic-", 8))
-		return !hid_match_id(hdev, hid_have_special_driver);
+		return !hid_match_id(hdev, hid_have_special_driver) &&
+		       !hid_match_id(hdev, hid_have_special_driver_extra);
 
 	return 1;
 }
@@ -2167,6 +2190,55 @@ int hid_check_keys_pressed(struct hid_device *hid)
 
 EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
 
+static int __init hid_parse_device_id_list(struct hid_device_id *id_list,
+					   char **str_list,
+					   size_t max)
+{
+	static const char *usb_str = "usb";
+	static const char *bluetooth_str = "bluetooth";
+
+	size_t i;
+	const char *p;
+	const char *t;
+	int n;
+	u16 bus;
+	u32 vid, pid;
+
+	for (i = 0; i < max && str_list[i] != NULL; i++) {
+		p = str_list[i];
+
+		t = strchr(p, ':');
+		if (t == NULL)
+			goto err;
+
+		if ((t - p) == strlen(usb_str) &&
+		    memcmp(p, usb_str, t - p) == 0)
+			bus = BUS_USB;
+		else if ((t - p) == strlen(bluetooth_str) &&
+			 memcmp(p, bluetooth_str, t - p) == 0)
+			bus = BUS_BLUETOOTH;
+		else
+			goto err;
+
+		p = t + 1;
+
+		if (sscanf(p, "0x%x:0x%x%n", &vid, &pid, &n) != 2)
+			goto err;
+
+		p += n;
+		if (*p != '\0')
+			goto err;
+
+		id_list[i] = (struct hid_device_id){HID_DEVICE(bus, vid, pid)};
+	}
+
+	id_list[i].bus = 0;
+	return 0;
+err:
+	id_list[0].bus = 0;
+	return 1;
+}
+
 static int __init hid_init(void)
 {
 	int ret;
@@ -2175,6 +2247,12 @@ static int __init hid_init(void)
 		pr_warn("hid_debug is now used solely for parser and driver debugging.\n"
 			"debugfs is now used for inspecting the device (report descriptor, reports)\n");
 
+	ret = hid_parse_device_id_list(hid_have_special_driver_extra,
+				       hid_have_special_driver_param,
+				       MAX_HAVE_SPECIAL_DRIVER_EXTRA);
+	if (ret)
+		pr_warn("invalid have_special_driver module parameter\n");
+
 	ret = bus_register(&hid_bus_type);
 	if (ret) {
 		pr_err("can't register hid bus\n");
-- 
1.7.9

