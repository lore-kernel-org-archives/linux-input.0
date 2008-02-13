From: Kmarty <gkmarty@gmail.com>
Subject: [PATCH 2/2] driver for Zhen Hua PCM-4CH RC transmitter
Date: Wed, 13 Feb 2008 16:28:53 +0100
Message-ID: <5fecb1300802130728w3c11e16bo94cea658b4b56e93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:6953 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756292AbYBMP2z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Feb 2008 10:28:55 -0500
Received: by wr-out-0506.google.com with SMTP id c48so75552wra.23
        for <linux-input@vger.kernel.org>; Wed, 13 Feb 2008 07:28:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org

Patch for inputattach from joystick-utils:
---
 inputattach.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

--- inputattach.c.orig  2008-02-06 10:35:22.000000000 +0100
+++ inputattach.c       2008-02-13 15:49:48.000000000 +0100
@@ -1,5 +1,4 @@
 /*
- * $Id: inputattach.c 2352 2006-02-08 12:19:31Z vojtech $
  *
  *  Copyright (c) 1999-2000 Vojtech Pavlik
  *
@@ -315,6 +314,42 @@
        return 0;
 }

+int zhenhua_init(int fd, long *id, long *extra)
+{
+       /* Zhen Hua 5 byte protokol: prvni (synchronizacni) byte
obsahuje vzdy 0xF7,
+        * nasledujici ctyri pak jednotlive osy ovladace v intervalu 50-200.
+        * Pozor, nacitana data (jednotlive bajty) jsou bitove
prevracene (nejnizsi
+        * bit je nejvyssim bitem) - neco jako little-endian na bitove urovni.
+        * Synchronizacni byte ma tedy bez prevraceni hodnotu 0xEF
+        *
+        * Inicializace je temer shodna s twiddlerem */
+
+       unsigned char c[10];
+       int count;
+
+       for (count=0 ; count < 5 ; count++) {
+               if(readchar(fd, c+0, 500)) return -1;
+               if(c[0] == 0xef) break;
+       }
+
+       if (count == 5) {
+               /* Could not find header byte in data stream */
+               return -1;
+       }
+
+       /* Read remaining 4 bytes plus the full next data packet */
+       for (count = 1; count < 10; count++) {
+               if (readchar(fd, c+count, 500)) return -1;
+       }
+
+       /* check if next sync byte exists */
+       if (c[5] != 0xef)
+               return -1;
+
+       return 0;
+
+}
+
 int dump_init(int fd, long *id, long *extra)
 {
        unsigned char c, o = 0;
@@ -376,6 +411,7 @@
 { "--elo4002",         "-elo6b",       B9600, CS8 | CRTSCTS,
 SERIO_ELO,      1,      0,      0,      NULL },
 { "--elo271-140",      "-elo4b",       B9600, CS8 | CRTSCTS,
 SERIO_ELO,      2,      0,      0,      NULL },
 { "--elo261-280",      "-elo3b",       B9600, CS8 | CRTSCTS,
 SERIO_ELO,      3,      0,      0,      NULL },
+{ "--zhen-hua",                "-zhen",        B19200, CS8,
         SERIO_ZHENHUA,  0,      0,      0,      zhenhua_init },
 { "--dump",            "-dump",        B2400, CS8,
 0,              0,      0,      0,      dump_init },
 { "", "", 0, 0 }

@@ -416,6 +452,7 @@
                puts("  --ps2serkbd     -ps2ser PS/2 via serial keyboard");
                puts("  --twiddler      -twid   Handykey Twiddler
chording keyboard");
                puts("  --twiddler-joy  -twidjoy  Handykey Twiddler
used as a joystick");
+               puts("  --zhen-hua      -zhen  Zhen Hua 5-byte protocol");
                puts("");
                 return 1;
         }
