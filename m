From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Update attributes defined on the tablet
Date: Wed, 24 Nov 2010 15:34:10 -0800
Message-ID: <1290641650-4624-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39247 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab0KXXdv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 18:33:51 -0500
Received: by mail-gw0-f46.google.com with SMTP id 20so177645gwj.19
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 15:33:51 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Moving ABS_WHEEL to ABS_HAT0X and REL_WHEEL to REL_HWHEEL for
ring and relative wheel on the tablet so they can be sent along
with another tool on the tablet or pretend itself as another
supported tool when none is on the tablet.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index b3252ef..9be6bc7 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1059,6 +1059,7 @@ static void wacom_setup_cintiq(struct wacom_wac *wacom_wac)
 
 	input_set_abs_params(input_dev, ABS_DISTANCE,
 			     0, wacom_wac->features.distance_max, 0, 0);
+	input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 	input_set_abs_params(input_dev, ABS_WHEEL, 0, 1023, 0, 0);
 	input_set_abs_params(input_dev, ABS_TILT_X, 0, 127, 0, 0);
 	input_set_abs_params(input_dev, ABS_TILT_Y, 0, 127, 0, 0);
@@ -1134,11 +1135,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case WACOM_MO:
 		__set_bit(BTN_1, input_dev->keybit);
 		__set_bit(BTN_5, input_dev->keybit);
-
-		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
+		input_set_abs_params(input_dev, ABS_HAT0X, 0, 71, 0, 0);
 		/* fall through */
 
 	case WACOM_G4:
+		input_set_capability(input_dev, EV_REL, REL_HWHEEL);
 		input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
 
 		__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
@@ -1169,6 +1170,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_Z, input_dev->keybit);
 		__set_bit(BTN_BASE, input_dev->keybit);
 		__set_bit(BTN_BASE2, input_dev->keybit);
+		input_set_abs_params(input_dev, ABS_HAT0X, 0, 71, 0, 0);
 		/* fall through */
 
 	case WACOM_BEE:
@@ -1183,7 +1185,6 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 		input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
 		input_set_abs_params(input_dev, ABS_RY, 0, 4096, 0, 0);
-		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
@@ -1206,7 +1207,6 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
 
 		input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
-		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		/* fall through */
 
 	case INTUOS:
@@ -1224,7 +1224,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			__set_bit(BTN_0 + i, input_dev->keybit);
 		__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
 
-		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_set_abs_params(input_dev, ABS_HAT0X, 0, 71, 0, 0);
 		wacom_setup_intuos(wacom_wac);
 		break;
 
-- 
1.7.2.3

