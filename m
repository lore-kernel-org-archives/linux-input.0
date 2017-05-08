From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] Input: Improve a size determination in four functions
Date: Mon, 8 May 2017 15:06:12 +0200
Message-ID: <a29ed456-2607-a417-8a35-e48c15656585@users.sourceforge.net>
References: <85bf6874-661a-9cab-1e9b-ea9e312b94de@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85bf6874-661a-9cab-1e9b-ea9e312b94de@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 8 May 2017 14:54:26 +0200

Replace the specification of four data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/input.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 067a6edd643c..7e6842bd525c 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -481,7 +481,7 @@ EXPORT_SYMBOL(input_inject_event);
 void input_alloc_absinfo(struct input_dev *dev)
 {
 	if (!dev->absinfo)
-		dev->absinfo = kcalloc(ABS_CNT, sizeof(struct input_absinfo),
+		dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo),
 					GFP_KERNEL);
 
 	WARN(!dev->absinfo, "%s(): kcalloc() failed?\n", __func__);
@@ -1783,7 +1783,7 @@ struct input_dev *input_allocate_device(void)
 	static atomic_t input_no = ATOMIC_INIT(-1);
 	struct input_dev *dev;
 
-	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev) {
 		dev->dev.type = &input_dev_type;
 		dev->dev.class = &input_class;
@@ -1849,7 +1849,7 @@ struct input_dev *devm_input_allocate_device(struct device *dev)
 	struct input_devres *devres;
 
 	devres = devres_alloc(devm_input_device_release,
-			      sizeof(struct input_devres), GFP_KERNEL);
+			      sizeof(*devres), GFP_KERNEL);
 	if (!devres)
 		return NULL;
 
@@ -2099,7 +2099,7 @@ int input_register_device(struct input_dev *dev)
 
 	if (dev->devres_managed) {
 		devres = devres_alloc(devm_input_device_unregister,
-				      sizeof(struct input_devres), GFP_KERNEL);
+				      sizeof(*devres), GFP_KERNEL);
 		if (!devres)
 			return -ENOMEM;
 
-- 
2.12.2
