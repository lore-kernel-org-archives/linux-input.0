From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/3] pwm: lpss: Make builtin so that i915 can find the pwm_backlight
Date: Sun, 22 Jan 2017 16:24:14 +0100
Message-ID: <20170122152415.10374-2-hdegoede@redhat.com>
References: <20170122152415.10374-1-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170122152415.10374-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Darren Hart <dvhart@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The primary consumer of the lpss pwm is the i915 kms driver,
the i915 driver does not support get_pwm returning -EPROBE_DEFER and
its init is very complex making this is almost impossible to fix.

This commit changes the PWM_LPSS Kconfig from a tristate to a bool, so
that when the i915 driver loads the lpss pwm will be available avoiding
the -EPROBE_DEFER issue. Note that this is identical to how the same
problem was solved for the pwm-crc driver, which is used by the i915
driver on other platforms.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
Changes in v2:
-Drop the pwm_add_table call (this has been moved to the acpi_lpss driver)
---
 drivers/pwm/Kconfig | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index f92dd41..12a6cf8 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -249,28 +249,22 @@ config PWM_LPC32XX
 	  will be called pwm-lpc32xx.
 
 config PWM_LPSS
-	tristate
+	bool
 
 config PWM_LPSS_PCI
-	tristate "Intel LPSS PWM PCI driver"
+	bool "Intel LPSS PWM PCI driver"
 	depends on X86 && PCI
 	select PWM_LPSS
 	help
 	  The PCI driver for Intel Low Power Subsystem PWM controller.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-lpss-pci.
-
 config PWM_LPSS_PLATFORM
-	tristate "Intel LPSS PWM platform driver"
+	bool "Intel LPSS PWM platform driver"
 	depends on X86 && ACPI
 	select PWM_LPSS
 	help
 	  The platform driver for Intel Low Power Subsystem PWM controller.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-lpss-platform.
-
 config PWM_MESON
 	tristate "Amlogic Meson PWM driver"
 	depends on ARCH_MESON
-- 
2.9.3
