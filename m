From: Derek Foreman <derek.foreman@collabora.co.uk>
Subject: [PATCH 4/4] Input: Synaptics: Add INPUT_PROP_SYNAPTICS_T3R2 property
Date: Fri, 10 Jun 2011 15:55:04 -0400
Message-ID: <1307735704-30673-5-git-send-email-derek.foreman@collabora.co.uk>
References: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.128.226]:37424 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab1FJUCi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 16:02:38 -0400
In-Reply-To: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This new property indicates that the trackpad is able to track more than two contacts, but can only report the positions of two contacts due to bus bandwidth limitations.

Signed-off-by: Derek Foreman <derek.foreman@collabora.co.uk>
---
 drivers/input/mouse/synaptics.c |    3 +++
 include/linux/input.h           |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 3c68663..a8ff669 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -701,6 +701,9 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 
 	__set_bit(INPUT_PROP_POINTER, dev->propbit);
 
+	if (priv->use_bounding_box == 0)
+		__set_bit(INPUT_PROP_SYNAPTICS_T3R2, dev->propbit);
+
 	__set_bit(EV_ABS, dev->evbit);
 	input_set_abs_params(dev, ABS_X,
 			     XMIN_NOMINAL, priv->x_max ?: XMAX_NOMINAL, 0, 0);
diff --git a/include/linux/input.h b/include/linux/input.h
index 388cdef..b667e88 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -137,6 +137,7 @@ struct input_keymap_entry {
 #define INPUT_PROP_DIRECT		0x01	/* direct input devices */
 #define INPUT_PROP_BUTTONPAD		0x02	/* has button(s) under pad */
 #define INPUT_PROP_SEMI_MT		0x03	/* touch rectangle only */
+#define INPUT_PROP_SYNAPTICS_T3R2	0x04	/* synaptics track 3 report 2 */
 #define INPUT_PROP_INCONSISTENT_RATE	0x05	/* device report rate changes */
 
 #define INPUT_PROP_MAX			0x1f
-- 
1.7.5.3

