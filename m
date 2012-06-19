From: Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH 2/2] drivers/input/mouse, drivers/platform/x86: add Lenovo
 IdeaPad Z570 support
Date: Tue, 19 Jun 2012 22:23:26 +0300
Message-ID: <1340133806.3636.11.camel@lenovo-ideapad-z570.olymp.linuxd.org>
References: <1340133637.3636.8.camel@lenovo-ideapad-z570.olymp.linuxd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1340133637.3636.8.camel@lenovo-ideapad-z570.olymp.linuxd.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Rubini <rubini@ipvvis.unipv.it>, Ike Panhc <ike.pan@canonical.com>
List-Id: linux-input@vger.kernel.org

From: Maxim Mikityanskiy <maxtram95@gmail.com>

The patch adds support for Lenovo IdeaPad Z570 laptop. It makes all special
keys working, adds possibility to control fan like Windows does, controls
Touchpad Disabled LED, toggles touchpad state via psmouse with previous
patch and corrects touchpad behavior on resume from suspend. It is new,
modified version of patch.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
--- linux/drivers/platform/x86/ideapad-laptop.c.orig
+++ linux/drivers/platform/x86/ideapad-laptop.c
@@ -36,6 +36,7 @@
 #include <linux/fb.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/input/psmouse.h>
 
 #define IDEAPAD_RFKILL_DEV_NUM	(3)
 
@@ -62,9 +63,12 @@ enum {
 	VPCCMD_W_CAMERA,
 	VPCCMD_R_3G,
 	VPCCMD_W_3G,
-	VPCCMD_R_ODD, /* 0x21 */
-	VPCCMD_R_RF = 0x23,
-	VPCCMD_W_RF,
+	VPCCMD_R_ODD,
+	VPCCMD_W_FAN,
+	VPCCMD_R_RF,
+	VPCCMD_W_RF, /* 0x24 */
+	VPCCMD_R_FAN = 0x2B,
+	VPCCMD_R_SPECIAL_BUTTONS = 0x31,
 	VPCCMD_W_BL_POWER = 0x33,
 };
 
