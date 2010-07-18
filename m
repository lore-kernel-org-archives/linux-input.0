From: chris@cnpbagwell.com
Subject: [PATCH 2/2] input: synaptics - set min/max for finger width
Date: Sun, 18 Jul 2010 14:06:07 -0500
Message-ID: <1279479967-4499-2-git-send-email-chris@cnpbagwell.com>
References: <1279479967-4499-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33292 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158Ab0GRTGr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jul 2010 15:06:47 -0400
Received: by gwj18 with SMTP id 18so1725260gwj.19
        for <linux-input@vger.kernel.org>; Sun, 18 Jul 2010 12:06:45 -0700 (PDT)
In-Reply-To: <1279479967-4499-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Reporting this will allow GUI config apps to correctly scale
width sensitive config values (such as palm detect) to correct range.
Current user apps are detecting kernels min/max=0/0 and making
an assumption that it means 0/16 or 0/15.

Synaptics touchpad interface guides show 4/15 are correct values
but driver forces to 0 when no fingers on touchpad.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/mouse/synaptics.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 1b49d7f..85a1e14 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -600,7 +600,7 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
 
 	if (SYN_CAP_PALMDETECT(priv->capabilities))
-		__set_bit(ABS_TOOL_WIDTH, dev->absbit);
+		input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
 
 	__set_bit(EV_KEY, dev->evbit);
 	__set_bit(BTN_TOUCH, dev->keybit);
-- 
1.7.1.1

