From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [RFC v1 PATCH 3/6] led: pmic8058: Add PMIC8058 leds driver
Date: Mon, 06 Dec 2010 19:14:23 +0530
Message-ID: <4CFCE8B7.8080305@codeaurora.org>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org> <1289393281-4459-4-git-send-email-tsoni@codeaurora.org> <4CDB0451.3090303@metafoo.de> <4CDBDE5D.4040801@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:27763 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab0LFNo0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Dec 2010 08:44:26 -0500
In-Reply-To: <4CDBDE5D.4040801@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

Hi Peter,

> 
>>> +
>>> +/**
>>> + * struct pmic8058_led - per led data
>>> + * @name - name of the led
>>> + * @default_trigger - default trigger which needs to e attached
>>> + * @max_brightness - maximum brightness level supported by the led
>>> + * @id - supported led id
>>> + */
>>> +struct pmic8058_led {
>>> +	const char	*name;
>>> +	const char	*default_trigger;
>>> +	unsigned	max_brightness;
>> Should max_brightness not rather be hardcoded in the driver? As far as I can tell it
>> depend on the hardware and is 4 bits wide for flash and bl leds and 5 bits for the
>> others.
>>> +	int		id;
>>
>> enum pmic8058_leds instead of int
> 
> Ack.
> 
>>> +struct pmic8058_leds_platform_data {
>>> +	int			num_leds;
>> size_t
> 
> Ack.
> 
>>> +	struct pmic8058_led	*leds;
>>> +};
>>
>>
>> If max_brightness is hardcoded in the driver you can reuse "struct led_info" and
>> "struct struct led_platform_data" instead of adding your own structs.
> 

I couldn't remove these pmic8058_led structure due to the "enum pmic8058_led id" member
info which I need from every led. This can be removed completely only if I abuse
the "flags" parameter in struct led_info to pass the led id. Let me know what you think.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
