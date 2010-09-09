From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [Patch v2] input:rohm based bu21013 touch panel controller driver
 support
Date: Fri, 10 Sep 2010 00:14:54 +0530
Message-ID: <4C892B26.9000505@codeaurora.org>
References: <81C3A93C17462B4BBD7E272753C1057916DE831AF4@EXDCVYMBSTM005.EQ1STM.local> <4C88CEC1.1010209@codeaurora.org> <81C3A93C17462B4BBD7E272753C1057916DE831C23@EXDCVYMBSTM005.EQ1STM.local> <4C88E52B.3020107@codeaurora.org> <20100909153930.GA19937@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:49934 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0IISpF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 14:45:05 -0400
In-Reply-To: <20100909153930.GA19937@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Dmitry,
>>
>> Refer: drivers/input/keyboard/adp5588-keys.c as example.
>>
> 
> Hm, indeed I forgot that i2c has been fully wired for dev_pm_ops. I
> should enforce its use then. Thank you for reminding Trilok.
> 
> I wonder if someone could wire SPI as well...
> 

Let me see if I could do that or atleast inspire someone to do it :)

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
