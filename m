From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cyapa: remove variable overwriting
Date: Mon, 28 Sep 2015 15:43:04 -0700
Message-ID: <CAKdAkRRBH04vTVYhrLa0XLfnujsV=JJoY4PY36vg1B=1KaaBWw@mail.gmail.com>
References: <1442311587-24458-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33355 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbbI1WnG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 18:43:06 -0400
In-Reply-To: <1442311587-24458-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Dudley Du <dudl@cypress.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Sudip,

On Tue, Sep 15, 2015 at 3:06 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Even if rotat_align is true or false the final value of
> cyapa->electrodes_rx is always cyapa->electrodes_y. remove the variable
> overwriting and in the process remove the variable rotat_align which is
> not required any more.
>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/input/mouse/cyapa_gen6.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
> index 5f19107..f0c614b 100644
> --- a/drivers/input/mouse/cyapa_gen6.c
> +++ b/drivers/input/mouse/cyapa_gen6.c
> @@ -196,7 +196,6 @@ static int cyapa_gen6_read_sys_info(struct cyapa *cyapa)
>         u8 resp_data[PIP_READ_SYS_INFO_RESP_LENGTH];
>         int resp_len;
>         u16 product_family;
> -       u8 rotat_align;
>         int error;
>
>         /* Get App System Information to determine Gen5 or Gen6. */
> @@ -241,14 +240,7 @@ static int cyapa_gen6_read_sys_info(struct cyapa *cyapa)
>         memcpy(&cyapa->product_id[13], &resp_data[62], 2);
>         cyapa->product_id[15] = '\0';
>
> -       rotat_align = resp_data[68];
> -       if (rotat_align) {
> -               cyapa->electrodes_rx = cyapa->electrodes_y;
> -               cyapa->electrodes_rx = cyapa->electrodes_y;
> -       } else {
> -               cyapa->electrodes_rx = cyapa->electrodes_x;
> -               cyapa->electrodes_rx = cyapa->electrodes_y;
> -       }
> +       cyapa->electrodes_rx = cyapa->electrodes_y;

II think it was probably a typo rather than rotat_align being not
needed. Dudley?

Thanks.

-- 
Dmitry
