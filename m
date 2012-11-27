From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: Document no-sleep requirement for playback() callback
Date: Tue, 27 Nov 2012 06:32:15 +0000
Message-ID: <1353997935-7210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41430 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755906Ab2K0GcS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 01:32:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Avoids surprising users.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/input.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 82ce323..0ba0de1 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -475,7 +475,8 @@ extern struct class input_class;
  * struct ff_device - force-feedback part of an input device
  * @upload: Called to upload an new effect into device
  * @erase: Called to erase an effect from device
- * @playback: Called to request device to start playing specified effect
+ * @playback: Called to request device to start playing specified effect.
+ *            Must not sleep.
  * @set_gain: Called to set specified gain
  * @set_autocenter: Called to auto-center device
  * @destroy: called by input core when parent input device is being
-- 
1.7.10.4

