From: <gregkh@linuxfoundation.org>
Subject: patch "input: serio: use DEVICE_ATTR_RO()" added to driver-core tree
Date: Sat, 19 Oct 2013 20:06:05 -0700
Message-ID: <1382238365810@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36826 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab3JTHiw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Oct 2013 03:38:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    input: serio: use DEVICE_ATTR_RO()

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 7eab8ded347244f1464006ace851521254cabb07 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 7 Oct 2013 18:08:23 -0700
Subject: input: serio: use DEVICE_ATTR_RO()

Convert the serio sysfs fiels to use the DEVICE_ATTR_RO() macros to make
it easier to audit the correct sysfs file permission usage.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/serio/serio.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 2b56855..478880e 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -373,34 +373,34 @@ static ssize_t serio_show_modalias(struct device *dev, struct device_attribute *
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
-- 
1.8.4.6.g82e253f.dirty


