From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 12/12] input: matrix-keypad: add diagnostics in probe()
Date: Fri, 21 Jun 2013 20:09:58 +0200
Message-ID: <1371838198-7327-13-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34678 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423568Ab3FUSKg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 14:10:36 -0400
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Marek Vasut <marek.vasut@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>, Gerhard Sittig <gsi@denx.de>

optionally dump relevant configuration of pins, matrix lines,
and delay/interval times at the very end of the probe routine
(development feature, silent by default)

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/input/keyboard/matrix_keypad.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 275b157..69b15720 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -800,6 +800,24 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 	platform_set_drvdata(pdev, keypad);
 
+	dev_dbg(&pdev->dev, "gpios col num[%u] lvl[%s] drv[%s] enc[%s]\n",
+		pdata->num_col_gpios,
+		pdata->col_gpios_active_low ? "low" : "high",
+		pdata->col_gpios_push_pull ? "pp" : "od",
+		pdata->col_gpios_binary_encoded ? "bin" : "1-1");
+	dev_dbg(&pdev->dev, "gpios row num[%u] lvl[%s]\n",
+		pdata->num_row_gpios,
+		pdata->row_gpios_active_low ? "low" : "high");
+	dev_dbg(&pdev->dev, "matrix cols[%u] rows[%u] code shift[%u]\n",
+		pdata->num_matrix_cols,
+		pdata->num_matrix_rows,
+		keypad->row_shift);
+	dev_dbg(&pdev->dev, "times scan[%u-%u] bounce[%u] switch[%u]\n",
+		pdata->col_scan_delay_us,
+		pdata->col_scan_delay_us_max,
+		pdata->debounce_ms,
+		pdata->col_switch_delay_ms);
+
 	return 0;
 
 err_free_gpio:
-- 
1.7.10.4

