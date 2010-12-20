From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 1/3] Input: synaptics - report clickpad property
Date: Mon, 20 Dec 2010 14:39:22 +0100
Message-ID: <1292852364-19127-2-git-send-email-rydberg@euromail.se>
References: <1292852364-19127-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:38258 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753137Ab0LTNkG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Dec 2010 08:40:06 -0500
In-Reply-To: <1292852364-19127-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>, Chase Douglas <chase.douglas@canonical.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

With the new input property interface, it is possible to report the
special quirks of a device using ioctl/sysfs. This patch sets up the
device as a pointer, and reports the clickpad functionality via the
INPUT_PROP_BUTTONPAD property.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/synaptics.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 2e300a4..8997cbc 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -622,6 +622,8 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 {
 	int i;
 
+	__set_bit(INPUT_PROP_POINTER, dev->propbit);
+
 	__set_bit(EV_ABS, dev->evbit);
 	input_set_abs_params(dev, ABS_X,
 			     XMIN_NOMINAL, priv->x_max ?: XMAX_NOMINAL, 0, 0);
@@ -663,6 +665,7 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	input_abs_set_res(dev, ABS_Y, priv->y_res);
 
 	if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
+		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 		/* Clickpads report only left button */
 		__clear_bit(BTN_RIGHT, dev->keybit);
 		__clear_bit(BTN_MIDDLE, dev->keybit);
-- 
1.7.2.3

