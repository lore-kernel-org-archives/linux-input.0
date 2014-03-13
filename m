From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 2/4] mfd: max8997: handle IRQs using regmap
Date: Thu, 13 Mar 2014 10:44:20 +0100
Message-ID: <1394703860.6546.1.camel@AMDC1943>
References: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
 <1394703532-494-3-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <1394703532-494-3-git-send-email-r.baldyga@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com
List-Id: linux-input@vger.kernel.org

On Thu, 2014-03-13 at 10:38 +0100, Robert Baldyga wrote:
> This patch modifies mfd driver to use regmap for handling interrupts.
> It allows to simplify irq handling process. This modifications needed
> to make small changes in function drivers, which use interrupts.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c     |    3 +-
>  drivers/mfd/Kconfig                 |    2 +-
>  drivers/mfd/Makefile                |    2 +-
>  drivers/mfd/max8997-irq.c           |  373 -----------------------------------
>  drivers/mfd/max8997.c               |  112 ++++++++++-
>  drivers/rtc/rtc-max8997.c           |    2 +-
>  include/linux/mfd/max8997-private.h |   63 +++++-
>  7 files changed, 165 insertions(+), 392 deletions(-)
>  delete mode 100644 drivers/mfd/max8997-irq.c

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Best regards,
Krzysztof Kozlowski
