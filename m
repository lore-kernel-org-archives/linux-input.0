From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] input: alps: Add support for the touchpad on Dell
	Latitude E6410
Date: Thu, 20 May 2010 19:44:45 -0400
Message-ID: <AANLkTilqjmKTU_zx50WWq41KIzZp-Y_cx0AD7S3R1S1_@mail.gmail.com>
References: <1273931524-15654-1-git-send-email-thomas@archlinux.org>
	 <4BEEAA43.5030005@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34281 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025Ab0ETXoq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 19:44:46 -0400
Received: by pwi5 with SMTP id 5so168216pwi.19
        for <linux-input@vger.kernel.org>; Thu, 20 May 2010 16:44:46 -0700 (PDT)
In-Reply-To: <4BEEAA43.5030005@archlinux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, alessandro@molarulez.com

On Sat, May 15, 2010 at 10:05 AM, Thomas B=E4chler <thomas@archlinux.or=
g> wrote:
> Am 15.05.2010 15:52, schrieb Thomas B=E4chler:
>> ---
>> =A0drivers/input/mouse/alps.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index 99d5876..0c83070 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -66,6 +66,8 @@ static const struct alps_model_info alps_model_dat=
a[] =3D {
>> =A0 =A0 =A0 { { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },=
 =A0 =A0 =A0 =A0 =A0/* Dell Vostro 1400 */
>> =A0 =A0 =A0 { { 0x52, 0x01, 0x14 }, 0xff, 0xff,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_IN=
TERLEAVED }, =A0 =A0 =A0/* Toshiba Tecra A11-11L */
>> + =A0 =A0 { { 0x73, 0x02, 0x64 }, 0xff, 0xff,
>> + =A0 =A0 =A0 =A0 =A0 =A0 ALPS_PASS | ALPS_DUALPOINT }, =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Dell Latitude E6410 */
>> =A0};
>>
>> =A0/*
>
> Okay, never mind, we were too quick in thinking everything was correc=
t,
> the parameters seem to be wrong. The touchpad is detected and seems t=
o
> work, but in 'synclient -m', you see that actually nothing happens.
>
> Dmitry, do you know which parameters we need to tweak to fix this? Ma=
ybe
> the 0xff, 0xff mask is wrong? Or the flags? Sorry, my knowledge ends =
here.

Been there, done that. I originally pushed a patch with this signature
about a month ago. It was applied, but then reverted because it didn't
work right. It seems there's a new protocol for these alps touchpads
that will need to be figured out first.

-- Chase
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
