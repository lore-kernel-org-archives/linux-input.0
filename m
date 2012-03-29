From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 02/16 v2] Input: atmel_mxt_ts - only allow root to update firmware
Date: Fri, 30 Mar 2012 00:49:12 +0800
Message-ID: <1333039766-8617-3-git-send-email-djkurtz@chromium.org>
References: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

Restrict permissions on the update_fw sysfs entry to read only for root
only.

Also, update object permission to use a macro S_IRUGO macro instead of
hard coded 0444.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Reviewed-by: Joonyoung Shim <jy0922.shim@samsung.com>
Acked-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 0a6e368..15ae6fd 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1049,8 +1049,8 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(object, 0444, mxt_object_show, NULL);
-static DEVICE_ATTR(update_fw, 0664, NULL, mxt_update_fw_store);
+static DEVICE_ATTR(object, S_IRUGO, mxt_object_show, NULL);
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);
 
 static struct attribute *mxt_attrs[] = {
 	&dev_attr_object.attr,
-- 
1.7.7.3
