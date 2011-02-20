From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Input: serio: Compile error fix (altera_ps2.c)
Date: Sat, 19 Feb 2011 20:04:49 -0700
Message-ID: <AANLkTinaVspNwHZFMUnbp=8F+K-=PRw95a1es+zyeCA+@mail.gmail.com>
References: <1298145859-10892-1-git-send-email-dustan.bower@gmail.com> <20110219214549.GA4933@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58320 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1BTDFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Feb 2011 22:05:09 -0500
In-Reply-To: <20110219214549.GA4933@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dustan Bower <dustan.bower@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Chou <thomas@wytron.com.tw>

On Sat, Feb 19, 2011 at 2:45 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sat, Feb 19, 2011 at 03:04:19PM -0500, Dustan Bower wrote:
>> Fixed compile error, today's linux-next tree:
>>
>> =A0 CC [M] =A0drivers/input/serio/altera_ps2.o
>> drivers/input/serio/altera_ps2.c:182:1: error: expected =91,=92 or =91=
;=92 before =91extern=92
>> make[1]: *** [drivers/input/serio/altera_ps2.o] Error 1
>> make: *** [_module_drivers/input/serio] Error 2
>>
>> Signed-off-by: Dustan Bower <dustan.bower@gmail.com>
>
> Thanks Dustan.
>
> Grant, maybe you could amend the original patch so that we do not
> introduce bisection failure point?

done, thanks.

g.

>
>> ---
>> =A0drivers/input/serio/altera_ps2.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/=
altera_ps2.c
>> index 3fee88b..d363dc4 100644
>> --- a/drivers/input/serio/altera_ps2.c
>> +++ b/drivers/input/serio/altera_ps2.c
>> @@ -178,7 +178,7 @@ static int __devexit altera_ps2_remove(struct pl=
atform_device *pdev)
>> =A0static const struct of_device_id altera_ps2_match[] =3D {
>> =A0 =A0 =A0 { .compatible =3D "ALTR,ps2-1.0", },
>> =A0 =A0 =A0 {},
>> -}
>> +};
>> =A0MODULE_DEVICE_TABLE(of, altera_ps2_match);
>> =A0#else /* CONFIG_OF */
>> =A0#define altera_ps2_match NULL
>> --
>> 1.7.4.1
>>
>
> --
> Dmitry
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
