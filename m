From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [Patch v2] input:rohm based bu21013 touch panel controller driver
 support
Date: Thu, 09 Sep 2010 19:16:19 +0530
Message-ID: <4C88E52B.3020107@codeaurora.org>
References: <81C3A93C17462B4BBD7E272753C1057916DE831AF4@EXDCVYMBSTM005.EQ1STM.local> <4C88CEC1.1010209@codeaurora.org> <81C3A93C17462B4BBD7E272753C1057916DE831C23@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:21689 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab0IINqZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 09:46:25 -0400
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057916DE831C23@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

On 9/9/2010 6:50 PM, Naveen Kumar GADDIPATI wrote:
> Hi Trilok,
> 
>> -----Original Message-----
>> From: Trilok Soni [mailto:tsoni@codeaurora.org]
>> Sent: Thursday, September 09, 2010 5:41 PM
>> To: Naveen Kumar GADDIPATI
>> Cc: Dmitry Torokhov; linux-input@vger.kernel.org;
>> STEricsson_nomadik_linux
> 
> 
>>> +
>>> +static struct i2c_driver bu21013_driver = {
>>> +       .driver = {
>>> +               .name   =       DRIVER_TP,
>>> +               .owner  =       THIS_MODULE,
>>> +       },
>>> +       .probe          =       bu21013_probe,
>>> +#ifdef CONFIG_PM
>>> +       .suspend        =       bu21013_suspend,
>>> +       .resume         =       bu21013_resume,
>>> +#endif
>>
>> Better to move these suspend and resume to dev_pm_ops.
>>
> 	How we could dev_pm_ops in i2c driver structure?
> 

Refer: drivers/input/keyboard/adp5588-keys.c as example.

---Trilok Soni
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
