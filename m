From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v11 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Fri, 3 Aug 2018 18:10:21 +0800
Message-ID: <201808031831.TJYSQ80i%fengguang.wu@intel.com>
References: <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: kbuild-all@01.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, eballetbo@gmail.com, linus.walleij@linaro.org, mazziesaccount@gmail.com, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

Hi Matti,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ljones-mfd/for-mfd-next]
[also build test WARNING on v4.18-rc7 next-20180802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matti-Vaittinen/mfd-bd71837-mfd-driver-for-ROHM-BD71837-PMIC/20180730-204810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next

smatch warnings:
drivers/mfd/rohm-bd718x7.c:163 bd71837_i2c_probe() warn: unsigned 'button.irq' is never less than zero.

vim +163 drivers/mfd/rohm-bd718x7.c

    88	
    89	static int bd71837_i2c_probe(struct i2c_client *i2c,
    90				    const struct i2c_device_id *id)
    91	{
    92		struct bd71837 *bd71837;
    93		int ret, i;
    94		unsigned int val;
    95	
    96		bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
    97	
    98		if (!bd71837)
    99			return -ENOMEM;
   100	
   101		bd71837->chip_irq = i2c->irq;
   102	
   103		if (!bd71837->chip_irq) {
   104			dev_err(&i2c->dev, "No IRQ configured\n");
   105			return -EINVAL;
   106		}
   107	
   108		bd71837->dev = &i2c->dev;
   109		dev_set_drvdata(&i2c->dev, bd71837);
   110	
   111		bd71837->regmap = devm_regmap_init_i2c(i2c, &bd71837_regmap_config);
   112		if (IS_ERR(bd71837->regmap)) {
   113			dev_err(&i2c->dev, "regmap initialization failed\n");
   114			return PTR_ERR(bd71837->regmap);
   115		}
   116	
   117		ret = regmap_read(bd71837->regmap, BD71837_REG_REV, &val);
   118		if (ret) {
   119			dev_err(&i2c->dev, "Read BD71837_REG_DEVICE failed\n");
   120			return ret;
   121		}
   122		for (i = 0; i < ARRAY_SIZE(supported_revisions); i++)
   123			if (supported_revisions[i] == val)
   124				break;
   125	
   126		if (i == ARRAY_SIZE(supported_revisions)) {
   127			dev_err(&i2c->dev, "Unsupported chip revision\n");
   128			return -ENODEV;
   129		}
   130	
   131		ret = devm_regmap_add_irq_chip(&i2c->dev, bd71837->regmap,
   132					       bd71837->chip_irq, IRQF_ONESHOT, 0,
   133					       &bd71837_irq_chip, &bd71837->irq_data);
   134		if (ret) {
   135			dev_err(&i2c->dev, "Failed to add irq_chip\n");
   136			return ret;
   137		}
   138	
   139		/* Configure short press to 10 milliseconds */
   140		ret = regmap_update_bits(bd71837->regmap,
   141					 BD71837_REG_PWRONCONFIG0,
   142					 BD718XX_PWRBTN_PRESS_DURATION_MASK,
   143					 BD718XX_PWRBTN_SHORT_PRESS_10MS);
   144		if (ret) {
   145			dev_err(&i2c->dev, "Failed to configure button short press timeout\n");
   146			return ret;
   147		}
   148	
   149		/* Configure long press to 10 seconds */
   150		ret = regmap_update_bits(bd71837->regmap,
   151					 BD71837_REG_PWRONCONFIG1,
   152					 BD718XX_PWRBTN_PRESS_DURATION_MASK,
   153					 BD718XX_PWRBTN_LONG_PRESS_10S);
   154	
   155		if (ret) {
   156			dev_err(&i2c->dev, "Failed to configure button long press timeout\n");
   157			return ret;
   158		}
   159	
   160		button.irq = regmap_irq_get_virq(bd71837->irq_data,
   161						  BD71837_INT_PWRBTN_S);
   162	
 > 163		if (button.irq < 0) {
   164			dev_err(&i2c->dev, "Failed to get the IRQ\n");
   165			return button.irq;
   166		}
   167	
   168		ret = devm_mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
   169					   bd71837_mfd_cells,
   170					   ARRAY_SIZE(bd71837_mfd_cells), NULL, 0,
   171					   regmap_irq_get_domain(bd71837->irq_data));
   172		if (ret)
   173			dev_err(&i2c->dev, "Failed to create subdevices\n");
   174	
   175		return ret;
   176	}
   177	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
