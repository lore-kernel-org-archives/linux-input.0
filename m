From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 0/6] elantech extend version support and add semi-mt
Date: Tue, 17 May 2011 14:06:42 +0200
Message-ID: <4DD264D2.701@tudelft.nl>
References: <4DCE24BE.70908@tudelft.nl> <20110516111552.GA10453@polaris.bitmath.org> <20110517054432.GA20428@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:58533 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab1EQMGp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 08:06:45 -0400
In-Reply-To: <20110517054432.GA20428@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

Hello,

Thanks to both of you for your comments.

Op 17-05-11 07:44, Dmitry Torokhov schreef:
> On Mon, May 16, 2011 at 01:15:52PM +0200, Henrik Rydberg wrote:
>> Hi =C9ric,
:
>>
>> Excellent work, thank you so much. A couple of tiny tiny details:
>>
>> [patch 1]
>>
>> +In the wild, there appear to be more versions, such as 04.03.01, 04=
=2E04.11. There
>> +appear to be almost no difference excepted the EF113 which do not r=
eport
>>
>> no difference, except
Indeed... I'll try to fix it in another patch.

>>
>> [patch 3]
>>
>> @@ -100,14 +100,22 @@ struct elantech_data {
>>          unsigned char reg_26;
>>          unsigned char debug;
>>          unsigned char capabilities;
>> -       bool paritycheck;
>> +       unsigned char paritycheck;
>>          bool jumpy_cursor;
>> +       unsigned char reports_pres :1;
>>          unsigned char hw_version;
>>          unsigned int fw_version;
>>          unsigned int single_finger_reports;
>>          unsigned char parity[256];
>>   };
>>
>> Any particular reason to use unsigned char instead of bool here, and=
 to
>> restrict report_pres to a single bit? Bool for both seems apt.
paritycheck became a type (between 0-3), that's why it can't be bool.=20
Anyway, this was dropped by Dmitry.

reports_pres would make much more sense as a bool, you are completely r=
ight!

:
> Thank you for working on this. I applied patches 1 and 4-6; 3rd requi=
red
> some changes but since they were minor I retained Henrik's reviewed-b=
y.
>
> I am not happy with the protocol checks from Dell, I am not sure they
> make much sense; so I dropped patch 3 for now and because of that pat=
ch
> 2 did not make much sense either. Actually patch 2 did not make sense=
 on
> its own in any case as it should have been partially rolled into 3 an=
d
> partially into 4.
Thanks for tweaking the patches. I don't mind dropping patch 3. I had=20
just implemented what was in the other driver, but I let you judge=20
whether it's meaningful. At least on my hardware, I never noticed the=20
detection of any error with them, anyway :-)

I'll try to update and resend patch 2.

See you,
=C9ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
