From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH] Input: matrix_keypad - make driver useable with GPIO drivers requiring threaded irqs
Date: Tue,  9 Sep 2014 10:33:04 +0200
Message-ID: <1410251584-5031-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:56978 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaIIIdH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Sep 2014 04:33:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

When trying to use the matrix-keypad driver with GPIO drivers that
require nested irq handlers (e.g. I2C GPIO adapters like PCA9554),
request_irq() fails because the GPIO driver requires a threaded
interrupt handler.

Use request_any_context_irq() to be able to use any GPIO driver as
keypad driver.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/input/keyboard/matrix_keypad.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/key=
board/matrix_keypad.c
index 8d2e19e..e651fa6 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -332,23 +332,24 @@ static int matrix_keypad_init_gpio(struct platfor=
m_device *pdev,
 	}
=20
 	if (pdata->clustered_irq > 0) {
-		err =3D request_irq(pdata->clustered_irq,
+		err =3D request_any_context_irq(pdata->clustered_irq,
 				matrix_keypad_interrupt,
 				pdata->clustered_irq_flags,
 				"matrix-keypad", keypad);
-		if (err) {
+		if (err < 0) {
 			dev_err(&pdev->dev,
 				"Unable to acquire clustered interrupt\n");
 			goto err_free_rows;
 		}
 	} else {
 		for (i =3D 0; i < pdata->num_row_gpios; i++) {
-			err =3D request_irq(gpio_to_irq(pdata->row_gpios[i]),
+			err =3D request_any_context_irq(
+					gpio_to_irq(pdata->row_gpios[i]),
 					matrix_keypad_interrupt,
 					IRQF_TRIGGER_RISING |
 					IRQF_TRIGGER_FALLING,
 					"matrix-keypad", keypad);
-			if (err) {
+			if (err < 0) {
 				dev_err(&pdev->dev,
 					"Unable to acquire interrupt for GPIO line %i\n",
 					pdata->row_gpios[i]);
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
