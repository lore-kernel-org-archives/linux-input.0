From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v4 4/4] input: synaptics - make image sensors and cr48 sensors report widths
Date: Fri,  1 Apr 2016 15:06:52 +0200
Message-ID: <1459516012-8060-5-git-send-email-gabriele.mzt@gmail.com>
References: <1459516012-8060-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33026 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbcDANHQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2016 09:07:16 -0400
In-Reply-To: <1459516012-8060-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>

Despite claiming to report finger widths, image sensors and cr48
profile sensors were not doing it. Since the touchpad uses an
abstract unit for the width of the fingers, report only the witdh
of the first touch using ABS_TOOL_WIDTH.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=77161
Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 27a091b..bed268b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -943,6 +943,8 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
 		input_report_abs(dev, ABS_MT_PRESSURE, hw[i]->z);
 	}
 
+	input_report_abs(dev, ABS_TOOL_WIDTH, hw[0]->w);
+
 	input_mt_drop_unused(dev);
 
 	/* Don't use active slot count to generate BTN_TOOL events. */
-- 
2.8.0.rc3

