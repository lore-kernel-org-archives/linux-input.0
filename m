From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: input: wacom - add new Bamboo PT
Date: Tue, 7 Dec 2010 13:51:22 -0800
Message-ID: <AANLkTinBDexTwwEQiaR6mjYEBPFWZiwiYXaM=3Jy50i4@mail.gmail.com>
References: <AANLkTikLXD+4wMY=UzDjVsDy7joUFR7O431gK02c-ZSt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:56294 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab0LGVv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Dec 2010 16:51:26 -0500
Received: by eyg5 with SMTP id 5so461913eyg.2
        for <linux-input@vger.kernel.org>; Tue, 07 Dec 2010 13:51:24 -0800 (PST)
In-Reply-To: <AANLkTikLXD+4wMY=UzDjVsDy7joUFR7O431gK02c-ZSt@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Favux ..." <favux.is@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Dec 7, 2010 at 1:29 PM, Favux ... <favux.is@gmail.com> wrote:
> Adds new Bamboo Pen & Touch model:
>
> Bamboo P & T Special Edition Medium =A0 =A0 =A0(CTH661/L; =A0 Product=
 ID =3D 0xdB)
>
> Signed-off-by: David Foley <favux.is@gmail.com>

Acked-by: Ping Cheng <pingc@wacom.com>

Ping

-----------------

=46rom: David Foley <favux.is@gmail.com>
Date: Tue, 7 Dec 2010 14:50:36 -0600
Subject: [PATCH 4/4] input: wacom - add new Bamboo PT

Adds new Bamboo Pen & Touch model.

Tested-by: Tobias Verbeke <tobias.verbeke@gmail.com>
Signed-off-by: David Foley <favux.is@gmail.com>
---
 drivers/input/tablet/wacom_wac.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wa=
com_wac.c
index db747e4..4852b44 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1440,6 +1440,8 @@ static struct wacom_features wacom_features_0xD8 =
=3D
 	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13530,
1023, 63, BAMBOO_PT };
 static struct wacom_features wacom_features_0xDA =3D
 	{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN,  14720,  9200,
1023, 63, BAMBOO_PT };
+static struct wacom_features wacom_features_0xDB =3D
+	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13530,
1023, 63, BAMBOO_PT };

 #define USB_DEVICE_WACOM(prod)					\
 	USB_DEVICE(USB_VENDOR_ID_WACOM, prod),			\
@@ -1510,6 +1512,7 @@ const struct usb_device_id wacom_ids[] =3D {
 	{ USB_DEVICE_WACOM(0xD3) },
 	{ USB_DEVICE_WACOM(0xD8) },
 	{ USB_DEVICE_WACOM(0xDA) },
+	{ USB_DEVICE_WACOM(0xDB) },
 	{ USB_DEVICE_WACOM(0xF0) },
 	{ USB_DEVICE_WACOM(0xCC) },
 	{ USB_DEVICE_WACOM(0x90) },
--=20
1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
