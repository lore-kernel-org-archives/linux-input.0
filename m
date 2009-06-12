From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Fri, 12 Jun 2009 21:26:43 +0800
Message-ID: <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com>
	 <f17812d70906070704s10f8eac6ybc353041e2db5a03@mail.gmail.com>
	 <200906112103.54043.dmitry.torokhov@gmail.com>
	 <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:16042 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764465AbZFLN0l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2009 09:26:41 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1417637qwd.37
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2009 06:26:43 -0700 (PDT)
In-Reply-To: <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

On Fri, Jun 12, 2009 at 9:01 PM, Trilok Soni<soni.trilok@gmail.com> wro=
te:
> Hi Dmitry,
>
>>
>> Input: add support for generic GPIO-based matrix keypad
>>
>> From: Eric Miao <eric.y.miao@gmail.com>
>>
>> Original patch by Marek Vasut, modified by Eric in:
>>
>> 1. use delayed work to simplify the debouncing
>> 2. combine col_polarity/row_polarity into a single active_low field
>> 3. use a generic bit array based XOR algorithm to detect key
>> =C2=A0 press/release, which should make the column assertion time
>> =C2=A0 shorter and code a bit cleaner
>> 4. remove the ALT_FN handling, which is no way generic, the ALT_FN
>> =C2=A0 key should be treated as no different from other keys, and
>> =C2=A0 translation will be done by user space by commands like 'load=
keys'.
>>
>> [dtor@mail.ru: fix error unwinding path, support changing keymap
>> =C2=A0from userspace]
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> ---
>
> Did you took latest patch submitted from Eric? Because it had more
> signed-off and acked-by lines, like this.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Reviewed-by: Trilok Soni <soni.trilok@gmail.com>
> Reviewed-by: Uli Luckas <u.luckas@road.de>
> Reviewed-by: Russell King <linux@arm.linux.org.uk>
> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>
> http://markmail.org/message/2wrr2b6mr6qsd4xs#query:+page:1+mid:fkkfxl=
umfm4mjhk4+state:results
>
> Eric can confirm otherwise.
>
>>
>> =C2=A0config KEYBOARD_HIL_OLD
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "HP HIL keyboard support (simple=
 driver)"
>> @@ -254,7 +263,7 @@ config KEYBOARD_PXA27x
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "PXA27x/PXA3xx keypad support"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on PXA27x || PXA3xx
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 Enable support for PXA27x/PXA3xx keypa=
d controller
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Enable support for PXA27x/PXA3xx keypa=
d controller.
>
> Why this change in this patch?
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 code =3D (row << 4) + col;
>
> << 4 logic will break once MAX_ROWS increased, right?
>

Hi Dmitry,

I've tested the driver code, and it's basically OK except for two minor
fixes:

1) GPIO and IRQs have to be initialized before input_register_device(),
otherwise input->open() will be invoked before that, which will schedul=
e
an immediate scan work and fail.

2) disable_irq_rows() called in init_matrix_gpio() so that by default i=
t's
initialized to disabled - and will be enabled by input->open()

Diff follows:

--- drivers/input/keyboard/matrix_keypad.c.orig	2009-06-12
21:18:20.000000000 +0800
+++ drivers/input/keyboard/matrix_keypad.c	2009-06-12 21:07:26.00000000=
0 +0800
@@ -290,6 +290,9 @@ static int __devinit init_matrix_gpio(st
 			goto err_free_irqs;
 		}
 	}
+
+	/* initialized as disabled - enabled by input->open */
+	disable_row_irqs(keypad);
 	return 0;

 err_free_irqs:
@@ -376,22 +379,19 @@ static int __devinit matrix_keypad_probe
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 	input_set_drvdata(input_dev, keypad);

-	err =3D input_register_device(keypad->input_dev);
+	err =3D init_matrix_gpio(pdev, keypad);
 	if (err)
 		goto err_free_mem;

-	err =3D init_matrix_gpio(pdev, keypad);
+	err =3D input_register_device(keypad->input_dev);
 	if (err)
-		goto err_unregister;
+		goto err_free_mem;

 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 	platform_set_drvdata(pdev, keypad);

 	return 0;

-err_unregister:
-	input_unregister_device(input_dev);
-	input_dev =3D NULL;
 err_free_mem:
 	input_free_device(input_dev);
 	kfree(keycodes);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
