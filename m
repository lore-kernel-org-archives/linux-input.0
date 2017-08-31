From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: byd: make array seq static, reduces object code size
Date: Thu, 31 Aug 2017 13:47:30 +0100
Message-ID: <20170831124730.27047-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47818 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdHaMrc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 31 Aug 2017 08:47:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array seq on the stack, instead make it static.
Makes the object code smaller by over 1100 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   6152	   1216	     64	   7432	   1d08	drivers/input/mouse/byd.o

After:
   text	   data	    bss	    dec	    hex	filename
   4974	   1280	     64	   6318	   18ae	drivers/input/mouse/byd.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/mouse/byd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index b27aa637f877..b64b81599f7e 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -344,7 +344,7 @@ static int byd_reset_touchpad(struct psmouse *psmouse)
 	u8 param[4];
 	size_t i;
 
-	const struct {
+	static const struct {
 		u16 command;
 		u8 arg;
 	} seq[] = {
-- 
2.14.1

