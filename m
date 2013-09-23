From: Juergen Beisert <jbe@pengutronix.de>
Subject: [PATCH 9/9] Staging/iio: add TODO reminder
Date: Mon, 23 Sep 2013 16:36:38 +0200
Message-ID: <1379946998-23041-10-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Some things have still to be done to the LRADC driver.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-input@vger.kernel.org
CC: devel@driverdev.osuosl.org
CC: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/TODO | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 04c2326..c22a0ed 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -13,6 +13,17 @@ Would be nice
 3) Expand device set. Lots of other maxim adc's have very
    similar interfaces.
 
+MXS LRADC driver:
+This is a classic MFD device as it combines the following subdevices
+ - touchscreen controller (input subsystem related device)
+ - general purpose ADC channels
+ - battery voltage monitor (power subsystem related device)
+ - die temperature monitor (thermal management)
+
+At least the battery voltage and die temperature feature is required in-kernel
+by a driver of the SoC's battery charging unit to avoid any damage to the
+silicon and the battery.
+
 TSL2561
 Would be nice
 1) Open question of userspace vs kernel space balance when
-- 
1.8.4.rc3
