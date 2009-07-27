From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 13/22] Input: Add support for the WM831x ON pin
Date: Mon, 27 Jul 2009 08:38:05 -0700
Message-ID: <20090727161151.A9D36526EC9@mailhub.coreip.homeip.net>
References: <20090727134527.GA12849@rakim.wolfsonmicro.main> <1248702372-29534-13-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:55296 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbZG0PiM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2009 11:38:12 -0400
Content-Disposition: inline
In-Reply-To: <1248702372-29534-13-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Mark,

On Mon, Jul 27, 2009 at 02:46:03PM +0100, Mark Brown wrote:
> --- /dev/null
> +++ b/drivers/input/misc/wm831x-on.c
> @@ -0,0 +1,163 @@
> +/**
> + * wm831x-on.c - WM831X ON pind river
> + *

"Pind river"? ;)

> +
> +static irqreturn_t wm831x_on_irq(int irq, void *data)
> +{
> +	struct wm831x_on *wm831x_on = data;
> +
> +	schedule_work(&wm831x_on->work.work);

schedule_delayed_work(&wm831x_on->work, 0); - I prefer not to expose
delayed work implementation details.

Other than that:

	Acked-by: Dmitry Torokhov <dtor@mail.ru>

Freel free to push this with the rest of the series. If that does not
work out let me know and I will get this driver into my tree.

Thanks!

-- 
Dmitry
