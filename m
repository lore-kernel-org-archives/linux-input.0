From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 03/11] touchscreen: ad7846: Use octal permissions
Date: Sun, 22 Jul 2018 00:39:43 +0530
Message-ID: <20180721191029.25658-2-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi@etezian.org>, Simon Budig <simon.budig@kernelconcepts.de>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index a2f45aefce08..7c07de0802de 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -431,7 +431,7 @@ name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 		return v; \
 	return sprintf(buf, "%u\n", adjust(ts, v)); \
 } \
-static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
+static DEVICE_ATTR(name, 0444, name ## _show, NULL);
 
 
 /* Sysfs conventions report temperatures in millidegrees Celsius.
@@ -561,7 +561,7 @@ static ssize_t ads7846_pen_down_show(struct device *dev,
 	return sprintf(buf, "%u\n", ts->pendown);
 }
 
-static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);
+static DEVICE_ATTR(pen_down, 0444, ads7846_pen_down_show, NULL);
 
 static ssize_t ads7846_disable_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
-- 
2.17.1
