From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: adi: make array seq static, reduces object code size
Date: Mon,  4 Sep 2017 10:04:18 +0100
Message-ID: <20170904090418.12110-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array seq on the stack, instead make it static.
Makes the object code smaller by over 170 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  13227	   3232	      0	  16459	   404b	drivers/input/joystick/adi.o

After:
   text	   data	    bss	    dec	    hex	filename
  12957	   3328	      0	  16285	   3f9d	drivers/input/joystick/adi.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/joystick/adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
index d09cefa37931..15a71acb6997 100644
--- a/drivers/input/joystick/adi.c
+++ b/drivers/input/joystick/adi.c
@@ -313,7 +313,7 @@ static void adi_close(struct input_dev *dev)
 
 static void adi_init_digital(struct gameport *gameport)
 {
-	int seq[] = { 4, -2, -3, 10, -6, -11, -7, -9, 11, 0 };
+	static const int seq[] = { 4, -2, -3, 10, -6, -11, -7, -9, 11, 0 };
 	int i;
 
 	for (i = 0; seq[i]; i++) {
-- 
2.14.1
