From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 08/11] touchscreen: melfas: Use octal permissions
Date: Mon, 23 Jul 2018 18:49:23 +0530
Message-ID: <20180723131954.30739-7-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Harshit Jain <harshitjain6751@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sangwon Jee <jeesw@melfas.com>, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mip4_sysfs_fw_update);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(fw_version, S_IRUGO, mip4_sysfs_read_fw_version, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(hw_version, S_IRUGO, mip4_sysfs_read_hw_version, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(product_id, S_IRUGO, mip4_sysfs_read_product_id, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(ic_name, S_IRUGO, mip4_sysfs_read_ic_name, NULL);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/melfas_mip4.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 430a2bc5f7ca..f7fd940e61ea 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1332,7 +1332,7 @@ static ssize_t mip4_sysfs_fw_update(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mip4_sysfs_fw_update);
+static DEVICE_ATTR(update_fw, 0200, NULL, mip4_sysfs_fw_update);
 
 static ssize_t mip4_sysfs_read_fw_version(struct device *dev,
 					  struct device_attribute *attr,
@@ -1354,7 +1354,7 @@ static ssize_t mip4_sysfs_read_fw_version(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(fw_version, S_IRUGO, mip4_sysfs_read_fw_version, NULL);
+static DEVICE_ATTR(fw_version, 0444, mip4_sysfs_read_fw_version, NULL);
 
 static ssize_t mip4_sysfs_read_hw_version(struct device *dev,
 					  struct device_attribute *attr,
@@ -1379,7 +1379,7 @@ static ssize_t mip4_sysfs_read_hw_version(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(hw_version, S_IRUGO, mip4_sysfs_read_hw_version, NULL);
+static DEVICE_ATTR(hw_version, 0444, mip4_sysfs_read_hw_version, NULL);
 
 static ssize_t mip4_sysfs_read_product_id(struct device *dev,
 					  struct device_attribute *attr,
@@ -1398,7 +1398,7 @@ static ssize_t mip4_sysfs_read_product_id(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(product_id, S_IRUGO, mip4_sysfs_read_product_id, NULL);
+static DEVICE_ATTR(product_id, 0444, mip4_sysfs_read_product_id, NULL);
 
 static ssize_t mip4_sysfs_read_ic_name(struct device *dev,
 					  struct device_attribute *attr,
@@ -1418,7 +1418,7 @@ static ssize_t mip4_sysfs_read_ic_name(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(ic_name, S_IRUGO, mip4_sysfs_read_ic_name, NULL);
+static DEVICE_ATTR(ic_name, 0444, mip4_sysfs_read_ic_name, NULL);
 
 static struct attribute *mip4_attrs[] = {
 	&dev_attr_fw_version.attr,
-- 
2.17.1
