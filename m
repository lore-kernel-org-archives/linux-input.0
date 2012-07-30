From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH 7/7] HID: picoLCD: add myself to MAINTAINERS
Date: Mon, 30 Jul 2012 21:39:03 +0200
Message-ID: <20120730213903.30c6ba0b@neptune.home>
References: <20120730213656.0a9f6d30@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Jaya Kumar <jayalk@intworks.biz>, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe643e7..0042553 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5283,6 +5283,12 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/devices/phram.c
=20
+PICOLCD HID DRIVER
+M:	Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-picolcd*
+
 PICOXCELL SUPPORT
 M:	Jamie Iles <jamie@jamieiles.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers=
)
--=20
1.7.8.6
