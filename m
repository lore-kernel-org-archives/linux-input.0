From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Wed, 3 Jun 2009 14:06:40 +0800
Message-ID: <f17812d70906022306w246ce8f8we162bb1df0d6a2c@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <200905271526.59064.u.luckas@road.de>
	 <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
	 <200906021655.18476.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f104.google.com ([209.85.221.104]:46942 "EHLO
	mail-qy0-f104.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbZFCGGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 02:06:39 -0400
Received: by qyk2 with SMTP id 2so1603476qyk.33
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2009 23:06:40 -0700 (PDT)
In-Reply-To: <200906021655.18476.u.luckas@road.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uli Luckas <u.luckas@road.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Jun 2, 2009 at 10:55 PM, Uli Luckas <u.luckas@road.de> wrote:
> On Sunday, 31. May 2009, Eric Miao wrote:
>> +#ifdef CONFIG_PM
>> +static int matrix_keypad_suspend(struct platform_device *pdev,
>> pm_message_t state)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct matrix_keypad *keypad =3D platform_get=
_drvdata(pdev);
>> + =C2=A0 =C2=A0 =C2=A0 struct matrix_keypad_platform_data *pdata =3D=
 keypad->pdata;
>> + =C2=A0 =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 disable_row_irqs(keypad);
>> + =C2=A0 =C2=A0 =C2=A0 flush_work(&keypad->work.work);
>>
> Hi Eric,
> thanks for fixing the problems. One comment on the approach:
> disable_row_irqs uses disable_irq_nosync. I guess this still works as
> the interrupt handler is requested with IRQF_DISABLED.
>
> Some more non-show stoppers:
> 1) On some SoCs wakeup gpios are a precoius resource. Therfore a hard=
ware design which ORs all row gpios and connects the result to a single=
 row_interrupt might be smart. Could
> the driver be made generic enought to support this?

I'd prefer this being left for further improvement when someone comes
with such a hardware and the patch.

> 2) Did anyone ever wonder why this driver is able to detect a second =
key press on the same row? Actually the driver has polling behavior whi=
le any key is pressed. This is
> because scanning the key matix triggers a new interrupt on every row.=
 Every one of these interrupts will fire as soon as enable_irq is calle=
d, scheduling a new scan after the
> debounce period. I think that is worth being documented in the source=
 code.
>

You see, I'm not a good writer, so ... And I think the reader
will be able to figure out. Well, just feel free to send me a
copy if you have a good description of this :)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
