From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 26/30] HID: wacom: leds: make sure Cintiq 21UX2 and 24HD control the right LEDs
Date: Wed, 13 Jul 2016 18:06:13 +0200
Message-ID: <1468425977-4819-27-git-send-email-benjamin.tissoires@redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56983 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbcGMQHW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 12:07:22 -0400
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

The code for 21UX2 and 24HD makes the LED group 1 on the left, and
the group 0 on the right. The buttons are ordered in the other way,
but libwacom already exports those that way. So we simply can't reassign
LED group 0 to the left buttons, and have to quirk the incoming data...

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

New in v2:
- replace: "[PATCH 25/27] HID: wacom: leds: fix ordering of LED banks"
---
 drivers/hid/wacom_wac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 00e0c80..a9693d5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2768,6 +2768,15 @@ static bool wacom_is_led_toggled(struct wacom *wacom, int button_count,
 {
 	int button_per_group;
 
+	/*
+	 * 24HD and 21UX2 have LED group 1 to the left and LED group 0
+	 * to the right. We need to reverse the group to match this
+	 * historical behavior.
+	 */
+	if (wacom->wacom_wac.features.type == WACOM_24HD ||
+	    wacom->wacom_wac.features.type == WACOM_21UX2)
+		group = 1 - group;
+
 	button_per_group = button_count/wacom->led.count;
 
 	return mask & (1 << (group * button_per_group));
-- 
2.5.5

