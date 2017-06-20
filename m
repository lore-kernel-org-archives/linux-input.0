From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] tty: improve tty_insert_flip_char() slow path
Date: Tue, 20 Jun 2017 23:10:42 +0200
Message-ID: <20170620211112.1490310-2-arnd@arndb.de>
References: <20170620211112.1490310-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170620211112.1490310-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-kernel@vger.kernel.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

While working on improving the fast path of tty_insert_flip_char(),
I noticed that by calling tty_buffer_request_room(), we needlessly
move to the separate flag buffer mode for the tty, even when all
characters use TTY_NORMAL as the flag.

This changes the code to call __tty_buffer_request_room() with the
correct flag, which will then allocate a regular buffer when it rounds
out of space but no special flags have been used. I'm guessing that
this is the behavior that Peter Hurley intended when he introduced
the compacted flip buffers.

Fixes: acc0f67f307f ("tty: Halve flip buffer GFP_ATOMIC memory consumption")
Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This patch is just based on my reading of the source code, it's
possible that I missed something and the previous behavior was
intentional, so please review carefully.
---
 drivers/tty/tty_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 2da05fa37aec..6a8563633d4b 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -375,10 +375,11 @@ int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag)
 	struct tty_buffer *tb = port->buf.tail;
 	int flags = (flag == TTY_NORMAL) ? TTYB_NORMAL : 0;
 
-	if (!tty_buffer_request_room(port, 1))
+	if (!__tty_buffer_request_room(port, 1, flags))
 		return 0;
 
-	*flag_buf_ptr(tb, tb->used) = flag;
+	if (~tb->flags & TTYB_NORMAL)
+		*flag_buf_ptr(tb, tb->used) = flag;
 	*char_buf_ptr(tb, tb->used++) = ch;
 
 	return 1;
-- 
2.9.0
