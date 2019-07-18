From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] Input: applespi: Fix build error without CONFIG_PCI
Date: Thu, 18 Jul 2019 10:06:54 +0800
Message-ID: <20190718020654.39860-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, hsweeten@visionengravers.com, robh@kernel.org, arnd@arndb.de, ronald@innovation.ch, andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

If CONFIG_KEYBOARD_APPLESPI is set to y, but
CONFIG_PCI is not set, building will fails:

drivers/spi/spi-pxa2xx-pci.c: In function pxa2xx_spi_pci_probe:
drivers/spi/spi-pxa2xx-pci.c:208:8: error: implicit declaration of function pcim_enable_device;
 did you mean pci_enable_device? [-Werror=implicit-function-declaration]
  ret = pcim_enable_device(dev);
        ^~~~~~~~~~~~~~~~~~
        pci_enable_device
drivers/spi/spi-pxa2xx-pci.c:239:8: error: implicit declaration of function pci_alloc_irq_vectors;
 did you mean pci_alloc_consistent? [-Werror=implicit-function-declaration]
  ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
        ^~~~~~~~~~~~~~~~~~~~~

Make CONFIG_KEYBOARD_APPLESPI depends on CONFIG_PCI
to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: b426ac045209 ("Input: add Apple SPI keyboard and trackpad driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index dd934c4..fefcc46 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -74,7 +74,7 @@ config ATARI_KBD_CORE
 config KEYBOARD_APPLESPI
 	tristate "Apple SPI keyboard and trackpad"
 	depends on ACPI && EFI
-	depends on SPI
+	depends on SPI && PCI
 	depends on X86 || COMPILE_TEST
 	imply SPI_PXA2XX
 	imply SPI_PXA2XX_PCI
-- 
2.7.4
