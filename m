From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] keyboard: (samsung) fix a missing check of return value
Date: Tue, 25 Dec 2018 19:51:29 -0600
Message-ID: <20181226015131.71198-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

of_device_is_compatible() returns false if the device is incompatible.
The fix adds a check for its return value;

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/input/keyboard/samsung-keypad.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 1fe1aa2adf85..5ba940f3f76e 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -387,9 +387,13 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	keypad->stopped = true;
 	init_waitqueue_head(&keypad->wait);
 
-	if (pdev->dev.of_node)
-		keypad->type = of_device_is_compatible(pdev->dev.of_node,
-					"samsung,s5pv210-keypad");
+	if (pdev->dev.of_node) {
+		error = of_device_is_compatible(pdev->dev.of_node,
+				"samsung,s5pv210-keypad");
+		if (!error)
+			return -EINVAL;
+		keypad->type = error;
+	}
 	else
 		keypad->type = platform_get_device_id(pdev)->driver_data;
 
-- 
2.17.2 (Apple Git-113)
