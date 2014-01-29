From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] input: Add some missing HUT mappings
Date: Wed, 29 Jan 2014 17:57:41 +0100
Message-ID: <1391014664-2642-2-git-send-email-hdegoede@redhat.com>
References: <1391014664-2642-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51851 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbaA2Q5x (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 11:57:53 -0500
In-Reply-To: <1391014664-2642-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Add mapping for "AL Next Task/Application", "AL Previous Task/Application"
and "AL File Browser" buttons, as found on the Microsoft Office keyboard.

Note that there already is a mapping for "AL Local Machine Browser" to
KEY_FILE. Unless we ever encounter a device with both that should not be
a problem.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d97f232..ef17163 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -789,10 +789,13 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x199: map_key_clear(KEY_CHAT);		break;
 		case 0x19c: map_key_clear(KEY_LOGOFF);		break;
 		case 0x19e: map_key_clear(KEY_COFFEE);		break;
+		case 0x1a3: map_key_clear(KEY_NEXT);		break;
+		case 0x1a4: map_key_clear(KEY_PREVIOUS);	break;
 		case 0x1a6: map_key_clear(KEY_HELP);		break;
 		case 0x1a7: map_key_clear(KEY_DOCUMENTS);	break;
 		case 0x1ab: map_key_clear(KEY_SPELLCHECK);	break;
 		case 0x1ae: map_key_clear(KEY_KEYBOARD);	break;
+		case 0x1b4: map_key_clear(KEY_FILE);		break;
 		case 0x1b6: map_key_clear(KEY_IMAGES);		break;
 		case 0x1b7: map_key_clear(KEY_AUDIO);		break;
 		case 0x1b8: map_key_clear(KEY_VIDEO);		break;
-- 
1.8.4.2

