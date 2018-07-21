From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 05/11] touchscreen: elants: Use octal permissions
Date: Sun, 22 Jul 2018 00:39:45 +0530
Message-ID: <20180721191029.25658-4-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi@etezian.org>, Simon Budig <simon.budig@kernelconcepts.de>, Luca Ceresoli <luca@lucaceresoli.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+		.dattr = __ATTR(_field, S_IRUGO,			\

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/elants_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index d21ca39b0fdb..9717b7c3bb6f 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1000,8 +1000,8 @@ static ssize_t show_iap_mode(struct device *dev,
 }
 
 static DEVICE_ATTR_WO(calibrate);
-static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
-static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw);
+static DEVICE_ATTR(iap_mode, 0444, show_iap_mode, NULL);
+static DEVICE_ATTR(update_fw, 0200, NULL, write_update_fw);
 
 struct elants_version_attribute {
 	struct device_attribute dattr;
@@ -1016,7 +1016,7 @@ struct elants_version_attribute {
 	 __ELANTS_FIELD_SIZE(_field))
 #define ELANTS_VERSION_ATTR(_field)					\
 	struct elants_version_attribute elants_ver_attr_##_field = {	\
-		.dattr = __ATTR(_field, S_IRUGO,			\
+		.dattr = __ATTR(_field, 0444,			\
 				elants_version_attribute_show, NULL),	\
 		.field_offset = offsetof(struct elants_data, _field),	\
 		.field_size = __ELANTS_VERIFY_SIZE(_field),		\
-- 
2.17.1
