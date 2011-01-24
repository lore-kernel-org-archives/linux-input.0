From: Andy Ross <andy.ross@windriver.com>
Subject: [PATCH 2/4] asus-laptop: Pegatron Lucid ALS support
Date: Mon, 24 Jan 2011 14:48:06 -0800
Message-ID: <1295909288-32650-3-git-send-email-andy.ross@windriver.com>
References: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add support for the ambient light sensor on the Pegatron Lucid tablet.
This uses a different inteface but the same sysfs interface for
ls_switch, has no equivalent to the existing ls_value threshold
setting, and exports the actual brightness via a new attribute
"ls_value".

Signed-off-by: Andy Ross <andy.ross@windriver.com>
---
 drivers/platform/x86/asus-laptop.c |   64 +++++++++++++++++++++++++++++++++---
 1 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 6f542af..b397a4c 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -383,6 +383,12 @@ static bool asus_check_pega_lucid(struct asus_laptop *asus)
 	   !acpi_check_handle(asus->handle, METHOD_PEGA_READ, NULL);
 }
 
+static int asus_pega_lucid_set(struct asus_laptop *asus, int unit, bool enable)
+{
+	char *method = enable ? METHOD_PEGA_ENABLE : METHOD_PEGA_DISABLE;
+	return write_acpi_int(asus->handle, method, unit);
+}
+
 /* Generic LED function */
 static int asus_led_set(struct asus_laptop *asus, const char *method,
 			 int value)
@@ -1051,7 +1057,15 @@ static ssize_t store_disp(struct device *dev, struct device_attribute *attr,
  */
 static void asus_als_switch(struct asus_laptop *asus, int value)
 {
-	if (write_acpi_int(asus->handle, METHOD_ALS_CONTROL, value))
+	int ret;
+	if (asus->have_pega_lucid) {
+		ret = asus_pega_lucid_set(asus, PEGA_ALS, value);
+		if (!ret)
+			ret = asus_pega_lucid_set(asus, PEGA_ALS_POWER, value);
+	} else {
+		ret = write_acpi_int(asus->handle, METHOD_ALS_CONTROL, value);
+	}
+	if (ret)
 		pr_warning("Error setting light sensor switch\n");
 	asus->light_switch = value;
 }
@@ -1108,6 +1122,35 @@ static ssize_t store_lslvl(struct device *dev, struct device_attribute *attr,
 	return rv;
 }
 
+static int pega_int_read(struct asus_laptop *asus, int arg, int *result)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	int err = write_acpi_int_ret(asus->handle, METHOD_PEGA_READ, arg,
+				     &buffer);
+	if (!err) {
+		union acpi_object *obj = buffer.pointer;
+		if (obj && obj->type == ACPI_TYPE_INTEGER)
+			*result = obj->integer.value;
+		else
+			err = -EIO;
+	}
+	return err;
+}
+
+static ssize_t show_lsvalue(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct asus_laptop *asus = dev_get_drvdata(dev);
+	int err, hi, lo;
+
+	err = pega_int_read(asus, PEGA_READ_ALS_H, &hi);
+	if (!err)
+		err = pega_int_read(asus, PEGA_READ_ALS_L, &lo);
+	if (!err)
+		return sprintf(buf, "%d\n", 10 * hi + lo);
+	return err;
+}
+
 /*
  * GPS
  */
@@ -1305,6 +1348,7 @@ static DEVICE_ATTR(wimax, S_IRUGO | S_IWUSR, show_wimax, store_wimax);
 static DEVICE_ATTR(wwan, S_IRUGO | S_IWUSR, show_wwan, store_wwan);
 static DEVICE_ATTR(display, S_IRUGO | S_IWUSR, show_disp, store_disp);
 static DEVICE_ATTR(ledd, S_IRUGO | S_IWUSR, show_ledd, store_ledd);
+static DEVICE_ATTR(ls_value, S_IRUGO, show_lsvalue, NULL);
 static DEVICE_ATTR(ls_level, S_IRUGO | S_IWUSR, show_lslvl, store_lslvl);
 static DEVICE_ATTR(ls_switch, S_IRUGO | S_IWUSR, show_lssw, store_lssw);
 static DEVICE_ATTR(gps, S_IRUGO | S_IWUSR, show_gps, store_gps);
@@ -1317,6 +1361,7 @@ static struct attribute *asus_attributes[] = {
 	&dev_attr_wwan.attr,
 	&dev_attr_display.attr,
 	&dev_attr_ledd.attr,
+	&dev_attr_ls_value.attr,
 	&dev_attr_ls_level.attr,
 	&dev_attr_ls_switch.attr,
 	&dev_attr_gps.attr,
@@ -1354,8 +1399,15 @@ static mode_t asus_sysfs_is_visible(struct kobject *kobj,
 
 	} else if (attr == &dev_attr_ls_switch.attr ||
 		   attr == &dev_attr_ls_level.attr) {
-		supported = !acpi_check_handle(handle, METHOD_ALS_CONTROL, NULL) &&
-			    !acpi_check_handle(handle, METHOD_ALS_LEVEL, NULL);
+		if (asus_check_pega_lucid(asus)) {
+			/* no ls_level interface on the Lucid */
+			supported = attr == &dev_attr_ls_switch.attr;
+		} else {
+			supported = !acpi_check_handle(handle, METHOD_ALS_CONTROL, NULL) &&
+				    !acpi_check_handle(handle, METHOD_ALS_LEVEL, NULL);
+		}
+	} else if (attr == &dev_attr_ls_value.attr) {
+		supported = asus_check_pega_lucid(asus);
 	} else if (attr == &dev_attr_gps.attr) {
 		supported = !acpi_check_handle(handle, METHOD_GPS_ON, NULL) &&
 			    !acpi_check_handle(handle, METHOD_GPS_OFF, NULL) &&
@@ -1567,8 +1619,10 @@ static int __devinit asus_acpi_init(struct asus_laptop *asus)
 	asus->light_switch = 0;	/* Default to light sensor disabled */
 	asus->light_level = 5;	/* level 5 for sensor sensitivity */
 
-	if (!acpi_check_handle(asus->handle, METHOD_ALS_CONTROL, NULL) &&
-	    !acpi_check_handle(asus->handle, METHOD_ALS_LEVEL, NULL)) {
+	if (asus->have_pega_lucid) {
+		asus_als_switch(asus, asus->light_switch);
+	} else if (!acpi_check_handle(asus->handle, METHOD_ALS_CONTROL, NULL) &&
+		   !acpi_check_handle(asus->handle, METHOD_ALS_LEVEL, NULL)) {
 		asus_als_switch(asus, asus->light_switch);
 		asus_als_level(asus, asus->light_level);
 	}
-- 
1.7.1
