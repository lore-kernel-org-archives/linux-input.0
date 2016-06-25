From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v2 5/8] Input: synaptics-rmi4: Remove pointer to rmi_function in f12_data
Date: Fri, 24 Jun 2016 17:19:06 -0700
Message-ID: <1466813946-15940-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:63842 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbcFYATR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2016 20:19:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>

The pointer to struct rmi_function in f12_data is never set and was never
used. The fn pointer is also stored in rmi_2d_sensor which is a member of
f12_data.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f12.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 041a91d..7d66766 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -27,7 +27,6 @@ enum rmi_f12_object_type {
 };
 
 struct f12_data {
-	struct rmi_function *fn;
 	struct rmi_2d_sensor sensor;
 	struct rmi_2d_sensor_platform_data sensor_pdata;
 	bool has_dribble;
-- 
2.5.0

