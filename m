From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/6] HID: wacom: break out wacom_intuos_get_tool_type
Date: Fri, 12 Feb 2016 17:27:40 +0100
Message-ID: <1455294465-13694-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38793 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbcBLQ1u (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2016 11:27:50 -0500
In-Reply-To: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org

Allow to reuse the code in a later series and simplifies
the reading of wacom_intuos_inout().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 166 +++++++++++++++++++++++++-----------------------
 1 file changed, 87 insertions(+), 79 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e92e1e8..bd198bb 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -575,6 +575,91 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	return 1;
 }
 
+static int wacom_intuos_get_tool_type(int tool_id)
+{
+	int tool_type;
+
+	switch (tool_id) {
+	case 0x812: /* Inking pen */
+	case 0x801: /* Intuos3 Inking pen */
+	case 0x120802: /* Intuos4/5 Inking Pen */
+	case 0x012:
+		tool_type = BTN_TOOL_PENCIL;
+		break;
+
+	case 0x822: /* Pen */
+	case 0x842:
+	case 0x852:
+	case 0x823: /* Intuos3 Grip Pen */
+	case 0x813: /* Intuos3 Classic Pen */
+	case 0x885: /* Intuos3 Marker Pen */
+	case 0x802: /* Intuos4/5 13HD/24HD General Pen */
+	case 0x804: /* Intuos4/5 13HD/24HD Marker Pen */
+	case 0x8e2: /* IntuosHT2 pen */
+	case 0x022:
+	case 0x100804: /* Intuos4/5 13HD/24HD Art Pen */
+	case 0x140802: /* Intuos4/5 13HD/24HD Classic Pen */
+	case 0x160802: /* Cintiq 13HD Pro Pen */
+	case 0x180802: /* DTH2242 Pen */
+	case 0x100802: /* Intuos4/5 13HD/24HD General Pen */
+		tool_type = BTN_TOOL_PEN;
+		break;
+
+	case 0x832: /* Stroke pen */
+	case 0x032:
+		tool_type = BTN_TOOL_BRUSH;
+		break;
+
+	case 0x007: /* Mouse 4D and 2D */
+	case 0x09c:
+	case 0x094:
+	case 0x017: /* Intuos3 2D Mouse */
+	case 0x806: /* Intuos4 Mouse */
+		tool_type = BTN_TOOL_MOUSE;
+		break;
+
+	case 0x096: /* Lens cursor */
+	case 0x097: /* Intuos3 Lens cursor */
+	case 0x006: /* Intuos4 Lens cursor */
+		tool_type = BTN_TOOL_LENS;
+		break;
+
+	case 0x82a: /* Eraser */
+	case 0x85a:
+	case 0x91a:
+	case 0xd1a:
+	case 0x0fa:
+	case 0x82b: /* Intuos3 Grip Pen Eraser */
+	case 0x81b: /* Intuos3 Classic Pen Eraser */
+	case 0x91b: /* Intuos3 Airbrush Eraser */
+	case 0x80c: /* Intuos4/5 13HD/24HD Marker Pen Eraser */
+	case 0x80a: /* Intuos4/5 13HD/24HD General Pen Eraser */
+	case 0x90a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
+	case 0x14080a: /* Intuos4/5 13HD/24HD Classic Pen Eraser */
+	case 0x10090a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
+	case 0x10080c: /* Intuos4/5 13HD/24HD Art Pen Eraser */
+	case 0x16080a: /* Cintiq 13HD Pro Pen Eraser */
+	case 0x18080a: /* DTH2242 Eraser */
+	case 0x10080a: /* Intuos4/5 13HD/24HD General Pen Eraser */
+		tool_type = BTN_TOOL_RUBBER;
+		break;
+
+	case 0xd12:
+	case 0x912:
+	case 0x112:
+	case 0x913: /* Intuos3 Airbrush */
+	case 0x902: /* Intuos4/5 13HD/24HD Airbrush */
+	case 0x100902: /* Intuos4/5 13HD/24HD Airbrush */
+		tool_type = BTN_TOOL_AIRBRUSH;
+		break;
+
+	default: /* Unknown tool */
+		tool_type = BTN_TOOL_PEN;
+		break;
+	}
+	return tool_type;
+}
+
 static int wacom_intuos_inout(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -597,85 +682,8 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		wacom->id[idx] = (data[2] << 4) | (data[3] >> 4) |
 			((data[7] & 0x0f) << 20) | ((data[8] & 0xf0) << 12);
 
-		switch (wacom->id[idx]) {
-		case 0x812: /* Inking pen */
-		case 0x801: /* Intuos3 Inking pen */
-		case 0x120802: /* Intuos4/5 Inking Pen */
-		case 0x012:
-			wacom->tool[idx] = BTN_TOOL_PENCIL;
-			break;
-
-		case 0x822: /* Pen */
-		case 0x842:
-		case 0x852:
-		case 0x823: /* Intuos3 Grip Pen */
-		case 0x813: /* Intuos3 Classic Pen */
-		case 0x885: /* Intuos3 Marker Pen */
-		case 0x802: /* Intuos4/5 13HD/24HD General Pen */
-		case 0x804: /* Intuos4/5 13HD/24HD Marker Pen */
-		case 0x8e2: /* IntuosHT2 pen */
-		case 0x022:
-		case 0x100804: /* Intuos4/5 13HD/24HD Art Pen */
-		case 0x140802: /* Intuos4/5 13HD/24HD Classic Pen */
-		case 0x160802: /* Cintiq 13HD Pro Pen */
-		case 0x180802: /* DTH2242 Pen */
-		case 0x100802: /* Intuos4/5 13HD/24HD General Pen */
-			wacom->tool[idx] = BTN_TOOL_PEN;
-			break;
-
-		case 0x832: /* Stroke pen */
-		case 0x032:
-			wacom->tool[idx] = BTN_TOOL_BRUSH;
-			break;
-
-		case 0x007: /* Mouse 4D and 2D */
-		case 0x09c:
-		case 0x094:
-		case 0x017: /* Intuos3 2D Mouse */
-		case 0x806: /* Intuos4 Mouse */
-			wacom->tool[idx] = BTN_TOOL_MOUSE;
-			break;
-
-		case 0x096: /* Lens cursor */
-		case 0x097: /* Intuos3 Lens cursor */
-		case 0x006: /* Intuos4 Lens cursor */
-			wacom->tool[idx] = BTN_TOOL_LENS;
-			break;
-
-		case 0x82a: /* Eraser */
-		case 0x85a:
-		case 0x91a:
-		case 0xd1a:
-		case 0x0fa:
-		case 0x82b: /* Intuos3 Grip Pen Eraser */
-		case 0x81b: /* Intuos3 Classic Pen Eraser */
-		case 0x91b: /* Intuos3 Airbrush Eraser */
-		case 0x80c: /* Intuos4/5 13HD/24HD Marker Pen Eraser */
-		case 0x80a: /* Intuos4/5 13HD/24HD General Pen Eraser */
-		case 0x90a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
-		case 0x14080a: /* Intuos4/5 13HD/24HD Classic Pen Eraser */
-		case 0x10090a: /* Intuos4/5 13HD/24HD Airbrush Eraser */
-		case 0x10080c: /* Intuos4/5 13HD/24HD Art Pen Eraser */
-		case 0x16080a: /* Cintiq 13HD Pro Pen Eraser */
-		case 0x18080a: /* DTH2242 Eraser */
-		case 0x10080a: /* Intuos4/5 13HD/24HD General Pen Eraser */
-			wacom->tool[idx] = BTN_TOOL_RUBBER;
-			break;
-
-		case 0xd12:
-		case 0x912:
-		case 0x112:
-		case 0x913: /* Intuos3 Airbrush */
-		case 0x902: /* Intuos4/5 13HD/24HD Airbrush */
-		case 0x100902: /* Intuos4/5 13HD/24HD Airbrush */
-			wacom->tool[idx] = BTN_TOOL_AIRBRUSH;
-			break;
-
-		default: /* Unknown tool */
-			wacom->tool[idx] = BTN_TOOL_PEN;
-			break;
-		}
-		wacom->shared->stylus_in_proximity = true;
+		wacom->tool[idx] = wacom_intuos_get_tool_type(wacom->id[idx]);
+
 		return 1;
 	}
 
-- 
2.5.0

