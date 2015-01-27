From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH v2 2/5] Input: synaptics - Log queried and quirked dimension values
Date: Tue, 27 Jan 2015 09:34:02 +0100
Message-ID: <1422347645-5194-3-git-send-email-daniel.martin@secunet.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
 <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Reply-To: Daniel Martin <consume.noise@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:52763 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbbA0I2c (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 03:28:32 -0500
In-Reply-To: <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: hdegoede@redhat.com, Daniel Martin <consume.noise@gmail.com>

From: Daniel Martin <consume.noise@gmail.com>

Logging the dimension values we queried (info) and the values we use
from a quirk to overwrite (warn) can be helpful for debugging.

This partly relates to bug:
    https://bugzilla.kernel.org/show_bug.cgi?id=91541

Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/input/mouse/synaptics.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 89b408b..7a78d75 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -361,6 +361,10 @@ static int synaptics_resolution(struct psmouse *psmouse)
 		} else {
 			priv->x_max = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
 			priv->y_max = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
+			psmouse_info(psmouse,
+				     "queried max coordinates: "
+				     "x [..%d], y [..%d]\n",
+				     priv->x_max, priv->y_max);
 		}
 	}
 
@@ -372,6 +376,10 @@ static int synaptics_resolution(struct psmouse *psmouse)
 		} else {
 			priv->x_min = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
 			priv->y_min = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
+			psmouse_info(psmouse,
+				     "queried min coordinates: "
+				     "x [%d..], y [%d..]\n",
+				     priv->x_min, priv->y_min);
 		}
 	}
 
@@ -394,6 +402,11 @@ static int synaptics_quirks(struct psmouse *psmouse)
 			priv->x_max = min_max_pnpid_table[i].x_max;
 			priv->y_min = min_max_pnpid_table[i].y_min;
 			priv->y_max = min_max_pnpid_table[i].y_max;
+			psmouse_warn(psmouse,
+				     "quirked min/max coordinates: "
+				     "x [%d..%d], y [%d..%d]\n",
+				     priv->x_min, priv->x_max,
+				     priv->y_min, priv->y_max);
 			break;
 		}
 	}
-- 
2.2.2

