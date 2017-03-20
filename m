From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 9/9] [NEEDS F21] Input: synaptics - switch forcepad devices over to SMbus access
Date: Sun, 19 Mar 2017 17:22:31 -0700
Message-ID: <20170320002231.31152-10-dmitry.torokhov@gmail.com>
References: <20170320002231.31152-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34092 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbdCTAWo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 19 Mar 2017 20:22:44 -0400
In-Reply-To: <20170320002231.31152-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Synaptics "forcedpad" devices use address 0x20 instead of 0x2c.
Unfortunately the fact that the device is a forcepad is not exported
through PS/2 interface, so we need a bit of DMI magic to switch over to the
correct address.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 20c329bba46a..86ed45bda7bb 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -171,6 +171,13 @@ static const char * const smbus_pnp_ids[] = {
 	NULL
 };
 
+/* This list has been kindly provided by Synaptics. */
+static const char * const forcepad_pnp_ids[] = {
+	"SYN300D",
+	"SYN3014",
+	NULL
+};
+
 /*
  * Send a command to the synpatics touchpad by special commands
  */
@@ -493,13 +500,6 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
 	{ }
 };
 
-/* This list has been kindly provided by Synaptics. */
-static const char * const forcepad_pnp_ids[] = {
-	"SYN300D",
-	"SYN3014",
-	NULL
-};
-
 /*****************************************************************************
  *	Synaptics communications functions
  ****************************************************************************/
@@ -1723,11 +1723,14 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 				!!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10),
 		},
 	};
-	const struct i2c_board_info intertouch_board = {
+	struct i2c_board_info intertouch_board = {
 		I2C_BOARD_INFO("rmi4_smbus", 0x2c),
 		.flags = I2C_CLIENT_HOST_NOTIFY,
 	};
 
+	if (psmouse_matches_pnp_id(psmouse, forcepad_pnp_ids))
+		intertouch_board.addr = 0x20;
+
 	return psmouse_smbus_init(psmouse, &intertouch_board,
 				  &pdata, sizeof(pdata),
 				  leave_breadcrumbs);
@@ -1748,8 +1751,10 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 
 	if (synaptics_intertouch == SYNAPTICS_INTERTOUCH_NOT_SET) {
 		if (!psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
-		    !psmouse_matches_pnp_id(psmouse, smbus_pnp_ids))
+		    !psmouse_matches_pnp_id(psmouse, smbus_pnp_ids) &&
+		    !psmouse_matches_pnp_id(psmouse, forcepad_pnp_ids)) {
 			return -ENXIO;
+		}
 	}
 
 	psmouse_info(psmouse, "Trying to set up SMBus access\n");
-- 
2.12.0.367.g23dc2f6d3c-goog

