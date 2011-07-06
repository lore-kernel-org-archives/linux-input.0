From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 01/12] Input: synaptics - cleanup 0x0c query documentation
Date: Wed, 6 Jul 2011 21:50:34 +0800
Message-ID: <CAGS+omBVKV0EvU2owK4rzxwJ25wEnnnAoJeA5do1V2rPr7wg-Q@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-2-git-send-email-djkurtz@chromium.org> <4E134AF0.1090209@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:31126 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1GFNvB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2011 09:51:01 -0400
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id p66Dp0uL010042
	for <linux-input@vger.kernel.org>; Wed, 6 Jul 2011 06:51:00 -0700
Received: from yie19 (yie19.prod.google.com [10.243.66.19])
	by wpaz24.hot.corp.google.com with ESMTP id p66DoWrk016331
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 6 Jul 2011 06:50:59 -0700
Received: by yie19 with SMTP id 19so3947339yie.39
        for <linux-input@vger.kernel.org>; Wed, 06 Jul 2011 06:50:54 -0700 (PDT)
In-Reply-To: <4E134AF0.1090209@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

Hi Chase,

On Wed, Jul 6, 2011 at 1:33 AM, Chase Douglas
<chase.douglas@canonical.com> wrote:
> On 06/28/2011 10:07 PM, djkurtz@chromium.org wrote:
>> From: Daniel Kurtz <djkurtz@chromium.org>
>>
>> Convert some spaces to tabs.
>> Reorder defines to match bit ordering.
>> Add defines for all bits.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>> =A0drivers/input/mouse/synaptics.h | =A0 16 +++++++++++-----
>> =A01 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/s=
ynaptics.h
>> index 7453938..34bedde 100644
>> --- a/drivers/input/mouse/synaptics.h
>> +++ b/drivers/input/mouse/synaptics.h
>> @@ -66,18 +66,24 @@
>> =A0 * 1 0x60 =A0 =A0multifinger mode =A0 =A0 =A0 =A0identifies firmw=
are finger counting
>> =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (not reporting!) algorithm.
>> =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 Not particularly meaningful
>> - * 1 0x80 =A0 =A0covered pad =A0 =A0 =A0 =A0 =A0 =A0 W clipped to 1=
4, 15 =3D=3D pad mostly covered
>> - * 2 0x01 =A0 =A0clickpad bit 1 =A0 =A0 =A0 =A0 =A02-button ClickPa=
d
>> - * 2 0x02 =A0 =A0deluxe LED controls =A0 =A0 touchpad support LED c=
ommands
>> + * 1 0x80 =A0 =A0covered pad =A0 =A0 =A0 =A0 =A0 =A0 W clipped to 1=
4, 15 =3D=3D pad mostly covered
>> + * 2 0x01 =A0 =A0clickpad bit 1 =A0 =A0 =A0 =A0 =A02-button ClickPa=
d
>> + * 2 0x02 =A0 =A0deluxe LED controls =A0 =A0 touchpad support LED c=
ommands
>> =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ala multimedia control bar
>> =A0 * 2 0x04 =A0 =A0reduced filtering =A0 =A0 =A0 firmware does less=
 filtering on
>> =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 position data, driver should watch
>> =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 for noise.
>> =A0 */
>> -#define SYN_CAP_CLICKPAD(ex0c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((ex0c) =
& 0x100000) /* 1-button ClickPad */
>> -#define SYN_CAP_CLICKPAD2BTN(ex0c) =A0 ((ex0c) & 0x000100) /* 2-but=
ton ClickPad */
>> +#define SYN_CAP_ADJ_THRESHOLD(ex0c) =A0((ex0c) & 0x010000)
>> =A0#define SYN_CAP_MAX_DIMENSIONS(ex0c) ((ex0c) & 0x020000)
>> +#define SYN_CAP_CLEARPAD(ex0c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((ex0c) =
& 0x040000)
>> =A0#define SYN_CAP_ADV_GESTURE(ex0c) =A0 =A0((ex0c) & 0x080000)
>> +#define SYN_CAP_CLICKPAD(ex0c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((ex0c) =
& 0x100000) /* 1-button ClickPad */
>> +#define SYN_CAP_MULTIFINGER_MODE(ex0c) =A0 =A0 =A0 ((ex0c) & 0x6000=
00)
>> +#define SYN_CAP_COVERED_PAD(ex0c) =A0 =A0((ex0c) & 0x800000)
>> +#define SYN_CAP_CLICKPAD2BTN(ex0c) =A0 ((ex0c) & 0x000100) /* 2-but=
ton ClickPad */
>> +#define SYN_CAP_DELUXE_LED(ex0c) =A0 =A0 ((ex0c) & 0x000200)
>> +#define SYN_CAP_REDUCED_FILTERING(ex0c) =A0 =A0 =A0((ex0c) & 0x0004=
00)
>>
>> =A0/* synaptics modes query bits */
>> =A0#define SYN_MODE_ABSOLUTE(m) =A0 =A0 =A0 =A0 ((m) & (1 << 7))
>
> I may not be the most knowledgeable developer on Synaptics, but I thi=
nk
> I'm somewhat knowledgeable and I can't figure out what each of the
> bitmasks does now. Since we now have many of them defined, could you =
add
> documentation about what each means? For example, I don't know if
> SYN_CAP_CLICKPAD is set in conjunction with SYN_CAP_CLICKPAD2BTN, or =
if
> they are mutually exclusive. I also don't know what SYN_CAP_CLICKPAD2=
BTN
> means anyways :).

Me neither.  All this patch does is convert some spaces to tabs, and
reorder the defines so that their order matches that of the
descriptions.  The descriptions are what Dmitry added in a previous
commit.

>
> I'm curious, are you basing this work on documentation or
> reverse-engineering? Maybe you can't say :). It would be awesome if
> someone at Synaptics would just release the documentation for these
> advanced features already...
>
> Thanks!
>
> -- Chase
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
