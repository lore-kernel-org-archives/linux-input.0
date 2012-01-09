From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>
Subject: [PATCH 1/2] input: adp5588 - add support for gpio names
Date: Mon,  9 Jan 2012 14:15:26 -0500
Message-ID: <1326136527-31447-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52065 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932792Ab2AITPg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 14:15:36 -0500
Received: by qcqz2 with SMTP id z2so2332246qcq.19
        for <linux-input@vger.kernel.org>; Mon, 09 Jan 2012 11:15:35 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Michael.Hennerich@analog.com, =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>


Signed-off-by: Jean-Fran=C3=A7ois Dagenais <jeff.dagenais@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/keyboard/adp5588-keys.c |    1 +
 include/linux/i2c/adp5588.h           |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyb=
oard/adp5588-keys.c
index e34eeb8..6412ced 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -197,6 +197,7 @@ static int __devinit adp5588_gpio_add(struct adp558=
8_kpad *kpad)
 	kpad->gc.base =3D gpio_data->gpio_start;
 	kpad->gc.label =3D kpad->client->name;
 	kpad->gc.owner =3D THIS_MODULE;
+	kpad->gc.names =3D gpio_data->names;
=20
 	mutex_init(&kpad->gpio_lock);
=20
diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
index cec17cf..d8341cb 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -157,6 +157,7 @@ struct i2c_client; /* forward declaration */
=20
 struct adp5588_gpio_platform_data {
 	int gpio_start;		/* GPIO Chip base # */
+	const char *const *names;
 	unsigned irq_base;	/* interrupt base # */
 	unsigned pullup_dis_mask; /* Pull-Up Disable Mask */
 	int	(*setup)(struct i2c_client *client,
--=20
1.7.8.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
