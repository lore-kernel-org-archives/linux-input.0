From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 1/3] Input: adp5589-keys: handle i2c errors on the irq handler
Date: Tue, 21 Apr 2015 11:21:28 -0300
Message-ID: <1429626090-29022-2-git-send-email-guido@vanguardiasur.com.ar>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34235 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbbDUOVm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 10:21:42 -0400
Received: by qgfi89 with SMTP id i89so68794744qgf.1
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2015 07:21:41 -0700 (PDT)
In-Reply-To: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

Bail out if reading the status register fails, otherwise we'll carry
on with a negative error code as if it were read from the keypad, and
falsely report events or errors.

=46ixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad Deco=
der and I/O Expander')
Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 drivers/input/keyboard/adp5589-keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyb=
oard/adp5589-keys.c
index a452677..19edd2d 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -622,6 +622,9 @@ static irqreturn_t adp5589_irq(int irq, void *handl=
e)
=20
 	status =3D adp5589_read(client, ADP5589_5_INT_STATUS);
=20
+	if (status < 0)
+		return IRQ_HANDLED;
+
 	if (status & OVRFLOW_INT)	/* Unlikely and should never happen */
 		dev_err(&client->dev, "Event Overflow Error\n");
=20
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
