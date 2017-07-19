From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 2/3] Input: axp20x-pek: remove mention to extended attributes
Date: Wed, 19 Jul 2017 09:43:36 +0200
Message-ID: <20170719074337.19189-3-quentin.schulz@free-electrons.com>
References: <20170719074337.19189-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719074337.19189-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com
List-Id: linux-input@vger.kernel.org

Now that extended attributes aren't used anymore, remove all the
mentions to extended attributes.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/input/misc/axp20x-pek.c | 60 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 94c89fbeeeaa..fa49f45c0f0e 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -70,9 +70,9 @@ static const struct axp20x_info axp20x_info = {
 	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
 };
 
-static ssize_t axp20x_show_ext_attr(struct device *dev,
-				    const struct axp20x_time *time,
-				    unsigned int mask, char *buf)
+static ssize_t axp20x_show_attr(struct device *dev,
+				const struct axp20x_time *time,
+				unsigned int mask, char *buf)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 	unsigned int val;
@@ -92,30 +92,30 @@ static ssize_t axp20x_show_ext_attr(struct device *dev,
 	return sprintf(buf, "%u\n", val);
 }
 
-static ssize_t axp20x_show_ext_attr_startup(struct device *dev,
-					    struct device_attribute *attr,
-					    char *buf)
+static ssize_t axp20x_show_attr_startup(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 
-	return axp20x_show_ext_attr(dev, axp20x_pek->info->startup_time,
-				    axp20x_pek->info->startup_mask, buf);
+	return axp20x_show_attr(dev, axp20x_pek->info->startup_time,
+				axp20x_pek->info->startup_mask, buf);
 }
 
-static ssize_t axp20x_show_ext_attr_shutdown(struct device *dev,
-					     struct device_attribute *attr,
-					     char *buf)
+static ssize_t axp20x_show_attr_shutdown(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 
-	return axp20x_show_ext_attr(dev, axp20x_pek->info->shutdown_time,
-				    axp20x_pek->info->shutdown_mask, buf);
+	return axp20x_show_attr(dev, axp20x_pek->info->shutdown_time,
+				axp20x_pek->info->shutdown_mask, buf);
 }
 
-static ssize_t axp20x_store_ext_attr(struct device *dev,
-				     const struct axp20x_time *time,
-				     unsigned int mask, const char *buf,
-				     size_t count)
+static ssize_t axp20x_store_attr(struct device *dev,
+				 const struct axp20x_time *time,
+				 unsigned int mask, const char *buf,
+				 size_t count)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 	char val_str[20];
@@ -157,30 +157,28 @@ static ssize_t axp20x_store_ext_attr(struct device *dev,
 	return count;
 }
 
-static ssize_t axp20x_store_ext_attr_startup(struct device *dev,
-					     struct device_attribute *attr,
-					     const char *buf, size_t count)
+static ssize_t axp20x_store_attr_startup(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 
-	return axp20x_store_ext_attr(dev, axp20x_pek->info->startup_time,
-				     axp20x_pek->info->startup_mask, buf,
-				     count);
+	return axp20x_store_attr(dev, axp20x_pek->info->startup_time,
+				 axp20x_pek->info->startup_mask, buf, count);
 }
 
-static ssize_t axp20x_store_ext_attr_shutdown(struct device *dev,
-					      struct device_attribute *attr,
-					      const char *buf, size_t count)
+static ssize_t axp20x_store_attr_shutdown(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 
-	return axp20x_store_ext_attr(dev, axp20x_pek->info->shutdown_time,
-				     axp20x_pek->info->shutdown_mask, buf,
-				     count);
+	return axp20x_store_attr(dev, axp20x_pek->info->shutdown_time,
+				 axp20x_pek->info->shutdown_mask, buf, count);
 }
 
-DEVICE_ATTR(startup, 0644, axp20x_show_ext_attr_startup, axp20x_store_ext_attr_startup);
-DEVICE_ATTR(shutdown, 0644, axp20x_show_ext_attr_shutdown, axp20x_store_ext_attr_shutdown);
+DEVICE_ATTR(startup, 0644, axp20x_show_attr_startup, axp20x_store_attr_startup);
+DEVICE_ATTR(shutdown, 0644, axp20x_show_attr_shutdown, axp20x_store_attr_shutdown);
 
 static struct attribute *axp20x_attributes[] = {
 	&dev_attr_startup.attr,
-- 
2.11.0
