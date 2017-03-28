From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
Date: Tue, 28 Mar 2017 09:21:41 +0100
Message-ID: <20170328082141.u2rgnhei5yhhzxdn@dell>
References: <539b8756120ab3558c906f7457e65f94dbe37425.1490608293.git.stwiss.opensource@diasemi.com>
 <201703272258.hWlipe1g%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201703272258.hWlipe1g%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>, kbuild-all@01.org, LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, 27 Mar 2017, kbuild test robot wrote:

> Hi Steve,
> 
> [auto build test WARNING on ljones-mfd/for-mfd-next]
> [also build test WARNING on v4.11-rc4 next-20170327]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Steve-Twiss/Documentation-devicetree-watchdog-da9062-61-watchdog-timer-binding/20170327-215359
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: x86_64-randconfig-x009-201713 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers//mfd/da9062-core.c: In function 'da9062_i2c_probe':
> >> drivers//mfd/da9062-core.c:845:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       chip->chip_type = (int)match->data;
>                         ^

Please use longs or enums.

> vim +845 drivers//mfd/da9062-core.c
> 
>    829		unsigned int irq_base;
>    830		const struct mfd_cell *cell;
>    831		const struct regmap_irq_chip *irq_chip;
>    832		const struct regmap_config *config;
>    833		int cell_num;
>    834		int ret;
>    835	
>    836		chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
>    837		if (!chip)
>    838			return -ENOMEM;
>    839	
>    840		if (i2c->dev.of_node) {
>    841			match = of_match_node(da9062_dt_ids, i2c->dev.of_node);
>    842			if (!match)
>    843				return -EINVAL;
>    844	
>  > 845			chip->chip_type = (int)match->data;
>    846		} else {
>    847			chip->chip_type = id->driver_data;
>    848		}
>    849	
>    850		i2c_set_clientdata(i2c, chip);
>    851		chip->dev = &i2c->dev;
>    852	
>    853		if (!i2c->irq) {
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
