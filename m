From: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors@gmail.com>
Subject: [PATCH] keyboard: adp5589-keys: Attach device to the gpio chip
Date: Thu, 10 Sep 2015 16:07:08 +0200
Message-ID: <1441894028.18532.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35992 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbbIJOHM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 10:07:12 -0400
Received: by lbcao8 with SMTP id ao8so23707030lbc.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2015 07:07:11 -0700 (PDT)
Received: from lillan.local ([193.15.208.193])
        by smtp.gmail.com with ESMTPSA id h10sm863017lam.29.2015.09.10.07.07.08
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2015 07:07:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Currently the device struct is not attached to the gpio chip struct.

This causes trouble if the GPIO pins are used in a device tree, because
the device struct is heavily used during gpio chip lookup and matching.

Signed-off-by: Richard R=C3=B6jfors <richard.rojfors@gmail.com>
---
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyb=
oard/adp5589-keys.c
index 4d446d5..63a8c85 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -522,6 +522,7 @@ static int adp5589_gpio_add(struct adp5589_kpad *kp=
ad)
 	kpad->gc.base =3D gpio_data->gpio_start;
 	kpad->gc.label =3D kpad->client->name;
 	kpad->gc.owner =3D THIS_MODULE;
+	kpad->gc.dev =3D dev;
=20
 	mutex_init(&kpad->gpio_lock);
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
