From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 4/4] HID: wacom: Fix pad button range for CINTIQ_COMPANION_2
Date: Wed, 16 Dec 2015 13:37:36 -0800
Message-ID: <1450301856-7253-4-git-send-email-killertofu@gmail.com>
References: <1450301856-7253-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35735 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966369AbbLPVh6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 16:37:58 -0500
Received: by mail-pa0-f43.google.com with SMTP id jx14so1051530pad.2
        for <linux-input@vger.kernel.org>; Wed, 16 Dec 2015 13:37:58 -0800 (PST)
In-Reply-To: <1450301856-7253-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Commit c7f0522 incorrectly constructs the 'buttons' variable for the
CINTIQ_COMPANION_2 case. The high nybble of data[2] is shifted four
bits too far, leaving the bits associated with BTN_7 through BTN_A
unset.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 23212af..f706604 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -516,7 +516,7 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 		 * d-pad down   -> data[4] & 0x80
 		 * d-pad center -> data[3] & 0x01
 		 */
-		buttons = ((data[2] & 0xF0) << 7) |
+		buttons = ((data[2] >> 4) << 7) |
 		          ((data[1] & 0x04) << 6) |
 		          ((data[2] & 0x0F) << 2) |
 		          (data[1] & 0x03);
-- 
2.6.3

