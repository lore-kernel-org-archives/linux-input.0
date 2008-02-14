From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Thu, 14 Feb 2008 15:55:43 +0000
Message-ID: <20080214155542.GA10009@rakim.wolfsonmicro.main>
References: <20080213140648.GD31617@rakim.wolfsonmicro.main> <1202912042-2631-1-git-send-email-broonie@opensource.wolfsonmicro.com> <bc64b4640802140710n697ce2f4l23832bba073169c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56310 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753256AbYBNPzp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Feb 2008 10:55:45 -0500
Content-Disposition: inline
In-Reply-To: <bc64b4640802140710n697ce2f4l23832bba073169c8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry <dbaryshkov@gmail.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Mike Arthur <mike.arthur@wolfsonmicro.com>, Stanley Cai <stanley.cai@intel.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Pete MacKay <linux01@architechnical.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>

On Thu, Feb 14, 2008 at 06:10:19PM +0300, Dmitry wrote:
> 2008/2/13, Mark Brown <broonie@opensource.wolfsonmicro.com>:

> >  +#define WM97XX_ADCSEL_X                0x1000  /* x coord measurement */
> >  +#define WM97XX_ADCSEL_Y                0x2000  /* y coord measurement */
> >  +#define WM97XX_ADCSEL_PRES     0x3000  /* pressure measurement */

> shouldn't this be 0x4000 ?

No, these are an enumeration on the chip rather than a bitmask.
