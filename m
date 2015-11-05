From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 16/26] Input: synaptics-rmi4: Use ifdef to check if CONFIG_PM_SLEEP is set
Date: Thu, 5 Nov 2015 15:41:10 -0800
Message-ID: <1446766870-30942-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

The pm variables are not included in the struct rmi_driver_data at compile
time. Using the IS_ENABLED macro in rmi_driver.c will result in a compiler
error if CONFIG_PM_SLEEP is not enabled.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_driver.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index b569aab..54852a0 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -924,15 +924,15 @@ static int rmi_driver_probe(struct device *dev)
 		goto err_destroy_functions;
 	}
 
-	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
-		data->pm_data = pdata->pm_data;
-		data->pre_suspend = pdata->pre_suspend;
-		data->post_suspend = pdata->post_suspend;
-		data->pre_resume = pdata->pre_resume;
-		data->post_resume = pdata->post_resume;
+#ifdef CONFIG_PM_SLEEP
+	data->pm_data = pdata->pm_data;
+	data->pre_suspend = pdata->pre_suspend;
+	data->post_suspend = pdata->post_suspend;
+	data->pre_resume = pdata->pre_resume;
+	data->post_resume = pdata->post_resume;
 
-		mutex_init(&data->suspend_mutex);
-	}
+	mutex_init(&data->suspend_mutex);
+#endif
 
 	if (data->input) {
 		rmi_driver_set_input_name(rmi_dev, data->input);
-- 
2.1.4
