From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH -next] HID: picoLCD: Add missing #include <linux/uaccess.h>
Date: Tue, 21 Aug 2012 22:41:23 +0200
Message-ID: <1345581683-2099-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from juliette.telenet-ops.be ([195.130.137.74]:47848 "EHLO
	juliette.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756282Ab2HUUle (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Aug 2012 16:41:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

m68k/allmodconfig:

drivers/hid/hid-picolcd_debugfs.c: In function =E2=80=98picolcd_debug_r=
eset_write=E2=80=99:
drivers/hid/hid-picolcd_debugfs.c:54: error: implicit declaration of fu=
nction =E2=80=98copy_from_user=E2=80=99
drivers/hid/hid-picolcd_debugfs.c: In function =E2=80=98picolcd_debug_e=
eprom_read=E2=80=99:
drivers/hid/hid-picolcd_debugfs.c:112: error: implicit declaration of f=
unction =E2=80=98copy_to_user=E2=80=99

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
http://kisskb.ellerman.id.au/kisskb/buildresult/6990818/

 drivers/hid/hid-picolcd_debugfs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolc=
d_debugfs.c
index f2491fa..15c22f2 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -27,6 +27,7 @@
 #include <linux/debugfs.h>
=20
 #include <linux/module.h>
+#include <linux/uaccess.h>
=20
 #include "hid-picolcd.h"
=20
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
