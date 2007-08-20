From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V3 3/3] ACPI video hotkey: export ACPI video hotkey events
	via input layer
Date: Mon, 20 Aug 2007 18:23:53 +0800
Message-ID: <1187605433.2920.142.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Cc: lenb@kernel.org, mjg59@srcf.ucam.org, dmitry.torokhov@gmail.com, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com
List-Id: linux-input@vger.kernel.org

From: Yu Luming <luming.yu@intel.com>

Export ACPI video hotkey events via input layer.

Signed-off-by: Yu Luming <luming.yu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

Index: linux-2.6.23-rc3/drivers/acpi/video.c
===================================================================
--- linux-2.6.23-rc3.orig/drivers/acpi/video.c
+++ linux-2.6.23-rc3/drivers/acpi/video.c
@@ -31,7 +31,7 @@
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-
+#include <linux/input.h>
 #include <linux/backlight.h>
 #include <linux/video_output.h>
 #include <asm/uaccess.h>
@@ -138,6 +138,8 @@ struct acpi_video_bus {
 	struct semaphore sem;
 	struct list_head video_device_list;
 	struct proc_dir_entry *dir;
+	struct input_dev *input;
+	char phys[32];	/* for input device */
 };
 
 struct acpi_video_device_flags {
@@ -1764,6 +1766,9 @@ static void acpi_video_bus_notify(acpi_h
 {
 	struct acpi_video_bus *video = data;
 	struct acpi_device *device = NULL;
+	struct input_dev *input;
+	int keycode;
+
 
 	printk("video bus notify\n");
 
@@ -1771,11 +1776,13 @@ static void acpi_video_bus_notify(acpi_h
 		return;
 
 	device = video->device;
+	input = video->input;
 
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
 					 * most likely via hotkey. */
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
 	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
@@ -1784,21 +1791,37 @@ static void acpi_video_bus_notify(acpi_h
 		acpi_video_device_rebind(video);
 		acpi_video_switch_output(video, event);
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
 	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey pressed. */
+		acpi_video_switch_output(video, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_DISPLAY_CYCLE;
+		break;
 	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:	/* Next Display output hotkey pressed. */
+		acpi_video_switch_output(video, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_VIDEO_NEXT;
+		break;
 	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:	/* previous Display output hotkey pressed. */
 		acpi_video_switch_output(video, event);
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_VIDEO_PREV;
 		break;
 
 	default:
+		keycode = KEY_UNKNOWN;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
 
+	input_report_key(input, keycode, 1);
+	input_sync(input);
+	input_report_key(input, keycode, 0);
+	input_sync(input);
+
 	return;
 }
 
@@ -1806,26 +1829,55 @@ static void acpi_video_device_notify(acp
 {
 	struct acpi_video_device *video_device = data;
 	struct acpi_device *device = NULL;
+	struct acpi_video_bus *bus;
+	struct input_dev *input;
+	int keycode;
 
 	if (!video_device)
 		return;
 
 	device = video_device->dev;
+	bus = video_device->video;
+	input = bus->input;
 
 	switch (event) {
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESS_CYCLE;
+		break;
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESSUP;
+		break;
 	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESSDOWN;
+		break;
 	case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS:	/* zero brightnesss */
+		acpi_video_switch_brightness(video_device, event);
+		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_BRIGHTNESS_ZERO;
+		break;
 	case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:	/* display device off */
 		acpi_video_switch_brightness(video_device, event);
 		acpi_bus_generate_event(device, event, 0);
+		keycode = KEY_DISPLAY_OFF;
 		break;
 	default:
+		keycode = KEY_UNKNOWN;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
+
+	input_report_key(input, keycode, 1);
+	input_sync(input);
+	input_report_key(input, keycode, 0);
+	input_sync(input);
+
 	return;
 }
 
@@ -1834,6 +1886,7 @@ static int acpi_video_bus_add(struct acp
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
+	struct input_dev *input;
 
 
 	if (!device)
@@ -1877,6 +1930,40 @@ static int acpi_video_bus_add(struct acp
 		goto end;
 	}
 
+
+	video->input = input = input_allocate_device();
+
+	snprintf(video->phys, sizeof(video->phys),
+		"%s/video/input0", acpi_device_hid(video->device));
+
+	input->name = acpi_device_name(video->device);
+	input->phys = video->phys;
+	input->id.bustype = BUS_HOST;
+	input->id.product = 0x06;
+	input->evbit[0] = BIT(EV_KEY);
+	set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
+	set_bit(KEY_DISPLAY_CYCLE, input->keybit);
+	set_bit(KEY_VIDEO_NEXT, input->keybit);
+	set_bit(KEY_VIDEO_PREV, input->keybit);
+	set_bit(KEY_BRIGHTNESS_CYCLE, input->keybit);
+	set_bit(KEY_BRIGHTNESSUP, input->keybit);
+	set_bit(KEY_BRIGHTNESSDOWN, input->keybit);
+	set_bit(KEY_BRIGHTNESS_ZERO, input->keybit);
+	set_bit(KEY_DISPLAY_OFF, input->keybit);
+	set_bit(KEY_UNKNOWN, input->keybit);
+	result = input_register_device(input);
+	if (result) {
+		acpi_remove_notify_handler(video->device->handle,
+						ACPI_DEVICE_NOTIFY,
+						acpi_video_bus_notify);
+		acpi_video_bus_stop_devices(video);
+		acpi_video_bus_put_devices(video);
+		kfree(video->attached_array);
+		acpi_video_bus_remove_fs(device);
+		goto end;
+        }
+
+
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
 	       video->flags.multihead ? "yes" : "no",
@@ -1910,6 +1997,7 @@ static int acpi_video_bus_remove(struct 
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
 
+	input_unregister_device(video->input);
 	kfree(video->attached_array);
 	kfree(video);
 
