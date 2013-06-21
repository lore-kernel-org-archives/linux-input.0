From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 10/12] input: keypad_matrix: use usleep_range() for scan delay
Date: Fri, 21 Jun 2013 20:09:56 +0200
Message-ID: <1371838198-7327-11-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:60347 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423568Ab3FUSKd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 14:10:33 -0400
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>

querying keyboards isn't a time critical task and does not depend on
exact timing in the microseconds order -- the timeouts and delays are
arbitrary choices or educated guesses at best anyway

so we can be nice and reduce stress on the timer management
- use usleep_range() for the scan delay (a delay in microseconds between
  activating a column and reading rows)
- allow optional range specs in device tree nodes in addition to the
  previous simple integer spec of an exact delay
- allow for platform data to optionally specify a delay range

this implementation assumes an exact delay with the first or only
integer spec when no upper bound for the range was specified as well as
when the range spec is invalid, as well as keeps up the scan delay's
being optional -- this results in compatible behaviour to the previous
implementation and an improvement on system load when the newly
introduced feature gets used

normalization of the range spec (enforcing a valid upper bound against
the lower bound, and assuming the exact value when no range was
specified) happens during probe in the devide tree case, but cannot be
done for the non-DT case because the platform data is read-only during
probe -- that's why the routine which enables the columns and optionally
applies the delay will enforce the constraints on the range spec -- this
is not a problem, and is perfectly acceptable given the low cost of the
min/max check and the potential benefit of reduced timer management cost

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 .../bindings/input/gpio-matrix-keypad.txt          |    7 +++--
 drivers/input/keyboard/matrix_keypad.c             |   29 +++++++++++++++++---
 include/linux/input/matrix_keypad.h                |    5 ++++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
index 75e9e28..1562681 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
@@ -93,7 +93,10 @@ Optional Properties:
 			a column line and reading back its row status,
 			such that pin levels can settle after
 			propagating through the matrix and its
-			associated hardware components
+			associated hardware components, can be specified
+			with either one value giving the exact delay, or
+			with two values giving a delay range (allowing
+			for reduced timer management overhead)
 - col-switch-delay-ms:	columns switch interval in milliseconds instead
 			of using interrupts to detect key press changes,
 			enables polling mode when specified
@@ -146,7 +149,7 @@ Examples:
 	matrix_keypad {
 		compatible = "gpio-matrix-keypad";
 		debounce-delay-ms = <5>;
-		col-scan-delay-us = <1>;
+		col-scan-delay-us = <2 10>;
 		col-switch-delay-ms = <20>;
 
 		col-gpios-binary;
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index c015f0d..275b157 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -100,6 +100,7 @@ static void activate_col(const struct matrix_keypad_platform_data *pdata,
 			 int col, bool on)
 {
 	int bit, lvl;
+	u32 delay_min, delay_max;
 
 	if (!pdata->col_gpios_binary_encoded) {
 		/* one-out-of-N approach, just setup the one pin */
@@ -115,8 +116,19 @@ static void activate_col(const struct matrix_keypad_platform_data *pdata,
 		/* EMPTY */
 	}
 
-	if (on && pdata->col_scan_delay_us)
-		udelay(pdata->col_scan_delay_us);
+	if (on && pdata->col_scan_delay_us) {
+		/*
+		 * the platform data is 'const' aka 'read-only' here, so
+		 * we may not modify it, yet might not have had a chance
+		 * to normalize its data before (we did for the DT case,
+		 * but did not for non-DT cases), which is why we have
+		 * to use local variables here to enforce sane input
+		 * data for the usleep range spec
+		 */
+		delay_min = pdata->col_scan_delay_us;
+		delay_max = max(delay_min, pdata->col_scan_delay_us_max);
+		usleep_range(delay_min, delay_max);
+	}
 }
 
 /*
@@ -609,6 +621,7 @@ matrix_keypad_parse_dt(struct device *dev)
 	unsigned int *gpios;
 	int i;
 	int err;
+	u32 us[2];
 
 	if (!np) {
 		dev_err(dev, "device lacks DT data for the keypad config\n");
@@ -655,8 +668,15 @@ matrix_keypad_parse_dt(struct device *dev)
 
 	/* get delay and interval timing specs */
 	of_property_read_u32(np, "debounce-delay-ms", &pdata->debounce_ms);
-	of_property_read_u32(np, "col-scan-delay-us",
-			     &pdata->col_scan_delay_us);
+	us[0] = us[1] = 0;
+	err = of_property_read_u32_array(np, "col-scan-delay-us", &us[0], 2);
+	if (err == -EOVERFLOW) {
+		err = of_property_read_u32(np, "col-scan-delay-us", &us[0]);
+		us[1] = us[0];
+	}
+	us[1] = max(us[1], us[0]);
+	pdata->col_scan_delay_us = us[0];
+	pdata->col_scan_delay_us_max = us[1];
 	of_property_read_u32(np, "col-switch-delay-ms",
 			     &pdata->col_switch_delay_ms);
 	if (pdata->col_gpios_binary_encoded && !pdata->col_switch_delay_ms) {
@@ -744,6 +764,7 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	/* start in stopped state, open(2) will activate the scan */
 	keypad->stopped = true;
 	INIT_DELAYED_WORK(&keypad->work_scan_matrix, matrix_keypad_scan);
+	/* we cannot normalize pdata here for the non-DT case, it's read-only */
 	INIT_DELAYED_WORK(&keypad->work_switch_column, matrix_keypad_switch);
 	keypad->col_to_poll = pdata->num_matrix_cols;
 	spin_lock_init(&keypad->lock);
diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 82db84a..fa093b2 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -43,6 +43,10 @@ struct matrix_keymap_data {
  * @num_matrix_cols: number of logical column lines in the matrix
  * @col_scan_delay_us: delay in microseconds, the interval between
  *	activating a column and reading back row information
+ * @col_scan_delay_us_max: maximum delay in microseconds between
+ *	activating a column and reading back row information,
+ *	defaults to @col_scan_delay_us when not specified, allows
+ *	for reduced timer management overhead
  * @col_switch_delay_ms: delay in milliseconds, the interval with which
  *	colums periodically get checked for changes in key press status
  * @debounce_ms: debounce interval in milliseconds, the interval between
@@ -80,6 +84,7 @@ struct matrix_keypad_platform_data {
 
 	/* delays and intervals specs */
 	unsigned int	col_scan_delay_us;
+	unsigned int	col_scan_delay_us_max;
 	unsigned int	col_switch_delay_ms;
 	unsigned int	debounce_ms;
 
-- 
1.7.10.4

