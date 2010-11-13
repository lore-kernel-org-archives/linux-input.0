From: kevin granade <kevin.granade@gmail.com>
Subject: [RFC PATCH] input: wacom - Add support for Bamboo Pen CTL460
Date: Sat, 13 Nov 2010 14:22:16 -0600
Message-ID: <AANLkTimCp=jt8J6S14Woh_BuNdvHxdDGZY8KEp3zty5m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42641 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab0KMUWi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Nov 2010 15:22:38 -0500
Received: by wwb29 with SMTP id 29so18412wwb.1
        for <linux-input@vger.kernel.org>; Sat, 13 Nov 2010 12:22:37 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, pingc@wacom.com, chris@cnpbagwell.com

From: Kevin Granade <kevin.granade@gmail.com>

Add support for Bamboo Pen CTL460 to wacom tablet driver.

I've been able to get working input with a CTL460 through X, though
I'm not sure if the settings are correct and there are a few issues.
How does one determine these numbers?

I tried 7336 and 4572 for x and y resolution based on the advertised
lpi of the device multiplied by the dimensions of the active area, but
these seemed to be off by about half, so I tried setting the
resolution numbers to match the other Bamboo devices, which seems to
work ok.

I'm not seeing pressure sensitivity in gimp with a pressure levels
setting of either 511 or 1023, is there additional X or gimp setup I
need to do to enable this?

I haven't been able to determine what the "distance" setting should be
other than copying the number used by the other devices, is this
correct?.

The last nit is that I'm not sure how this device fits into the naming
scheme for the similar tablets, would it be something like "Wacom
Bamboo 2FG 4x6", or should it reflect the fact that it is pen-only
somehow?

Signed-off-by: Kevin Granade <kevin.granade@gmail.com>
---
 drivers/input/tablet/wacom_wac.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index b3252ef..aa08ec5 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1436,6 +1436,8 @@ static struct wacom_features wacom_features_0xD2 =
        { "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,
9200, 1023, 63, BAMBOO_PT };
 static struct wacom_features wacom_features_0xD3 =
        { "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648,
13530, 1023, 63, BAMBOO_PT };
+static const struct wacom_features wacom_features_0xD4 =
+       { "Wacom Bamboo Pen CTL460", WACOM_PKGLEN_BBFUN,  14720,
9200, 1023, 63, BAMBOO_PT };

 #define USB_DEVICE_WACOM(prod)                                 \
        USB_DEVICE(USB_VENDOR_ID_WACOM, prod),                  \
@@ -1504,6 +1506,7 @@ const struct usb_device_id wacom_ids[] = {
        { USB_DEVICE_WACOM(0xD1) },
        { USB_DEVICE_WACOM(0xD2) },
        { USB_DEVICE_WACOM(0xD3) },
+       { USB_DEVICE_WACOM(0xD4) },
        { USB_DEVICE_WACOM(0xF0) },
        { USB_DEVICE_WACOM(0xCC) },
        { USB_DEVICE_WACOM(0x90) },
--
1.5.6.5
