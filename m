From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 1/3] mfd: max8997: use regmap to access registers
Date: Wed, 12 Mar 2014 15:24:47 +0100
Message-ID: <1394634287.11860.7.camel@AMDC1943>
References: <1394631466-6429-1-git-send-email-r.baldyga@samsung.com>
 <1394631466-6429-2-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:10808 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbaCLOYv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 10:24:51 -0400
In-reply-to: <1394631466-6429-2-git-send-email-r.baldyga@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com

On Wed, 2014-03-12 at 14:37 +0100, Robert Baldyga wrote:
> This patch modifies max8997 driver and each associated function driver,
> to use regmap instead of operating directly on i2c bus. It will allow to
> simplify IRQ handling using regmap-irq.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
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

Looks fine to me:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Best regards,
Krzysztof

