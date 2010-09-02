From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Fri, 03 Sep 2010 01:23:55 +0530
Message-ID: <4C8000D3.3060903@codeaurora.org>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com> <20100901165142.GB6908@core.coreip.homeip.net> <20100902065537.GA26429@bnru01.bnr.st.com> <20100902172222.GA17386@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:27815 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab0IBTyU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 15:54:20 -0400
In-Reply-To: <20100902172222.GA17386@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Dmitry,

On 9/2/2010 10:52 PM, Dmitry Torokhov wrote:
> 
>>>
>>> I'll change it to use normal interrupts locally, no need to resubmit.
>>
>> Changing it to request_irq() will cause it to fail, because __setup_irq
>> will error out if this is a nested thread interrupt and no interrupt
>> thread is specified.  request_any_context_irq() should work, if you
>> would like to get rid of explicitly asking for a threaded irq.
>>
> 
> OK, request_any_context_irq() it is then.

Though request_any_context_irq() would work here, but I would still
prefer to use the request_threaded_irq(..) because power-on key functionality
is in-built to this PMIC chip and it will always be threaded it seems. No new
thread will be created because they did the right thing in their PMIC core
irq code it seems.

We could prefer the request_any_context_irq(...) when we are using the line
(say gpio) coming out of this PMIC and used by generic device driver where
the another h/w design could have memory mapped gpio for the same device driver.

Better to keep this driver with request_threaded_irq(..) only.

---Trilok Soni
 
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
