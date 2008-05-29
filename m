From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH] pxa: Fix some issues with pxa27x_keypad driver v3
Date: Thu, 29 May 2008 08:37:08 +0800
Message-ID: <f17812d70805281737y1f4440cdo8d94ee609a905b45@mail.gmail.com>
References: <20080528162539.6d7a2158.ospite@studenti.unina.it>
	 <20080528103004.ZZRA012@mailhub.coreip.homeip.net>
	 <20080528171114.ed177b63.ospite@studenti.unina.it>
	 <20080528111503.ZZRA012@mailhub.coreip.homeip.net>
	 <20080528193624.3b2e97b8.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:9916 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbYE2AhP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2008 20:37:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2117632ywe.1
        for <linux-input@vger.kernel.org>; Wed, 28 May 2008 17:37:08 -0700 (PDT)
In-Reply-To: <20080528193624.3b2e97b8.ospite@studenti.unina.it>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, May 29, 2008 at 1:36 AM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
>
> Fix some issues with pxa27x_keypad driver:
>
> 1. set input bits for direct keys codes
> 2. set input bits for rotary encoder codes only if rotary
>   encoder is enabled
> 3. enable EV_REL only if rel_codes are set for rotary encoders
>
> Signed-off-by: Antonio Ospite <ao2@openezx.org>
>
> Index: linux-2.6.26-rc3/drivers/input/keyboard/pxa27x_keypad.c
> ===================================================================
> --- linux-2.6.26-rc3.orig/drivers/input/keyboard/pxa27x_keypad.c
> +++ linux-2.6.26-rc3/drivers/input/keyboard/pxa27x_keypad.c
> @@ -136,6 +136,9 @@
>                set_bit(code, input_dev->keybit);
>        }
>
> +       for (i = 0; i < pdata->direct_key_num; i++)
> +               set_bit(pdata->direct_key_map[i], input_dev->keybit);
> +
>        keypad->rotary_up_key[0] = pdata->rotary0_up_key;
>        keypad->rotary_up_key[1] = pdata->rotary1_up_key;
>        keypad->rotary_down_key[0] = pdata->rotary0_down_key;
> @@ -143,17 +146,21 @@
>        keypad->rotary_rel_code[0] = pdata->rotary0_rel_code;
>        keypad->rotary_rel_code[1] = pdata->rotary1_rel_code;
>
> -       if (pdata->rotary0_up_key && pdata->rotary0_down_key) {
> -               set_bit(pdata->rotary0_up_key, input_dev->keybit);
> -               set_bit(pdata->rotary0_down_key, input_dev->keybit);
> -       } else
> -               set_bit(pdata->rotary0_rel_code, input_dev->relbit);
> -
> -       if (pdata->rotary1_up_key && pdata->rotary1_down_key) {
> -               set_bit(pdata->rotary1_up_key, input_dev->keybit);
> -               set_bit(pdata->rotary1_down_key, input_dev->keybit);
> -       } else
> -               set_bit(pdata->rotary1_rel_code, input_dev->relbit);
> +       if (pdata->enable_rotary0) {
> +               if (pdata->rotary0_up_key && pdata->rotary0_down_key) {
> +                       set_bit(pdata->rotary0_up_key, input_dev->keybit);
> +                       set_bit(pdata->rotary0_down_key, input_dev->keybit);
> +               } else
> +                       set_bit(pdata->rotary0_rel_code, input_dev->relbit);
> +       }
> +
> +       if (pdata->enable_rotary1) {
> +               if (pdata->rotary1_up_key && pdata->rotary1_down_key) {
> +                       set_bit(pdata->rotary1_up_key, input_dev->keybit);
> +                       set_bit(pdata->rotary1_down_key, input_dev->keybit);
> +               } else
> +                       set_bit(pdata->rotary1_rel_code, input_dev->relbit);
> +       }
>  }
>
>  static inline unsigned int lookup_matrix_keycode(
> @@ -484,8 +491,11 @@
>        keypad->input_dev = input_dev;
>        input_set_drvdata(input_dev, keypad);
>
> -       input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> -               BIT_MASK(EV_REL);
> +       input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +       if ((keypad->pdata->enable_rotary0 && keypad->pdata->rotary0_rel_code)
> +           || (keypad->pdata->enable_rotary1
> +               && keypad->pdata->rotary1_rel_code))
> +               input_dev->evbit[0] |= BIT_MASK(EV_REL);
>
>        pxa27x_keypad_build_keycode(keypad);
>        platform_set_drvdata(pdev, keypad);
>

OK

-- 
Cheers
- eric
