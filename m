From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH V3 2/4] Input: pxa27x_keypad bug fix for direct_key_mask
Date: Mon, 2 Apr 2012 17:37:35 +0800
Message-ID: <CAN1soZzHivmGNX+T_OOfj0MOSqO_aT7q4OfHau4z-bWAC8EvuQ@mail.gmail.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
	<1333246084-14110-2-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46004 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab2DBJhg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 05:37:36 -0400
Received: by vbbff1 with SMTP id ff1so1555074vbb.19
        for <linux-input@vger.kernel.org>; Mon, 02 Apr 2012 02:37:35 -0700 (PDT)
In-Reply-To: <1333246084-14110-2-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, haojian.zhuang@marvell.com

On Sun, Apr 1, 2012 at 10:08 AM, Chao Xie <chao.xie@marvell.com> wrote:
> When direcct_key_num is 0, the mask should be 0.
> When direcct_key_num is 1, the mask should be 0b1.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> =A0drivers/input/keyboard/pxa27x_keypad.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/k=
eyboard/pxa27x_keypad.c
> index b07771e..5d71720 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -383,7 +383,7 @@ static void pxa27x_keypad_config(struct pxa27x_ke=
ypad *keypad)
> =A0 =A0 =A0 =A0if (pdata->direct_key_num > direct_key_num)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0direct_key_num =3D pdata->direct_key_n=
um;
>
> - =A0 =A0 =A0 keypad->direct_key_mask =3D ((2 << direct_key_num) - 1)=
 & ~mask;
> + =A0 =A0 =A0 keypad->direct_key_mask =3D ((1 << direct_key_num) - 1)=
 & ~mask;
>
> =A0 =A0 =A0 =A0/* enable direct key */
> =A0 =A0 =A0 =A0if (direct_key_num)
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Loop Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
