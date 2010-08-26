From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 4/4] firmware sysfs node
Date: Thu, 26 Aug 2010 00:54:57 -0400
Message-ID: <1282798497-19791-5-git-send-email-rafi@seas.upenn.edu>
References: <1282798497-19791-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:54144 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0HZFFg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Aug 2010 01:05:36 -0400
In-Reply-To: <1282798497-19791-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr, micki@n-trig.com, Rafi Rubin <rafi@seas.upenn.edu>

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index ab0ca7f..e341e88 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -375,6 +375,26 @@ static ssize_t set_deactivate_slack(struct device *dev,
 static DEVICE_ATTR(deactivate_slack, S_IWUSR | S_IRUGO, show_deactivate_slack,
 		   set_deactivate_slack);
 
+static ssize_t show_firmware(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct ntrig_data *nd = hid_get_drvdata(hdev);
+
+	if (!(nd->firmware_version[0] || nd->firmware_version[1] ||
+	      nd->firmware_version[2] || nd->firmware_version[3]))
+		return sprintf(buf, "Firmware version unavailable");
+
+	ntrig_version_string(nd->firmware_version, buf);
+
+	return sprintf(buf, "%s (%02x%02x %02x%02x)\n", buf,
+		       nd->firmware_version[0], nd->firmware_version[1],
+		       nd->firmware_version[2], nd->firmware_version[3]);
+}
+
+static DEVICE_ATTR(firmware, S_IRUGO, show_firmware, NULL);
+
 static struct attribute *sysfs_attrs[] = {
 	&dev_attr_sensor_physical_width.attr,
 	&dev_attr_sensor_physical_height.attr,
@@ -386,6 +406,7 @@ static struct attribute *sysfs_attrs[] = {
 	&dev_attr_activation_width.attr,
 	&dev_attr_activation_height.attr,
 	&dev_attr_deactivate_slack.attr,
+	&dev_attr_firmware.attr,
 	NULL
 };
 
-- 
1.7.1

