From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] Input, blackfin: ! has a higher priority than >
Date: Thu, 29 Jan 2009 09:08:45 -0000
Message-ID: <8A42379416420646B9BFAC9682273B6D0844D6E2@limkexm3.ad.analog.com>
References: <4980DAB1.6090202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:57574 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbZA2JSk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2009 04:18:40 -0500
Content-class: urn:content-classes:message
In-Reply-To: <4980DAB1.6090202@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, michael.hennerich@analog.com, cooloney@kernel.org
Cc: linux-input@vger.kernel.org



>From: Roel Kluin [mailto:roel.kluin@gmail.com]
>
>! has a higher priority than >
>
>Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>---
>diff --git a/drivers/input/keyboard/bf54x-keys.c
>b/drivers/input/keyboard/bf54x-keys.c
>index 1928401..ee855c5 100644
>--- a/drivers/input/keyboard/bf54x-keys.c
>+++ b/drivers/input/keyboard/bf54x-keys.c
>@@ -209,8 +209,8 @@ static int __devinit bfin_kpad_probe(struct
>platform_device *pdev)
> 		goto out;
> 	}
>
>-	if (!pdata->debounce_time || !pdata->debounce_time > MAX_MULT ||
>-	    !pdata->coldrive_time || !pdata->coldrive_time > MAX_MULT) {
>+	if (!pdata->debounce_time || pdata->debounce_time > MAX_MULT ||
>+	    !pdata->coldrive_time || pdata->coldrive_time > MAX_MULT) {
> 		printk(KERN_ERR DRV_NAME
> 			": Invalid Debounce/Columdrive Time from
pdata\n");
> 		bfin_write_KPAD_MSEL(0xFF0);	/* Default MSEL	*/

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Thanks,
Michael
