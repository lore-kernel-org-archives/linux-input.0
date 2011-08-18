From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 5/6] Input: elantech - clean up elantech_init
Date: Thu, 18 Aug 2011 11:08:08 +0800
Message-ID: <4E4C8218.8040100@cn.fujitsu.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-6-git-send-email-jj_ding@emc.com.tw> <CAGS+omDVn1uoU85pPN+jeHMTMp83EA13b3E8Sca0QOqDBZHQFg@mail.gmail.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:60459 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754902Ab1HRDJK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 23:09:10 -0400
In-Reply-To: <CAGS+omDVn1uoU85pPN+jeHMTMp83EA13b3E8Sca0QOqDBZHQFg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On 08/18/2011 11:04 AM, Daniel Kurtz wrote:
> On Thu, Aug 18, 2011 at 9:57 AM, JJ Ding<jj_ding@emc.com.tw>  wrote:
>> Group property setting code into elantech_set_properties.
>>
>> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
>> ---
>>   drivers/input/mouse/elantech.c |   69 ++++++++++++++++++++++-----------------
>>   1 files changed, 39 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
>> index 7b9b6e5..ddd40eb 100644
>> --- a/drivers/input/mouse/elantech.c
>> +++ b/drivers/input/mouse/elantech.c
>> @@ -791,6 +791,42 @@ static int elantech_reconnect(struct psmouse *psmouse)
>>   }
>>
>>   /*
>> + * determine hardware version and set some properties according to it.
>> + */
>> +static void elantech_set_properties(struct elantech_data *etd)
>> +{
>> +       /*
>> +        * Assume every version greater than 0x020030 is new EeePC style
>> +        * hardware with 6 byte packets, except 0x020600
>> +        */
>> +       if (etd->fw_version<  0x020030 || etd->fw_version == 0x020600)
>> +               etd->hw_version = 1;
>> +       else
>> +               etd->hw_version = 2;
>> +
>> +       /*
>> +        * Turn on packet checking by default.
>> +        */
>> +       etd->paritycheck = 1;
>
> Assuming paritycheck goes away:
Agree.
>
> Reviewed-by: Daniel Kurtz<djkurtz@chromium.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Thanks
Wanlong Gao
