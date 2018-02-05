From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH 2/5] add video control register definitions
Date: Mon,  5 Feb 2018 15:29:38 +0100
Message-ID: <1517840981-12280-3-git-send-email-floe@butterbrot.org>
References: <1517840981-12280-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1517840981-12280-1-git-send-email-floe@butterbrot.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org, hverkuil@xs4all.nl
Cc: linux-input@vger.kernel.org, modin@yuri.at, Florian Echtler <floe@butterbrot.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 8375b06..0dbb004 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -149,6 +149,30 @@ struct sur40_image_header {
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
+#define SUR40_VSVIDEO_DEF 0x86
+
+#define SUR40_BACKLIGHT_MAX 0x01
+#define SUR40_BACKLIGHT_MIN 0x00
+#define SUR40_BACKLIGHT_DEF 0x01
+
+int sur40_v4l2_brightness = SUR40_BRIGHTNESS_DEF; /* infrared     */
+int sur40_v4l2_contrast   = SUR40_CONTRAST_DEF;   /* blacklevel   */
+int sur40_v4l2_gain       = SUR40_GAIN_DEF;       /* gain         */
+int sur40_v4l2_backlight  = 1;                    /* preprocessor */
+
 static const struct v4l2_pix_format sur40_pix_format[] = {
 	{
 		.pixelformat = V4L2_TCH_FMT_TU08,
-- 
2.7.4
