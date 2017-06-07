From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 1/1] Input: elantech - add Fujitsu Lifebook E546/E557
 to force crc_enabled
Date: Wed, 7 Jun 2017 10:31:22 -0700
Message-ID: <20170607173122.GF13116@dtor-ws>
References: <20170531184942.23214-1-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33017 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdFGRb0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 13:31:26 -0400
Received: by mail-pg0-f67.google.com with SMTP id a70so2022169pge.0
        for <linux-input@vger.kernel.org>; Wed, 07 Jun 2017 10:31:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170531184942.23214-1-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: Arjan Opmeer <arjan@opmeer.net>, linux-input@vger.kernel.org

On Wed, May 31, 2017 at 08:49:42PM +0200, Ulrik De Bie wrote:
> The Lifebook E546 and E557 touchpad were also not functioning and
> worked after running:
> 
>         echo "1" > /sys/devices/platform/i8042/serio2/crc_enabled
> 
> Add them to the list of machines that need this workaround.
> 
> Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
> Reviewed-by: Arjan Opmeer <arjan@opmeer.net>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> The problem was reported by users of those laptops and they confirmed that
> the crc_enabled workaround solved it. They were not able to test the patch
> though so if anyone else here has such a laptop please feel free to test
> the patch !
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index e73d968023f7..f1fa1f172107 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1118,8 +1118,10 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
>   * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
>   * Avatar AVIU-145A2       0x361f00        ?               clickpad
>   * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
> + * Fujitsu LIFEBOOK E546   0x470f00        50, 12, 09      2 hw buttons
>   * Fujitsu LIFEBOOK E547   0x470f00        50, 12, 09      2 hw buttons
>   * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
> + * Fujitsu LIFEBOOK E557   0x570f01        40, 14, 0c      2 hw buttons
>   * Fujitsu T725            0x470f01        05, 12, 09      2 hw buttons
>   * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons (**)
>   * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw buttons
> @@ -1525,6 +1527,13 @@ static const struct dmi_system_id elantech_dmi_force_crc_enabled[] = {
>  		},
>  	},
>  	{
> +		/* Fujitsu LIFEBOOK E546  does not work with crc_enabled == 0 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E546"),
> +		},
> +	},
> +	{
>  		/* Fujitsu LIFEBOOK E547 does not work with crc_enabled == 0 */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> @@ -1546,6 +1555,13 @@ static const struct dmi_system_id elantech_dmi_force_crc_enabled[] = {
>  		},
>  	},
>  	{
> +		/* Fujitsu LIFEBOOK E557 does not work with crc_enabled == 0 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E557"),
> +		},
> +	},
> +	{
>  		/* Fujitsu LIFEBOOK U745 does not work with crc_enabled == 0 */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -- 
> 2.11.0
> 

-- 
Dmitry
