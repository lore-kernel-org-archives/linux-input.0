From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/1] Input: rotary-encoder: Add 'stepped' irq handler
Date: Sun, 29 Sep 2013 19:39:56 +0200
Message-ID: <524865EC.3050100@gmail.com>
References: <1380392798-23345-1-git-send-email-ezequiel@vanguardiasur.com.ar> <1380392798-23345-2-git-send-email-ezequiel@vanguardiasur.com.ar> <524803A9.5090708@gmail.com> <CAAEAJfDSW5rgGYXnL2Z_YUKUCVQ82BOg_Q5HtOKKpFvJAs5Qvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:37381 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab3I2RkA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Sep 2013 13:40:00 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so1659437bkb.17
        for <linux-input@vger.kernel.org>; Sun, 29 Sep 2013 10:39:58 -0700 (PDT)
In-Reply-To: <CAAEAJfDSW5rgGYXnL2Z_YUKUCVQ82BOg_Q5HtOKKpFvJAs5Qvw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Ezequiel_Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 29.09.2013 19:29, Ezequiel Garc=EDa wrote:
> On 29 September 2013 07:40, Daniel Mack <zonque@gmail.com> wrote:
>> On 28.09.2013 20:26, Ezequiel Garcia wrote:

>>> +     sum =3D (encoder->last_stable << 2) + state;
>>> +     switch (sum) {
>>> +     case 0b1101:
>>> +     case 0b0100:
>>> +     case 0b0010:
>>> +     case 0b1011:
>>
>> Binary constants are frowned upon, please avoid them in the kernel.
>> checkpatch.pl should have warned you about them as well.
>>
>=20
> Well... despite any checkpatch.pl warnings, I think the above is much=
 clear
> to the reader than any alternative.

The problem is that support for that notation is a proprietary gcc
extension that is AFAIK only supported from gcc 4.3 onwards or so.
However, the current minimum gcc version for building the kernel is 3.2=
=2E

> If binary values should be avoided by all means, then I would prefer =
to encode
> the previous and current in different nibbles:
>=20
> sum =3D (encoder->last_stable << 4) + state;
> switch (sum) {
>         case 0x31:
>         case 0x10:
>         case 0x02:
>         case 0x23:
>=20
> Maybe this is better?

Either that, or use
	case BIT(3) | BIT(2) | BIT(0):
		...

> I'm really curious about the rotary devices you originally used with
> this driver.
> I guess those have no detents, so there's no mechanical-click on each=
 step?

Some models have detents, some don't. We've used one of this series
which does:


http://de.mouser.com/ProductDetail/Alpha-Taiwan/RE111F-20B3-20F-20P/?qs=
=3DyA6kp8fx8Y7KsyMOFz9p0A=3D=3D



Best regards,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
