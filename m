From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 2/2] Documentation: devices.txt: remove the mk712 touchscreen device from the list
Date: Mon,  2 Apr 2018 14:55:51 +0200
Message-ID: <20180402125551.13641-2-martink@posteo.de>
References: <20180402125551.13641-1-martink@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180402125551.13641-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, dmitry.torokhov@gmail.com
Cc: gregkh@linuxfoundation.org, logang@deltatee.com, stefanha@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

The input/touchscreen/mk712.c driver has been rewritten for the common
input event system. in 2005. There shouldn't a special device node be
created anymore.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

Please review this by looking at the driver too. Thanks,

                    martin



 Documentation/admin-guide/devices.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 4ec843123cc3..fb39bbf0789a 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -259,7 +259,6 @@
 		 11 = /dev/vrtpanel	Vr41xx embedded touch panel
 		 13 = /dev/vpcmouse	Connectix Virtual PC Mouse
 		 14 = /dev/touchscreen/ucb1x00  UCB 1x00 touchscreen
-		 15 = /dev/touchscreen/mk712	MK712 touchscreen
 		128 = /dev/beep		Fancy beep device
 		129 =
 		130 = /dev/watchdog	Watchdog timer port
-- 
2.16.2
