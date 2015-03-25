From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2] Input: cros_ec_keyb - Clear keyboard state only when it hasn't been a wake source
Date: Wed, 25 Mar 2015 17:08:36 +0100
Message-ID: <1427299718-22820-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37044 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbbCYQJN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 12:09:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Bill Richardson <wfrichar@chromium.org>, Todd Broch <tbroch@chromium.org>, linux-input@vger.kernel.org

As the comment right before explains, the keyboard state is to be
cleared only if the EC wasn't a wakeup source in the last suspend.

Without this commit, there's an unneeded delay when resuming from
suspend and we also lose the key that was pressed while suspended.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Sorry, v1 included an unintended change.

Thanks,

Tomeu

---
 drivers/input/keyboard/cros_ec_keyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 769f8f7..b50c5b8 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
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

