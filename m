From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/02] input: serio: use DEVICE_ATTR_RO()
Date: Mon, 7 Oct 2013 18:08:23 -0700
Message-ID: <20131008010823.GA27012@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35850 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab3JHCP2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Oct 2013 22:15:28 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Convert the serio sysfs fiels to use the DEVICE_ATTR_RO() macros to make
it easier to audit the correct sysfs file permission usage.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/serio/serio.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -373,34 +373,34 @@ static ssize_t serio_show_modalias(struc
 			serio->id.type, serio->id.proto, serio->id.id, serio->id.extra);
 }
 
-static ssize_t serio_show_id_type(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.type);
 }
 
-static ssize_t serio_show_id_proto(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t proto_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.proto);
 }
 
-static ssize_t serio_show_id_id(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.id);
 }
 
-static ssize_t serio_show_id_extra(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t extra_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
 	return sprintf(buf, "%02x\n", serio->id.extra);
 }
 
-static DEVICE_ATTR(type, S_IRUGO, serio_show_id_type, NULL);
-static DEVICE_ATTR(proto, S_IRUGO, serio_show_id_proto, NULL);
-static DEVICE_ATTR(id, S_IRUGO, serio_show_id_id, NULL);
-static DEVICE_ATTR(extra, S_IRUGO, serio_show_id_extra, NULL);
+static DEVICE_ATTR_RO(type);
+static DEVICE_ATTR_RO(proto);
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(extra);
 
 static struct attribute *serio_device_id_attrs[] = {
 	&dev_attr_type.attr,
