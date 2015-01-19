From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH 2/2] HID: hid-lg4ff: use DEVICE_ATTR_RW macro
Date: Mon, 19 Jan 2015 02:03:26 -0500
Message-ID: <1421651006-30812-2-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1421651006-30812-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421651006-30812-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
List-Id: linux-input@vger.kernel.org

Use the DEVICE_ATTR_RW macro to reduce boiler plate and move the
attribute declaration to get rid of function signatures.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/hid/hid-lg4ff.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 4b668bf..db0dd9b 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -49,11 +49,6 @@
 
 static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 range);
 static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range);
-static ssize_t lg4ff_range_show(struct device *dev, struct device_attribute *attr, char *buf);
-static ssize_t lg4ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count);
-
-static DEVICE_ATTR(range, S_IRUGO | S_IWUSR, lg4ff_range_show,
-		   lg4ff_range_store);
 
 struct lg4ff_device_entry {
 	__u32 product_id;
@@ -417,7 +412,8 @@ static void hid_lg4ff_switch_native(struct hid_device *hid, const struct lg4ff_n
 }
 
 /* Read current range and display it in terminal */
-static ssize_t lg4ff_range_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t range_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct hid_device *hid = to_hid_device(dev);
 	struct lg4ff_device_entry *entry;
@@ -442,7 +438,8 @@ static ssize_t lg4ff_range_show(struct device *dev, struct device_attribute *att
 
 /* Set range to user specified value, call appropriate function
  * according to the type of the wheel */
-static ssize_t lg4ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t range_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct hid_device *hid = to_hid_device(dev);
 	struct lg4ff_device_entry *entry;
@@ -473,6 +470,7 @@ static ssize_t lg4ff_range_store(struct device *dev, struct device_attribute *at
 
 	return count;
 }
+static DEVICE_ATTR_RW(range);
 
 #ifdef CONFIG_LEDS_CLASS
 static void lg4ff_set_leds(struct hid_device *hid, __u8 leds)
-- 
2.2.2
