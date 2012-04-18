From: Benedikt Bergenthal <bbergenthal@cern.ch>
Subject: [PATCH] Driver: HID: hid-apple: Fixed a tab width style issue
Date: Wed, 18 Apr 2012 12:22:40 +0200
Message-ID: <1334744560-28985-1-git-send-email-bbergenthal@cern.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49490 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab2DRKWn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 06:22:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benedikt <bbergenthal@cern.ch>, Benedikt Bergenthal <benedikt@kdrennert.de>

From: Benedikt <bbergenthal@cern.ch>

Fixed a style issue.

Signed-off-by: Benedikt Bergenthal <benedikt@kdrennert.de>
---
 drivers/hid/hid-apple.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 299d238..7a79e39 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -234,7 +234,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		}
 	}
 
-        if (iso_layout) {
+	if (iso_layout) {
 		if (asc->quirks & APPLE_ISO_KEYBOARD) {
 			trans = apple_find_translation(apple_iso_keyboard, usage->code);
 			if (trans) {
-- 
1.7.5.4

