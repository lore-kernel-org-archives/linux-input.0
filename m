From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] Input: cros_ec_keyb - Clear keyboard state only when it hasn't been a wake source
Date: Wed, 25 Mar 2015 17:04:04 +0100
Message-ID: <1427299446-22338-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Bill Richardson <wfrichar@chromium.org>, Todd Broch <tbroch@chromium.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

As the comment right before explains, the keyboard state is to be
cleared only if the EC wasn't a wakeup source in the last suspend.

Without this commit, there's an unneeded delay when resuming from
suspend and we also lose the key that was pressed while suspended.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 769f8f7..14f35c4 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -327,7 +327,7 @@ static void cros_ec_keyb_clear_keyboard(struct cros_ec_keyb *ckdev)
 			break;
 	}
 	duration = jiffies - duration;
-	dev_info(ckdev->dev, "Discarded %d keyscan(s) in %dus\n", i,
+	printk("Discarded %d keyscan(s) in %dus\n", i,
 		jiffies_to_usecs(duration));
 }
 
@@ -341,7 +341,7 @@ static int cros_ec_keyb_resume(struct device *dev)
 	 * wake source (e.g. the lid is open and the user might press a key to
 	 * wake) then the key scan buffer should be preserved.
 	 */
-	if (ckdev->ec->was_wake_device)
+	if (!ckdev->ec->was_wake_device)
 		cros_ec_keyb_clear_keyboard(ckdev);
 
 	return 0;
-- 
2.1.0
