From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 29/37] drivers/input/misc: Use kmemdup
Date: Sat, 15 May 2010 23:22:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005152321430.21345@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Miloslav Trmac <mitr@volny.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Use kmemdup when some other buffer is immediately copied into the
allocated region.

A simplified version of the semantic patch that makes this change is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression from,to,size,flag;
statement S;
@@

-  to = \(kmalloc\|kzalloc\)(size,flag);
+  to = kmemdup(from,size,flag);
   if (to==NULL || ...) S
-  memcpy(to, from, size);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/input/misc/wistron_btns.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -983,11 +983,11 @@ static int __init copy_keymap(void)
 	for (key = keymap; key->type != KE_END; key++)
 		length++;
 
-	new_keymap = kmalloc(length * sizeof(struct key_entry), GFP_KERNEL);
+	new_keymap = kmemdup(keymap, length * sizeof(struct key_entry),
+			     GFP_KERNEL);
 	if (!new_keymap)
 		return -ENOMEM;
 
-	memcpy(new_keymap, keymap, length * sizeof(struct key_entry));
 	keymap = new_keymap;
 
 	return 0;
