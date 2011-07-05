From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/3 v2] Input: atmel_mxt_ts - Make wait-after-reset period
 compatible with all chips
Date: Tue, 05 Jul 2011 10:07:21 +0900
Message-ID: <4E1263C9.3010704@samsung.com>
References: <4E11B8C3.8010608@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11553 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1GEBHG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 21:07:06 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LNU00M7B5RPYKC0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Tue, 05 Jul 2011 10:07:05 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LNU00I6I5RTXA@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 05 Jul 2011 10:07:05 +0900 (KST)
In-reply-to: <4E11B8C3.8010608@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi,

On 2011-07-04 =EC=98=A4=ED=9B=84 9:57, Iiro Valkonen wrote:
> The delay before the chip can be accessed after reset varies between =
different
> chips in maXTouch family. Waiting for 200ms and then monitoring the C=
HG (chip
> is ready when the line is low) is guaranteed to work with all chips.

I wonder 200ms waiting needs indeed, it is very long time.
If monitoring the CHG line can detect the completion of reset,
200ms waiting can be removed?

>
> v2: At Dmitry's suggestion, add a timeout so we are not stuck looping
> endlessly in case the CHG is not going low.
>
> Signed-off-by: Iiro Valkonen<iiro.valkonen@atmel.com>
> ---
>   drivers/input/touchscreen/atmel_mxt_ts.c |    9 ++++++++-
>   include/linux/i2c/atmel_mxt_ts.h         |    1 +
>   2 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input=
/touchscreen/atmel_mxt_ts.c
> index 1e61387..5469a29 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -170,7 +170,7 @@
>   #define MXT_BOOT_VALUE		0xa5
>   #define MXT_BACKUP_VALUE	0x55
>   #define MXT_BACKUP_TIME		25	/* msec */
> -#define MXT_RESET_TIME		65	/* msec */
> +#define MXT_RESET_TIME		200	/* msec */
>
>   #define MXT_FWRESET_TIME	175	/* msec */
>
> @@ -792,6 +792,7 @@ static int mxt_initialize(struct mxt_data *data)
>   	struct i2c_client *client =3D data->client;
>   	struct mxt_info *info =3D&data->info;
>   	int error;
> +	int reset_timeout =3D 0;
>   	u8 val;
>
>   	error =3D mxt_get_info(data);
> @@ -828,6 +829,12 @@ static int mxt_initialize(struct mxt_data *data)
>   	mxt_write_object(data, MXT_GEN_COMMAND,
>   			MXT_COMMAND_RESET, 1);
>   	msleep(MXT_RESET_TIME);
> +	while ((reset_timeout++<=3D 100)&&  data->pdata->read_chg())

If pdata->read_chg is NULL?

> +		msleep(2);
> +	if (reset_timeout>=3D 100) {
> +		dev_err(&client->dev, "No response after reset!\n");
> +		return -EIO;
> +	}
>
>   	/* Update matrix size at info struct */
>   	error =3D mxt_read_reg(client, MXT_MATRIX_X_SIZE,&val);
> diff --git a/include/linux/i2c/atmel_mxt_ts.h b/include/linux/i2c/atm=
el_mxt_ts.h
> index f027f7a..ef59c22 100644
> --- a/include/linux/i2c/atmel_mxt_ts.h
> +++ b/include/linux/i2c/atmel_mxt_ts.h
> @@ -39,6 +39,7 @@ struct mxt_platform_data {
>   	unsigned int voltage;
>   	unsigned char orient;
>   	unsigned long irqflags;
> +	u8(*read_chg) (void);
>   };
>
>   #endif /* __LINUX_ATMEL_MXT_TS_H */

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
