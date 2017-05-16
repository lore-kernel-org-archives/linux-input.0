From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/5] HID: intel_ish-hid: enable compile testing
Date: Tue, 16 May 2017 13:09:07 +0200
Message-ID: <20170516110907.3545799-6-arnd@arndb.de>
References: <20170516110907.3545799-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170516110907.3545799-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-input@vger.kernel.org

To increase build coverage, drivers should generally be allowed to
build on other architectures even if they are only used on one
of them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/intel-ish-hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/Kconfig b/drivers/hid/intel-ish-hid/Kconfig
index ea065b3684a2..519e4c8b53c4 100644
--- a/drivers/hid/intel-ish-hid/Kconfig
+++ b/drivers/hid/intel-ish-hid/Kconfig
@@ -1,5 +1,5 @@
 menu "Intel ISH HID support"
-	depends on X86_64 && PCI
+	depends on (X86_64 || COMPILE_TEST) && PCI
 
 config INTEL_ISH_HID
 	tristate "Intel Integrated Sensor Hub"
-- 
2.9.0
