From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH] Input: synaptics - disable fuzz when using mt slots
Date: Fri,  1 Feb 2013 16:28:32 +0800
Message-ID: <1359707312-12986-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Seth Forshee <seth.forshee@canonical.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chung-Yih Wang <cywang@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

The input fuzz algorithm does a pretty good job filtering out small
jitter on input samples.

However, there is a subtle problem when fuzz is used with mt drivers that
also use input_mt_report_pointer_emulation() to report legacy single
touch coordinates.  The reported single touch coordinates are taken from
the active MT slot with smallest tracking id.  However, since the MT data
is sent first, it has already had FUZZ applied.  Thus, the ST coordinates
actually get FUZZ applied a second time, with the just-fuzzed MT value as
the 'old value'.

It appears that it is non-trivial to fix this in the mt layer/input core,
so, for now, just disable fuzz for the synaptics IMAGE_SENSOR path that
uses input_mt_report_pointer_emulation().

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/mouse/synaptics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 12d12ca..b6c6838 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1211,7 +1211,8 @@ static void set_abs_position_params(struct input_dev *dev,
 	int x_max = priv->x_max ?: XMAX_NOMINAL;
 	int y_min = priv->y_min ?: YMIN_NOMINAL;
 	int y_max = priv->y_max ?: YMAX_NOMINAL;
-	int fuzz = SYN_CAP_REDUCED_FILTERING(priv->ext_cap_0c) ?
+	int fuzz = (SYN_CAP_REDUCED_FILTERING(priv->ext_cap_0c) &&
+			!SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) ?
 			SYN_REDUCED_FILTER_FUZZ : 0;
 
 	input_set_abs_params(dev, x_code, x_min, x_max, fuzz, 0);
-- 
1.8.1
