From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 23/27] HID: wacom: leds: use the ledclass instead of custom made sysfs files
Date: Tue,  5 Jul 2016 16:39:19 +0200
Message-ID: <1467729563-23318-24-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The now obsolete sysfs files for LEDs and EKRemote are kept for backward
compatibility.
Both the EKR (read-only) and the regular Cintiqs and Intuos are now
sharing the same led API.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 Documentation/ABI/testing/sysfs-driver-wacom |   5 +
 drivers/hid/wacom.h                          |  19 +++
 drivers/hid/wacom_sys.c                      | 191 +++++++++++++++++++++++++--
 3 files changed, 205 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-wacom b/Documentation/ABI/testing/sysfs-driver-wacom
index dca4293..2aa5503 100644
--- a/Documentation/ABI/testing/sysfs-driver-wacom
+++ b/Documentation/ABI/testing/sysfs-driver-wacom
@@ -24,6 +24,7 @@ What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/wacom_led/status0_luminance
 Date:		August 2014
 Contact:	linux-input@vger.kernel.org
 Description:
+		<obsoleted by the LED class API now exported by the driver>
 		Writing to this file sets the status LED luminance (1..127)
 		when the stylus does not touch the tablet surface, and no
 		button is pressed on the stylus. This luminance level is
@@ -33,6 +34,7 @@ What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/wacom_led/status1_luminance
 Date:		August 2014
 Contact:	linux-input@vger.kernel.org
 Description:
+		<obsoleted by the LED class API now exported by the driver>
 		Writing to this file sets the status LED luminance (1..127)
 		when the stylus touches the tablet surface, or any button is
 		pressed on the stylus.
@@ -41,6 +43,7 @@ What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/wacom_led/status_led0_select
 Date:		August 2014
 Contact:	linux-input@vger.kernel.org
 Description:
+		<obsoleted by the LED class API now exported by the driver>
 		Writing to this file sets which one of the four (for Intuos 4
 		and Intuos 5) or of the right four (for Cintiq 21UX2 and Cintiq
 		24HD) status LEDs is active (0..3). The other three LEDs on the
@@ -50,6 +53,7 @@ What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/wacom_led/status_led1_select
 Date:		August 2014
 Contact:	linux-input@vger.kernel.org
 Description:
+		<obsoleted by the LED class API now exported by the driver>
 		Writing to this file sets which one of the left four (for Cintiq 21UX2
 		and Cintiq 24HD) status LEDs is active (0..3). The other three LEDs on
 		the left are always inactive.
@@ -91,6 +95,7 @@ What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/wacom_remote/<serial_number>/r
 Date:		July 2015
 Contact:	linux-input@vger.kernel.org
 Description:
+		<obsoleted by the LED class API now exported by the driver>
 		Reading from this file reports the mode status of the
 		remote as indicated by the LED lights on the device. If no
 		reports have been received from the paired device, reading
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 768d696..0c498c4 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -91,6 +91,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/hid.h>
 #include <linux/kfifo.h>
+#include <linux/leds.h>
 #include <linux/usb/input.h>
 #include <linux/power_supply.h>
 #include <asm/unaligned.h>
@@ -112,8 +113,23 @@ enum wacom_worker {
 	WACOM_WORKER_REMOTE,
 };
 
