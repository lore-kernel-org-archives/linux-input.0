From: Joonyoung Shim <dofmind@gmail.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - Increase the wait times for
 backup and reset
Date: Mon, 21 Mar 2011 21:11:18 +0900
Message-ID: <AANLkTik2vokDJuUpX8KObztfcjCbH3O7s5XGN3weiubM@mail.gmail.com>
References: <4D821DCF.6090403@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54898 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab1CUMLT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Mar 2011 08:11:19 -0400
Received: by qyk7 with SMTP id 7so2371164qyk.19
        for <linux-input@vger.kernel.org>; Mon, 21 Mar 2011 05:11:18 -0700 (PDT)
In-Reply-To: <4D821DCF.6090403@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi, Iiro.

2011/3/17 Iiro Valkonen <iiro.valkonen@atmel.com>:
> Increase the sleep times after backup and reset, so that we can be su=
re they have been completed even when the mXT cycle time is set to maxi=
mum value (254ms).
>
> Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
> ---
> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input=
/touchscreen/atmel_mxt_ts.c
> index 4012436..f8cd478 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -169,8 +169,8 @@
> =A0/* Define for MXT_GEN_COMMAND */
> =A0#define MXT_BOOT_VALUE =A0 =A0 =A0 =A0 0xa5
> =A0#define MXT_BACKUP_VALUE =A0 =A0 =A0 0x55
> -#define MXT_BACKUP_TIME =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A025 =A0 =A0 =A0=
/* msec */
> -#define MXT_RESET_TIME =A0 =A0 =A0 =A0 65 =A0 =A0 =A0/* msec */
> +#define MXT_BACKUP_TIME =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0270 =A0 =A0 /=
* msec */
> +#define MXT_RESET_TIME =A0 =A0 =A0 =A0 350 =A0 =A0 /* msec */

I wonder mXT cycle time is alterable and if reset and backup time is de=
sided
by mXT cycle time, i think they can be used to variable.

--=20
- Joonyoung Shim
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
