From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Fri, 19 Jun 2009 12:24:53 +0530
Message-ID: <5d5443650906182354k7ab5d593y6419ca965a4f7e43@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com>
	 <f17812d70906070704s10f8eac6ybc353041e2db5a03@mail.gmail.com>
	 <200906112103.54043.dmitry.torokhov@gmail.com>
	 <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com>
	 <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f195.google.com ([209.85.221.195]:48842 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbZFSGyv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Jun 2009 02:54:51 -0400
Received: by qyk33 with SMTP id 33so851116qyk.33
        for <linux-input@vger.kernel.org>; Thu, 18 Jun 2009 23:54:53 -0700 (PDT)
In-Reply-To: <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

On Fri, Jun 12, 2009 at 6:56 PM, Eric Miao<eric.y.miao@gmail.com> wrote=
:
> On Fri, Jun 12, 2009 at 9:01 PM, Trilok Soni<soni.trilok@gmail.com> w=
rote:
>> Hi Dmitry,
>>
>>>
>>> Input: add support for generic GPIO-based matrix keypad
>>>
>>> From: Eric Miao <eric.y.miao@gmail.com>
>>>
>>> Original patch by Marek Vasut, modified by Eric in:
>>>
>>> 1. use delayed work to simplify the debouncing
>>> 2. combine col_polarity/row_polarity into a single active_low field
>>> 3. use a generic bit array based XOR algorithm to detect key
>>> =A0 press/release, which should make the column assertion time
>>> =A0 shorter and code a bit cleaner
>>> 4. remove the ALT_FN handling, which is no way generic, the ALT_FN
>>> =A0 key should be treated as no different from other keys, and
>>> =A0 translation will be done by user space by commands like 'loadke=
ys'.
>>>
>>> [dtor@mail.ru: fix error unwinding path, support changing keymap
>>> =A0from userspace]
>>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>>> ---
>>
>> Did you took latest patch submitted from Eric? Because it had more
>> signed-off and acked-by lines, like this.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> Reviewed-by: Trilok Soni <soni.trilok@gmail.com>
>> Reviewed-by: Uli Luckas <u.luckas@road.de>
>> Reviewed-by: Russell King <linux@arm.linux.org.uk>
>> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>>
>> http://markmail.org/message/2wrr2b6mr6qsd4xs#query:+page:1+mid:fkkfx=
lumfm4mjhk4+state:results
>>
>> Eric can confirm otherwise.
>>
>>>
>>> =A0config KEYBOARD_HIL_OLD
>>> =A0 =A0 =A0 =A0tristate "HP HIL keyboard support (simple driver)"
>>> @@ -254,7 +263,7 @@ config KEYBOARD_PXA27x
>>> =A0 =A0 =A0 =A0tristate "PXA27x/PXA3xx keypad support"
>>> =A0 =A0 =A0 =A0depends on PXA27x || PXA3xx
>>> =A0 =A0 =A0 =A0help
>>> - =A0 =A0 =A0 =A0 Enable support for PXA27x/PXA3xx keypad controlle=
r
>>> + =A0 =A0 =A0 =A0 Enable support for PXA27x/PXA3xx keypad controlle=
r.
>>
>> Why this change in this patch?
>>
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D (row << 4) +=
 col;
>>
>> << 4 logic will break once MAX_ROWS increased, right?
>>
>
> Hi Dmitry,
>
> I've tested the driver code, and it's basically OK except for two min=
or
> fixes:
>
> 1) GPIO and IRQs have to be initialized before input_register_device(=
),
> otherwise input->open() will be invoked before that, which will sched=
ule
> an immediate scan work and fail.
>
> 2) disable_irq_rows() called in init_matrix_gpio() so that by default=
 it's
> initialized to disabled - and will be enabled by input->open()
>
> Diff follows:
>
> --- drivers/input/keyboard/matrix_keypad.c.orig 2009-06-12
> 21:18:20.000000000 +0800
> +++ drivers/input/keyboard/matrix_keypad.c =A0 =A0 =A02009-06-12 21:0=
7:26.000000000 +0800
> @@ -290,6 +290,9 @@ static int __devinit init_matrix_gpio(st
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_irqs;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* initialized as disabled - enabled by input->open */
> + =A0 =A0 =A0 disable_row_irqs(keypad);
> =A0 =A0 =A0 =A0return 0;
>
> =A0err_free_irqs:
> @@ -376,22 +379,19 @@ static int __devinit matrix_keypad_probe
> =A0 =A0 =A0 =A0input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> =A0 =A0 =A0 =A0input_set_drvdata(input_dev, keypad);
>
> - =A0 =A0 =A0 err =3D input_register_device(keypad->input_dev);
> + =A0 =A0 =A0 err =3D init_matrix_gpio(pdev, keypad);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_mem;
>
> - =A0 =A0 =A0 err =3D init_matrix_gpio(pdev, keypad);
> + =A0 =A0 =A0 err =3D input_register_device(keypad->input_dev);
> =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unregister;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>
> =A0 =A0 =A0 =A0device_init_wakeup(&pdev->dev, pdata->wakeup);
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, keypad);
>
> =A0 =A0 =A0 =A0return 0;
>
> -err_unregister:
> - =A0 =A0 =A0 input_unregister_device(input_dev);
> - =A0 =A0 =A0 input_dev =3D NULL;
> =A0err_free_mem:
> =A0 =A0 =A0 =A0input_free_device(input_dev);
> =A0 =A0 =A0 =A0kfree(keycodes);
>

Ping? We are already half-way through open merge window.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
