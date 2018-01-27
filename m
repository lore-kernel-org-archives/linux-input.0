From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: gamecon: Delete an error message for a failed
 memory allocation in gc_attach()
Date: Sat, 27 Jan 2018 17:14:14 +0100
Message-ID: <1097eb0c-fd33-3229-90be-417aca3795bd@users.sourceforge.net>
References: <e02726e3-2ee7-e690-a8ea-90a55f8fd0c2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e02726e3-2ee7-e690-a8ea-90a55f8fd0c2@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2018 16:27:11 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/joystick/gamecon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index 2ffb2e8bdc3b..f6006383d30d 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -966,10 +966,8 @@ static void gc_attach(struct parport *pp)
 	}
 
 	gc = kzalloc(sizeof(struct gc), GFP_KERNEL);
-	if (!gc) {
-		pr_err("Not enough memory\n");
+	if (!gc)
 		goto err_unreg_pardev;
-	}
 
 	mutex_init(&gc->mutex);
 	gc->pd = pd;
-- 
2.16.1
