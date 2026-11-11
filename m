Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422725;
	b=qjkp0Dp70CKrM1H6A9yUqf2Ulp5fTVIdY+J+1JpoI99y4fKRG2dRUEkTvMjBMwxxUkwG
	 IeFhDz89PmZsO0eoTvjy7e1PTLjfq/f7AJK319IXqtOei6nAgcLhYNuM4MJYGlJNradgr
	 8bORMp9EIYvy3dDCne/7fKPaAkJedVyvas5qAX812d4aP7xN1HxB3OpSgc6hUe+X/rkoi
	 cLolI3keCWFx1K5le8LeqnEuIEqQuaCKD8Szk8VYMYEnLmZFnFrG1Zta/727Jiv+xWBu8
	 PVbuTYGwMti3WuT9AOko4G5R8W+3qOch3QpTmE/qWIA0qaez2t3er+/iAqAn4qWPplA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422725;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=2yMqdEoLkLNHpg5NeFYoX3pGkM6E5xBE6BECcgZwEdg=;
	b=MzbEKQSt0h4XmUkr3dMmcEiMIk2ReGH6scRuoggmOHlmrKwN0b6GW6yex3sbnxW0gsZQ
	 goTKQosJB699HqA6c4rdaBsyy0pvc/hKmdSJ5y7JxIsXwSSbkdxcKSmxK6nTIGjh/QlKI
	 JrnK8p9uQvzVOS2JskEUGFZyBUL3IeT+y2vXjRr+4Awwk5NqKm7HQ3j51kNy3O9tlsXfm
	 Xpk92S0EK8aNiHn8LCt+BvSOZCy1/Zg/ncNYKEV5j4Msf4Y/J0Oy2jLqM5xOldPN/ILFn
	 ImowlHNlqAFj22vW6BmHTkApcQF/OP7Idlk6yKNk/cLDopBetH4ncAu4uCE0S/vO8fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=H+q00WEz;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3934606A32A
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 18:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3934606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=H+q00WEz
DKIM2-Signature:  i=1; m=1; t=1794422722;
 mf=PGhlbnJpLm9tbWVyQGdteC5uZXQ+;
 rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.net;
 s=s31663417:rsa-sha256:dPdp+e0jNOSsCsK7SiXpSn8q6fkI
   3f4Flbotd+G+6Yxf2ZhQVQYoAfl2Y5kzAvjJpFYQCrLGEoDD3N26cLyNqNlXEAGD8YtqueeXEKD
   PyDoy6IE4ZuiyzH76z+eX1djD7ALAnZ4T4oXhaF6ynoDEymjCwzCOZ+crMf9/leWCZ5zxvq41OC
   SPUcoBKojuvLrCEYtOEK7BBsZG+jFfOczpJkFMd+wuLAqhTnPwEi+6Xk3t1mxfdESLgnoTPuNBk
   87CQKEpXt0wwWwiO04TiLuwxqZaWqaZm/u0K35I0QG+h5rcIlNUEFYAzINmQCld6SvP/zFGFoxS
   BA+mZW1oF2Uknw==;
Message-Instance:  m=1;
 h=sha256:
   GbwKkVUm442bNApTawxDRWS2epmUS6/FYWubFddHfcM=:
   UTmggoAckeQCnVXc4lfzfycgcQZ+ZkbEk0rr4zsrqyM=,
  sha512:
   A279Ei4m5z4tqPu+UufRysTAIE92VuPzZLjZGZcfEE9lijhBLq4n4aCmFn8Qm3iEuxI+TrHUC02TK9ErwjTubQ==:
   kf+WqYgojw8076RQins9RpH7NR8YSAVzjbzRntyDYkMDNHy9E2jcXxAO3c0BBd+TBCyKaoogXOeOAnRYhCiC+A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794422715; x=1795027515; i=henri.ommer@gmx.net;
	bh=2yMqdEoLkLNHpg5NeFYoX3pGkM6E5xBE6BECcgZwEdg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H+q00WEzp6Eb/FUFJ77AjGxEnsvRr84Hw7j6HsPzvgfXt06LXXyr3uqYdSkeVN5q
	 LjLX1cub2wxnDeduErqQ4Wq8Ib1+PILpZ+AA4f7CkL3dFLrtEUa980JJBd6xB26qr
	 hi9q6ZW6LFjpSZLR0nXZ/UWu7k0Ykm5HErs6d/6dzbXzsJAPbibwqzsuvdcO0TYvq
	 xCM+jm5eqH6/add3h3/ThB+50V0amyJPIrVEWfZhKAELvw7fYvYt6lTONDBh+fL87
	 M5/+21ycVv5CG/CV5WqMxENHEO3pOtT3JfzgIbyS1JwvLjwlDnXONEKwul3+VAssP
	 0lxV+Yz+dqln52nxPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1x01Hi2QCb-00Qeyg; Wed, 11
 Nov 2026 19:45:15 +0100
