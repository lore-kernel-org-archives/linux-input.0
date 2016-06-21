From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] HID-PICOLCD: Dummy hid-picolcd functions should return error code
Date: Wed, 22 Jun 2016 00:08:40 +0530
Message-ID: <1466534320-31256-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 51.18-broadband.acttv.in ([106.51.18.144]:48439 "EHLO
	arvind-ThinkPad-Edge-E431" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751568AbcFUTex (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 15:34:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: bonbons@linux-vserver.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>

- inline picolcd_fb_reset and picolcd_init_framebuffer stub simply
  allows compilation on systems with CONFIG_HID_PICOLCD_FB disabled.
- inline picolcd_init_backlight and picolcd_resume_backlight stub
  simply allows compilation on systems with CONFIG_HID_PICOLCD_BACKLIGHT
  disabled.
- inline picolcd_init_lcd and picolcd_resume_lcd stub simply allows
  compilation on systems with CONFIG_HID_PICOLCD_LCD disabled.
- inline picolcd_init_leds stub simply allows compilation on systems
  with CONFIG_HID_PICOLCD_LEDS disabled.
- inline picolcd_init_cir stub simply allows compilation on systems
  with CONFIG_HID_PICOLCD_CIR disabled.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/hid-picolcd.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
index e56d847..7e6c10a 100644
--- a/drivers/hid/hid-picolcd.h
+++ b/drivers/hid/hid-picolcd.h
@@ -17,6 +17,8 @@
  *   along with this software. If not see <http://www.gnu.org/licenses/>.  *
  ***************************************************************************/
 
+#include <linux/errno.h>
+
 #define PICOLCD_NAME "PicoLCD (graphic)"
 
 /* Report numbers */
@@ -192,11 +194,11 @@ void picolcd_fb_refresh(struct picolcd_data *data);
 #else
 static inline int picolcd_fb_reset(struct picolcd_data *data, int clear)
 {
-	return 0;
+	return -ENODEV;
 }
 static inline int picolcd_init_framebuffer(struct picolcd_data *data)
 {
-	return 0;
+	return -ENOMEM;
 }
 static inline void picolcd_exit_framebuffer(struct picolcd_data *data)
 {
@@ -221,14 +223,14 @@ void picolcd_suspend_backlight(struct picolcd_data *data);
 static inline int picolcd_init_backlight(struct picolcd_data *data,
 		struct hid_report *report)
 {
-	return 0;
+	return -ENODEV;
 }
 static inline void picolcd_exit_backlight(struct picolcd_data *data)
 {
 }
 static inline int picolcd_resume_backlight(struct picolcd_data *data)
 {
-	return 0;
+	return -ENODEV;
 }
 static inline void picolcd_suspend_backlight(struct picolcd_data *data)
 {
@@ -248,14 +250,14 @@ int picolcd_resume_lcd(struct picolcd_data *data);
 static inline int picolcd_init_lcd(struct picolcd_data *data,
 		struct hid_report *report)
 {
-	return 0;
+	return -ENODEV;
 }
 static inline void picolcd_exit_lcd(struct picolcd_data *data)
 {
 }
 static inline int picolcd_resume_lcd(struct picolcd_data *data)
 {
-	return 0;
+	return -ENODEV;
 }
 #endif /* CONFIG_HID_PICOLCD_LCD */
 
@@ -271,7 +273,7 @@ void picolcd_leds_set(struct picolcd_data *data);
 static inline int picolcd_init_leds(struct picolcd_data *data,
 		struct hid_report *report)
 {
-	return 0;
+	return -ENODEV;
 }
 static inline void picolcd_exit_leds(struct picolcd_data *data)
 {
@@ -297,7 +299,7 @@ static inline int picolcd_raw_cir(struct picolcd_data *data,
 }
 static inline int picolcd_init_cir(struct picolcd_data *data, struct hid_report *report)
 {
-	return 0;
+	return -ENOMEM;
 }
 static inline void picolcd_exit_cir(struct picolcd_data *data)
 {
-- 
1.9.1

