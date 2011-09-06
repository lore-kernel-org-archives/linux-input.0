From: David Herrmann <dh.herrmann@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=2015/15=5D=20HID=3A=20wiimote=3A=20Add=20MAINTAINERS=20entry?=
Date: Tue,  6 Sep 2011 13:50:40 +0200
Message-ID: <1315309840-4664-16-git-send-email-dh.herrmann@googlemail.com>
References: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32933 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab1IFLv2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 07:51:28 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4508762fxh.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 04:51:27 -0700 (PDT)
In-Reply-To: <1315309840-4664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Add entry to MAINTAINERS and also bump version level as the core driver=
 is
feature complete now.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 MAINTAINERS               |    6 ++++++
 drivers/hid/hid-wiimote.c |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 069ee3b..c250d2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7133,6 +7133,12 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/wd7000.c
=20
+WIIMOTE HID DRIVER
+M:	David Herrmann <dh.herrmann@googlemail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-wiimote*
+
 WINBOND CIR DRIVER
 M:	David H=C3=A4rdeman <david@hardeman.nu>
 S:	Maintained
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index c83cafa..76739c0 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -21,7 +21,7 @@
 #include <linux/spinlock.h>
 #include "hid-ids.h"
=20
-#define WIIMOTE_VERSION "0.1"
+#define WIIMOTE_VERSION "0.2"
 #define WIIMOTE_NAME "Nintendo Wii Remote"
 #define WIIMOTE_BUFSIZE 32
=20
--=20
1.7.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
