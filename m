From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Thu, 14 Feb 2008 18:10:19 +0300
Message-ID: <bc64b4640802140710n697ce2f4l23832bba073169c8@mail.gmail.com>
References: <20080213140648.GD31617@rakim.wolfsonmicro.main>
	 <1202912042-2631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:13437 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933720AbYBNPKW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Feb 2008 10:10:22 -0500
Received: by py-out-1112.google.com with SMTP id u52so448766pyb.10
        for <linux-input@vger.kernel.org>; Thu, 14 Feb 2008 07:10:21 -0800 (PST)
In-Reply-To: <1202912042-2631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Mike Arthur <mike.arthur@wolfsonmicro.com>, Stanley Cai <stanley.cai@intel.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Pete MacKay <linux01@architechnical.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>

Hi,

2008/2/13, Mark Brown <broonie@opensource.wolfsonmicro.com>:
>  diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
>  new file mode 100644
>  index 0000000..f0d9fc0
>  --- /dev/null
>  +++ b/include/linux/wm97xx.h
>  @@ -0,0 +1,308 @@

...

>  +#define WM97XX_POLL            0x8000  /* initiate a polling measurement */
>  +#define WM97XX_ADCSEL_X                0x1000  /* x coord measurement */
>  +#define WM97XX_ADCSEL_Y                0x2000  /* y coord measurement */
>  +#define WM97XX_ADCSEL_PRES     0x3000  /* pressure measurement */

shouldn't this be 0x4000 ?

>  +#define WM97XX_ADCSEL_MASK     0x7000
>  +#define WM97XX_COO             0x0800  /* enable coordinate mode */
>  +#define WM97XX_CTC             0x0400  /* enable continuous mode */

-- 
With best wishes
Dmitry
