From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 3/4] mfd: max8997: change irq names to upper case
Date: Thu, 13 Mar 2014 19:18:10 +0900
Message-ID: <532185E2.5080204@samsung.com>
References: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
 <1394703532-494-4-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1394703532-494-4-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org

On 03/13/2014 06:38 PM, Robert Baldyga wrote:
> This patch changes naming convention of MUIC interrupts form CamelCase
> to upper case. It makes names more readable and consistent with another
> interrupt names in max8997 driver.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c     |   32 ++++++++++++++++----------------
>  include/linux/mfd/max8997-private.h |   16 ++++++++--------
>  2 files changed, 24 insertions(+), 24 deletions(-)
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
