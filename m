From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Thu,  1 Sep 2011 09:00:43 -0700
Message-ID: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43265 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932452Ab1IAQAv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Sep 2011 12:00:51 -0400
Received: by gxk21 with SMTP id 21so1471671gxk.19
        for <linux-input@vger.kernel.org>; Thu, 01 Sep 2011 09:00:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, dmitry.torokhov@gmail.com, Jason Gerecke <killertofu@gmail.com>

Adds INPUT_PROP_POINTER or INPUT_PROP_DIRECT as necessary to the
hardware supported by the Wacom driver. The DIRECT property is
assigned to devices with an embedded screen (i.e. touchscreens
and display tablets). The POINTER property is assigned to those
without embedded screens.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/hid-wacom.c                 |    2 ++
 drivers/input/tablet/wacom_wac.c        |   25 ++++++++++++++++++++++++-
 drivers/input/touchscreen/wacom_w8001.c |    2 ++
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 0688832..5b9267d 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -383,6 +383,8 @@ move_on:
 	hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
 	input = hidinput->input;
 
+	__set_bit(INPUT_PROP_POINTER, input->propbit);
+
 	/* Basics */
 	input->evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_REL);
 
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 87b0e0d..a28d48c 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1098,6 +1098,8 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_MOUSE, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
 		__set_bit(BTN_STYLUS2, input_dev->keybit);
+
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
 	case WACOM_21UX2:
@@ -1126,6 +1128,9 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		}
 
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
@@ -1150,6 +1155,8 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case INTUOS:
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
 		wacom_setup_intuos(wacom_wac);
 		break;
 
@@ -1165,6 +1172,8 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		wacom_setup_intuos(wacom_wac);
+
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
 	case TABLETPC2FG:
@@ -1183,14 +1192,24 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case TABLETPC:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+
 		if (features->device_type != BTN_TOOL_PEN)
 			break;  /* no need to process stylus stuff */
 
 		/* fall through */
 
 	case PL:
-	case PTU:
 	case DTU:
+		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
+		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
+		__set_bit(BTN_STYLUS, input_dev->keybit);
+		__set_bit(BTN_STYLUS2, input_dev->keybit);
+
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+		break;
+
+	case PTU:
 		__set_bit(BTN_STYLUS2, input_dev->keybit);
 		/* fall through */
 
@@ -1198,11 +1217,15 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
 		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
+
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
 	case BAMBOO_PT:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
 		if (features->device_type == BTN_TOOL_DOUBLETAP) {
 			__set_bit(BTN_LEFT, input_dev->keybit);
 			__set_bit(BTN_FORWARD, input_dev->keybit);
diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index c14412e..9941d39 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -383,6 +383,8 @@ static int w8001_setup(struct w8001 *w8001)
 	dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	strlcat(w8001->name, "Wacom Serial", sizeof(w8001->name));
 
+	__set_bit(INPUT_PROP_DIRECT, dev->propbit);
+
 	/* penabled? */
 	error = w8001_command(w8001, W8001_CMD_QUERY, true);
 	if (!error) {
-- 
1.7.6

