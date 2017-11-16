From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 devices
Date: Thu, 16 Nov 2017 17:07:12 +0800
Message-ID: <30b4c473-9f7b-1657-4a23-e5f789d07c80@canonical.com>
References: <20171115063404.10066-1-aaron.ma@canonical.com>
 <20171115083529.jmlpcj4td4evj3xl@pali>
 <TYXPR01MB07195A0116F835764DE99882C72E0@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43207 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758221AbdKPJHW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Nov 2017 04:07:22 -0500
In-Reply-To: <TYXPR01MB07195A0116F835764DE99882C72E0@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Hi Masaki Ota:

Yes, the laptop is L570.

If your code is right, the workaround code for L570 must be done.

Please fix it ASAP.

Regards,
Aaron

On 11/16/2017 03:27 PM, Masaki Ota wrote:
> Hi, Pali, Aaron,
> 
> Current code is correct device setting, previous code is wrong.
> If the trackstick does not work(DUALPOINT flag disable), Device Firmware setting is wrong.
> 
> But recently I received the same report from Thinkpad L570 user, and I checked this device and found this device Firmware setting is wrong. Sorry for our mistake.
> Is your laptop L570 ?
> 
> I will add code that supports the trackstick for this device.
> 
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Pali Rohár [mailto:pali.rohar@gmail.com] 
> Sent: Wednesday, November 15, 2017 5:35 PM
> To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; dmitry.torokhov@gmail.com; Aaron Ma <aaron.ma@canonical.com>
> Subject: Re: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 devices
> 
> On Wednesday 15 November 2017 14:34:04 Aaron Ma wrote:
>> There is a regression of commit 4a646580f793 ("Input: ALPS - fix 
>> two-finger scroll breakage"), ALPS device fails with log:
>>
>> psmouse serio1: alps: Rejected trackstick packet from non DualPoint 
>> device
>>
>> ALPS device with id "74 03 28" report OTP[0] data 0xCE after commit 
>> 4a646580f793, after restore the OTP reading order, it becomes to 0x10 
>> as before and reports the right flag.
>>
>> Fixes: 4a646580f793 ("Input: ALPS - fix two-finger scroll breakage")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>>  drivers/input/mouse/alps.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c 
>> index 579b899add26..c59b8f7ca2fc 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -2562,8 +2562,8 @@ static int alps_set_defaults_ss4_v2(struct 
>> psmouse *psmouse,
>>  
>>  	memset(otp, 0, sizeof(otp));
>>  
>> -	if (alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]) ||
>> -	    alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]))
>> +	if (alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]) ||
>> +	    alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]))
>>  		return -1;
>>  
>>  	alps_update_device_area_ss4_v2(otp, priv);
> 
> Masaki Ota, please look at this patch as it partially revert your commit
> 4a646580f793 ("Input: ALPS - fix two-finger scroll breakage"). Something smells here.
> 
> --
> Pali Rohár
> pali.rohar@gmail.com
> 
