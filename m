From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH V3 3/4] Input: pxa27x_keypad direct key may be low active
Date: Mon, 2 Apr 2012 17:38:01 +0800
Message-ID: <CAN1soZzcW6Oy_vd3U_WYy9RNL1BLDfG+NpWKg1HUfQDD0eJAUQ@mail.gmail.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
	<1333246084-14110-3-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46004 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab2DBJiB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 05:38:01 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so1555074vbb.19
        for <linux-input@vger.kernel.org>; Mon, 02 Apr 2012 02:38:01 -0700 (PDT)
In-Reply-To: <1333246084-14110-3-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, haojian.zhuang@marvell.com

On Sun, Apr 1, 2012 at 10:08 AM, Chao Xie <chao.xie@marvell.com> wrote:
> KPDK_DK only indicates the pin level of direct key.
> So it is related to board, and low level may be active which
> indicates that a key is pressed.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> =A0arch/arm/plat-pxa/include/plat/pxa27x_keypad.h | =A0 =A02 ++
> =A0drivers/input/keyboard/pxa27x_keypad.c =A0 =A0 =A0 =A0 | =A0 10 ++=
+++++++-
> =A02 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/ar=
m/plat-pxa/include/plat/pxa27x_keypad.h
> index abcc36e..7ffb16b 100644
> --- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> +++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> @@ -44,6 +44,8 @@ struct pxa27x_keypad_platform_data {
> =A0 =A0 =A0 =A0/* direct keys */
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 direct_key_num;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0direct_key_map[MAX_DIRECT_KEY_NUM]=
;
> + =A0 =A0 =A0 /* the key output may be low active */
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 direct_key_low_active;
>
> =A0 =A0 =A0 =A0/* rotary encoders 0 */
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 enable_rotary0;
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/k=
eyboard/pxa27x_keypad.c
> index 5d71720..a60f14e 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -311,7 +311,15 @@ static void pxa27x_keypad_scan_direct(struct pxa=
27x_keypad *keypad)
> =A0 =A0 =A0 =A0if (pdata->enable_rotary0 || pdata->enable_rotary1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pxa27x_keypad_scan_rotary(keypad);
>
> - =A0 =A0 =A0 new_state =3D KPDK_DK(kpdk) & keypad->direct_key_mask;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The KPDR_DK only output the key pin level, so it r=
elates to board,
> + =A0 =A0 =A0 =A0* and low level may be active.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->direct_key_low_active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D ~KPDK_DK(kpdk) & keypad->=
direct_key_mask;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D KPDK_DK(kpdk) & keypad->d=
irect_key_mask;
> +
> =A0 =A0 =A0 =A0bits_changed =3D keypad->direct_key_state ^ new_state;
>
> =A0 =A0 =A0 =A0if (bits_changed =3D=3D 0)
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
