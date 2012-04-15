From: Benedikt Bergenthal <benedikt@kdrennert.de>
Subject: Style issue in Driver/hid/hid-apple
Date: Sun, 15 Apr 2012 23:45:35 +0200
Message-ID: <4F8B417F.6030204@kdrennert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50298 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab2DOVpj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Apr 2012 17:45:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

>From 6e3e0130d7b9b39e114aeb55b1626f3070e22239 Mon Sep 17 00:00:00 2001
From: Benedikt <bbergenthal@cern.ch>
Date: Sun, 15 Apr 2012 23:29:57 +0200
Subject: [PATCH] Driver: HID: hid-apple: Fixed a tab width style issue

Fixed a style issue.

Signed-off-by: Benedikt Bergenthal <benedikt@kdrennert.de>
---
 drivers/hid/hid-apple.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 299d238..7a79e39 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -234,7 +234,7 @@ static int hidinput_apple_event(struct hid_device
*hid, struct input_dev *input,
         }
     }
 
-        if (iso_layout) {
+    if (iso_layout) {
         if (asc->quirks & APPLE_ISO_KEYBOARD) {
             trans = apple_find_translation(apple_iso_keyboard,
usage->code);
             if (trans) {
-- 
1.7.5.4

