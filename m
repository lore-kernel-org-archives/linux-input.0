From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>
Subject: [PATCH 2/2] gpio: adp5588 - add support for gpio names
Date: Mon,  9 Jan 2012 14:15:27 -0500
Message-ID: <1326136527-31447-2-git-send-email-jeff.dagenais@gmail.com>
References: <1326136527-31447-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52065 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932792Ab2AITPh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 14:15:37 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so2332246qcq.19
        for <linux-input@vger.kernel.org>; Mon, 09 Jan 2012 11:15:37 -0800 (PST)
In-Reply-To: <1326136527-31447-1-git-send-email-jeff.dagenais@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Michael.Hennerich@analog.com, =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>

follows the commit in input, which already modified the
common header for adp5588

Signed-off-by: Jean-Fran=C3=A7ois Dagenais <jeff.dagenais@gmail.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/gpio/gpio-adp5588.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index 3525ad9..3122713 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -384,6 +384,7 @@ static int __devinit adp5588_gpio_probe(struct i2c_=
client *client,
 	gc->ngpio =3D ADP5588_MAXGPIO;
 	gc->label =3D client->name;
 	gc->owner =3D THIS_MODULE;
+	gc->names =3D pdata->names;
=20
 	mutex_init(&dev->lock);
=20
--=20
1.7.8.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
