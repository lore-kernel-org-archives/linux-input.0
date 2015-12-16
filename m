From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [PATCH] Add eGalaxTouch serial touchscreen driver v3
Date: Wed, 16 Dec 2015 20:31:44 +0100
Message-ID: <5671BC20.1080509@pr.hu>
References: <1450269798-13928-1-git-send-email-zboszor@pr.hu>
 <56715EE9.9080303@pr.hu> <20151216192830.GA10962@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:60221 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbbLPTb4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 14:31:56 -0500
In-Reply-To: <20151216192830.GA10962@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszormenyi@sicom.com>

2015-12-16 20:28 keltez=C3=A9ssel, Dmitry Torokhov =C3=ADrta:
> On Wed, Dec 16, 2015 at 01:54:01PM +0100, Boszormenyi Zoltan wrote:
>> 2015-12-16 13:43 keltez=C3=A9ssel, Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9=
nyi =C3=ADrta:
>>> Signed-off-by: B=EF=BF=BDsz=EF=BF=BDrm=EF=BF=BDnyi Zolt=EF=BF=BDn <=
zboszor@pr.hu>
>> this
>>
>>> + * Copyright (c) 2015 Zolt=EF=BF=BDn B=EF=BF=BDsz=EF=BF=BDrm=EF=BF=
=BDnyi <zboszor@pr.hu>
>> this
>>
>>> +MODULE_AUTHOR("Zolt=EF=BF=BDn B=EF=BF=BDsz=EF=BF=BDrm=EF=BF=BDnyi =
<zboszor@pr.hu>");
>> and this were in Latin-2 after you sent the patch back to me, my pat=
ch
>> was UTF-8 in the beginning.
> Hmm, not sure what happened...
>
>> Can you run the code through "recode latin2..utf-8" before committin=
g or
>> should I resend to fix this?
> No, I recoded it and I also added back SERIO_EGALAX definition to
> serio.h that you somehow dropped from the patch.

and the Makefile change I suppose. I think I was in a hurry and
only did "git add egalax_ts_serial.c" and "git commit" instead of "git =
commit -a".
Sorry for that.

>  The driver is queued for 4.5 now.

Thank you very much,
Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
