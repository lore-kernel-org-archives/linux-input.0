From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Fri, 03 Sep 2010 10:46:55 +0530
Message-ID: <4C8084C7.4020105@codeaurora.org>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com> <20100901165142.GB6908@core.coreip.homeip.net> <20100902065537.GA26429@bnru01.bnr.st.com> <20100902172222.GA17386@core.coreip.homeip.net> <4C8000D3.3060903@codeaurora.org> <20100902202431.GA22482@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:35908 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0ICFRk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 01:17:40 -0400
In-Reply-To: <20100902202431.GA22482@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Dmitry,

On 9/3/2010 1:54 AM, Dmitry Torokhov wrote:
>>
> 
> I disagree. I believe that drivers should use request_threaded_irq()
> only if they _themselves_ require handling interrupts in process context.
> The fact that someone up the stack set up threaded IRQ and not hard IRQ
> should not matter.
> 
> Ideally I'd love request_irq() to be what request_any_context_irq()
> currently is and then we'd have request_hard_irq() for driver that
> absolutely need hard IRQ context.
> 

Well, how I see the request_any_context_irq(...) call is that when the caller
doesn't know the protocol being setup from the irq core code and how the line
he is controlling was being setup, so in that case request_any_context_irq(..)
to be the safest call. But in this case we know that it will be __always__
threaded due the PMIC driven over slow bus.

May be multiple APIs are now causing confusion :)

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
