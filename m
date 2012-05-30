From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] ads7846: enable usage of internal vref for AD7873
Date: Wed, 30 May 2012 14:45:19 +0200
Message-ID: <4FC6165F.3060603@analog.com>
References: <4FC4E9B7.7050100@tqsc.de>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:58054
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753629Ab2E3Mpu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 May 2012 08:45:50 -0400
In-Reply-To: <4FC4E9B7.7050100@tqsc.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Niebel <list-09_linux_input@tqsc.de>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 05/29/2012 05:22 PM, Markus Niebel wrote:
> Touchscreen samples are taken in differential mode.
> Therefore an external reference is not needed.
> When working with internal vref disabling vref after
> every touchscreen sample leads to settling effects in sampling
> and errors in position data.
>
> This patch disables the internal vref only if keep_vref_on us
> is not set in platform_data.
>
> Tested on i.MX35 with costum board
>
>
> Signed-off-by: Markus Niebel<Markus.Niebel@tqs.de>
> ---
>   drivers/input/touchscreen/ads7846.c |    9 ++++-----
>   1 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index f02028e..b271633 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1001,15 +1001,14 @@ static void __devinit ads7846_setup_spi_msg(struct ads7846 *ts,
>          struct ads7846_packet *packet = ts->packet;
>          int vref = pdata->keep_vref_on;
>
> -       if (ts->model == 7873) {
> +       if (ts->model == 7873)
>                  /*
>                   * The AD7873 is almost identical to the ADS7846
> -                * keep VREF off during differential/ratiometric
> -                * conversion modes.
> +                * set VREF off during differential/ratiometric
> +                * conversion modes if keep_vref_on is not set.
> +                * TODO: does keep_vref_on collide with usage of external vref?
>                   */
>                  ts->model = 7846;
> -               vref = 0;
> -       }

I would scrap this section from ads7846_setup_spi_msg() completely
and force ts->model to 7846 in ads7846_probe() when 7873 is specified.

>
>          ts->msg_count = 1;
>          spi_message_init(m);
> --
> 1.7.0.4
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


