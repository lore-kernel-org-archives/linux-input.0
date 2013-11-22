From: Oskar Andero <oskar.andero@sonymobile.com>
Subject: [PATCH v2] input: don't call input_dev_release_keys() in resume
Date: Fri, 22 Nov 2013 14:27:04 +0100
Message-ID: <1385126824-20446-1-git-send-email-oskar.andero@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Julian Shandorov <jshandorov@gmail.com>, Aleksej Makarov <aleksej.makarov@sonymobile.com>, Oskar Andero <oskar.andero@sonymobile.com>
List-Id: linux-input@vger.kernel.org

From: Aleksej Makarov <aleksej.makarov@sonymobile.com>

When waking up the platform by pressing a specific key, sending a
release on that key makes it impossible to react on the event in
user-space. This is fixed by moving the input_reset_device() call to
resume instead.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Radovan Lekanovic <radovan.lekanovic@sonymobile.com>
Signed-off-by: Aleksej Makarov <aleksej.makarov@sonymobile.com>
Signed-off-by: Oskar Andero <oskar.andero@sonymobile.com>
---
 drivers/input/input.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 846ccdd..511d490 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1676,22 +1676,13 @@ static int input_dev_suspend(struct device *dev)
 {
 	struct input_dev *input_dev = to_input_dev(dev);
 
-	mutex_lock(&input_dev->mutex);
-
-	if (input_dev->users)
-		input_dev_toggle(input_dev, false);
-
-	mutex_unlock(&input_dev->mutex);
+	input_reset_device(input_dev);
 
 	return 0;
 }
 
 static int input_dev_resume(struct device *dev)
 {
-	struct input_dev *input_dev = to_input_dev(dev);
-
-	input_reset_device(input_dev);
-
 	return 0;
 }
 
-- 
1.8.1.5
