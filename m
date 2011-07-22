From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH] elantech: clean up hardware/firmware version check
Date: Fri, 22 Jul 2011 15:38:59 +0200
Message-ID: <4E297D73.8050404@tudelft.nl>
References: <4DCE24BE.70908@tudelft.nl> <20110516111552.GA10453@polaris.bitmath.org> <20110517054432.GA20428@core.coreip.homeip.net> <4DD6E8F4.5070101@tudelft.nl> <20110704203052.GA22437@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:37065 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab1GVNjD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 09:39:03 -0400
In-Reply-To: <20110704203052.GA22437@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

Op 04-07-11 22:30, Henrik Rydberg schreef:
> Hi =C9ric,
>
>> Find below patch 2 rebased. Actually, as half of if is not useful
>> anymore (we gave up on checking the data for version 2) and you had
>> integrated the other half already, this doesn't contain a lot anymor=
e.
>> So it ends up being just a clean up patch, mostly putting all the
>> version checks in the same place.
>
> Did you get any response to this one?
Not yet.

Dmitry, could you take this patch for elantech?

Cheers,
=C9ric

>
>> According to the protocol document, there are a couple of different
>> versions of the hardware and firmware. Using the version number, it
>> should be possible to distinguish between them, at least for the
>> properties we care about. This moves all the version check together.
>>
>> Signed-off-by: =C9ric Piel<eric.piel@tremplin-utc.net>
>> ---
>>   drivers/input/mouse/elantech.c |   28 ++++++++++++++--------------
>>   1 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/el=
antech.c
>> index 3250356..0d9c547 100644
>> --- a/drivers/input/mouse/elantech.c
>> +++ b/drivers/input/mouse/elantech.c
>> @@ -757,15 +757,25 @@ int elantech_init(struct psmouse *psmouse)
>>   		etd->hw_version =3D 2;
>>   		/* For now show extra debug information */
>>   		etd->debug =3D 1;
>> -		/* Don't know how to do parity checking for version 2 */
>> -		etd->paritycheck =3D 0;
>> +		/* Version 2 doesn't contain control bits */
>> +		etd->paritycheck =3D false;
>>
>>   		if (etd->fw_version>=3D 0x020800)
>>   			etd->reports_pressure =3D true;
>> -
>> +	} else if ((etd->fw_version =3D=3D 0x020022) || (etd->fw_version =3D=
=3D 0x020600)) {
>> +		/*
>> +		 * This firmware suffers from misreporting coordinates when
>> +		 * a touch action starts causing the mouse cursor or scrolled pag=
e
>> +		 * to jump. Enable a workaround.
>> +		 */
>> +		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy c=
ursor workaround\n");
>> +		etd->jumpy_cursor =3D 1;
>> +		etd->debug =3D 1;
>> +		etd->hw_version =3D 1;
>> +		etd->paritycheck =3D true;
>>   	} else {
>>   		etd->hw_version =3D 1;
>> -		etd->paritycheck =3D 1;
>> +		etd->paritycheck =3D true;
>>   	}
>>
>>   	pr_info("assuming hardware version %d, firmware version %d.%d.%d\=
n",
>> @@ -779,16 +789,6 @@ int elantech_init(struct psmouse *psmouse)
>>   		param[0], param[1], param[2]);
>>   	etd->capabilities =3D param[0];
>>
>> -	/*
>> -	 * This firmware suffers from misreporting coordinates when
>> -	 * a touch action starts causing the mouse cursor or scrolled page
>> -	 * to jump. Enable a workaround.
>> -	 */
>> -	if (etd->fw_version =3D=3D 0x020022 || etd->fw_version =3D=3D 0x02=
0600) {
>> -		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy c=
ursor workaround\n");
>> -		etd->jumpy_cursor =3D true;
>> -	}
>> -
>>   	if (elantech_set_absolute_mode(psmouse)) {
>>   		pr_err("failed to put touchpad into absolute mode.\n");
>>   		goto init_fail;
>> --
>> 1.7.5.1
>>
>
>      Acked-by: Henrik Rydberg<rydberg@euromail.se>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
