From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom - Add INPUT_PROP_DIRECT flag to Cintiq 24HD
Date: Tue, 23 Oct 2012 15:45:20 -0700
Message-ID: <1351032320-4155-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62938 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab2JWWpa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Oct 2012 18:45:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so771435pbb.19
        for <linux-input@vger.kernel.org>; Tue, 23 Oct 2012 15:45:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c3468c8..c30d4c9 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1449,6 +1449,9 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_set_abs_params(input_dev, ABS_THROTTLE, 0, 71, 0, 0);
+
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
-- 
1.7.12.2

