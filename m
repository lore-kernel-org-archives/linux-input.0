From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 3/6] Haptic: Add haptic maintainer
Date: Wed, 07 Oct 2009 15:18:05 +0900
Message-ID: <20091007061805.GA7592@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757790AbZJGGS6@vger.kernel.org>
Content-disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: soni.trilok@gmail.com
List-Id: linux-input@vger.kernel.org

Add me to haptic class maintainer

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09a2028..906b603 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2287,6 +2287,13 @@ F:	Documentation/isdn/README.gigaset
 F:	drivers/isdn/gigaset/
 F:	include/linux/gigaset_dev.h
 
+HAPTIC SUBSYSTEM
+M:	Kyungmin Park <kyungmin.park@samsung.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/haptic/
+F:	include/linux/haptic.h
+
 HARD DRIVE ACTIVE PROTECTION SYSTEM (HDAPS) DRIVER
 M:	Frank Seidel <frank@f-seidel.de>
 L:	lm-sensors@lm-sensors.org
-- 
1.5.3.3
