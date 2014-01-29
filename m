From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] input: hid-microsoft: Do the check for the ms usage page per device
Date: Wed, 29 Jan 2014 17:57:42 +0100
Message-ID: <1391014664-2642-3-git-send-email-hdegoede@redhat.com>
References: <1391014664-2642-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbaA2Q5y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 11:57:54 -0500
In-Reply-To: <1391014664-2642-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

For some devices we may also want to do custom mappings for other pages.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-microsoft.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 551795b..a161afd 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -62,6 +62,9 @@ static int ms_ergonomy_kb_quirk(struct hid_input *hi, struct hid_usage *usage,
 {
 	struct input_dev *input = hi->input;
 
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_MSVENDOR)
+		return 0;
+
 	switch (usage->hid & HID_USAGE) {
 	case 0xfd06: ms_map_key_clear(KEY_CHAT);	break;
 	case 0xfd07: ms_map_key_clear(KEY_PHONE);	break;
@@ -82,6 +85,9 @@ static int ms_ergonomy_kb_quirk(struct hid_input *hi, struct hid_usage *usage,
 static int ms_presenter_8k_quirk(struct hid_input *hi, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_MSVENDOR)
+		return 0;
+
 	set_bit(EV_REP, hi->input->evbit);
 	switch (usage->hid & HID_USAGE) {
 	case 0xfd08: ms_map_key_clear(KEY_FORWARD);	break;
@@ -101,9 +107,6 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
 
-	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_MSVENDOR)
-		return 0;
-
 	if (quirks & MS_ERGONOMY) {
 		int ret = ms_ergonomy_kb_quirk(hi, usage, bit, max);
 		if (ret)
-- 
1.8.4.2

