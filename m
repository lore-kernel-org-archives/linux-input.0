From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH 1/2] HID: hid-lg4ff: fix sysfs attribute permission
Date: Mon, 19 Jan 2015 02:03:25 -0500
Message-ID: <1421651006-30812-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
List-Id: linux-input@vger.kernel.org

There is no reason to set the range attribute executable to the user and
group, and writable to the group. Fix the permission to 0644.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/hid/hid-lg4ff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 7835717..4b668bf 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -52,7 +52,8 @@ static void hid_lg4ff_set_range_g25(struct hid_device *hid, u16 range);
 static ssize_t lg4ff_range_show(struct device *dev, struct device_attribute *attr, char *buf);
 static ssize_t lg4ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count);
 
-static DEVICE_ATTR(range, S_IRWXU | S_IRWXG | S_IROTH, lg4ff_range_show, lg4ff_range_store);
+static DEVICE_ATTR(range, S_IRUGO | S_IWUSR, lg4ff_range_show,
+		   lg4ff_range_store);
 
 struct lg4ff_device_entry {
 	__u32 product_id;
-- 
2.2.2
