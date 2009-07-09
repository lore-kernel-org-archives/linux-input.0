From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: Add keypad support for w90p910 evb
Date: Thu, 9 Jul 2009 12:17:12 +0530
Message-ID: <5d5443650907082347i40f5f39bn63e2683046155eb@mail.gmail.com>
References: <4A546443.9030907@gmail.com>
	 <5d5443650907080332t4156cabdu267d28c6c486f372@mail.gmail.com>
	 <4A55901B.6070805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:7140 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbZGIGrO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 02:47:14 -0400
Received: by qw-out-2122.google.com with SMTP id 9so2508219qwb.37
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2009 23:47:12 -0700 (PDT)
In-Reply-To: <4A55901B.6070805@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Hi Wan ZongShun,

>>> +static void w90p910_keypad_scan_matrix(struct w90p910_keypad *keyp=
ad,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int status)
>>> +{
>>> + =A0 =A0 =A0 unsigned int row, col, val;
>>> +
>>> + =A0 =A0 =A0 row =3D KGET_RAW(status);
>>> + =A0 =A0 =A0 col =3D KGET_COLUMN(status);
>>> +
>>> + =A0 =A0 =A0 val =3D lookup_matrix_keycode(keypad, row, col);
>>> +
>>> + =A0 =A0 =A0 input_report_key(keypad->input_dev, val, 1);
>>> +
>>> + =A0 =A0 =A0 input_sync(keypad->input_dev);
>>> +
>>> + =A0 =A0 =A0 input_report_key(keypad->input_dev, val, 0);
>>
>> So, we don't get interrupt on key release?
>
> In w90p910,there is no way to identify whether the key was released o=
r not,so I have to put above code here to report the key has been relea=
sed.
>

Ok.

>>> +
>>> +static void w90p910_keypad_close(struct input_dev *dev)
>>> +{
>>> + =A0 =A0 =A0 struct w90p910_keypad *keypad =3D input_get_drvdata(d=
ev);
>>> +
>>> + =A0 =A0 =A0 /* Disable clock unit */
>>> + =A0 =A0 =A0 clk_disable(keypad->clk);
>>
>> So this controller doesn't support putting controller FSM into IDLE
>> state by writing some bits into it or is it doing auto-sleep?
>
> What you said not be supporting in w90p910,
> When to disable this clk,I think the controller will be power down.

Ok.

>>> +
>>> + =A0 =A0 =A0 /* set multi-function pin for w90p910 kpi. */
>>> + =A0 =A0 =A0 mfp_set_groupi(&pdev->dev);
>>> +
>>
>> Could you please point me to implementation of this API? I believe
>> this is pin-multiplexing code.
>
> Sure, it is a muti-function pin API, which was defined in /mach-w90x9=
00/mfp-w90p910.c.
> What's wrong?

I prefer pin-multiplexing being done from board-xxx.c files, as
pin-multiplexing differs for every board design. I will look at this
API.

>
>>
>>> + =A0 =A0 =A0 input_dev->name =3D pdev->name;
>>> + =A0 =A0 =A0 input_dev->id.bustype =3D BUS_HOST;
>>> + =A0 =A0 =A0 input_dev->open =3D w90p910_keypad_open;
>>> + =A0 =A0 =A0 input_dev->close =3D w90p910_keypad_close;
>>> + =A0 =A0 =A0 input_dev->dev.parent =3D &pdev->dev;
>>> +
>>> + =A0 =A0 =A0 keypad->input_dev =3D input_dev;
>>> + =A0 =A0 =A0 input_set_drvdata(input_dev, keypad);
>>> +
>>> + =A0 =A0 =A0 input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(E=
V_REP);
>>
>> EV_REP can be done as per platform data, but not a problem to enable
>> by default if keypad controller itself is not supporting it
>
>
> This is not suitable to w90p910?
> Maybe I have a mistake to understand EV_REP, how to do for me here?.

No problem, keep EV_REP as is.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
