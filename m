From: Don Prince <dhprince.devel@yahoo.co.uk>
Subject: [PATCH 2.6.34-rc7] HID: remove redundant key mappings from Desktop
 Wireless 6000
Date: Mon, 17 May 2010 20:18:21 +0100
Message-ID: <4BF1967D.3060404@yahoo.co.uk>
Reply-To: dhprince.devel@yahoo.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp109.plus.mail.re1.yahoo.com ([69.147.102.72]:37754 "HELO
	smtp109.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755552Ab0EQTSY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 May 2010 15:18:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Remove 7 redundant key mappings from Desktop Wireless 6000 that are
already handled by the default hid code.

Signed-off-by: Don Prince <dhprince-devel@yahoo.co.uk>

---

Spotted by by Robert Schedel <r.schedel@yahoo.de>


diff -X /opt/scripts/diff-exclude.txt -Npaur a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
--- a/drivers/hid/hid-samsung.c	2010-05-17 11:01:26.772377750 +0100
+++ b/drivers/hid/hid-samsung.c	2010-05-17 20:04:36.988502775 +0100
@@ -112,13 +112,6 @@ static int samsung_kbd_mouse_input_mappi
 
 	switch (usage->hid & HID_USAGE) {
 	/* report 2 */
-	case 0x0b5: samsung_kbd_mouse_map_key_clear(KEY_NEXTSONG); break;
-	case 0x0b6: samsung_kbd_mouse_map_key_clear(KEY_PREVIOUSSONG); break;
-	case 0x0b7: samsung_kbd_mouse_map_key_clear(KEY_STOPCD); break;
-	case 0x0cd: samsung_kbd_mouse_map_key_clear(KEY_PLAYPAUSE); break;
-	case 0x0e2: samsung_kbd_mouse_map_key_clear(KEY_MUTE); break;
-	case 0x0e9: samsung_kbd_mouse_map_key_clear(KEY_VOLUMEUP); break;
-	case 0x0ea: samsung_kbd_mouse_map_key_clear(KEY_VOLUMEDOWN); break;
 	case 0x183: samsung_kbd_mouse_map_key_clear(KEY_MEDIA); break;
 	case 0x195: samsung_kbd_mouse_map_key_clear(KEY_EMAIL);	break;
 	case 0x196: samsung_kbd_mouse_map_key_clear(KEY_CALC); break;



	
	
		
___________________________________________________________ 
All new Yahoo! Mail "The new Interface is stunning in its simplicity and ease of use." - PC Magazine 
http://uk.docs.yahoo.com/nowyoucan.html
