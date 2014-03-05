From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] mfd: max8997: use regmap to access registers
Date: Wed, 5 Mar 2014 10:54:39 -0800
Message-ID: <20140305185439.GC5453@core.coreip.homeip.net>
References: <1394031497-16648-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394031497-16648-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Robert,

On Wed, Mar 05, 2014 at 03:58:17PM +0100, Robert Baldyga wrote:
>  
> -int max8997_write_reg(struct i2c_client *i2c, u8 reg, u8 value)
> +int max8997_write_reg(struct regmap *map, u8 reg, u8 value)

Why don't you make read/write reg to take struct max8997_dev as argument
instead of regmap? regmap seems to be the current implementation du jur,
but that is core's detail, functions do not need to care.

Thanks.

-- 
Dmitry