+struct wacom;
+
+struct wacom_led {
+	struct led_classdev cdev;
+	struct led_trigger trigger;
+	struct wacom *wacom;
+	unsigned int group;
+	unsigned int id;
+	u8 llv;
+	u8 hlv;
+	bool held;
+};
+
 struct wacom_group_leds {
 	u8 select; /* status led selector (0..3) */
+	struct wacom_led *leds;
+	unsigned int count;
 };
 
 struct wacom_battery {
@@ -154,9 +170,12 @@ struct wacom {
 	struct wacom_remote *remote;
 	struct wacom_leds {
 		struct wacom_group_leds *groups;
+		unsigned int count;
 		u8 llv;       /* status led brightness no button (1..127) */
 		u8 hlv;       /* status led brightness button pressed (1..127) */
 		u8 img_lum;   /* OLED matrix display brightness */
+		u8 max_llv;   /* maximum brightness of LED (llv) */
+		u8 max_hlv;   /* maximum brightness of LED (hlv) */
 	} led;
 	struct wacom_battery battery;
 	bool resources;
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 1d79215..2354d73 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -966,31 +966,193 @@ static int wacom_devm_sysfs_create_group(struct wacom *wacom,
 					       group);
 }
 
+static enum led_brightness wacom_leds_brightness_get(struct wacom_led *led)
+{
+	struct wacom *wacom = led->wacom;
+
+	if (wacom->led.max_hlv)
+		return led->hlv * LED_FULL / wacom->led.max_hlv;
+
+	if (wacom->led.max_llv)
+		return led->llv * LED_FULL / wacom->led.max_llv;
+
+	/* device doesn't support brightness tuning */
+	return LED_FULL;
+}
+
+static enum led_brightness __wacom_led_brightness_get(struct led_classdev *cdev)
+{
+	struct wacom_led *led = container_of(cdev, struct wacom_led, cdev);
+	struct wacom *wacom = led->wacom;
+
+	if (wacom->led.groups[led->group].select != led->id)
+		return LED_OFF;
+
+	return wacom_leds_brightness_get(led);
+}
+
+static int wacom_led_brightness_set(struct led_classdev *cdev,
+				    enum led_brightness brightness)
+{
+	struct wacom_led *led = container_of(cdev, struct wacom_led, cdev);
+	struct wacom *wacom = led->wacom;
+	int error;
+
+	mutex_lock(&wacom->lock);
+
+	if (!wacom->led.groups || (brightness == LED_OFF &&
+	    wacom->led.groups[led->group].select != led->id)) {
+		error = 0;
+		goto out;
+	}
+
+	led->llv = wacom->led.llv = wacom->led.max_llv * brightness / LED_FULL;
+	led->hlv = wacom->led.hlv = wacom->led.max_hlv * brightness / LED_FULL;
+
+	wacom->led.groups[led->group].select = led->id;
+
+	error = wacom_led_control(wacom);
+
+out:
+	mutex_unlock(&wacom->lock);
+
+	return error;
+}
+
+static void wacom_led_readonly_brightness_set(struct led_classdev *cdev,
+					       enum led_brightness brightness)
+{
+}
+
+static int wacom_led_register_one(struct device *dev, struct wacom *wacom,
+				  struct wacom_led *led, unsigned int group,
+				  unsigned int id, bool read_only)
+{
+	int error;
+	char *name;
+
+	name = devm_kasprintf(dev, GFP_KERNEL,
+			      "%s::wacom-led_%d.%d",
+			      dev_name(dev),
+			      group,
+			      id);
+	if (!name)
+		return -ENOMEM;
+
+	led->group = group;
+	led->id = id;
+	led->wacom = wacom;
+	led->llv = wacom->led.llv;
+	led->hlv = wacom->led.hlv;
+	led->cdev.name = name;
+	led->cdev.max_brightness = LED_FULL;
+	led->cdev.brightness_get = __wacom_led_brightness_get;
+	if (!read_only)
+		led->cdev.brightness_set_blocking = wacom_led_brightness_set;
+	else
+		led->cdev.brightness_set = wacom_led_readonly_brightness_set;
+
+	error = devm_led_classdev_register(dev, &led->cdev);
+	if (error) {
+		hid_err(wacom->hdev,
+			"failed to register LED %s: %d\n",
+			led->cdev.name, error);
+		led->cdev.name = NULL;
+		return error;
+	}
+
+	return 0;
+}
+
+static int wacom_led_groups_alloc_and_register_one(struct device *dev,
+						   struct wacom *wacom,
+						   int group_id, int count,
+						   bool read_only)
+{
+	struct wacom_led *leds;
+	int i, error;
+
+	if (group_id >= wacom->led.count || count <= 0)
+		return -EINVAL;
+
+	if (!devres_open_group(dev, &wacom->led.groups[group_id], GFP_KERNEL))
+		return -ENOMEM;
+
+	leds = devm_kzalloc(dev, sizeof(struct wacom_led) * count, GFP_KERNEL);
+	if (!leds) {
+		error = -ENOMEM;
+		goto err;
+	}
+
+	wacom->led.groups[group_id].leds = leds;
+	wacom->led.groups[group_id].count = count;
+
+	for (i = 0; i < count; i++) {
+		error = wacom_led_register_one(dev, wacom, &leds[i],
+					       group_id, i, read_only);
+		if (error)
+			goto err;
+	}
+
+	devres_remove_group(dev, &wacom->led.groups[group_id]);
+	return 0;
+
+err:
+	devres_release_group(dev, &wacom->led.groups[group_id]);
+	return error;
+}
+
 static void wacom_led_groups_release(void *data)
 {
 	struct wacom *wacom = data;
 
 	wacom->led.groups = NULL;
+	wacom->led.count = 0;
 }
 
 static int wacom_led_groups_allocate(struct wacom *wacom, int count)
 {
+	struct device *dev = &wacom->hdev->dev;
 	struct wacom_group_leds *groups;
 	int error;
 
-	groups = devm_kzalloc(&wacom->hdev->dev,
-			      sizeof(struct wacom_group_leds) * count,
+	groups = devm_kzalloc(dev, sizeof(struct wacom_group_leds) * count,
 			      GFP_KERNEL);
 	if (!groups)
 		return -ENOMEM;
 
-	error = devm_add_action_or_reset(&wacom->hdev->dev,
-					 wacom_led_groups_release,
-					 wacom);
+	error = devm_add_action_or_reset(dev, wacom_led_groups_release, wacom);
 	if (error)
 		return error;
 
 	wacom->led.groups = groups;
+	wacom->led.count = count;
+
+	return 0;
+}
+
+static int wacom_leds_alloc_and_register(struct wacom *wacom, int group_count,
+					 int led_per_group, bool read_only)
+{
+	struct device *dev;
+	int i, error;
+
+	if (!wacom->wacom_wac.pad_input)
+		return -EINVAL;
+
+	dev = &wacom->wacom_wac.pad_input->dev;
+
+	error = wacom_led_groups_allocate(wacom, group_count);
+	if (error)
+		return error;
+
+	for (i = 0; i < group_count; i++) {
+		error = wacom_led_groups_alloc_and_register_one(dev, wacom, i,
+								led_per_group,
+								read_only);
+		if (error)
+			return error;
+	}
 
 	return 0;
 }
@@ -1010,9 +1172,11 @@ static int wacom_initialize_leds(struct wacom *wacom)
 	case INTUOS4L:
 		wacom->led.llv = 10;
 		wacom->led.hlv = 20;
+		wacom->led.max_llv = 127;
+		wacom->led.max_hlv = 127;
 		wacom->led.img_lum = 10;
 
-		error = wacom_led_groups_allocate(wacom, 1);
+		error = wacom_leds_alloc_and_register(wacom, 1, 4, false);
 		if (error) {
 			hid_err(wacom->hdev,
 				"cannot create leds err: %d\n", error);
@@ -1029,7 +1193,7 @@ static int wacom_initialize_leds(struct wacom *wacom)
 		wacom->led.hlv = 0;
 		wacom->led.img_lum = 0;
 
-		error = wacom_led_groups_allocate(wacom, 2);
+		error = wacom_leds_alloc_and_register(wacom, 2, 4, false);
 		if (error) {
 			hid_err(wacom->hdev,
 				"cannot create leds err: %d\n", error);
@@ -1047,10 +1211,9 @@ static int wacom_initialize_leds(struct wacom *wacom)
 	case INTUOSPM:
 	case INTUOSPL:
 		wacom->led.llv = 32;
-		wacom->led.hlv = 0;
-		wacom->led.img_lum = 0;
+		wacom->led.max_llv = 96;
 
-		error = wacom_led_groups_allocate(wacom, 1);
+		error = wacom_leds_alloc_and_register(wacom, 1, 4, false);
 		if (error) {
 			hid_err(wacom->hdev,
 				"cannot create leds err: %d\n", error);
@@ -1062,6 +1225,8 @@ static int wacom_initialize_leds(struct wacom *wacom)
 		break;
 
 	case REMOTE:
+		wacom->led.llv = 255;
+		wacom->led.max_llv = 255;
 		error = wacom_led_groups_allocate(wacom, 5);
 		if (error) {
 			hid_err(wacom->hdev,
@@ -1987,6 +2152,12 @@ static int wacom_remote_create_one(struct wacom *wacom, u32 serial,
 	if (error)
 		goto fail;
 
+	error = wacom_led_groups_alloc_and_register_one(
+					&remote->remotes[index].input->dev,
+					wacom, index, 3, true);
+	if (error)
+		goto fail;
+
 	remote->remotes[index].registered = true;
 
 	devres_close_group(dev, &remote->remotes[index]);
-- 
2.5.5
