From: Tobias Doerffel <tobias.doerffel@gmail.com>
Subject: [PATCH] Input: matrix_keypad - depend on CONFIG_PM_SLEEP for suspend/resume functions
Date: Sun, 30 May 2010 00:23:55 +0200
Message-ID: <1275171835-13246-1-git-send-email-tobias.doerffel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46]:46613 "EHLO
	jack.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668Ab0E2WuQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 May 2010 18:50:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Tobias Doerffel <tobias.doerffel@gmail.com>

When building a kernel with CONFIG_PM=3Dy but neither suspend nor
hibernate support, the compiler complains about the static functions
matrix_keypad_suspend() and matrix_keypad_resume() not being used:

drivers/input/keyboard/matrix_keypad.c:219:12: warning: =E2=80=98matrix=
_keypad_suspend=E2=80=99 defined but not used
drivers/input/keyboard/matrix_keypad.c:242:12: warning: =E2=80=98matrix=
_keypad_resume=E2=80=99 defined but not used

Depending on CONFIG_PM_SLEEP rather than CONFIG_PM fixes the issue.

Signed-off-by: Tobias Doerffel <tobias.doerffel@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/key=
board/matrix_keypad.c
index b443e08..139a3bc 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -215,7 +215,7 @@ static void matrix_keypad_stop(struct input_dev *de=
v)
 	disable_row_irqs(keypad);
 }
=20
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int matrix_keypad_suspend(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -440,7 +440,7 @@ static struct platform_driver matrix_keypad_driver =
=3D {
 	.driver		=3D {
 		.name	=3D "matrix-keypad",
 		.owner	=3D THIS_MODULE,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 		.pm	=3D &matrix_keypad_pm_ops,
 #endif
 	},
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
