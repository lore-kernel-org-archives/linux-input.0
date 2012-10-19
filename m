From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/2] input: qt2160: Add support for LEDs.
Date: Fri, 19 Oct 2012 09:37:08 -0700
Message-ID: <20121019163708.GC2152@core.coreip.homeip.net>
References: <1350638470-27966-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:59906 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758741Ab2JSQhS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Oct 2012 12:37:18 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so310438dak.19
        for <linux-input@vger.kernel.org>; Fri, 19 Oct 2012 09:37:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1350638470-27966-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-input@vger.kernel.org, axel.lin@gmail.com

On Fri, Oct 19, 2012 at 11:21:10AM +0200, Javier Martin wrote:
> Outputs x8..x0 of the qt2160 can have leds attached to it.
> This patch handles those outputs using the generic LED
> framework.
> 
> The PWM controls available in the chip are used to achieve
> different levels of brightness.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
> Changes since v2:
>  - Make sure LEDS_CLASS is selected.

I think that if user does not want LEDs the driver shoudl still be
useful so please just guard LED code with #ifdefs and provide dummy
stubs when not in use.

Thanks.

-- 
Dmitry
