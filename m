From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 4/4] mfd: max8997: move regmap handling to function
 drivers
Date: Thu, 13 Mar 2014 10:50:11 +0100
Message-ID: <1394704211.6546.3.camel@AMDC1943>
References: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
 <1394703532-494-5-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <1394703532-494-5-git-send-email-r.baldyga@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com
List-Id: linux-input@vger.kernel.org

On Thu, 2014-03-13 at 10:38 +0100, Robert Baldyga wrote:
> This patch moves code creating new i2c clients and regmaps to function
> drivers which use them. It allows to avoid creating this instances when
> individual function drivers are not enabled.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c     |  131 +++++++++++++++++++++++++--
>  drivers/input/misc/max8997_haptic.c |  117 +++++++++++++++++++-----
>  drivers/mfd/max8997.c               |  169 +----------------------------------
>  drivers/rtc/rtc-max8997.c           |   78 +++++++++++-----
>  include/linux/mfd/max8997-private.h |   14 +--
>  5 files changed, 284 insertions(+), 225 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
