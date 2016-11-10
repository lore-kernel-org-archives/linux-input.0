From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: [PATCH v5 2/3] Input: ALPS - Clean up TrackStick handling for SS5 hardware
Date: Thu, 10 Nov 2016 11:44:45 -0500
Message-ID: <1478796286-1924-3-git-send-email-linux-kernel@PaulSD.com>
References: <20161110151942.GA3969@pali>
 <1478796286-1924-1-git-send-email-linux-kernel@PaulSD.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:47365 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934958AbcKJQpE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 11:45:04 -0500
In-Reply-To: <1478796286-1924-1-git-send-email-linux-kernel@PaulSD.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ben Gamari <ben@smart-cactus.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Michal Hocko <mhocko@suse.com>, Paul Donohue <linux-kernel@PaulSD.com>

For consistency and clarity, the input_report_*() functions should
be called by alps_process_packet_ss4_v2() instead of by
alps_decode_ss4_v2().

Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>
---
 drivers/input/mouse/alps.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index b93fe83..61d61cc 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1267,18 +1267,12 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 		break;
 
 	case SS4_PACKET_ID_STICK:
-		if (!(priv->flags & ALPS_DUALPOINT)) {
-			psmouse_warn(psmouse,
-				     "Rejected trackstick packet from non DualPoint device");
-		} else {
-			int x = (s8)(((p[0] & 1) << 7) | (p[1] & 0x7f));
-			int y = (s8)(((p[3] & 1) << 7) | (p[2] & 0x7f));
-			int pressure = (s8)(p[4] & 0x7f);
-
-			input_report_rel(priv->dev2, REL_X, x);
-			input_report_rel(priv->dev2, REL_Y, -y);
-			input_report_abs(priv->dev2, ABS_PRESSURE, pressure);
-		}
+		/*
+		 * x, y, and pressure are decoded in
+		 * alps_process_packet_ss4_v2()
+		 */
+		f->first_mp = 0;
+		f->is_mp = 0;
 		break;
 
 	case SS4_PACKET_ID_IDLE:
@@ -1312,6 +1306,7 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 	struct input_dev *dev = psmouse->dev;
 	struct input_dev *dev2 = priv->dev2;
 	struct alps_fields *f = &priv->f;
+	int x, y, pressure;
 
 	memset(f, 0, sizeof(struct alps_fields));
 	priv->decode_fields(f, packet, psmouse);
@@ -1348,12 +1343,25 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 
 	/* Report trackstick */
 	if (alps_get_pkt_id_ss4_v2(packet) == SS4_PACKET_ID_STICK) {
-		if (priv->flags & ALPS_DUALPOINT) {
-			input_report_key(dev2, BTN_LEFT, f->ts_left);
-			input_report_key(dev2, BTN_RIGHT, f->ts_right);
-			input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
-			input_sync(dev2);
+		if (!(priv->flags & ALPS_DUALPOINT)) {
+			psmouse_warn(psmouse,
+				     "Rejected trackstick packet from non DualPoint device");
+			return;
 		}
+
+		x = (s8)(((packet[0] & 1) << 7) | (packet[1] & 0x7f));
+		y = (s8)(((packet[3] & 1) << 7) | (packet[2] & 0x7f));
+		pressure = (s8)(packet[4] & 0x7f);
+
+		input_report_rel(dev2, REL_X, x);
+		input_report_rel(dev2, REL_Y, -y);
+		input_report_abs(dev2, ABS_PRESSURE, pressure);
+
+		input_report_key(dev2, BTN_LEFT, f->ts_left);
+		input_report_key(dev2, BTN_RIGHT, f->ts_right);
+		input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
+
+		input_sync(dev2);
 		return;
 	}
 
-- 
2.7.4

