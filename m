From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Sat, 04 Sep 2010 00:36:08 +0530
Message-ID: <4C814720.1040607@codeaurora.org>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com> <4C809F7B.2020807@codeaurora.org> <20100903164032.GC2200@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:19862 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0ICTGS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 15:06:18 -0400
In-Reply-To: <20100903164032.GC2200@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>, sameo@linux.intel.com, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

Hi Dmitry,

On 9/3/2010 10:10 PM, Dmitry Torokhov wrote:
> 
>>
>>> +
>>> +static struct platform_driver ab8500_ponkey_driver = {
>>> +	.driver		= {
>>> +		.name	= "ab8500-poweron-key",
>>> +		.owner	= THIS_MODULE,
>>> +	},
>>> +	.probe		= ab8500_ponkey_probe,
>>> +	.remove		= __devexit_p(ab8500_ponkey_remove),
>>
>> It is not must for this driver to go through, but what would be the behaviour of
>> pwr-key on suspend and resume? Do you want power key to wakeup the system from sleep?
>> OR don't want to make it as wakeup source?
> 
> I am about to apply the patch so if you decide to do any PM changes they
> shoudl go as a separete path please.
> 

Please go ahead and merge it. Thanks.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
