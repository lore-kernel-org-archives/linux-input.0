From: Jiri Kosina <jkosina@suse.com>
Subject: [PATCH] Input: synaptics: dump ext10 capabilities as well
Date: Tue, 21 Jul 2015 15:34:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507211529230.1141@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>
List-Id: linux-input@vger.kernel.org

Make extended capabilities obtained through $10 query also available in 
touchpad identification.

Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/input/mouse/synaptics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 3a32caf..6025eb4 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1484,12 +1484,12 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;
 
 	psmouse_info(psmouse,
-		     "Touchpad model: %ld, fw: %ld.%ld, id: %#lx, caps: %#lx/%#lx/%#lx, board id: %lu, fw id: %lu\n",
+		     "Touchpad model: %ld, fw: %ld.%ld, id: %#lx, caps: %#lx/%#lx/%#lx/%#lx, board id: %lu, fw id: %lu\n",
 		     SYN_ID_MODEL(priv->identity),
 		     SYN_ID_MAJOR(priv->identity), SYN_ID_MINOR(priv->identity),
 		     priv->model_id,
 		     priv->capabilities, priv->ext_cap, priv->ext_cap_0c,
-		     priv->board_id, priv->firmware_id);
+		     priv->ext_cap_10, priv->board_id, priv->firmware_id);
 
 	set_input_params(psmouse, priv);
 
-- 
Jiri Kosina
SUSE Labs
