From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Wed, 3 Jun 2009 23:36:32 +0530
Message-ID: <5d5443650906031106r2b3b07cfq2d95a36e34710cf6@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <200905271526.59064.u.luckas@road.de>
	 <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
	 <200906021655.18476.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:10075 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbZFCSGb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 14:06:31 -0400
Received: by qw-out-2122.google.com with SMTP id 5so121091qwd.37
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2009 11:06:33 -0700 (PDT)
In-Reply-To: <200906021655.18476.u.luckas@road.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uli Luckas <u.luckas@road.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Uli Luckas,

On Tue, Jun 2, 2009 at 8:25 PM, Uli Luckas <u.luckas@road.de> wrote:
> On Sunday, 31. May 2009, Eric Miao wrote:
>> +#ifdef CONFIG_PM
>> +static int matrix_keypad_suspend(struct platform_device *pdev,
>> pm_message_t state)
>> +{
>> + =A0 =A0 =A0 struct matrix_keypad *keypad =3D platform_get_drvdata(=
pdev);
>> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata =3D keypad->=
pdata;
>> + =A0 =A0 =A0 int i;
>> +
>> + =A0 =A0 =A0 disable_row_irqs(keypad);
>> + =A0 =A0 =A0 flush_work(&keypad->work.work);
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
> 2) Did anyone ever wonder why this driver is able to detect a second =
key press on the same row? Actually the driver has polling behavior whi=
le any key is pressed. This is
> because scanning the key matix triggers a new interrupt on every row.=
 Every one of these interrupts will fire as soon as enable_irq is calle=
d, scheduling a new scan after the
> debounce period. I think that is worth being documented in the source=
 code.


=46ollowing is on radar after this driver gets picked up for the
mainline merge window (should open soon as 2.6.30-rc8 already out) by
Dmitry.

1. passing settling time from platform data as mentioned by you.
Android gpio matrix driver I have pointed out earlier is already doing
this.
2. adding phantom key removal support - probably picking it up
straight from android driver.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
