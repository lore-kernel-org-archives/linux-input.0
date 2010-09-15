From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: HID: Allow changing not-yet-mapped usages
Date: Tue, 14 Sep 2010 21:58:22 -0700
Message-ID: <20100915045822.GA21672@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59575 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab0IOE63 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 00:58:29 -0400
Received: by yxp4 with SMTP id 4so2577201yxp.19
        for <linux-input@vger.kernel.org>; Tue, 14 Sep 2010 21:58:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Linux Input <linux-input@vger.kernel.org>, jonno.conder+bugs@gmail.com

Jiri,

Currently HID only allows re-mapping of usages that have already been
mapped by hid-input or one of the sub-drivers as keys. This,
unfortunately, leads to sub-drivers multiplying by the hour and many
of them only do initial setup of usages and waste memory once that is
done.

How about we also allow EVIOCSKEYCODE to establish mapping for
not-yet-unmapped usages (usage->type == 0)? Then we could offload the
task of setting up keymaps to udev.

This depends on the large keycode handling patches that are in my tree
in 'next' branch. Not tested past booting...

-- 
Dmitry

Input: hid-input - allow mapping unknown usages

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Currently HID layer only allows to remap keycodes for known usages,
and responds with -EINVAL when user tries to map new usage code.
This precludes us form relying on udev/keymap for establishing correct
mappings and forces us to write dummy HID drivers responsible only for
setting up keymaps.

Let's allow remapping not only usages that have been set up as keys
(usage->type == EV_KEY) but also yet-unmapped usages (usage->type == 0).

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/hid/hid-input.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)


diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index b12c07e..8dd17ce 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -77,7 +77,10 @@ static bool match_scancode(struct hid_usage *usage,
 static bool match_keycode(struct hid_usage *usage,
 			  unsigned int cur_idx, unsigned int keycode)
 {
-	return usage->code == keycode;
+	/*
+	 * We should exclude unmapped usages when doing lookup by keycode.
+	 */
+	return usage->type == EV_KEY && usage->code == keycode;
 }
 
 static bool match_index(struct hid_usage *usage,
@@ -103,7 +106,7 @@ static struct hid_usage *hidinput_find_key(struct hid_device *hid,
 			for (i = 0; i < report->maxfield; i++) {
 				for (j = 0; j < report->field[i]->maxusage; j++) {
 					usage = report->field[i]->usage + j;
-					if (usage->type == EV_KEY) {
+					if (usage->type == EV_KEY || usage->type == 0) {
 						if (match(usage, cur_idx, value)) {
 							if (usage_idx)
 								*usage_idx = cur_idx;
@@ -144,7 +147,8 @@ static int hidinput_getkeycode(struct input_dev *dev,
 
 	usage = hidinput_locate_usage(hid, ke, &index);
 	if (usage) {
-		ke->keycode = usage->code;
+		ke->keycode = usage->type == EV_KEY ?
+				usage->code : KEY_RESERVED;
 		ke->index = index;
 		scancode = usage->hid & (HID_USAGE_PAGE | HID_USAGE);
 		ke->len = sizeof(scancode);
@@ -164,7 +168,8 @@ static int hidinput_setkeycode(struct input_dev *dev,
 
 	usage = hidinput_locate_usage(hid, ke, NULL);
 	if (usage) {
-		*old_keycode = usage->code;
+		*old_keycode = usage->type == EV_KEY ?
+				usage->code : KEY_RESERVED;
 		usage->code = ke->keycode;
 
 		clear_bit(*old_keycode, dev->keybit);
