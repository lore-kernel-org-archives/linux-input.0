From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] pwm: Get rid of HAVE_PWM
Date: Sun, 7 Oct 2012 12:17:50 +0800
Message-ID: <20121007041748.GN20231@S2101-09.ap.freescale.net>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46711 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab2JGER4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Oct 2012 00:17:56 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3068145pbb.19
        for <linux-input@vger.kernel.org>; Sat, 06 Oct 2012 21:17:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Andrew Jones <drjones@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org

On Thu, Oct 04, 2012 at 08:06:59AM +0200, Thierry Reding wrote:
> Now that all drivers have been moved to the PWM subsystem, remove the
> legacy HAVE_PWM symbol and replace it with the new PWM symbol. While at
> it, select the PWM subsystem and corresponding PWM driver on boards that
> require PWM functionality.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bryan Wu <bryan.wu@canonical.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Ashish Jangam <ashish.jangam@kpitcummins.com>
> Cc: Andrew Jones <drjones@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-leds@vger.kernel.org
> ---
>  arch/arm/Kconfig           |  6 ++----
>  arch/arm/mach-mxs/Kconfig  |  6 ++++--

Shawn Guo <shawn.guo@linaro.org>

>  arch/arm/mach-pxa/Kconfig  | 42 ++++++++++++++++++++++++++++--------------
>  arch/mips/Kconfig          |  3 ++-
>  drivers/input/misc/Kconfig |  4 ++--
>  drivers/leds/Kconfig       |  2 +-
>  include/linux/pwm.h        |  2 +-
>  7 files changed, 40 insertions(+), 25 deletions(-)
