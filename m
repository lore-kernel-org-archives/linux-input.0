From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH v2] Touchscreen driver for FT5x06 based EDT displays
Date: Wed, 21 Dec 2011 02:47:31 +0400
Message-ID: <4EF11083.8050100@emcraft.com>
References: <1317311577-29742-1-git-send-email-simon.budig@kernelconcepts.de> <1317311577-29742-2-git-send-email-simon.budig@kernelconcepts.de> <20111202145146.33d5b8be@wker> <4EE9D333.8050107@kernelconcepts.de> <20111215131727.83266xhan7tbcl8g@webmail.mnet-online.de> <4EE9F927.7070609@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:44093 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1LTWrB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 17:47:01 -0500
In-Reply-To: <4EE9F927.7070609@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: agust@denx.de, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi Simon,

On 15.12.2011 17:41, Simon Budig wrote:
> If I am not supposed to use irq_to_gpio, then how do I solve this?
> 
> * expect the board file to set up the resp. GPIO direction?

If you don't need GPIO number for anything else (e.g. reading GPIO state
manually) I'd go that way. This introduces a bit of code duplication as
Anatolij already said but I think this is acceptable. If your code wants
IRQ number than pass IRQ number to it. I can't see any reason for the
driver to "know" that IRQ comes from GPIO.

> or
> 
> * use an entry in my platform data (next to the reset pin) for the gpio
> number and then try to map this to an irq number?
> 
> or did I miss the best solution?

Probably it makes sense to configure GPIO as input when the
corresponding interrupt is requested from GPIO driver internally.
However, this will require some rework.

Regards, Ilya.
