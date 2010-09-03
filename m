From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Fri, 03 Sep 2010 13:24:03 +0530
Message-ID: <4C80A99B.9010402@codeaurora.org>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com> <4C809F7B.2020807@codeaurora.org> <33A307AF30D7BF4F811B1568FE7A9B181C768836@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:15484 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab0ICHyH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 03:54:07 -0400
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B181C768836@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar R IYER <sundar.iyer@stericsson.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Sundar,

On 9/3/2010 12:50 PM, Sundar R IYER wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Trilok Soni [mailto:tsoni@codeaurora.org]
>> It is not must for this driver to go through, but what would be the behaviour of
>> pwr-key on suspend and resume? Do you want power key to wakeup the system
>>from sleep?
>> OR don't want to make it as wakeup source?
> 
> This is from the AB8500 PMIC which is on always-on power source. All the AB8500 interrupts
> to the system are by platform configuration wakeup source, which is handled separately by 
> a PRCM unit on the DB8500 and hence no suspend/resume helpers or wakeup configuration 
> for the Pon-Key.

You can still mask these interrupts at .set_wake if they are not enabled as wakeup source. 
I am not sure if you guys have implemented .set_wake in PMIC irq core code or not. I need to check.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
