From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [RFC v1 PATCH 3/6] led: pmic8058: Add PMIC8058 leds driver
Date: Tue, 07 Dec 2010 21:17:19 +0530
Message-ID: <4CFE5707.6030702@codeaurora.org>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org> <1289393281-4459-4-git-send-email-tsoni@codeaurora.org> <4CDB0451.3090303@metafoo.de> <4CDBDE5D.4040801@codeaurora.org> <4CFCE8B7.8080305@codeaurora.org> <4CFE4EAC.9000606@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:62377 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab0LGPrc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Dec 2010 10:47:32 -0500
In-Reply-To: <4CFE4EAC.9000606@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

Hi Peter,

>>>>
>>>> If max_brightness is hardcoded in the driver you can reuse "struct led_info" and
>>>> "struct struct led_platform_data" instead of adding your own structs.
>>>
>>
>> I couldn't remove these pmic8058_led structure due to the "enum pmic8058_led id" member
>> info which I need from every led. This can be removed completely only if I abuse
>> the "flags" parameter in struct led_info to pass the led id. Let me know what you think.
> 
> Hi
> 
> I think that would be ok, other drivers seem to do the same.

Thanks. I will use "flags" parameter for "id" then and submit the re-worked version as V2.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
