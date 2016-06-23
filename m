From: Colin King <colin.king@canonical.com>
Subject: [PATCH] Input: apanel - spelling mistake: "skiping" -> "skipping"
Date: Thu, 23 Jun 2016 17:57:40 +0100
Message-ID: <1466701060-7896-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in pr_notice message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/misc/apanel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index a8d2b8d..53630af 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -297,7 +297,7 @@ static int __init apanel_init(void)
 
 		if (slave != i2c_addr) {
 			pr_notice(APANEL ": only one SMBus slave "
-				  "address supported, skiping device...\n");
+				  "address supported, skipping device...\n");
 			continue;
 		}
 
-- 
2.8.1
