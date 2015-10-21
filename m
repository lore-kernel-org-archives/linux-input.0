From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Regression since commit 92bac83
Date: Wed, 21 Oct 2015 10:30:47 +0200
Message-ID: <56274D37.8050009@redhat.com>
References: <5624327B.7080906@lwfinger.net> <5624A503.7090609@redhat.com>
 <56251268.2060203@lwfinger.net> <562627D9.6020109@redhat.com>
 <20151021081936.GB15219@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57278 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787AbbJUIax (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 04:30:53 -0400
In-Reply-To: <20151021081936.GB15219@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi,

On 21-10-15 10:19, Pali Roh=C3=A1r wrote:
> On Tuesday 20 October 2015 13:39:05 Hans de Goede wrote:
>>  From 5d21a8004260c3e6287bde81c2a9e8f80144e77c Mon Sep 17 00:00:00 2=
001
>> From: Hans de Goede <hdegoede@redhat.com>
>> Date: Tue, 20 Oct 2015 11:12:07 +0200
>> Subject: [PATCH] alps: Only the Dell Latitude D420/430/620/630 have =
separate
>>   stick button bits
>>
>> commit 92bac83dd79e ("Input: alps - non interleaved V2 dualpoint has
>> separate stick button bits") assumes that all alps v2 non-interleave=
d
>> dual point setups have the separate stick button bits.
>>
>> Later we limited this to Dell laptops only because of reports that t=
his
>> broke things on non Dell laptops. Now it turns out that this breaks =
things
>> on the Dell Latitude D600 too. So it seems that only the Dell Latitu=
de
>> D420/430/620/630, which all share the same touchpad / stick combo,
>> have these separate bits.
>>
>> This patch limits the checking of the separate bits to only these mo=
dels
>> fixing regressions with other models.
>>
>> Reported-and-tested-by: Larry Finger <Larry.Finger@lwfinger.net>
>> Cc: stable@vger.kernel.org
>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/input/mouse/alps.c | 48 ++++++++++++++++++++++++++++++++++=
++++++------
>>   1 file changed, 42 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index 4d24686..41e6cb5 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -100,7 +100,7 @@ static const struct alps_nibble_commands alps_v6=
_nibble_commands[] =3D {
>>   #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
>>   #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleave=
d with
>>   					   6-byte ALPS packet */
>> -#define ALPS_DELL		0x100	/* device is a Dell laptop */
>> +#define ALPS_STICK_BITS		0x100	/* separate stick button bits */
>>   #define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
>>
>>   static const struct alps_model_info alps_model_data[] =3D {
>> @@ -159,6 +159,43 @@ static const struct alps_protocol_info alps_v8_=
protocol_data =3D {
>>   	ALPS_PROTO_V8, 0x18, 0x18, 0
>>   };
>>
>> +/*
>> + * Some v2 models report the stick buttons in separate bits
>> + */
>> +static const struct dmi_system_id alps_dmi_has_separate_stick_butto=
ns[] =3D {
>> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
>> +	{
>> +		/* Extrapolated from other entries */
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D420"),
>> +		},
>> +	},
>> +	{
>> +		/* Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl> */
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D430"),
>> +		},
>> +	},
>> +	{
>> +		/* Reported-by: Hans de Goede <hdegoede@redhat.com> */
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D620"),
>> +		},
>> +	},
>> +	{
>> +		/* Extrapolated from other entries */
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D630"),
>> +		},
>> +	},
>> +#endif
>> +	{ }
>> +};
>> +
>
> Hi! Are you sure that above machines do not have variants without
> ALPS_DUALPOINT or without ALPS_PASS? Because if yes, then we could se=
e
> another break.

Yes I'm sure that these machines always come with a dualpoint setup
with pass-through support. The 20/30 models are in essence the same
with just a newer version core2duo dropped in (they changed the model
now since the newer core2duo-s where the first x86_64 cpu-s from Intel,
and the 4x0 / 6x0 models have the exact same dualpoint setup, which is
why both Hans de Bruin and me were seeing the same bug.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
