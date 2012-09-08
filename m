From: =?UTF-8?B?TWljaGHFgg==?= Pecio
	<michal.pecio@students.mimuw.edu.pl>
Subject: [PATCH] input: libps2: add ID of IBM terminal keyboards
Date: Fri, 7 Sep 2012 20:45:10 -0700
Message-ID: <20120907204510.74418ae7@students.mimuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from students.mimuw.edu.pl ([193.0.96.129]:38895 "EHLO
	students.mimuw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab2IHDvq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Sep 2012 23:51:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

From: Michal Pecio <michal.pecio@students.mimuw.edu.pl>

Keyboards for several IBM terminals from 1980's and 1990's are
compatible with the PS/2 protocol.
Add their ID (0xBF) to the whitelist of supported keyboards.
Only untranslated ID needs to be added because atkbd doesn't
support translated scancode set 3 anyway.

Signed-off-by: Michal Pecio <michal.pecio@students.mimuw.edu.pl>
---
 drivers/input/serio/libps2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 07a8363..f946544 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -114,6 +114,7 @@ int ps2_is_keyboard_id(char id_byte)
 		0x5d,	/* Trust keyboard		*/
 		0x60,	/* NMB SGI keyboard, translated */
 		0x47,	/* NMB SGI keyboard		*/
+		0xbf,	/* IBM terminal keyboards	*/
 	};
 
 	return memchr(keyboard_ids, id_byte, sizeof(keyboard_ids)) != NULL;
