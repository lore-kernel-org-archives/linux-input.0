From: =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>
Subject: [PATCH 2/3] Input: rotary_encoder - fix device tree error handling
Date: Fri, 15 Jan 2016 22:33:49 +0200
Message-ID: <1452890030-23316-2-git-send-email-timo.teras@iki.fi>
References: <1452890030-23316-1-git-send-email-timo.teras@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:33903 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbcAOUd5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 15:33:57 -0500
Received: by mail-lb0-f196.google.com with SMTP id oe3so5186444lbb.1
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 12:33:56 -0800 (PST)
In-Reply-To: <1452890030-23316-1-git-send-email-timo.teras@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>

of_get_gpio_flags() can fail, so pass through the error code
properly. Most important use case is when it returns EPROBE_DEFER
so that the probe gets called again later.

Signed-off-by: Timo Ter=C3=A4s <timo.teras@iki.fi>
---
 drivers/input/misc/rotary_encoder.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 0f23d32..156f40f 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -206,7 +206,7 @@ static struct rotary_encoder_platform_data *rotary_=
encoder_parse_dt(struct devic
 	struct device_node *np =3D dev->of_node;
 	struct rotary_encoder_platform_data *pdata;
 	enum of_gpio_flags flags;
-	int error;
+	int ret;
=20
 	if (!of_id || !np)
 		return NULL;
@@ -219,19 +219,25 @@ static struct rotary_encoder_platform_data *rotar=
y_encoder_parse_dt(struct devic
 	of_property_read_u32(np, "rotary-encoder,steps", &pdata->steps);
 	of_property_read_u32(np, "linux,axis", &pdata->axis);
=20
-	pdata->gpio_a =3D of_get_gpio_flags(np, 0, &flags);
+	ret =3D of_get_gpio_flags(np, 0, &flags);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	pdata->gpio_a =3D ret;
 	pdata->inverted_a =3D flags & OF_GPIO_ACTIVE_LOW;
=20
-	pdata->gpio_b =3D of_get_gpio_flags(np, 1, &flags);
+	ret =3D of_get_gpio_flags(np, 1, &flags);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	pdata->gpio_b =3D ret;
 	pdata->inverted_b =3D flags & OF_GPIO_ACTIVE_LOW;
=20
 	pdata->relative_axis =3D
 		of_property_read_bool(np, "rotary-encoder,relative-axis");
 	pdata->rollover =3D of_property_read_bool(np, "rotary-encoder,rollove=
r");
=20
-	error =3D of_property_read_u32(np, "rotary-encoder,steps-per-period",
-				     &pdata->steps_per_period);
-	if (error) {
+	ret =3D of_property_read_u32(np, "rotary-encoder,steps-per-period",
+				   &pdata->steps_per_period);
+	if (ret) {
 		/*
 		 * The 'half-period' property has been deprecated, you must use
 		 * 'steps-per-period' and set an appropriate value, but we still
--=20
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
