From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v4 RESEND 1/3] Input: egalax_ts: get gpio from devicetree
Date: Thu, 11 Oct 2012 17:23:11 +0800
Message-ID: <50768FFF.9060702@gmail.com>
References: <1349860323-12786-1-git-send-email-jason77.wang@gmail.com> <1349860323-12786-2-git-send-email-jason77.wang@gmail.com> <20121010163036.GC19335@core.coreip.homeip.net> <20121011085535.GA31464@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:58004 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab2JKJX1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 05:23:27 -0400
In-Reply-To: <20121011085535.GA31464@S2101-09.ap.freescale.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hui Wang <jason77.wang@gmail.com>, jiejing.zhang@freescale.com, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Shawn Guo wrote:
> Add LAKML ...
>
> On Wed, Oct 10, 2012 at 09:30:36AM -0700, Dmitry Torokhov wrote:
>   
>> Hi Hui,
>>
>> On Wed, Oct 10, 2012 at 05:12:01PM +0800, Hui Wang wrote:
>>     
>>> The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
>>> and don't support this API anymore.
>>>
>>> The i.MX6q sabrelite platform equips an egalax touchscreen controller,
>>> and this platform already transfered to GENERIC_GPIO framework, to
>>> support this driver, we use a more generic way to get gpio.
>>>       
>> Unfortunately this does break the driver for platforms that do still
>> support irq_to_gpio and have not transitioned to device tree (yet?).
>> It looks like the API suffered from premature deletion...
>>
>> I really do not want to add a new platform data structure with only gpio
>> in it, is there a better way to detect if irq_to_gpio() (even if only a
>> stub) is available?
>>
>>     
> If CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is not enabled for an architecture,
> the irq_to_gpio() in include/linux/gpio.h will tell unavailability by
> returning -EINVAL.  But ARM
>   
So far, the only way i can figure out is to add following in the 
arch/arm/include/asm/gpio.h

static inline int arm_irq_to_gpio(unsigned int irq)
{
return -EINVAL;
}

#ifndef irq_to_gpio
#define irq_to_gpio arm_irq_to_gpio
#endif

And remove all irq_to_gpio() function definitions in the arch/arm/, if 
mach want a specific irq_to_gpio, they can use macro to define their own.

Regards,
Hui.
