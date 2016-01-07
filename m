From: Yuasa Yoichi <yuasa@linux-mips.org>
Subject: Re: [PATCH] Input: rohm_bu21023 - fix handling of retrying firmware update
Date: Thu, 7 Jan 2016 19:11:59 +0900
Message-ID: <CACBHAey1nr6iq2U-Y0NNEDDbfDni9q4BrA7UWg3+cTXH-ex6Vw@mail.gmail.com>
References: <20160106225111.GA40396@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160106225111.GA40396@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thank you for fixing it.

Acked-by:Yoichi Yuasa <yuasa@linux-mips.org>

2016-01-07 7:51 GMT+09:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Because of the wrong condition we'd never retry firmware update.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/rohm_bu21023.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
> index ba6024f..611156a 100644
> --- a/drivers/input/touchscreen/rohm_bu21023.c
> +++ b/drivers/input/touchscreen/rohm_bu21023.c
> @@ -725,7 +725,7 @@ static int rohm_ts_load_firmware(struct i2c_client *client,
>                         break;
>
>                 error = -EIO;
> -       } while (++retry >= FIRMWARE_RETRY_MAX);
> +       } while (++retry <= FIRMWARE_RETRY_MAX);
>
>  out:
>         error2 = i2c_smbus_write_byte_data(client, INT_MASK, INT_ALL);
> --
> 2.6.0.rc2.230.g3dd15c0
>
>
> --
> Dmitry
>
