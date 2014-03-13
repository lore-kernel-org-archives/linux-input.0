From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 3/4] mfd: max8997: change irq names to upper case
Date: Thu, 13 Mar 2014 10:44:56 +0100
Message-ID: <1394703896.6546.2.camel@AMDC1943>
References: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
 <1394703532-494-4-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1394703532-494-4-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com
List-Id: linux-input@vger.kernel.org

On Thu, 2014-03-13 at 10:38 +0100, Robert Baldyga wrote:
> This patch changes naming convention of MUIC interrupts form CamelCase
> to upper case. It makes names more readable and consistent with another
> interrupt names in max8997 driver.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c     |   32 ++++++++++++++++----------------
>  include/linux/mfd/max8997-private.h |   16 ++++++++--------
>  2 files changed, 24 insertions(+), 24 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Best regards,
Krzysztof Kozlowski
