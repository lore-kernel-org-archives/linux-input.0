From: akpm@linux-foundation.org
Subject: [patch 10/17] drivers/input/keyboard/atkbd.c: make forced_release_keys[] static
Date: Fri, 09 Jan 2009 12:19:49 -0800
Message-ID: <200901092019.n09KJnsJ017196@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46364 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755777AbZAIUa6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jan 2009 15:30:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, impulze@impulze.org

From: Daniel Mierswa <impulze@impulze.org>

Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/keyboard/atkbd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/input/keyboard/atkbd.c~drivers-input-keyboard-atkbdc-make-forced_release_keys-static drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c~drivers-input-keyboard-atkbdc-make-forced_release_keys-static
+++ a/drivers/input/keyboard/atkbd.c
@@ -852,7 +852,7 @@ static void atkbd_gen_release_event(stru
  */
 static void atkbd_dell_laptop_keymap_fixup(struct atkbd *atkbd)
 {
-	const unsigned int forced_release_keys[] = {
+	static const unsigned int forced_release_keys[] = {
 		0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8f, 0x93,
 	};
 
@@ -866,7 +866,7 @@ static void atkbd_dell_laptop_keymap_fix
  */
 static void atkbd_hp_keymap_fixup(struct atkbd *atkbd)
 {
-	const unsigned int forced_release_keys[] = {
+	static const unsigned int forced_release_keys[] = {
 		0x94,
 	};
 
_
