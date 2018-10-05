From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH v2 1/2] mfd: cros: add "base attached" MKBP switch definition
Date: Fri,  5 Oct 2018 11:41:13 -0700
Message-ID: <20181005184114.207503-1-dtor@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>
List-Id: linux-input@vger.kernel.org

This adds a "base attached" switch definition to the MKBP protocol that
is used by Whiskers driver to properly determine device state (clamshell
vs tablet mode).

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

v2 changes: None

Lee, I was wondering if it would be OK for cros_ec_commands.h to be
merged through HID tree.


 include/linux/mfd/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 20ee71f10865..5fd0e429f472 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2132,6 +2132,7 @@ struct ec_response_get_next_event_v1 {
 /* Switches */
 #define EC_MKBP_LID_OPEN	0
 #define EC_MKBP_TABLET_MODE	1
+#define EC_MKBP_BASE_ATTACHED	2
 
 /*****************************************************************************/
 /* Temperature sensor commands */
-- 
2.19.0.605.g01d371f741-goog
