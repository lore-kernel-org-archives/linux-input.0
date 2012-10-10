From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: egalax_ts: get gpio from devicetree node
Date: Wed, 10 Oct 2012 11:26:52 +0800
Message-ID: <5074EAFC.1010409@gmail.com>
References: <1345114051-3052-1-git-send-email-jason77.wang@gmail.com> <1345114051-3052-2-git-send-email-jason77.wang@gmail.com> <20120817003125.GA24242@S2101-09.ap.freescale.net> <201210091158.33040.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:61100 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab2JJD1M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Oct 2012 23:27:12 -0400
In-Reply-To: <201210091158.33040.arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Hui Wang <jason77.wang@gmail.com>, devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, linux-input@vger.kernel.org

Arnd Bergmann wrote:
> On Friday 17 August 2012, Shawn Guo wrote:
>   
>> On Thu, Aug 16, 2012 at 06:47:29PM +0800, Hui Wang wrote:
>>     
>>> The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
>>> and don't support this API anymore.
>>>
>>> The i.MX6q sabrelite platform equips an egalax touchscreen controller,
>>> and this platform already transfered to GENERIC_GPIO framework, to
>>> support this driver, we use a more generic way to get gpio.
>>>
>>> Add a return value checking for waking up the controller in the probe
>>> function, this guarantee only a workable device can pass init.
>>>
>>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>>>       
>> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
>>     
>
> What's the status on this patch? I'm still getting build errors from this
> driver, so I guess it was never accepted for the 3.7 merge window.
>
> 	Arnd
>
>   
I forgot to resend this patchset After Dmitry was back to the maillist. 
I will rebase the patchset and resend them to review.

Regards,
Hui.

