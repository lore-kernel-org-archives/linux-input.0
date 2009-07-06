From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Mon, 06 Jul 2009 14:02:10 +0800
Message-ID: <4A519362.9040805@gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com> <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com> <5d5443650906092110j1ed0914fn791039c4a4746bda@mail.gmail.com> <200907040754.28010.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:39144 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbZGFGCV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2009 02:02:21 -0400
Received: by pzk31 with SMTP id 31so2057244pzk.33
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2009 23:02:24 -0700 (PDT)
In-Reply-To: <200907040754.28010.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-arm-kernel@lists.arm.linux.org.uk, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Marek Vasut wrote:
> Dne St 10. =C4=8Dervna 2009 06:10:31 Trilok Soni napsal(a):
>> Hi Dmitry,
>>
>>> Sounds good, patch updated again, with attachment.
>>>
>>> >From 76776dfc468dc35f0d8394a2331e1a91f390e642 Mon Sep 17 00:00:00 =
2001
>>>
>>> From: Marek Vasut <marek.vasut@gmail.com>
>>> Date: Thu, 7 May 2009 15:49:32 +0800
>>> Subject: [PATCH] input: add support for generic GPIO-based matrix k=
eypad
>> Could you please review this patch and see if it can be acked as mer=
ge
>> window will open in couple of days? Thanks.
>=20
> Hi, I have but one comment (see further), otherwise works well on Pal=
m=20
> Tungsten C (PXA255A0 CPU).
>=20
> btw Eric, please add yourself to the credits, you did most of the wor=
k on it=20
> anyway ;-) .
>>> Original patch by Marek Vasut, modified by Eric in:
>>>
>>> 1. use delayed work to simplify the debouncing process
>=20
> ...
>=20
>>> diff --git a/include/linux/input/matrix_keypad.h
>>> b/include/linux/input/matrix_keypad.h
>>> new file mode 100644
>>> index 0000000..8b661cb
>>> --- /dev/null
>>> +++ b/include/linux/input/matrix_keypad.h
>>> @@ -0,0 +1,34 @@
>>> +#ifndef _MATRIX_KEYPAD_H
>>> +#define _MATRIX_KEYPAD_H
>>> +
>>> +#include <linux/input.h>
>>> +
>>> +#define MATRIX_MAX_ROWS                16
>>> +#define MATRIX_MAX_COLS                16
>>> +#define MATRIX_MAX_KEYS                (MATRIX_MAX_ROWS *
>>> MATRIX_MAX_COLS) +
>>> +struct matrix_keypad_platform_data {
>>> +       /* scancode map for the matrix keys */
>>> +       uint32_t        *key_map;
>>> +       int             key_map_size;
>>> +
>>> +       unsigned        row_gpios[MATRIX_MAX_ROWS];
>>> +       unsigned        col_gpios[MATRIX_MAX_COLS];
>=20
> Why not doing the above like the following?
> +       unsigned        *row_gpios;
> +       unsigned        *col_gpios;
>=20

By having an array, one can specify the GPIOs inside the
structure initialization instead of a dedicated array outside,
which might look a little bit better.

>>> +       int             num_row_gpios;
>>> +       int             num_col_gpios;
>>> +
>>> +       unsigned int    active_low;
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
