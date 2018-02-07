From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH 2/4] add default settings and module parameters for video controls
Date: Wed,  7 Feb 2018 14:00:36 +0100
Message-ID: <1518008438-26603-3-git-send-email-floe@butterbrot.org>
References: <1518008438-26603-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1518008438-26603-1-git-send-email-floe@butterbrot.org>
Sender: linux-media-owner@vger.kernel.org
To: hverkuil@xs4all.nl, linux-media@vger.kernel.org
Cc: linux-input@vger.kernel.org, modin@yuri.at, Florian Echtler <floe@butterbrot.org>
List-Id: linux-input@vger.kernel.org

This patch adds parameter definitions and module parameters for the four
userspace controls that the SUR40 can currently provide.

Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 8375b06..8a5b031 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -149,6 +149,34 @@ struct sur40_image_header {
 #define SUR40_TOUCH	0x02
 #define SUR40_TAG	0x04
 
+/* video controls */
+#define SUR40_BRIGHTNESS_MAX 0xFF
+#define SUR40_BRIGHTNESS_MIN 0x00
+#define SUR40_BRIGHTNESS_DEF 0xFF
+
+#define SUR40_CONTRAST_MAX 0x0F
+#define SUR40_CONTRAST_MIN 0x00
+#define SUR40_CONTRAST_DEF 0x0A
+
+#define SUR40_GAIN_MAX 0x09
+#define SUR40_GAIN_MIN 0x00
+#define SUR40_GAIN_DEF 0x08
+
+#define SUR40_BACKLIGHT_MAX 0x01
+#define SUR40_BACKLIGHT_MIN 0x00
+#define SUR40_BACKLIGHT_DEF 0x01
+
+/* module parameters */
+static uint brightness = SUR40_BRIGHTNESS_DEF;
+module_param(brightness, uint, 0644);
+MODULE_PARM_DESC(brightness, "set initial brightness");
+static uint contrast = SUR40_CONTRAST_DEF;
+module_param(contrast, uint, 0644);
+MODULE_PARM_DESC(contrast, "set initial contrast");
+static uint gain = SUR40_GAIN_DEF;
+module_param(gain, uint, 0644);
+MODULE_PARM_DESC(gain, "set initial gain");
+
 static const struct v4l2_pix_format sur40_pix_format[] = {
 	{
 		.pixelformat = V4L2_TCH_FMT_TU08,
-- 
2.7.4
