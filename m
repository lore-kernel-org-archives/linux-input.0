From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] input: ff-core: Fix spelling mistake in ff-core
Date: Fri, 8 May 2015 14:45:20 -0500
Message-ID: <1431114320-23861-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41430 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753311AbbEHTpX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 May 2015 15:45:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Dan Murphy <dmurphy@ti.com>

Fix spelling of magnitude
s/manginude/magnitude

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/input/ff-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index b81c88c..d10154e 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -70,12 +70,11 @@ static int compat_effect(struct ff_device *ff, struct ff_effect *effect)
 			return -EINVAL;
 
 		/*
-		 * calculate manginude of sine wave as average of rumble's
+		 * calculate magnitude of sine wave as average of rumble's
 		 * 2/3 of strong magnitude and 1/3 of weak magnitude
 		 */
 		magnitude = effect->u.rumble.strong_magnitude / 3 +
 			    effect->u.rumble.weak_magnitude / 6;
-
 		effect->type = FF_PERIODIC;
 		effect->u.periodic.waveform = FF_SINE;
 		effect->u.periodic.period = 50;
-- 
1.9.1

