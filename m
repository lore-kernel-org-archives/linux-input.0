Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418647;
	b=FDRrGFb4/nCkPIDZ3U7uDe6ASXRjwLU4gA8jHozfyntWw/cXung87nWYe5pOTmGenBi/
	 x3dtsmEKG6FmgPmStDOUBfkqVn4VXuQZfMvd9/V8Z4goOBL2burTDHldZFJfCM4iBBfR7
	 dh8q9XIwJGbYBRt5FHCUiDSTgR9nxyNbR9afXiz4ovcHEQSOabMp+TAb7MTD9Bt3C6CCN
	 P3jEXiHlq0SX888SCW20U3kKrz88eg5d9JJxVGWhTsWLVs2p8veX3CVdin0OcvFV3j4hr
	 pizliJDLOlemsals4n1Net/AsEeOcOFgs3cezV+jF2GSob9xjOTIIQLMHAzqE4gUQbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418647;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=2yMqdEoLkLNHpg5NeFYoX3pGkM6E5xBE6BECcgZwEdg=;
	b=0vGVrLQnFrTH/nOGl89UUjdjVYAWaQwfCXrxMTLukpjB8fOXJuTUPOIGoeNVn8oHM6fg
	 zI+gNK//VAcjl30+kxE3eXib5SJq0joLBDzmNY2o3rVzIrkHMaRszXVyvhxczbhMIiM8s
	 7MOu1YQIx/Dfyl7OCpwRbfTTypwfstGOp80ROH3F3rtvnwK9VA45sQf5D4s+dedd7SERS
	 YDmhGFiafICG0BD7najD3KDFhc+BJzaT3jqyUPRagBxzPVxc5nz8jwGz5gg9+ioLceElc
	 BEIkR1edPAkdgR+o6zp/dvH/OpGaCTWPv0x20a7xmoK8al5RVHAQj6uREWmXW/GeKYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=U7pJWFaI;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE7606A31C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 17:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDE7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=U7pJWFaI
DKIM2-Signature:  i=1; m=1; t=1794418644;
 mf=PGhlbnJpLm9tbWVyQGdteC5uZXQ+;
 rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.net;
 s=s31663417:rsa-sha256:ocvZDwikfcPImYPY0/0TsQIyoRBF
   UmqiHwyLP8mz3COCvl0SzoXZXzdlqHUIW8l4RBYoDCrguiLfNSG9w5+TjwjByo2AiwODWzjIg/X
   4+wDcXGtQw+Mmy7XL2L0Jj+9KG48CxyIy8A2+ANSF+NLpVyoybIQbrr3SBjqlE5XPR5Cg2m5qeH
   rUgIAPEHJ0rHENQL0UWHdza5fO6gZqumTi0ND4FrARWfDBC63yANu8XAVefejBG86vaQeVE6wgB
   ohTPHu3N/6sRvIGWvcH95Td8MgkMVS6J7VcL8l/z9eiGJukVa4VnEos2OwGLe3enslTU/jPDUFH
   iIcT/yRrqSEaqw==;
Message-Instance:  m=1;
 h=sha256:
   W4WlkJs90i3oV8rLKFApfrtCsVqnKuQm9dH3jIoUU1I=:
   UTmggoAckeQCnVXc4lfzfycgcQZ+ZkbEk0rr4zsrqyM=,
  sha512:
   gVpLHpifT52762yEkVThOtXeD0QrBkbhfl4t3H/HQGaXXsKyUfUWdk1sd5Ae6yFd7YCu9/LZJPOeGL3O1TmyGA==:
   kf+WqYgojw8076RQins9RpH7NR8YSAVzjbzRntyDYkMDNHy9E2jcXxAO3c0BBd+TBCyKaoogXOeOAnRYhCiC+A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794418644; x=1795023444; i=henri.ommer@gmx.net;
	bh=2yMqdEoLkLNHpg5NeFYoX3pGkM6E5xBE6BECcgZwEdg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U7pJWFaItD4SAm2DdWPTD2DHIEhMfK7nBINY8x3xfjtPPNfhi5cyXHHUi3e4Eb8Y
	 kI1jZ56h7OoIzwRzRMbgNTeizZQpkQF9ab87Ypw7dwNRKq00iJDRRjvxFLIHCndCd
	 1FbhVHUCOOsEKbnYzxo+X2mgx4SFu406zqZQZwFPTxXdry+k8oRGpTFrrGuVXo/+h
	 HVs4t0AHQ4ms8KjrVynRkFc+e317YGho4bYjlU6lJQtMQaBQvV3JtjOHDz2u93heX
	 Y6eU5o28mSLzMcGQKjhOlWlNuh5IE+KtcBRFs3y7hI3D2o1j5n9ysVSlj+TgS7IVG
	 XhU5lmAwrWA1pxP3NA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1x8JWp2kyh-00JeHB; Wed, 11
 Nov 2026 18:37:24 +0100
From: Henri Ommer <henri.ommer@gmx.net>
To: linux-input@vger.kernel.org
Cc: phone-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henri Ommer <henri.ommer@gmx.net>
Subject: [PATCH 1/2] input: himax_hx83112b: Add hx83102d support
Date: Wed, 11 Nov 2026 18:37:22 +0100
Message-ID: <20261111173722.5698-1-henri.ommer@gmx.net>
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
X-Provags-ID: V03:K1:ML0duLfNClEioaQmtFk4hma/4ioxyVk+xwn4h55cZ1C0geXVw3t
 zqpSeHuOhxgBlZ+rI3qg2nhkqRMvN3330PPZ1k8cZjqzXYBJbMdky80P0zoh1PL7jn/QObA
 Pml0mqWEPOSGrx0c7LuSggyta7okpZlf1+D52wLH75XJLaohdfaVQEcIfdJCsYto+JUWprR
 B3S4GGSh1gRTI8GYwGCWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mI9b0dwUc88=;h9TQHxcatvF2VYNj9DPdbvNkAnF
 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
 8i9TtTp7vUC/5ueFGSJIPm50

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

