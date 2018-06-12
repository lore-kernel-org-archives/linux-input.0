From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH] Input: elan: enable middle button of touchpads on ThinkPad P52
Date: Tue, 12 Jun 2018 15:09:06 +0800
Message-ID: <20180612070906.5305-1-aaron.ma@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aaron.ma@canonical.com, kt.liao@emc.com.tw, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

PNPID is better way to identify the type of touchpads.
Enable middle button support on 2 types of touchpads on Lenovo P52.

Cc: stable@vger.kernel.org
Cc: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/mouse/elantech.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index fb4d902c4403..67b061dd4494 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1175,6 +1175,12 @@ static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
 	{ }
 };
 
+static const char * const middle_button_pnp_ids[] = {
+	"LEN2131", /* ThinkPad P52 w/ NFC */
+	"LEN2132", /* ThinkPad P52 */
+	NULL
+};
+
 /*
  * Set the appropriate event bits for the input subsystem
  */
@@ -1194,7 +1200,8 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 	__clear_bit(EV_REL, dev->evbit);
 
 	__set_bit(BTN_LEFT, dev->keybit);
-	if (dmi_check_system(elantech_dmi_has_middle_button))
+	if (dmi_check_system(elantech_dmi_has_middle_button) ||
+		psmouse_matches_pnp_id(psmouse, middle_button_pnp_ids))
 		__set_bit(BTN_MIDDLE, dev->keybit);
 	__set_bit(BTN_RIGHT, dev->keybit);
 
-- 
2.17.1
