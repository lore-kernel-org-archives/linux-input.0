From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [RESEND v9 06/12] rtc: Kconfig: Name RK805 in Kconfig for
 RTC_DRV_RK808
Date: Thu, 24 Aug 2017 11:17:50 +0200
Message-ID: <20170824091750.yoo5wzg77ftt2wyt@piout.net>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
 <1502848835-24800-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502848835-24800-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-clk-owner@vger.kernel.org
To: Joseph Chen <chenjh@rock-chips.com>
Cc: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, zhangqing@rock-chips.com, robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, wdc@rock-chips.com, tony.xie@rock-chips.com, linux-input@vger.kernel.org, mark.rutland@arm.com, w.egorov@phytec.de, linux-clk@vger.kernel.org, a.zummo@towertech.it, rtc-linux@googlegroups.com
List-Id: linux-input@vger.kernel.org

On 16/08/2017 at 10:00:35 +0800, Joseph Chen wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> The RK808 and RK805 PMICs are using a similar register map.
> We can reuse the rtc driver for the RK805 PMIC. So let's add
> the RK805 in the Kconfig description.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
> ---
>  drivers/rtc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
