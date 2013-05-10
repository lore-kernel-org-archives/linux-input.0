From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/2] Input: cyttsp - fix memcpy size param
Date: Fri, 10 May 2013 15:56:25 +0200
Message-ID: <CABxcv==jenFd=4NPme0y274SdmAkVMFQRqNgOFDJa33ptzinVg@mail.gmail.com>
References: <1368192769-24067-1-git-send-email-fery@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368192769-24067-1-git-send-email-fery@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, ttdrivers@cypress.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Ferruh,

On Fri, May 10, 2013 at 3:32 PM, Ferruh Yigit <fery@cypress.com> wrote:
> memcpy param is wrong because of offset in bl_cmd, this may corrupt the
> stack which may cause a crash.
>
> Tested-by: Ferruh Yigit <fery@cypress.com> on TMA300-DVK
> Signed-off-by: Ferruh Yigit <fery@cypress.com>

Nice catch, thanks for fixing it

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

> ---
>  drivers/input/touchscreen/cyttsp_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
> index 8e60437..97ba891 100644
> --- a/drivers/input/touchscreen/cyttsp_core.c
> +++ b/drivers/input/touchscreen/cyttsp_core.c
> @@ -133,7 +133,7 @@ static int cyttsp_exit_bl_mode(struct cyttsp *ts)
>         memcpy(bl_cmd, bl_command, sizeof(bl_command));
>         if (ts->pdata->bl_keys)
>                 memcpy(&bl_cmd[sizeof(bl_command) - CY_NUM_BL_KEYS],
> -                       ts->pdata->bl_keys, sizeof(bl_command));
> +                       ts->pdata->bl_keys, CY_NUM_BL_KEYS);
>
>         error = ttsp_write_block_data(ts, CY_REG_BASE,
>                                       sizeof(bl_cmd), bl_cmd);
> --
> 1.7.9.5
>
> This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.

In the future can you please drop this footer? It has no point to
state the above when you send emails to a public mailing list.

Best regards,
Javier
