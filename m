From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] Input-gameport: Delete an error message for a failed
 memory allocation
Date: Sat, 24 Sep 2016 15:47:42 +0200
Message-ID: <0b438906-0b64-7635-801d-8edfe5bcd8dd@users.sourceforge.net>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 14:18:48 +0200

Omit an extra message for a memory allocation failure in this function.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/joystick/joydump.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
index e515058..f9f6cbe 100644
--- a/drivers/input/joystick/joydump.c
+++ b/drivers/input/joystick/joydump.c
@@ -80,10 +80,9 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
 
 	timeout = gameport_time(gameport, 10000); /* 10 ms */
 	buf = kmalloc_array(BUF_SIZE, sizeof(*buf), GFP_KERNEL);
-	if (!buf) {
-		printk(KERN_INFO "joydump: no memory for testing\n");
+	if (!buf)
 		goto jd_end;
-	}
+
 	dump = buf;
 	t = 0;
 	i = 1;
-- 
2.10.0
