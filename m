From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] input: sh_keysc: Switch to threaded IRQ handler
Date: Thu, 28 Apr 2011 15:46:16 +0900
Message-ID: <BANLkTi=t0p-m-nNssH8dF6K00aX+6mt60w@mail.gmail.com>
References: <20110421133824.8698.22092.sendpatchset@t400s>
	<20110428062952.GF31734@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44373 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab1D1GqR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2011 02:46:17 -0400
In-Reply-To: <20110428062952.GF31734@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, simon@horms.net, linux-sh@vger.kernel.org

On Thu, Apr 28, 2011 at 3:29 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Apr 21, 2011 at 10:38:24PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Update the KEYSC driver to make use of threaded IRQs
>> with IRQF_ONESHOT.
>>
>
> Explanation of why this is needed is missing.
>
> Thanks.

Sorry for not giving you a more complete commit message.

The reason for this change is to improve interrupt latency. This
driver is using udelay() in the ISR to make sure the hardware has
stabilized. Without using interrupt threads this delay may affect the
latency of the rest of the system.

Would you like me to resend a V2?

Thanks,

/ magnus
