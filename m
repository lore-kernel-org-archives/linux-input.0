From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] elantech: Don't set bit 1 of reg_10 when the no_hw_res quirk is set
Date: Tue,  3 Jun 2014 10:31:05 +0200
Message-ID: <1401784265-18325-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: James Lademann <jwlademann@gmail.com>, Philipp Wolfer <ph.wolfer@gmail.com>, linux-input@vger.kernel.org, stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

The touchpad on the GIGABYTE U2442 not only stops communicating when we try
to set bit 3 (enable real hardware resolution) of reg_10, but on some BIOS
versions also when we set bit 1 (enable two finger mode auto correct).

I've asked the original reporter of:
https://bugzilla.kernel.org/show_bug.cgi?id=61151

To check that not setting bit 1 does not lead to any adverse effects on
his model / BIOS revision, and it does not, so this commit fixes the touchpad
not working on these versions by simply never setting bit 1 for laptop models
with the no_hw_res quirk.

Reported-and-tested-by: James Lademann <jwlademann@gmail.com>
Tested-by: Philipp Wolfer <ph.wolfer@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/elantech.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index b96e978..4d79821 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -835,7 +835,7 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 		if (etd->set_hw_resolution)
 			etd->reg_10 = 0x0b;
 		else
-			etd->reg_10 = 0x03;
+			etd->reg_10 = 0x01;
 
 		if (elantech_write_reg(psmouse, 0x10, etd->reg_10))
 			rc = -1;
@@ -1336,7 +1336,8 @@ static int elantech_reconnect(struct psmouse *psmouse)
 }
 
 /*
- * Some hw_version 3 models go into error state when we try to set bit 3 of r10
+ * Some hw_version 3 models go into error state when we try to set
+ * bit 3 and/or bit 1 of r10
  */
 static const struct dmi_system_id no_hw_res_dmi_table[] = {
 #if defined(CONFIG_DMI) && defined(CONFIG_X86)
-- 
2.0.0
