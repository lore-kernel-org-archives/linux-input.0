From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH] Input: gpio-keys - fix possible NULL pointer dereference
Date: Wed, 30 Jul 2008 15:27:10 +0200
Message-ID: <1217424431-8732-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail37.messagelabs.com ([216.82.244.163]:54535 "EHLO
	mail37.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYG3N10 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2008 09:27:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>

bdata->button is used in gpio_check_button but never initialized.  Havi=
ng a
device with debounce_interval !=3D 0 without this patch resulted on an =
oops on
my machine.

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/keyboard/gpio_keys.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboar=
d/gpio_keys.c
index be58730..1a92f4b 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -118,6 +118,7 @@ static int __devinit gpio_keys_probe(struct platfor=
m_device *pdev)
 		unsigned int type =3D button->type ?: EV_KEY;
=20
 		bdata->input =3D input;
+		bdata->button =3D button;
 		setup_timer(&bdata->timer,
 			    gpio_check_button, (unsigned long)bdata);
=20
--=20
1.5.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
