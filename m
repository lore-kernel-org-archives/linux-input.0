From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH V2 4/4] Input: pxa27x_keypad add choice to set direct_key_mask
Date: Fri, 30 Mar 2012 10:01:48 +0800
Message-ID: <CAN1soZwVoCXyKD8antPjjGJ5XkKyQ-zz5Dkp5CaHOD5bsfge=g@mail.gmail.com>
References: <1333072698-15344-1-git-send-email-chao.xie@marvell.com>
	<1333072698-15344-4-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42310 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758964Ab2C3CBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 22:01:49 -0400
Received: by vcqp1 with SMTP id p1so105555vcq.19
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 19:01:48 -0700 (PDT)
In-Reply-To: <1333072698-15344-4-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>
Cc: linux-input@vger.kernel.org, eric.y.miao@gmail.com, haojian.zhuang@marvell.com, linux-arm-kernel@lists.infradead.org

On Fri, Mar 30, 2012 at 9:58 AM, Chao Xie <chao.xie@marvell.com> wrote:
> Direct keys usage may not start from KP_DKIN0, add a msk option
> to configure the specifics for platforms that can skip some keys.
>
> Change-Id: Ia8fd28254fec9595dcf39f12a78392c1e8b675eb

You need remove Change-Id

> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> =A0arch/arm/plat-pxa/include/plat/pxa27x_keypad.h | =A0 =A02 ++
> =A0drivers/input/keyboard/pxa27x_keypad.c =A0 =A0 =A0 =A0 | =A0 =A09 =
++++++++-
> =A02 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/ar=
m/plat-pxa/include/plat/pxa27x_keypad.h
> index 7ffb16b..5ce8d5e 100644
> --- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> +++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> @@ -46,6 +46,8 @@ struct pxa27x_keypad_platform_data {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0direct_key_map[MAX_DIRECT_KEY_NUM]=
;
> =A0 =A0 =A0 =A0/* the key output may be low active */
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 direct_key_low_active;
> + =A0 =A0 =A0 /* give board a chance to choose the start direct key *=
/
> + =A0 =A0 =A0 unsigned int =A0 =A0direct_key_mask;
>
> =A0 =A0 =A0 =A0/* rotary encoders 0 */
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 enable_rotary0;
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/k=
eyboard/pxa27x_keypad.c
> index b41ebda..3da60b3 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -391,7 +391,14 @@ static void pxa27x_keypad_config(struct pxa27x_k=
eypad *keypad)
> =A0 =A0 =A0 =A0if (pdata->direct_key_num > direct_key_num)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0direct_key_num =3D pdata->direct_key_n=
um;
>
> - =A0 =A0 =A0 keypad->direct_key_mask =3D ((1 << direct_key_num) - 1)=
 & ~mask;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Direct keys usage may not start from KP_DKIN0, che=
ck the platfrom
> + =A0 =A0 =A0 =A0* mask data to config the specific.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->direct_key_mask)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad->direct_key_mask =3D pdata->dire=
ct_key_mask;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad->direct_key_mask =3D ((1 << dire=
ct_key_num) - 1) & ~mask;
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
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
