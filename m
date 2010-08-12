From: Neil Leeder <nleeder@codeaurora.org>
Subject: Re: [PATCH v2] input: mouse: add qci touchpad driver
Date: Thu, 12 Aug 2010 13:58:18 -0400
Message-ID: <4C64363A.4080406@codeaurora.org>
References: <1281631760-15589-1-git-send-email-nleeder@codeaurora.org> <4C642E6D.6000908@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:65142 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab0HLR6U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Aug 2010 13:58:20 -0400
In-Reply-To: <4C642E6D.6000908@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stepan Moskovchenko <stepanm@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>

On 8/12/2010 1:25 PM, Stepan Moskovchenko wrote:
> On 8/12/2010 9:49 AM, Neil Leeder wrote:
>> +config MOUSE_QCITP
>> + tristate "Quanta Computer Inc. Touchpad"
>> + depends on I2C
>> + help
>> + This driver supports the touchpad on Quanta smartbook devices.
>> +
>> + Say Y here if you have a Quanta-based smartboot or notepad
> Sorry, very minor point - do you mean "smartbook" here?
>
> A lot of machines are made by Quanta. Should this be given a description
> / option name that is more specific, ie, "Quanta [chip name] Touchpad"
> or even "Quanta I2C Touchpad" ? What you have might be fine, however...
>

Good catch on the typo. I can update the Kconfig item to include I2C as 
you suggested.

--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
