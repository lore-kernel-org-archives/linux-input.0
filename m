From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH] Input: gpio-keys - make gpio_keys_device_driver static
Date: Wed, 30 Jul 2008 15:27:11 +0200
Message-ID: <1217424431-8732-2-git-send-email-Uwe.Kleine-Koenig@digi.com>
References: <1217424431-8732-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail37.messagelabs.com ([216.82.244.163]:25833 "EHLO
	mail37.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbYG3N10 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2008 09:27:26 -0400
In-Reply-To: <1217424431-8732-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This fixes the sparse warning

	symbol 'gpio_keys_device_driver' was not declared. Should it be static=
?

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
---
 drivers/input/keyboard/gpio_keys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboar=
d/gpio_keys.c
index 1a92f4b..3f48279 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -257,7 +257,7 @@ static int gpio_keys_resume(struct platform_device =
*pdev)
 #define gpio_keys_resume	NULL
 #endif
=20
-struct platform_driver gpio_keys_device_driver =3D {
+static struct platform_driver gpio_keys_device_driver =3D {
 	.probe		=3D gpio_keys_probe,
 	.remove		=3D __devexit_p(gpio_keys_remove),
 	.suspend	=3D gpio_keys_suspend,
--=20
1.5.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
