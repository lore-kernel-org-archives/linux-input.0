From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCHv2] Input: fix typos in Documentation/input/gamepad.txt
Date: Tue, 17 Dec 2013 12:33:44 +0100
Message-ID: <1387280024-12213-1-git-send-email-ospite@studenti.unina.it>
References: <52AF51EA.8090400@infradead.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:36240 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab3LQLds (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 06:33:48 -0500
In-Reply-To: <52AF51EA.8090400@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Randy Dunlap <rdunlap@infradead.org>, David Herrmann <dh.herrmann@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Fix some typos and while at it also use "PS" as the name for the central
"HOME" button on Sony controllers, this is how Sony itself calls it.

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Changes since v1:
  - Fix one of the fixes: use "advise" (verb) in place of "advice" (noun)

Thanks Randy.

 Documentation/input/gamepad.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
index 31bb6a4..3f6d8a5 100644
--- a/Documentation/input/gamepad.txt
+++ b/Documentation/input/gamepad.txt
@@ -68,7 +68,7 @@ features that you need, first. How each feature is mapped is described below.
 Legacy drivers often don't comply to these rules. As we cannot change them
 for backwards-compatibility reasons, you need to provide fixup mappings in
 user-space yourself. Some of them might also provide module-options that
-change the mappings so you can adivce users to set these.
+change the mappings so you can advise users to set these.
 
 All new gamepads are supposed to comply with this mapping. Please report any
 bugs, if they don't.
@@ -150,10 +150,10 @@ Menu-Pad:
                   BTN_START
   Many pads also have a third button which is branded or has a special symbol
   and meaning. Such buttons are mapped as BTN_MODE. Examples are the Nintendo
-  "HOME" button, the XBox "X"-button or Sony "P" button.
+  "HOME" button, the XBox "X"-button or Sony "PS" button.
 
 Rumble:
-  Rumble is adverticed as FF_RUMBLE.
+  Rumble is advertised as FF_RUMBLE.
 
 ----------------------------------------------------------------------------
   Written 2013 by David Herrmann <dh.herrmann@gmail.com>
-- 
1.8.5.1

