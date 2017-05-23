From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/3] Input: synaptics - tell users to report when they should be using rmi-smbus
Date: Tue, 23 May 2017 10:36:57 +0200
Message-ID: <20170523083657.11148-3-benjamin.tissoires@redhat.com>
References: <20170523083657.11148-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523083657.11148-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Users should really consider switching to rmi-smbus instead of plain PS/2.
Notify them that they should report a missing pnpID in the file.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index fc42259..8d02f4d 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1741,8 +1741,12 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 
 	if (synaptics_intertouch == SYNAPTICS_INTERTOUCH_NOT_SET) {
 		if (!psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
-		    !psmouse_matches_pnp_id(psmouse, smbus_pnp_ids))
+		    !psmouse_matches_pnp_id(psmouse, smbus_pnp_ids)) {
+			psmouse_info(psmouse, "Your touchpad (%s) says it can support a different bus.\n"
+				"If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.\n",
+				psmouse->ps2dev.serio->firmware_id);
 			return -ENXIO;
+		}
 	}
 
 	psmouse_info(psmouse, "Trying to set up SMBus access\n");
-- 
2.9.4
