From: kenichi3.nagai@toshiba.co.jp
Subject: evdev: Fix a buffer overflow on BIG_ENDIAN systems
Date: Fri, 11 May 2007 09:54:04 +0900
Message-ID: <200705110054.l4B0sKil026374@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru
List-Id: linux-input@vger.kernel.org

 I found a little mistake. 
 On TOSHIBA Cell refference system(BIG_ENDIAN systems) a buffer overflow
was occured when I specified smaller buffers than maxlen.


Best regards,

Kenichi Nagai
Semiconductor Company
TOSHIBA Corporation
Kenichi3.nagai@toshiba.co.jp


Signed-off-by: Kenichi Nagai <kenichi3.nagai@toshiba.co.jp>
---
 
--- drivers/input/evdev.c.orig  2007-04-14 05:48:14.000000000 +0900
+++ drivers/input/evdev.c       2007-04-19 09:36:19.000000000 +0900
@@ -320,7 +320,7 @@ static int bits_to_user(unsigned long *b

        if (compat) {
                len = NBITS_COMPAT(maxbit) * sizeof(compat_long_t);
-               if (len < maxlen)
+               if (len > maxlen)
                        len = maxlen;

                for (i = 0; i < len / sizeof(compat_long_t); i++)