From: Henri Ommer <henri.ommer@gmx.net>
To: job@noorman.info,
	dmitry.torokhov@gmail.com
Cc: phone-devel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henri Ommer <henri.ommer@gmx.net>
Subject: [PATCH RESEND 1/2] input: himax_hx83112b: Add hx83102d support
Date: Wed, 11 Nov 2026 19:45:12 +0100
Message-ID: <20261111184512.5607-1-henri.ommer@gmx.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d6Vj9h02iqxHr9kGrlacLTxDK7SsdXhEqYQvXy+ZiWdWDhZ/fLM
 NL1RPpGWBiCC0n4GHS/a+FdYUBym6tkk1CNeiZqudzYZOZh142nEX6HGUByyaKlznXDfxH3
 HPzIK7Hqz/XGW2OpIDn2W9Gt8zIrRhCVGRKZIO8SkAshTS9WPkLhhejkkDZ+t2AyPA1qwtk
 yL+10gOP+ykUtDrdZXs9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HqMdl1Ggdek=;2j7inzJTH3jCDJ9YkOfLgFCZ3Lo
 +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
 JsclrXuQ+hfNcD/1lQnggl0hqjQ==

The core functionality of the hx83102d is software-compatible with the hx8=
3112b. As with the hx83112b, firmware flashing is unimplemented.
This commit also adds support for touchscreen chips which do not have a re=
set GPIO, like the hx83102d in the Samsung Galaxy A20e.

Tested on: Samsung Galaxy A20e (SM-A202F)

Signed-off-by: Henri Ommer <henri.ommer@gmx.net>
=2D--
 drivers/input/touchscreen/himax_hx83112b.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/to=
uchscreen/himax_hx83112b.c
index 345ece27fe74..04c9c6aba396 100644
=2D-- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -7,6 +7,9 @@
  * HX83100A support
  * Copyright (C) 2024 Felix Kaechele <felix@kaechele.ca>
  *
+ * HX83102D support
+ * Copyright (C) 2026 Henri Ommer <henri.ommer@gmx.net>
+ *
  * This code is based on "Himax Android Driver Sample Code for QCT platfo=
rm":
  *
  * Copyright (C) 2017 Himax Corporation.
@@ -132,6 +135,14 @@ static int himax_bus_read(struct himax_ts_data *ts, u=
32 address, void *dst,
=20
 static void himax_reset(struct himax_ts_data *ts)
 {
+	/*
+	 * Some versions of himax touchscreen chips do not contain a reset
+	 * GPIO. The downstream driver only resets these chips for firmware
+	 * updates (which aren't implemented in this driver)
+	 */
+	if (!ts->gpiod_rst)
+		return;
+
 	gpiod_set_value_cansleep(ts->gpiod_rst, 1);
=20
 	/* Delay copied from downstream driver */
@@ -349,7 +360,7 @@ static int himax_probe(struct i2c_client *client)
 		return error;
 	}
=20
-	ts->gpiod_rst =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	ts->gpiod_rst =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	error =3D PTR_ERR_OR_ZERO(ts->gpiod_rst);
 	if (error) {
 		dev_err(dev, "Failed to get reset GPIO: %d\n", error);
@@ -399,6 +410,12 @@ static const struct himax_chip hx83100a_chip =3D {
 	.read_events =3D hx83100a_read_events,
 };
=20
+static const struct himax_chip hx83102d_chip =3D {
+	.id =3D 0x83102d,
+	.check_id =3D himax_check_product_id,
+	.read_events =3D himax_read_events,
+};
+
 static const struct himax_chip hx83112b_chip =3D {
 	.id =3D 0x83112b,
 	.check_id =3D himax_check_product_id,
@@ -407,6 +424,7 @@ static const struct himax_chip hx83112b_chip =3D {
=20
 static const struct i2c_device_id himax_ts_id[] =3D {
 	{ .name =3D "hx83100a", .driver_data =3D (kernel_ulong_t)&hx83100a_chip =
},
+	{ .name =3D "hx83102d", .driver_data =3D (kernel_ulong_t)&hx83102d_chip =
},
 	{ .name =3D "hx83112b", .driver_data =3D (kernel_ulong_t)&hx83112b_chip =
},
 	{ /* sentinel */ }
 };
@@ -415,6 +433,7 @@ MODULE_DEVICE_TABLE(i2c, himax_ts_id);
 #ifdef CONFIG_OF
 static const struct of_device_id himax_of_match[] =3D {
 	{ .compatible =3D "himax,hx83100a", .data =3D &hx83100a_chip },
+	{ .compatible =3D "himax,hx83102d", .data =3D &hx83102d_chip },
 	{ .compatible =3D "himax,hx83112b", .data =3D &hx83112b_chip },
 	{ /* sentinel */ }
 };
=2D-=20
2.56.0

