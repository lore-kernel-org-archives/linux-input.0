From: Arnd Bergmann <arnd@arndb.de>
Subject: Qualcomm PMIC8XXX keypad never worked?
Date: Tue, 11 Mar 2014 09:49 +0100
Message-ID: <5887114.1jrNo21sGX@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Trilok Soni <tsoni@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Anirudh Ghayal <aghayal@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Something in the MFD_PM8XXX driver must have changed recently that now allows
the KEYBOARD_PMIC8XXX driver to be enabled. Unfortunately, it does not build
because of a dependency on the <linux/mfd/pm8xxx/gpio.h> header file that
does not exist.

In order to keep 'make randconfig' working on my test box, I have disabled
this driver, but it would be nice of someone could have a look into fixing it.

	Arnd

--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -470,7 +470,7 @@ config KEYBOARD_PXA930_ROTARY
 
 config KEYBOARD_PMIC8XXX
        tristate "Qualcomm PMIC8XXX keypad support"
-       depends on MFD_PM8XXX
+       depends on MFD_PM8XXX && BROKEN
        select INPUT_MATRIXKMAP
        help
          Say Y here if you want to enable the driver for the PMIC8XXX
