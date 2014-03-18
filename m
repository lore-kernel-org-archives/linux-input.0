From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 1/4] mfd: max8997: use regmap to access registers
Date: Tue, 18 Mar 2014 18:51:05 +0900
Message-ID: <53281709.5010102@samsung.com>
References: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
 <1394703532-494-2-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44596 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbaCRJvH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2014 05:51:07 -0400
In-reply-to: <1394703532-494-2-git-send-email-r.baldyga@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com

On 03/13/2014 06:38 PM, Robert Baldyga wrote:
> This patch modifies max8997 driver and each associated function driver,
> to use regmap instead of operating directly on i2c bus. It will allow to
> simplify IRQ handling using regmap-irq.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c     |   31 ++++----
>  drivers/input/misc/max8997_haptic.c |   34 +++++----
>  drivers/leds/leds-max8997.c         |   13 ++--
>  drivers/mfd/Kconfig                 |    1 +
>  drivers/mfd/max8997-irq.c           |   64 +++++++---------
>  drivers/mfd/max8997.c               |  141 ++++++++++++++++-------------------
>  drivers/power/max8997_charger.c     |   33 ++++----
>  drivers/regulator/max8997.c         |   87 +++++++++++----------
>  drivers/rtc/rtc-max8997.c           |   56 +++++++-------
>  include/linux/mfd/max8997-private.h |   17 ++---
>  10 files changed, 228 insertions(+), 249 deletions(-)
> 

For extcon part,
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

