From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom - Advertise BTN_TOOL_PEN and BTN_STYLUS for PenPartner
Date: Fri, 26 Aug 2011 14:31:25 -0700
Message-ID: <1314394285-6994-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44713 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab1HZVbg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Aug 2011 17:31:36 -0400
Received: by ywf7 with SMTP id 7so3197652ywf.19
        for <linux-input@vger.kernel.org>; Fri, 26 Aug 2011 14:31:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, dmitry.torokhov@gmail.com, Jason Gerecke <killertofu@gmail.com>

The Wacom PenPartner should advertise its stylus tip and button
in addition to the eraser tool. These are both physically
present on the hardware, and emitted from 'wacom_penpartner_irq'.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c1c2f7b..87b0e0d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1191,13 +1191,13 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case PL:
 	case PTU:
 	case DTU:
-		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-		__set_bit(BTN_STYLUS, input_dev->keybit);
 		__set_bit(BTN_STYLUS2, input_dev->keybit);
 		/* fall through */
 
 	case PENPARTNER:
+		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
 		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
+		__set_bit(BTN_STYLUS, input_dev->keybit);
 		break;
 
 	case BAMBOO_PT:
-- 
1.7.6

