From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.22-rc2-git] ads7846: SPI_CPHA mode bugfix
Date: Tue, 22 May 2007 13:59:11 -0700
Message-ID: <200705221359.12410.david-b@pacbell.net>
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
To: Dmitry Torokhov <dtor@mail.ru>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz, Semih Hazar <semih.hazar@indefia.com>, Nicolas Ferre <nicolas.ferre@rfo.atmel.com>, Tony Lindgren <tony@atomide.com>, imre.deak@solidboot.com
List-Id: linux-input@vger.kernel.org

From: Semih Hazar <semih.hazar@indefia.com>

In commit [1] the SPI mode is set to 1, but it should be 0.  As stated
in the commit, ads784x samples the data on the rising edge.  SPI mode 1
samples on the falling edge [2] though.

The root cause of this is a bug in the omap_uwire code, which treats
CPHA=1 incorrectly; so these two bugs cancel each other out on one
of the main regression test platforms for this driver.

[1] kernel.org GIT 7937e86a70235e1584486654687dc9908a11e00a
[2] http://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 drivers/input/touchscreen/ads7846.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- g26.orig/drivers/input/touchscreen/ads7846.c	2007-05-20 21:08:30.000000000 -0700
+++ g26/drivers/input/touchscreen/ads7846.c	2007-05-20 21:08:54.000000000 -0700
@@ -847,7 +847,7 @@ static int __devinit ads7846_probe(struc
 	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
 	 */
 	spi->bits_per_word = 8;
-	spi->mode = SPI_MODE_1;
+	spi->mode = SPI_MODE_0;
 	err = spi_setup(spi);
 	if (err < 0)
 		return err;
