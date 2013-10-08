From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/02] input: serio: remove bus usage of dev_attrs
Date: Mon, 7 Oct 2013 18:09:08 -0700
Message-ID: <20131008010908.GB27012@kroah.com>
References: <20131008010823.GA27012@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35851 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab3JHCPh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Oct 2013 22:15:37 -0400
Content-Disposition: inline
In-Reply-To: <20131008010823.GA27012@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The dev_attrs field of struct bus_type is going away soon, so move the
remaining sysfs files that are being described with this field to use
dev_groups instead.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/serio/serio.c |   62 +++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -365,7 +365,7 @@ static ssize_t serio_show_description(st
 	return sprintf(buf, "%s\n", serio->name);
 }
 
-static ssize_t serio_show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 
@@ -397,30 +397,7 @@ static ssize_t extra_show(struct device
 	return sprintf(buf, "%02x\n", serio->id.extra);
 }
 
-static DEVICE_ATTR_RO(type);
-static DEVICE_ATTR_RO(proto);
-static DEVICE_ATTR_RO(id);
-static DEVICE_ATTR_RO(extra);
-
-static struct attribute *serio_device_id_attrs[] = {
-	&dev_attr_type.attr,
-	&dev_attr_proto.attr,
-	&dev_attr_id.attr,
-	&dev_attr_extra.attr,
-	NULL
-};
-
-static struct attribute_group serio_id_attr_group = {
-	.name	= "id",
-	.attrs	= serio_device_id_attrs,
-};
-
-static const struct attribute_group *serio_device_attr_groups[] = {
-	&serio_id_attr_group,
-	NULL
-};
-
-static ssize_t serio_rebind_driver(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t drvctl_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct serio *serio = to_serio_port(dev);
 	struct device_driver *drv;
@@ -474,14 +451,36 @@ static ssize_t serio_set_bind_mode(struc
 	return retval;
 }
 
-static struct device_attribute serio_device_attrs[] = {
-	__ATTR(description, S_IRUGO, serio_show_description, NULL),
-	__ATTR(modalias, S_IRUGO, serio_show_modalias, NULL),
-	__ATTR(drvctl, S_IWUSR, NULL, serio_rebind_driver),
-	__ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode),
-	__ATTR_NULL
+static DEVICE_ATTR_RO(type);
+static DEVICE_ATTR_RO(proto);
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(extra);
+static DEVICE_ATTR_RO(modalias);
+static DEVICE_ATTR_WO(drvctl);
+static DEVICE_ATTR(description, S_IRUGO, serio_show_description, NULL);
+static DEVICE_ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode);
+
+static struct attribute *serio_device_id_attrs[] = {
+	&dev_attr_type.attr,
+	&dev_attr_proto.attr,
+	&dev_attr_id.attr,
+	&dev_attr_extra.attr,
+	&dev_attr_modalias.attr,
+	&dev_attr_description.attr,
+	&dev_attr_drvctl.attr,
+	&dev_attr_bind_mode.attr,
+	NULL
+};
+
+static struct attribute_group serio_id_attr_group = {
+	.name	= "id",
+	.attrs	= serio_device_id_attrs,
 };
 
+static const struct attribute_group *serio_device_attr_groups[] = {
+	&serio_id_attr_group,
+	NULL
+};
 
 static void serio_release_port(struct device *dev)
 {
@@ -996,7 +995,6 @@ EXPORT_SYMBOL(serio_interrupt);
 
 static struct bus_type serio_bus = {
 	.name		= "serio",
-	.dev_attrs	= serio_device_attrs,
 	.drv_groups	= serio_driver_groups,
 	.match		= serio_bus_match,
 	.uevent		= serio_uevent,
