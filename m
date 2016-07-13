From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 01/30] HID: wacom: actually report the battery level for wireless connected
Date: Wed, 13 Jul 2016 18:05:48 +0200
Message-ID: <1468425977-4819-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42686 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbcGMQGd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 12:06:33 -0400
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Since fd5f92b ("HID: wacom: reuse wacom_parse_and_register() in
wireless_work"), wacom->shared->type is not set.
Send the information of the battery if we have one.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

No changes in v2
---
 drivers/hid/wacom_wac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1eae13c..d6746ca 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2125,6 +2125,7 @@ static int wacom_bamboo_pad_irq(struct wacom_wac *wacom, size_t len)
 
 static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 {
+	struct wacom *w = container_of(wacom, struct wacom, wacom_wac);
 	unsigned char *data = wacom->data;
 	int connected;
 
@@ -2152,7 +2153,7 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 			wacom_schedule_work(wacom);
 		}
 
-		if (wacom->shared->type)
+		if (w->battery)
 			wacom_notify_battery(wacom, battery, charging, 1, 0);
 
 	} else if (wacom->pid != 0) {
-- 
2.5.5

