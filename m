From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 04/11] touchscreen: amtel: Use octal permissions
Date: Sun, 22 Jul 2018 00:39:44 +0530
Message-ID: <20180721191029.25658-3-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(fw_version, S_IRUGO, mxt_fw_version_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(hw_version, S_IRUGO, mxt_hw_version_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(object, S_IRUGO, mxt_object_show, NULL);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 54fe190fd4bc..5202a8244f1d 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2892,10 +2892,10 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(fw_version, S_IRUGO, mxt_fw_version_show, NULL);
-static DEVICE_ATTR(hw_version, S_IRUGO, mxt_hw_version_show, NULL);
-static DEVICE_ATTR(object, S_IRUGO, mxt_object_show, NULL);
-static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);
+static DEVICE_ATTR(fw_version, 0444, mxt_fw_version_show, NULL);
+static DEVICE_ATTR(hw_version, 0444, mxt_hw_version_show, NULL);
+static DEVICE_ATTR(object, 0444, mxt_object_show, NULL);
+static DEVICE_ATTR(update_fw, 0200, NULL, mxt_update_fw_store);
 
 static struct attribute *mxt_attrs[] = {
 	&dev_attr_fw_version.attr,
-- 
2.17.1
