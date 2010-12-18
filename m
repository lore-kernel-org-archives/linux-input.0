From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 3/4] Input: synaptics - report clickpad property
Date: Sat, 18 Dec 2010 15:53:00 +0100
Message-ID: <1292683981-6908-4-git-send-email-rydberg@euromail.se>
References: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

With the new input property interface, it is possible to report
the special quirks of a device using ioctl/sysfs. This patch
sets up the device as a pointer, and reports the clickpad
functionality via the INPUT_PROP_BUTTONPAD property.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/synaptics.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 4744064..01302db 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -661,6 +661,8 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 {
 	int i;
 
+	__set_bit(INPUT_PROP_POINTER, dev->propbit);
+
 	__set_bit(EV_ABS, dev->evbit);
 	input_set_abs_params(dev, ABS_X,
 			     XMIN_NOMINAL, priv->x_max ?: XMAX_NOMINAL, 0, 0);
@@ -702,6 +704,7 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	input_abs_set_res(dev, ABS_Y, priv->y_res);
 
 	if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
+		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 		/* Clickpads report only left button */
 		__clear_bit(BTN_RIGHT, dev->keybit);
 		__clear_bit(BTN_MIDDLE, dev->keybit);
-- 
1.7.2.3
