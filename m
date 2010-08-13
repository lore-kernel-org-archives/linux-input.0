From: Neil Leeder <nleeder@codeaurora.org>
Subject: Re: [PATCH v2] input: mouse: add qci touchpad driver
Date: Fri, 13 Aug 2010 17:56:41 -0400
Message-ID: <4C65BF99.9030601@codeaurora.org>
References: <1281631760-15589-1-git-send-email-nleeder@codeaurora.org> <4C642E6D.6000908@codeaurora.org> <4C64363A.4080406@codeaurora.org> <20100813024912.GA2661@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:38413 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab0HMV4o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Aug 2010 17:56:44 -0400
In-Reply-To: <20100813024912.GA2661@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stepan Moskovchenko <stepanm@codeaurora.org>, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>, Trilok Soni <tsoni@codeaurora.org>

On 8/12/2010 10:49 PM, Dmitry Torokhov wrote:
> On Thu, Aug 12, 2010 at 01:58:18PM -0400, Neil Leeder wrote:
> Actually, since this is not a new touchpad but simply a PS/2 interface
> it should be implemented as a serio driver, not input device driver.
>
Dmitri,

Thanks for supplying that serio driver. I just have a couple of questions.

Even though the interface on the wpce775x EC happens to be a PS/2 
interface, this is completely hidden by the firmware on that device. To 
the linux driver it looks like a dedicated i2c connection directly to 
the touchpad. You can't substitute any other device on that PS/2 
interface without rewriting the firmware in the EC - it's not a generic 
interface.  A manufacturer could even move the touchpad from the PS/2 
interface to say GPIOs, re-write the firmware and the linux driver 
couldn't tell the difference. Does that change the rationale for using a 
serio driver?

If the request to use a serio driver is still valid, then it seems that 
the workqueue from the interrupt handler sends each byte of data 
received over i2c in a separate serio_interrupt() call to the touchpad 
driver. Touchpad data comes in 3-byte packets, so the touchpad driver 
will have to re-assemble the packet from 3 separate interrupts. Is that 
the intended use?

> Could you please tell me if the following works for you? Note that it
> expects IRQ to be set up properly (edge vs. level trigger) by the
> platform code

The i2c_board_info that supplies the irq # from platform code doesn't 
have a way to set i2c flags, and can't set_irq_type() until after 
irq_request(). This may require another platform_data struct to pass the 
trigger level in.

Thanks.

--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
