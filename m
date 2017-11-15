From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 devices
Date: Wed, 15 Nov 2017 09:35:29 +0100
Message-ID: <20171115083529.jmlpcj4td4evj3xl@pali>
References: <20171115063404.10066-1-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:53464 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752853AbdKOIfd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Nov 2017 03:35:33 -0500
Content-Disposition: inline
In-Reply-To: <20171115063404.10066-1-aaron.ma@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: masaki.ota@jp.alps.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, Aaron Ma <aaron.ma@canonical.com>

On Wednesday 15 November 2017 14:34:04 Aaron Ma wrote:
> There is a regression of commit 4a646580f793 ("Input: ALPS - fix
> two-finger scroll breakage"), ALPS device fails with log:
> 
> psmouse serio1: alps: Rejected trackstick packet from non DualPoint device
> 
> ALPS device with id "74 03 28" report OTP[0] data 0xCE after
> commit 4a646580f793, after restore the OTP reading order,
> it becomes to 0x10 as before and reports the right flag.
> 
> Fixes: 4a646580f793 ("Input: ALPS - fix two-finger scroll breakage")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/input/mouse/alps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 579b899add26..c59b8f7ca2fc 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2562,8 +2562,8 @@ static int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
>  
>  	memset(otp, 0, sizeof(otp));
>  
> -	if (alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]) ||
> -	    alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]))
> +	if (alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]) ||
> +	    alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]))
>  		return -1;
>  
>  	alps_update_device_area_ss4_v2(otp, priv);

Masaki Ota, please look at this patch as it partially revert your commit
4a646580f793 ("Input: ALPS - fix two-finger scroll breakage"). Something
smells here.

-- 
Pali Rohár
pali.rohar@gmail.com
