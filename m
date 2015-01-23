From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH RESEND 0/2] Add regulator-haptic device tree
Date: Fri, 23 Jan 2015 15:56:35 +0900
Message-ID: <0c4e01d036d9$ba40dac0$2ec29040$@kernel.org>
References: <1421826960-26491-1-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421826960-26491-1-git-send-email-jaewon02.kim@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jaewon Kim' <jaewon02.kim@samsung.com>, 'Kukjin Kim' <kgene@kernel.org>
Cc: 'Chanwoo Choi' <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Jaewon Kim wrote:
> 
> This patch series adds regulator-haptic device tree in rinato and monk boards.
> 
> The regulator-haptic has haptic motor and it is controlled by
> voltage of regulator via force feedback framework.
> 
> regualtor-haptic driver merged at linux-next
> ref : https://lkml.org/lkml/2014/12/17/477
> 
Found the series in linux-next.

> Jaewon Kim (2):
>   ARM: dts: exynos3250-rinato: Add regulator-haptic node for haptics
>   ARM: dts: exynos3250-monk: Add regulator-haptic node for haptics
> 
OK, looks good to me, will apply this series.

Thanks,
Kukjin
