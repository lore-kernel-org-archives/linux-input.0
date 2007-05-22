From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.22-rc2] ads7846 doc: handles tsc2046 too
Date: Tue, 22 May 2007 11:39:08 -0700
Message-ID: <200705221139.08689.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@mail.ru>, linux-input@atrey.karlin.mff.cuni.cz
Cc: Kevin Hilman <khilman@mvista.com>
List-Id: linux-input@vger.kernel.org

The TSC2046 is an updated version of the ADS7846 ... mention that in
the Kconfig helptext and driver source.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/input/touchscreen/Kconfig   |    8 ++++----
 drivers/input/touchscreen/ads7846.c |    1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

--- g26.orig/drivers/input/touchscreen/Kconfig	2007-05-19 12:58:22.000000000 -0700
+++ g26/drivers/input/touchscreen/Kconfig	2007-05-19 12:59:06.000000000 -0700
@@ -12,17 +12,17 @@ menuconfig INPUT_TOUCHSCREEN
 if INPUT_TOUCHSCREEN
 
 config TOUCHSCREEN_ADS7846
-	tristate "ADS 7846/7843 based touchscreens"
+	tristate "ADS7846/TSC2046 and ADS7843 based touchscreens"
 	depends on SPI_MASTER
 	depends on HWMON = n || HWMON
 	help
 	  Say Y here if you have a touchscreen interface using the
-	  ADS7846 or ADS7843 controller, and your board-specific setup
-	  code includes that in its table of SPI devices.
+	  ADS7846/TSC2046 or ADS7843 controller, and your board-specific
+	  setup code includes that in its table of SPI devices.
 
 	  If HWMON is selected, and the driver is told the reference voltage
 	  on your board, you will also get hwmon interfaces for the voltage
-	  (and on ads7846, temperature) sensors of this chip.
+	  (and on ads7846/tsc2046, temperature) sensors of this chip.
 
 	  If unsure, say N (but it's safe to say "Y").
 
--- g26.orig/drivers/input/touchscreen/ads7846.c	2007-05-19 13:01:02.000000000 -0700
+++ g26/drivers/input/touchscreen/ads7846.c	2007-05-19 13:01:47.000000000 -0700
@@ -39,6 +39,7 @@
 /*
  * This code has been heavily tested on a Nokia 770, and lightly
  * tested on other ads7846 devices (OSK/Mistral, Lubbock).
+ * TSC2046 is just newer ads7846 silicon.
  * Support for ads7843 tested on Atmel at91sam926x-EK.
  * Support for ads7845 has only been stubbed in.
  *
