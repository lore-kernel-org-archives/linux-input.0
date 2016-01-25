From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] input: sirf onkey: allow modular build
Date: Mon, 25 Jan 2016 16:31:35 +0100
Message-ID: <1453735950-1958677-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Barry Song <baohua@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

CONFIG_INPUT may itself be a loadable module, but the sirf power key
driver is listed as 'bool', which makes it possible to select
a broken configuration with the driver built-in but the subsystem
not loaded. In this configuration, we get a link error:

drivers/input/built-in.o: In function `sirfsoc_pwrc_isr':
drivers/input/misc/sirfsoc-onkey.c:63: undefined reference to `input_event'
drivers/input/built-in.o: In function `sirfsoc_pwrc_isr':
include/linux/input.h:414: undefined reference to `input_event'
drivers/input/built-in.o: In function `sirfsoc_pwrc_probe':
drivers/input/misc/sirfsoc-onkey.c:132: undefined reference to `devm_input_allocate_device'
drivers/input/misc/sirfsoc-onkey.c:139: undefined reference to `input_set_capability'
drivers/input/misc/sirfsoc-onkey.c:161: undefined reference to `input_register_device'
drivers/input/built-in.o: In function `sirfsoc_pwrc_report_event':
drivers/input/misc/sirfsoc-onkey.c:48: undefined reference to `input_event'
drivers/input/built-in.o: In function `sirfsoc_pwrc_report_event':
include/linux/input.h:414: undefined reference to `input_event'
drivers/input/built-in.o:(.debug_addr+0x24): undefined reference to `input_event'
drivers/input/built-in.o:(.debug_addr+0xbc): undefined reference to `devm_input_allocate_device'
drivers/input/built-in.o:(.debug_addr+0x104): undefined reference to `input_set_capability'
drivers/input/built-in.o:(.debug_addr+0x128): undefined reference to `input_register_device'

This marks the driver as 'tristate' so it becomes possible to have
it in a loadable module, mainly to help with randconfig builds.

We also have to add a missing semicolon here, which ended up not
being needed in built-in mode because the following MODULE_DEVICE_TABLE
is an empty macro followed by another semicolon then.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/misc/Kconfig         | 2 +-
 drivers/input/misc/sirfsoc-onkey.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index d6d16fa78281..1f2337abcf2f 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -733,7 +733,7 @@ config INPUT_XEN_KBDDEV_FRONTEND
 	  module will be called xen-kbdfront.
 
 config INPUT_SIRFSOC_ONKEY
-	bool "CSR SiRFSoC power on/off/suspend key support"
+	tristate "CSR SiRFSoC power on/off/suspend key support"
 	depends on ARCH_SIRF && OF
 	default y
 	help
diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 9d5b89befe6f..ed7237f19539 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -101,7 +101,7 @@ static void sirfsoc_pwrc_close(struct input_dev *input)
 static const struct of_device_id sirfsoc_pwrc_of_match[] = {
 	{ .compatible = "sirf,prima2-pwrc" },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, sirfsoc_pwrc_of_match);
 
 static int sirfsoc_pwrc_probe(struct platform_device *pdev)
-- 
2.7.0
