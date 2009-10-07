From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 4/6] Haptic: add haptic configuration
Date: Wed, 07 Oct 2009 15:18:14 +0900
Message-ID: <20091007061814.GA7596@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757675AbZJGG3k@vger.kernel.org>
Content-disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: soni.trilok@gmail.com
List-Id: linux-input@vger.kernel.org

haptic class support

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/Kconfig  |    2 ++
 drivers/Makefile |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 48bbdbe..a44348e 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -90,6 +90,8 @@ source "drivers/memstick/Kconfig"
 
 source "drivers/leds/Kconfig"
 
+source "drivers/haptic/Kconfig"
+
 source "drivers/accessibility/Kconfig"
 
 source "drivers/infiniband/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 6ee53c7..ee6f438 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -94,6 +94,7 @@ obj-y				+= idle/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
 obj-$(CONFIG_NEW_LEDS)		+= leds/
+obj-$(CONFIG_HAPTCI)		+= haptic/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
-- 
1.5.3.3
