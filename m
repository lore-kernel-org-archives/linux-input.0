From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH] hid: split picolcd's operation_mode sysfs attribute
Date: Sun, 25 Apr 2010 21:29:16 +0200
Message-ID: <20100425212916.2b9af33b@neptune.home>
References: <20100324233707.7243b04d@neptune.home>
	<20100330223224.18fe4f3e@neptune.home>
	<20100330223350.32044891@neptune.home>
	<201004011858.45859.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:59786 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0DYUPr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Apr 2010 16:15:47 -0400
In-Reply-To: <201004011858.45859.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>, Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Jaya Kumar <jayakumar.lkml@gmail.com>

Original operation_mode sysfs attribute accepts the operation mode
as main value with an option delay as second value to change
the start-up delay on mode change.

As it is preferred to have exactly one value per sysfs attribute,
extract this delay into a separate sysfs attribute called
operation_mode_delay.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 Documentation/ABI/testing/sysfs-driver-hid-picolcd |   17 ++++-
 drivers/hid/hid-picolcd.c                          |   62 ++++++++++++=
++-----
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-picolcd b/Docum=
entation/ABI/testing/sysfs-driver-hid-picolcd
index 14f52d7..08579e7 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-picolcd
+++ b/Documentation/ABI/testing/sysfs-driver-hid-picolcd
@@ -8,12 +8,21 @@ Description:	Make it possible to switch the PicoLCD d=
evice between LCD
 		enclosed in brackets ('[' and ']')
=20
 		Writing: causes operation mode switch. Permitted values are
-		the non-active mode names listed when read, optionally followed
-		by a delay value expressed in ms.
+		the non-active mode names listed when read.
=20
 		Note: when switching mode the current PicoLCD HID device gets
-		disconnected and reconnects after above delay (default value
-		is 5 seconds though this default should not be relied on).
+		disconnected and reconnects after above delay (see attribute
+		operation_mode_delay for its value).
+
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/operation_mode_delay
+Date:		April 2010
+Contact:	Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
+Description:	Delay PicoLCD waits before restarting in new mode when
+		operation_mode has changed.
+
+		Reading/Writing: It is expressed in ms and permitted range is
+		0..30000ms.
=20
=20
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/fb_update_rate
diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 6f71c60..aa6f2e1 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -177,6 +177,7 @@ struct picolcd_data {
 	int addr_sz;
 #endif
 	u8 version[2];
+	unsigned short opmode_delay;
 	/* input stuff */
 	u8 pressed_keys[2];
 	struct input_dev *input_keys;
@@ -1270,8 +1271,7 @@ static ssize_t picolcd_operation_mode_store(struc=
t device *dev,
 	struct picolcd_data *data =3D dev_get_drvdata(dev);
 	struct hid_report *report =3D NULL;
 	size_t cnt =3D count;
-	int timeout =3D 5000;
-	unsigned u;
+	int timeout =3D data->opmode_delay;
 	unsigned long flags;
=20
 	if (cnt >=3D 3 && strncmp("lcd", buf, 3) =3D=3D 0) {
@@ -1288,20 +1288,10 @@ static ssize_t picolcd_operation_mode_store(str=
uct device *dev,
 	if (!report)
 		return -EINVAL;
=20
-	while (cnt > 0 && (*buf =3D=3D ' ' || *buf =3D=3D '\t')) {
-		buf++;
-		cnt--;
-	}
 	while (cnt > 0 && (buf[cnt-1] =3D=3D '\n' || buf[cnt-1] =3D=3D '\r'))
 		cnt--;
-	if (cnt > 0) {
-		if (sscanf(buf, "%u", &u) !=3D 1)
-			return -EINVAL;
-		if (u > 30000)
-			return -EINVAL;
-		else
-			timeout =3D u;
-	}
+	if (cnt !=3D 0)
+		return -EINVAL;
=20
 	spin_lock_irqsave(&data->lock, flags);
 	hid_set_field(report->field[0], 0, timeout & 0xff);
@@ -1314,6 +1304,34 @@ static ssize_t picolcd_operation_mode_store(stru=
ct device *dev,
 static DEVICE_ATTR(operation_mode, 0644, picolcd_operation_mode_show,
 		picolcd_operation_mode_store);
=20
+/*
+ * The "operation_mode_delay" sysfs attribute
+ */
+static ssize_t picolcd_operation_mode_delay_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct picolcd_data *data =3D dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%hu\n", data->opmode_delay);
+}
+
+static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct picolcd_data *data =3D dev_get_drvdata(dev);
+	unsigned u;
+	if (sscanf(buf, "%u", &u) !=3D 1)
+		return -EINVAL;
+	if (u > 30000)
+		return -EINVAL;
+	else
+		data->opmode_delay =3D u;
+	return count;
+}
+
+static DEVICE_ATTR(operation_mode_delay, 0644, picolcd_operation_mode_=
delay_show,
+		picolcd_operation_mode_delay_store);
+
=20
 #ifdef CONFIG_DEBUG_FS
 /*
@@ -2409,6 +2427,7 @@ static int picolcd_probe(struct hid_device *hdev,
 	spin_lock_init(&data->lock);
 	mutex_init(&data->mutex);
 	data->hdev =3D hdev;
+	data->opmode_delay =3D 5000;
 	if (hdev->product =3D=3D USB_DEVICE_ID_PICOLCD_BOOTLOADER)
 		data->status |=3D PICOLCD_BOOTLOADER;
 	hid_set_drvdata(hdev, data);
@@ -2436,24 +2455,32 @@ static int picolcd_probe(struct hid_device *hde=
v,
 		goto err_cleanup_hid_hw;
 	}
=20
-	error =3D device_create_file(&hdev->dev, &dev_attr_operation_mode);
+	error =3D device_create_file(&hdev->dev, &dev_attr_operation_mode_del=
ay);
 	if (error) {
 		dev_err(&hdev->dev, "failed to create sysfs attributes\n");
 		goto err_cleanup_hid_ll;
 	}
=20
+	error =3D device_create_file(&hdev->dev, &dev_attr_operation_mode);
+	if (error) {
+		dev_err(&hdev->dev, "failed to create sysfs attributes\n");
+		goto err_cleanup_sysfs1;
+	}
+
 	if (data->status & PICOLCD_BOOTLOADER)
 		error =3D picolcd_probe_bootloader(hdev, data);
 	else
 		error =3D picolcd_probe_lcd(hdev, data);
 	if (error)
-		goto err_cleanup_sysfs;
+		goto err_cleanup_sysfs2;
=20
 	dbg_hid(PICOLCD_NAME " activated and initialized\n");
 	return 0;
=20
-err_cleanup_sysfs:
+err_cleanup_sysfs2:
 	device_remove_file(&hdev->dev, &dev_attr_operation_mode);
+err_cleanup_sysfs1:
+	device_remove_file(&hdev->dev, &dev_attr_operation_mode_delay);
 err_cleanup_hid_ll:
 	hdev->ll_driver->close(hdev);
 err_cleanup_hid_hw:
@@ -2478,6 +2505,7 @@ static void picolcd_remove(struct hid_device *hde=
v)
=20
 	picolcd_exit_devfs(data);
 	device_remove_file(&hdev->dev, &dev_attr_operation_mode);
+	device_remove_file(&hdev->dev, &dev_attr_operation_mode_delay);
 	hdev->ll_driver->close(hdev);
 	hid_hw_stop(hdev);
 	hid_set_drvdata(hdev, NULL);
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
