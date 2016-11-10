From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: [PATCH v5 1/3] Input: ALPS - Fix TrackStick support for SS5 hardware
Date: Thu, 10 Nov 2016 11:44:44 -0500
Message-ID: <1478796286-1924-2-git-send-email-linux-kernel@PaulSD.com>
References: <20161110151942.GA3969@pali>
 <1478796286-1924-1-git-send-email-linux-kernel@PaulSD.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:47346 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935106AbcKJQpE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 11:45:04 -0500
In-Reply-To: <1478796286-1924-1-git-send-email-linux-kernel@PaulSD.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ben Gamari <ben@smart-cactus.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Michal Hocko <mhocko@suse.com>, Paul Donohue <linux-kernel@PaulSD.com>

The current Alps SS5 (SS4 v2) code generates bogus TouchPad events when
TrackStick packets are processed.

This causes the xorg synaptics driver to print
"unable to find touch point 0" and
"BUG: triggered 'if (priv->num_active_touches > priv->num_slots)'"
messages.  It also causes unexpected TouchPad button release and reclick
event sequences if the TrackStick is moved while holding a TouchPad
button.

This commit corrects the problem by adjusting
alps_process_packet_ss4_v2() so that it only sends TrackStick reports
when processing TrackStick packets.

Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>
---
 drivers/input/mouse/alps.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 6d7de9b..b93fe83 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1346,6 +1346,18 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 
 	priv->multi_packet = 0;
 
+	/* Report trackstick */
+	if (alps_get_pkt_id_ss4_v2(packet) == SS4_PACKET_ID_STICK) {
+		if (priv->flags & ALPS_DUALPOINT) {
+			input_report_key(dev2, BTN_LEFT, f->ts_left);
+			input_report_key(dev2, BTN_RIGHT, f->ts_right);
+			input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
+			input_sync(dev2);
+		}
+		return;
+	}
+
+	/* Report touchpad */
 	alps_report_mt_data(psmouse, (f->fingers <= 4) ? f->fingers : 4);
 
 	input_mt_report_finger_count(dev, f->fingers);
@@ -1356,13 +1368,6 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 
 	input_report_abs(dev, ABS_PRESSURE, f->pressure);
 	input_sync(dev);
-
-	if (priv->flags & ALPS_DUALPOINT) {
-		input_report_key(dev2, BTN_LEFT, f->ts_left);
-		input_report_key(dev2, BTN_RIGHT, f->ts_right);
-		input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
-		input_sync(dev2);
-	}
 }
 
 static bool alps_is_valid_package_ss4_v2(struct psmouse *psmouse)
-- 
2.7.4

