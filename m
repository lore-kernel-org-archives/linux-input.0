From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: gamecon: Improve a size determination in
 gc_attach()
Date: Sat, 27 Jan 2018 17:15:21 +0100
Message-ID: <423af7ee-401a-5e6a-b7f1-fb9b223a2b75@users.sourceforge.net>
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
Date: Sat, 27 Jan 2018 16:30:58 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/joystick/gamecon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index f6006383d30d..0e3d47ab9ab9 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -965,7 +965,7 @@ static void gc_attach(struct parport *pp)
 		return;
 	}
 
-	gc = kzalloc(sizeof(struct gc), GFP_KERNEL);
+	gc = kzalloc(sizeof(*gc), GFP_KERNEL);
 	if (!gc)
 		goto err_unreg_pardev;
 
-- 
2.16.1
