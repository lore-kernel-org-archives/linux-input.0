From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 8/9] IR: Add ENE input driver.
Date: Wed, 28 Jul 2010 15:13:12 -0300
Message-ID: <4C507338.3080005@redhat.com>
References: <1280330051-27732-1-git-send-email-maximlevitsky@gmail.com>	 <1280330051-27732-9-git-send-email-maximlevitsky@gmail.com>	 <4C506472.3080506@redhat.com> <1280337215.6590.1.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45050 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746Ab0G1SNH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jul 2010 14:13:07 -0400
In-Reply-To: <1280337215.6590.1.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

Em 28-07-2010 14:13, Maxim Levitsky escreveu:
> On Wed, 2010-07-28 at 14:10 -0300, Mauro Carvalho Chehab wrote: 
>> Em 28-07-2010 12:14, Maxim Levitsky escreveu:
>>> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
>>
>> Please, instead of patch 9/9, do a patch moving ENE driver from staging into 
>> drivers/media/IR, and then a patch porting it into rc-core. This will allow us
>> to better understand what were done to convert it to rc-core, being an example
>> for others that may work on porting the other drivers to rc-core.
> 
> The version in staging is outdated.
> Should I first update it, and then move?

Yes, please. It shouldn't be hard to produce such patches, and this will help
other developers when porting the other drivers. So, it may result on a some gain
at the speed for the other ports.
> 
> Best regards,
> Maxim Levitsky
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

