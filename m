From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: convert gpio-keys.c driver to request_any_context_irq
Date: Thu, 16 Dec 2010 09:29:44 -0800
Message-ID: <20101216172943.GB28364@core.coreip.homeip.net>
References: <4D09E939.8030700@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37872 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab0LPR3y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Dec 2010 12:29:54 -0500
Content-Disposition: inline
In-Reply-To: <4D09E939.8030700@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Thu, Dec 16, 2010 at 03:56:01PM +0530, Trilok Soni wrote:
> Hi Dmitry,
> 
> gpio_keys.c driver should be converted to use request_any_context_irq(...)
> infrastructure because some of the devices could use gpios from PMIC like
> chips where their irqs gets registered as nested. I don't have any
> device with such configuration but I was looking at this driver and I thought
> if someone has come across this then they can test and submit the patch.
> 

Hi Trilok,

Yes, I agree.

If someone who has device served by gpio_keys and coudl prepare a patch
changing request_irq() to request_any_context_irq() I'll gladly accept
it.

Thanks.

-- 
Dmitry
