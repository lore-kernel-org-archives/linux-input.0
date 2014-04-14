From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/2] input/serio: Add a firmware_id sysfs attribute
Date: Mon, 14 Apr 2014 12:30:18 +0200
Message-ID: <1397471419-31224-2-git-send-email-hdegoede@redhat.com>
References: <1397471419-31224-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbaDNKas (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 06:30:48 -0400
In-Reply-To: <1397471419-31224-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

serio devices exposed via platform firmware interfaces such as ACPI
may provide additional identifying information of use to userspace.

We don't associate the serio devices with the firmware device (we don't
set it as parent), so there's no way for userspace to make use of this
information.

We cannot change the parent for serio devices instantiated though a firmware
interface as that would break suspend / resume ordering.

Therefor this patch adds a new firmware_id sysfs attribute so that userspace
can get a string from there with any additional identifying information the
firmware interface may provide.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/input/serio/serio.c | 12 ++++++++++++
 include/linux/serio.h       |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 8f4c4ab..1788a4d 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -451,6 +451,13 @@ static ssize_t serio_set_bind_mode(struct device *dev, struct device_attribute *
 	return retval;
 }
 
+static ssize_t firmware_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct serio *serio = to_serio_port(dev);
+
+	return sprintf(buf, "%s\n", serio->firmware_id);
+}
+
 static DEVICE_ATTR_RO(type);
 static DEVICE_ATTR_RO(proto);
 static DEVICE_ATTR_RO(id);
@@ -473,12 +480,14 @@ static DEVICE_ATTR_RO(modalias);
 static DEVICE_ATTR_WO(drvctl);
 static DEVICE_ATTR(description, S_IRUGO, serio_show_description, NULL);
 static DEVICE_ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode);
+static DEVICE_ATTR_RO(firmware_id);
 
 static struct attribute *serio_device_attrs[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_description.attr,
 	&dev_attr_drvctl.attr,
 	&dev_attr_bind_mode.attr,
+	&dev_attr_firmware_id.attr,
 	NULL
 };
 
@@ -923,6 +932,9 @@ static int serio_uevent(struct device *dev, struct kobj_uevent_env *env)
 	SERIO_ADD_UEVENT_VAR("SERIO_EXTRA=%02x", serio->id.extra);
 	SERIO_ADD_UEVENT_VAR("MODALIAS=serio:ty%02Xpr%02Xid%02Xex%02X",
 				serio->id.type, serio->id.proto, serio->id.id, serio->id.extra);
+	if (serio->firmware_id[0])
+		SERIO_ADD_UEVENT_VAR("SERIO_FIRMWARE_ID=%s",
+				     serio->firmware_id);
 
 	return 0;
 }
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 36aac73..9f779c7 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -23,6 +23,7 @@ struct serio {
 
 	char name[32];
 	char phys[32];
+	char firmware_id[128];
 
 	bool manual_bind;
 
-- 
1.9.0

