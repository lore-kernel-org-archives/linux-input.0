From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V5] input synaptics-rmi4: Bug fixes to ATTN GPIO handling.
Date: Tue, 31 Dec 2013 10:43:55 -0800
Message-ID: <20131231184355.GA6897@core.coreip.homeip.net>
References: <1388455525-30610-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:53146 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336Ab3LaSn7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Dec 2013 13:43:59 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so12874655pbb.14
        for <linux-input@vger.kernel.org>; Tue, 31 Dec 2013 10:43:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1388455525-30610-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Mon, Dec 30, 2013 at 06:05:25PM -0800, Christopher Heiny wrote:
> This patch fixes some bugs in handling of the RMI4 attention line GPIO.
> 
> 1) in enable_sensor(), eliminate the complicated check on ATTN and just 
> call process_interrupt_requests().  This will have minimal overhead if ATTN
> is not asserted, and clears the state of the RMI4 device in any case.
> 
> 2) Correctly free the GPIO in rmi_driver_remove().
> 
> 3) in rmi_driver_probe()
>     - declare the name of the attention gpio (GPIO_LABEL)
>     - use gpio_request_one() to get the gpio and export it.
>     - simplify (somewhat) conditional gpio acquisition logic and combine 
>       with interrupt setup
> 
> 4) use gpio_is_valid() instead of comparing to 0.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>


Applied, thank you.

-- 
Dmitry
