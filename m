From: Jean Delvare <khali@linux-fr.org>
Subject: Re: qt1070: Why IRQF_TRIGGER_NONE?
Date: Thu, 3 May 2012 08:14:49 +0200
Message-ID: <20120503081449.065a8232@endymion.delvare>
References: <CACKLOr1XE+tJ92jbfOHdDQVVsXhsNASrHgENEbiuR+8aBE11cw@mail.gmail.com>
	<4FA1E237.2070404@atmel.com>
	<ABFEDD1A8D2AAF42A54E3C074D49DC720F627464@penmbx02>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:19755 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab2ECGPA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 May 2012 02:15:00 -0400
In-Reply-To: <ABFEDD1A8D2AAF42A54E3C074D49DC720F627464@penmbx02>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Shen, Voice" <Voice.Shen@atmel.com>
Cc: "Wu, Josh" <Josh.wu@atmel.com>, javier Martin <javier.martin@vista-silicon.com>, linux-input@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Axel Lin <axel.lin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, 3 May 2012 05:15:14 +0000, Shen, Voice wrote:
> Hi All,
>   Some information as following,
> 
>   According to the datasheet of qt1070, we can use IRQF_TRIGGER_FALLING or IRQF_TRIGGER_LOW (I think this is the best) for IRQ flag. However, the IRQ line is a GPIO of a SOC. Some SOC can detect the level change of the GPIO, while can not distinguish the falling or rising. So, the IRQ flag depends on the trigger mode of GPIO line.
> 
>   Maybe use the "flags" element in "struct i2c_board_info" to pass the IRQ flag, or add another element named "irqflags" into "struct i2c_board_info". I think this will be better, but I am not sure whether this is a good solution.

i2c_board_info.flags is for I2C client flags, please do not abuse it
for IRQ information.

I have no objection to an irq_flag member being added, however I
remember past discussions where people argued whether it was the right
thing to do or whether the IRQ mode was best set by platform
initialization code. Part of that discussion was archived here:
http://marc.info/?t=128743170300002&r=1&w=2
Said discussion did not result in any code being merged as I don't
think we came to an agreement. Feel free to restart the discussion with
the interested people.

-- 
Jean Delvare
