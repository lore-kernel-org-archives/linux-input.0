From: <oskar.andero@sonymobile.com>
Subject: [PATCH] input: don't call input_dev_release_keys() in resume
Date: Thu, 7 Mar 2013 15:01:22 +0100
Message-ID: <1362664882-16194-1-git-send-email-oskar.andero@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Aleksej Makarov <aleksej.makarov@sonymobile.com>, Oskar Andero <oskar.andero@sonymobile.com>
List-Id: linux-input@vger.kernel.org

From: Aleksej Makarov <aleksej.makarov@sonymobile.com>

When waking up the platform by pressing a specific key, sending a
release on that key makes it impossible to react on the event in
user-space.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Radovan Lekanovic <radovan.lekanovic@sonymobile.com>
Signed-off-by: Aleksej Makarov <aleksej.makarov@sonymobile.com>
Signed-off-by: Oskar Andero <oskar.andero@sonymobile.com>
---
 drivers/input/input.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c044699..61ce19f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1690,7 +1690,10 @@ static int input_dev_resume(struct device *dev)
 {
 	struct input_dev *input_dev = to_input_dev(dev);
 
-	input_reset_device(input_dev);
+	mutex_lock(&input_dev->mutex);
+	if (input_dev->users)
+		input_dev_toggle(input_dev, true);
+	mutex_unlock(&input_dev->mutex);
 
 	return 0;
 }
-- 
1.7.8.6
