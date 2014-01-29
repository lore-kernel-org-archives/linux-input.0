From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] input: hid-microsoft: Add support for 2 reserved usage ids used on ms office kb
Date: Wed, 29 Jan 2014 17:57:44 +0100
Message-ID: <1391014664-2642-5-git-send-email-hdegoede@redhat.com>
References: <1391014664-2642-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46684 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbaA2Q55 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 11:57:57 -0500
In-Reply-To: <1391014664-2642-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-microsoft.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 992252b..10dd20f 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -62,6 +62,22 @@ static int ms_ergonomy_kb_quirk(struct hid_input *hi, struct hid_usage *usage,
 {
 	struct input_dev *input = hi->input;
 
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
+		switch (usage->hid & HID_USAGE) {
+		/*
+		 * Microsoft uses these 2 reserved usage ids for 2 keys on
+		 * the MS office kb labelled "Office Home" and "Task Pane".
+		 */
+		case 0x29d:
+			ms_map_key_clear(KEY_PROG1);
+			return 1;
+		case 0x29e:
+			ms_map_key_clear(KEY_PROG2);
+			return 1;
+		}
+		return 0;
+	}
+
 	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_MSVENDOR)
 		return 0;
 
-- 
1.8.4.2

