From: Neil Leeder <nleeder@codeaurora.org>
Subject: Re: [PATCH 0/1] input: keyboard: add qci keyboard driver
Date: Fri, 03 Sep 2010 15:13:10 -0400
Message-ID: <4C8148C6.2010006@codeaurora.org>
References: <4C7838DD.1020004@codeaurora.org> <201008271533.01542.dmitry.torokhov@gmail.com> <4C7BF6D2.5080501@codeaurora.org> <20100830215556.GC28865@core.coreip.homeip.net> <4C7D6C17.1070604@codeaurora.org> <20100901063430.GG23585@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:50604 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab0ICTNM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 15:13:12 -0400
In-Reply-To: <20100901063430.GG23585@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Hsin.Wu@quantatw.com, mcuos.com@gmail.com

On 9/1/2010 2:34 AM, Dmitry Torokhov wrote:
>
> OK, I give up on pursuit of serio solution. Again ;)

Dmitry,

Don't give up yet... I've been talking to Quanta and they are using a 
different EC in their new products, which should have better firmware 
support for serio over i2c. When I get the new hardware I will try again 
to overcome the issues that showed up on the previous firmware, and I'll 
submit new patches for both touchpad and keyboard.

Thanks.

--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
