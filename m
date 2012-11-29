From: Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH v3 1/4] input: increase struct ps2dev cmdbuf[] to 8 bytes
Date: Thu, 29 Nov 2012 13:57:58 -0800
Message-ID: <1354226281-3476-2-git-send-email-kamal@canonical.com>
References: <1354226281-3476-1-git-send-email-kamal@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354226281-3476-1-git-send-email-kamal@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, Dudley Du <dudl@cypress.com>, Cypress Semiconductor Corporation <customercare@cypress.com>, Kamal Mostafa <kamal@canonical.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>
List-Id: linux-input@vger.kernel.org

Cypress PS/2 Trackpad (drivers/input/mouse/cypress_ps2.c) needs
this larger cmdbuf[] to handle 8-byte packet responses.

Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 include/linux/libps2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index 79603a6..4ad06e8 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -36,7 +36,7 @@ struct ps2dev {
 	wait_queue_head_t wait;
 
 	unsigned long flags;
-	unsigned char cmdbuf[6];
+	unsigned char cmdbuf[8];
 	unsigned char cmdcnt;
 	unsigned char nak;
 };
-- 
1.7.10.4
