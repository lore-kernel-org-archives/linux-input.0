From: Martin Herkt <lachs0r@srsfckn.biz>
Subject: [PATCH] input: elantech.c: add more exceptions to fw version signature check
Date: Thu, 28 May 2015 18:29:30 +0200
Message-ID: <1432830570-31406-1-git-send-email-lachs0r@srsfckn.biz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srsfckn.biz ([148.251.137.227]:46637 "EHLO srsfckn.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbbE1Qia (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 12:38:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Ulrik De Bie <ulrik.debie-os@e2big.org>, George Moutsopoulos <gmoutso@yahoo.co.uk>, Martin Herkt <lachs0r@srsfckn.biz>

This makes the driver work with the ElanTech touchpad of my
ASUS PU551LD laptop (fw signature 0x480f0a). There may be more
touchpads with firmware versions in the 0x4? range, so I've added
those to the exception as well.

Signed-off-by: Martin Herkt <lachs0r@srsfckn.biz>
---
 drivers/input/mouse/elantech.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 79363b6..cd3e2a3 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1379,7 +1379,8 @@ static bool elantech_is_signature_valid(const unsigned char *param)
 	 * Some models have a revision higher then 20. Meaning param[2] may
 	 * be 10 or 20, skip the rates check for these.
 	 */
-	if (param[0] == 0x46 && (param[1] & 0xef) == 0x0f && param[2] < 40)
+	if (param[0] >= 0x40 && param[0] < 0x50 &&
+	    (param[1] & 0xef) == 0x0f && param[2] < 40)
 		return true;
 
 	for (i = 0; i < ARRAY_SIZE(rates); i++)
-- 
2.3.5

