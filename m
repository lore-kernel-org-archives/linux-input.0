From: =?ISO-8859-1?Q?Richard_Sch=FCtz?= <r.schtz@t-online.de>
Subject: Re: elantech touchpad issues
Date: Mon, 12 Sep 2011 11:57:06 +0200
Message-ID: <4E6DD772.20004@t-online.de>
References: <4E6633E5.6080108@t-online.de> <87sjo7oef3.fsf@emc.com.tw> <4E6906B9.1080205@t-online.de> <4E6DC5F6.7090008@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout02.t-online.de ([194.25.134.17]:58167 "EHLO
	mailout02.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab1ILJ51 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Sep 2011 05:57:27 -0400
In-Reply-To: <4E6DC5F6.7090008@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>

Am 12.09.2011 10:42, schrieb =C9ric Piel:
> Op 08-09-11 20:17, Richard Sch=FCtz schreef:
>> Am 08.09.2011 06:18, schrieb JJ Ding:
>>
>> Yeah, this fixes the annoying issue with multiple fingers.
>>
>> Now only the problem with the wrong axis ranges is remaining.
>>
>
> I've tried with my version of the hardware (a old v2) and it doesn't
> seem to have the problem you describe.
>
> Basically your problem is that the driver reports ranges as 0-1152 an=
d
> 0-576, but in reality, when you move your finger, the coordinates sta=
y
> in the ranges 0-819, 171-576. So in practice the cursor moves as
> expected but the borders to allow the scrolling don't work. Is that r=
ight?

Exactly.

> I wonder if it's normal that the device has a range even smaller than
> what it reports, and whether something can be done. JJ Ding?
>
> Cheers,
> =C9ric

--=20
Regards,
Richard Sch=FCtz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
