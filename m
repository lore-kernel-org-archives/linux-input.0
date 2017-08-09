From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v9 00/12] rk808: Add RK805 support
Date: Wed, 09 Aug 2017 11:35:53 +0200
Message-ID: <1741653.yAH6rPlhTH@phil>
References: <1502244643-11712-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502244643-11712-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Cc: Joseph Chen <chenjh@rock-chips.com>, gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, tony.xie@rock-chips.com, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, linux-gpio@vger.kernel.org, wdc@rock-chips.com, broonie@kernel.org, linux-input@vger.kernel.org, mark.rutland@arm.com, w.egorov@phytec.de
List-Id: linux-input@vger.kernel.org

Hi Joseph,

Am Mittwoch, 9. August 2017, 10:10:41 CEST schrieb Joseph Chen:
> change in v9:
> PATCH V9 1/12:  (1) fix spelling issue: s/Chip/chip/
> 		(2) add: Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> PATCH V9 2/12 ~ 12/12: they are applied and no changes, so I don't resend them.

I don't know Lee's workflow, but I'm not sure that is actually true.

I.e. he added "for his own reference" Acked-for-MFD-by: tags to the
patches, but did not apply them (and therefore you cannot find them on [0])

So I'd think you might need to send everything again?


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next
