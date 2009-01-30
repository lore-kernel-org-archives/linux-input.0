From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input, blackfin: ! has a higher priority than >
Date: Thu, 29 Jan 2009 23:10:00 -0800
Message-ID: <20090130070959.GA3481@dtor-d630.eng.vmware.com>
References: <4980DAB1.6090202@gmail.com> <8A42379416420646B9BFAC9682273B6D0844D6E2@limkexm3.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:61077 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZA3HKt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2009 02:10:49 -0500
Received: by qw-out-2122.google.com with SMTP id 3so170802qwe.37
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2009 23:10:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8A42379416420646B9BFAC9682273B6D0844D6E2@limkexm3.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Roel Kluin <roel.kluin@gmail.com>, cooloney@kernel.org, linux-input@vger.kernel.org

On Thu, Jan 29, 2009 at 09:08:45AM -0000, Hennerich, Michael wrote:
> 
> 
> >From: Roel Kluin [mailto:roel.kluin@gmail.com]
> >
> >! has a higher priority than >
> >
> >Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> >---
> >diff --git a/drivers/input/keyboard/bf54x-keys.c
> >b/drivers/input/keyboard/bf54x-keys.c
> >index 1928401..ee855c5 100644
> >--- a/drivers/input/keyboard/bf54x-keys.c
> >+++ b/drivers/input/keyboard/bf54x-keys.c
> >@@ -209,8 +209,8 @@ static int __devinit bfin_kpad_probe(struct
> >platform_device *pdev)
> > 		goto out;
> > 	}
> >
> >-	if (!pdata->debounce_time || !pdata->debounce_time > MAX_MULT ||
> >-	    !pdata->coldrive_time || !pdata->coldrive_time > MAX_MULT) {
> >+	if (!pdata->debounce_time || pdata->debounce_time > MAX_MULT ||
> >+	    !pdata->coldrive_time || pdata->coldrive_time > MAX_MULT) {
> > 		printk(KERN_ERR DRV_NAME
> > 			": Invalid Debounce/Columdrive Time from
> pdata\n");
> > 		bfin_write_KPAD_MSEL(0xFF0);	/* Default MSEL	*/
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> 

Applied to 'for-linus', thanks!

-- 
Dmitry
