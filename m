From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 5/5] HID: intel_ish-hid: enable compile testing
Date: Thu, 18 May 2017 22:21:44 +0200
Message-ID: <20170518202144.3482304-6-arnd@arndb.de>
References: <20170518202144.3482304-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:51952 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdERUWh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 18 May 2017 16:22:37 -0400
In-Reply-To: <20170518202144.3482304-1-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

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

