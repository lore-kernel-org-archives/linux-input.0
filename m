From: Derek Foreman <derek.foreman@collabora.co.uk>
Subject: [PATCH 1/4] Input: New property to indicate that a device's report rate may not be consistent
Date: Fri, 10 Jun 2011 15:55:01 -0400
Message-ID: <1307735704-30673-2-git-send-email-derek.foreman@collabora.co.uk>
References: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.128.226]:37423 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863Ab1FJUCi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 16:02:38 -0400
In-Reply-To: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Some (multi-touch) devices are capable of reporting 1 finger at 80Hz or 2 fingers at 40Hz.
This property allows a user space driver to know that this can happen, and perform extrapolation to present the illusion of fluidity.

Signed-off-by: Derek Foreman <derek.foreman@collabora.co.uk>
---
 drivers/input/mouse/synaptics.c |    1 +
 include/linux/input.h           |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index e06e045..40748e3 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -695,6 +695,7 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
 
 	if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c)) {
+		__set_bit(INPUT_PROP_INCONSISTENT_RATE, dev->propbit);
 		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
 		input_mt_init_slots(dev, 2);
 		input_set_abs_params(dev, ABS_MT_POSITION_X, XMIN_NOMINAL,
diff --git a/include/linux/input.h b/include/linux/input.h
index 771d6d8..f8a0c2d 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -137,6 +137,7 @@ struct input_keymap_entry {
 #define INPUT_PROP_DIRECT		0x01	/* direct input devices */
 #define INPUT_PROP_BUTTONPAD		0x02	/* has button(s) under pad */
 #define INPUT_PROP_SEMI_MT		0x03	/* touch rectangle only */
+#define INPUT_PROP_INCONSISTENT_RATE	0x05	/* device report rate changes */
 
 #define INPUT_PROP_MAX			0x1f
 #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
-- 
1.7.5.3