@@ -363,8 +367,47 @@ static ssize_t store_ideapad_cam(struct
 
 static DEVICE_ATTR(camera_power, 0644, show_ideapad_cam, store_ideapad_cam);
 
+static ssize_t show_ideapad_fan(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	unsigned long result;
+
+	if (read_ec_data(ideapad_handle, VPCCMD_R_FAN, &result))
+		return sprintf(buf, "-1\n");
+	return sprintf(buf, "%lu\n", result);
+}
+
+static ssize_t store_ideapad_fan(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	int ret, state;
+
+	if (!count)
+		return 0;
+	if (sscanf(buf, "%i", &state) != 1)
+		return -EINVAL;
+	/* WARNING: these fan states are not speed
+	 * so it isn't cooling_device interface
+	 * 0 = super silent mode
+	 * 1 = standard mode
+	 * 2 = dust cleaning
+	 * 4 = efficient thermal dissipation mode
+	 */
+	if (state < 0 || state > 4 || state == 3)
+		return -EINVAL;
+	ret = write_ec_cmd(ideapad_handle, VPCCMD_W_FAN, state);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
+static DEVICE_ATTR(fan_mode, 0644, show_ideapad_fan, store_ideapad_fan);
+
 static struct attribute *ideapad_attributes[] = {
 	&dev_attr_camera_power.attr,
+	&dev_attr_fan_mode.attr,
 	NULL
 };
 
@@ -379,6 +422,10 @@ static umode_t ideapad_is_visible(struct
 	if (attr == &dev_attr_camera_power.attr)
 		supported = test_bit(CFG_CAMERA_BIT, &(priv->cfg));
 	else
+	if (attr == &dev_attr_fan_mode.attr) {
+		unsigned long value;
+		supported = !read_ec_data(ideapad_handle, VPCCMD_R_FAN, &value);
+	} else
 		supported = true;
 
 	return supported ? attr->mode : 0;
@@ -519,9 +566,15 @@ static void ideapad_platform_exit(struct
  */
 static const struct key_entry ideapad_keymap[] = {
 	{ KE_KEY, 6,  { KEY_SWITCHVIDEOMODE } },
+	{ KE_KEY, 7,  { KEY_CAMERA } },
+	{ KE_KEY, 11, { KEY_F16 } },
 	{ KE_KEY, 13, { KEY_WLAN } },
 	{ KE_KEY, 16, { KEY_PROG1 } },
 	{ KE_KEY, 17, { KEY_PROG2 } },
+	{ KE_KEY, 64, { KEY_PROG3 } },
+	{ KE_KEY, 65, { KEY_PROG4 } },
+	{ KE_KEY, 66, { KEY_TOUCHPAD_OFF } },
+	{ KE_KEY, 67, { KEY_TOUCHPAD_ON } },
 	{ KE_END, 0 },
 };
 
@@ -692,6 +745,25 @@ static const struct acpi_device_id ideap
 };
 MODULE_DEVICE_TABLE(acpi, ideapad_device_ids);
 
+static void ideapad_sync_touchpad_state(struct acpi_device *adevice)
+{
+	struct ideapad_private *priv = dev_get_drvdata(&adevice->dev);
+	unsigned long value;
+
+	/* Without reading from EC touchpad LED doesn't switch state */
+	if (!read_ec_data(adevice->handle, VPCCMD_R_TOUCHPAD, &value)) {
+		/* Some IdeaPads don't really turn off touchpad - they only
+		 * switch the LED state. We (de)activate psmouse to turn
+		 * touchpad off and on. We send KEY_TOUCHPAD_OFF and
+		 * KEY_TOUCHPAD_ON to not to get out of sync with LED */
+		if (value)
+			psmouse_enable();
+		else
+			psmouse_disable();
+		ideapad_input_report(priv, value ? 67 : 66);
+	}
+}
+
 static int __devinit ideapad_acpi_add(struct acpi_device *adevice)
 {
 	int ret, i;
@@ -728,6 +800,7 @@ static int __devinit ideapad_acpi_add(st
 			priv->rfk[i] = NULL;
 	}
 	ideapad_sync_rfk_state(priv);
+	ideapad_sync_touchpad_state(adevice);
 
 	if (!acpi_video_backlight_support()) {
 		ret = ideapad_backlight_init(priv);
@@ -767,6 +840,26 @@ static int __devexit ideapad_acpi_remove
 	return 0;
 }
 
+static void ideapad_check_special_buttons(struct ideapad_private *priv,
+					  unsigned long state)
+{
+	unsigned long bit;
+	for (bit = 0; bit < 16; bit++) {
+		if (test_bit(bit, &state)) {
+			switch (bit) {
+			case 6:
+				/* Thermal Management button */
+				ideapad_input_report(priv, 65);
+				break;
+			case 1:
+				/* OneKey Theater button */
+				ideapad_input_report(priv, 64);
+				break;
+			}
+		}
+	}
+}
+
 static void ideapad_acpi_notify(struct acpi_device *adevice, u32 event)
 {
 	struct ideapad_private *priv = dev_get_drvdata(&adevice->dev);
@@ -785,6 +878,9 @@ static void ideapad_acpi_notify(struct a
 			case 9:
 				ideapad_sync_rfk_state(priv);
 				break;
+			case 5:
+				ideapad_sync_touchpad_state(adevice);
+				break;
 			case 4:
 				ideapad_backlight_notify_brightness(priv);
 				break;
@@ -794,6 +890,14 @@ static void ideapad_acpi_notify(struct a
 			case 2:
 				ideapad_backlight_notify_power(priv);
 				break;
+			case 0:
+				{
+				unsigned long value;
+				read_ec_data(handle, VPCCMD_R_SPECIAL_BUTTONS,
+					     &value);
+				ideapad_check_special_buttons(priv, value);
+				}
+				break;
 			default:
 				ideapad_input_report(priv, vpc_bit);
 			}
@@ -801,6 +905,12 @@ static void ideapad_acpi_notify(struct a
 	}
 }
 
+static int ideapad_acpi_resume(struct acpi_device *adevice)
+{
+	ideapad_sync_touchpad_state(adevice);
+	return 0;
+}
+
 static struct acpi_driver ideapad_acpi_driver = {
 	.name = "ideapad_acpi",
 	.class = "IdeaPad",
@@ -808,6 +918,7 @@ static struct acpi_driver ideapad_acpi_d
 	.ops.add = ideapad_acpi_add,
 	.ops.remove = ideapad_acpi_remove,
 	.ops.notify = ideapad_acpi_notify,
+	.ops.resume = ideapad_acpi_resume,
 	.owner = THIS_MODULE,
 };
 
--- linux/Documentation/ABI/testing/sysfs-platform-ideapad-laptop.orig
+++ linux/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
@@ -5,4 +5,14 @@ Contact:	"Ike Panhc <ike.pan@canonical.c
 Description:
 		Control the power of camera module. 1 means on, 0 means off.
 
-
+What:		/sys/devices/platform/ideapad/fan_mode
+Date:		June 2012
+KernelVersion:	3.5
+Contact:	"Maxim Mikityanskiy <maxtram95@gmail.com>"
+Description:
+		Change fan mode
+		There are four available modes:
+		    * 0 -> Super Silent Mode
+		    * 1 -> Standard Mode
+		    * 2 -> Dust Cleaning
+		    * 4 -> Efficient Thermal Dissipation Mode
