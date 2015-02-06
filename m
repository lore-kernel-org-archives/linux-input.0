From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: da9052_tsi: remove unnecessary worker
Date: Fri, 6 Feb 2015 15:24:48 -0800
Message-ID: <20150206232448.GC29225@dtor-ws>
References: <1421595368-31203-1-git-send-email-m.grzeschik@pengutronix.de>
 <1423220748-21778-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:45904 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758240AbbBFXYx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 18:24:53 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so5751808igb.0
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2015 15:24:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423220748-21778-1-git-send-email-m.grzeschik@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-input@vger.kernel.org, support.opensource@diasemi.com, kernel@pengutronix.de

On Fri, Feb 06, 2015 at 12:05:48PM +0100, Michael Grzeschik wrote:
> With the datardy irq we get the information if the
> pen got pulled from the screen. This patch changes
> the irq by checking this condition every time instead
> of triggering the worker.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> v1 -> v2: - removed adc_on variable
> 	  - added locking for irq switch
> 	  - event reporting in ts_read and irq switchover in datardy_irq
>  drivers/input/touchscreen/da9052_tsi.c | 119 +++++++++++++++++----------------
>  1 file changed, 62 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
> index 5a013bb..c28cfee 100644
> --- a/drivers/input/touchscreen/da9052_tsi.c
> +++ b/drivers/input/touchscreen/da9052_tsi.c
> @@ -22,19 +22,24 @@
>  
>  #define TSI_PEN_DOWN_STATUS 0x40
>  
> +#define TSI_PEN_UP		1
> +
>  struct da9052_tsi {
>  	struct da9052 *da9052;
>  	struct input_dev *dev;
> -	struct delayed_work ts_pen_work;
>  	struct mutex mutex;
> +	spinlock_t *lock;

I am gonna go out on a limb and say that you did not test it.

Thanks.

-- 
Dmitry
