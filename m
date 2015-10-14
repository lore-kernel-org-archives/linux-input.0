From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 0/2] input: rotary encoder: Add wake up support
Date: Tue, 13 Oct 2015 23:28:19 -0700
Message-ID: <20151014062819.GD20406@dtor-ws>
References: <1444763620-14652-1-git-send-email-sylvain.rochet@finsecur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36825 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbbJNG2W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2015 02:28:22 -0400
Received: by pacex6 with SMTP id ex6so44853624pac.3
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2015 23:28:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444763620-14652-1-git-send-email-sylvain.rochet@finsecur.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sylvain Rochet <sylvain.rochet@finsecur.com>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>

On Tue, Oct 13, 2015 at 09:13:38PM +0200, Sylvain Rochet wrote:
> Changes since v4:
>   * As suggested by Johan, Reverted the 
>     device_set_wakeup_capable()/device_wakeup_enable() change,
>     stick to device_init_wakeup()
> 
> Changes since v3:
>   * Stick to the "wakeup-source" DT property, we are standardizing on it.
>   * Improved wake-up support: This driver is always supporting wake up
>     support, thus it is now calling device_set_wakeup_capable(dev, true)
>     followed by device_wakeup_enable(dev) if wake up is enabled at boot
>     time. This way the wakeup sysfs tree is always available to the user.
>     Only calling device_init_wakeup(dev, false) totally disable wake up  
>     support at boot tine with no way to enable wake up support furtherly,
>     which isn't nice.                                                    
> 
> Changes since v2:
>   * Using false instead of 0 on boolean
>   * Splitted DT documentation in a separate patch
> 
> Changes since v1:
>   * Using DT property wakeup-source instead of rotary-encoder,wakeup
>   * Renamed int wakeup to bool wakeup_source
>   * Patch cleanup (checkpatch.pl)
> 
> Sylvain Rochet (2):
>   Documentation: input: rotary encoder: Add wakeup-source property
>   input: rotary encoder: Add wake up support

Folded the 2 patches together and applied.

Thank you.

> 
>  .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
>  Documentation/input/rotary-encoder.txt             |  1 +
>  drivers/input/misc/rotary_encoder.c                | 37 ++++++++++++++++++++++
>  include/linux/rotary_encoder.h                     |  1 +
>  4 files changed, 40 insertions(+)
> 
> -- 
> 2.5.1
> 

-- 
Dmitry
