From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/4] HID: wacom: Limit touchstrip data to 13 bits
Date: Wed, 16 Dec 2015 13:37:33 -0800
Message-ID: <1450301856-7253-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33507 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966369AbbLPVh4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 16:37:56 -0500
Received: by mail-pf0-f171.google.com with SMTP id e66so19053070pfe.0
        for <linux-input@vger.kernel.org>; Wed, 16 Dec 2015 13:37:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Commit c7f0522 uses sixteen bits of data in the construction of 'strip1'
and 'strip2'. This can cause problems in some cases, however, since some
tablets store flags in the MSB of data[2] and data[4] that should not be
included in these values. This restores the 0x1f mask that used prior
to c7f0522.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 22d3225..cf87810 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -545,8 +545,8 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 			          ((data[6] & 0x0F) << 4)  |
 			          (data[5] & 0x0F);
 		}
-		strip1 = (data[1] << 8) | data[2];
-		strip2 = (data[3] << 8) | data[4];
+		strip1 = ((data[1] & 0x1f) << 8) | data[2];
+		strip2 = ((data[3] & 0x1f) << 8) | data[4];
 	}
 
 	prox = (buttons & ~(~0 << nbuttons)) | (keys & ~(~0 << nkeys)) |
-- 
2.6.3

