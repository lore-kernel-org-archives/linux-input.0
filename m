From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v1  1/1] Input: elantech - fix absolute mode setting on some Asus touchpads
Date: Wed, 25 Mar 2015 22:27:55 +0100
Message-ID: <1427318875-12142-2-git-send-email-ulrik.debie-os@e2big.org>
References: <20150325203428.GA24094@lantern>
 <1427318875-12142-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:48890 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbbCYV2k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 17:28:40 -0400
In-Reply-To: <1427318875-12142-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, ulrik.debie-os@e2big.org, George Moutsopoulos <gmoutso@yahoo.co.uk>

On Asus TP500LN and X750JN, the touchpad absolute mode is reset each
time set_rate is done.

In order to fix this, we will verify the firmware version, and if it
matches the one in those laptops, the set_rate function is overloaded
with a function elantech_set_rate_restore_reg_07 that perfoms the
set_rate with the original function, followed by a restore of reg_07
(the register that sets the absolute mode on elantech v4 hardware).

Also the asus TP500LN and X750JN firmware version, capabilities, and
button constellation is added to elantech.c

Reported-and-tested-by: George Moutsopoulos <gmoutso@yahoo.co.uk>
Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 22 ++++++++++++++++++++++
 drivers/input/mouse/elantech.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 6e22682..991dc6b 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -893,6 +893,21 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 }
 
 /*
+ * This writes the reg_07 value again to the hardware at the end of every
+ * set_rate call because the register loses its value. reg_07 allows setting
+ * absolute mode on v4 hardware
+ */
+static void elantech_set_rate_restore_reg_07(struct psmouse *psmouse,
+		unsigned int rate)
+{
+	struct elantech_data *etd = psmouse->private;
+
+	etd->original_set_rate(psmouse, rate);
+	if (elantech_write_reg(psmouse, 0x07, etd->reg_07))
+		psmouse_err(psmouse, "restoring reg_07 failed\n");
+}
+
+/*
  * Put the touchpad into absolute mode
  */
 static int elantech_set_absolute_mode(struct psmouse *psmouse)
@@ -1094,6 +1109,8 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
  * Asus K53SV              0x450f01        78, 15, 0c      2 hw buttons
  * Asus G46VW              0x460f02        00, 18, 0c      2 hw buttons
  * Asus G750JX             0x360f00        00, 16, 0c      2 hw buttons
+ * Asus TP500LN            0x381f17        10, 14, 0e      clickpad
+ * Asus X750JN             0x381f17        10, 14, 0e      clickpad
  * Asus UX31               0x361f00        20, 15, 0e      clickpad
  * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
  * Avatar AVIU-145A2       0x361f00        ?               clickpad
@@ -1635,6 +1652,11 @@ int elantech_init(struct psmouse *psmouse)
 		goto init_fail;
 	}
 
+	if (etd->fw_version == 0x381f17) {
+		etd->original_set_rate = psmouse->set_rate;
+		psmouse->set_rate = elantech_set_rate_restore_reg_07;
+	}
+
 	if (elantech_set_input_params(psmouse)) {
 		psmouse_err(psmouse, "failed to query touchpad range.\n");
 		goto init_fail;
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 6f3afec..f965d15 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -142,6 +142,7 @@ struct elantech_data {
 	struct finger_pos mt[ETP_MAX_FINGERS];
 	unsigned char parity[256];
 	int (*send_cmd)(struct psmouse *psmouse, unsigned char c, unsigned char *param);
+	void (*original_set_rate)(struct psmouse *psmouse, unsigned int rate);
 };
 
 #ifdef CONFIG_MOUSE_PS2_ELANTECH
-- 
2.1.4

