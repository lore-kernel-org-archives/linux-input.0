From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/3] mfd: max8997: use regmap to access registers
Date: Tue, 11 Mar 2014 16:20:11 +0100
Message-ID: <1394551211.24263.34.camel@AMDC1943>
References: <1394546304-15191-1-git-send-email-r.baldyga@samsung.com>
 <1394546304-15191-2-git-send-email-r.baldyga@samsung.com>
 <1394548336.24263.7.camel@AMDC1943> <531F24C0.3070603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <531F24C0.3070603@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com
List-Id: linux-input@vger.kernel.org

On Tue, 2014-03-11 at 15:59 +0100, Robert Baldyga wrote:
> >> @@ -180,12 +167,12 @@ static struct irq_chip max8997_irq_chip = { 
> >> static irqreturn_t max8997_irq_thread(int irq, void *data) {
> >> struct max8997_dev *max8997 = data; -	u8
> >> irq_reg[MAX8997_IRQ_GROUP_NR] = {}; -	u8 irq_src; +	unsigned int
> >> irq_reg[MAX8997_IRQ_GROUP_NR] = {}; +	unsigned int irq_src; int
> >> ret; int i, cur_irq;
> >> 
> >> -	ret = max8997_read_reg(max8997->i2c, MAX8997_REG_INTSRC, 
> >> &irq_src); +	ret = regmap_read(max8997->regmap,
> >> MAX8997_REG_INTSRC, &irq_src); if (ret < 0) { dev_err(max8997->dev,
> >> "Failed to read interrupt source: %d\n", ret); @@ -194,8 +181,9 @@
> >> static irqreturn_t max8997_irq_thread(int irq, void *data)
> >> 
> >> if (irq_src & MAX8997_IRQSRC_PMIC) { /* PMIC INT1 ~ INT4 */ - 
> >> max8997_bulk_read(max8997->i2c, MAX8997_REG_INT1, 4, - 
> >> &irq_reg[PMIC_INT1]); +		for (i = 0; i < 4; ++i) + 
> >> regmap_read(max8997->regmap, +				MAX8997_REG_INT1+i, 
> >> &irq_reg[PMIC_INT1+i]);
> > 
> > Can't you use here one bulk read instead of 4xregmap_read()?
> 
> Mixing regmap_read and regmap_bulk_read is not good idea, because the
> first function returns register value as unsigned int, but the second
> returns reg value to each single byte. So it would need to do some
> additional operations, and makes things more complicated.

The only mixing I see would be in reading FLASHSTATUS register which
could be resolved with:

if (irq_src & MAX8997_IRQSRC_FLASH) {
       /* Flash Status Interrupt */
       unsigned int data;
       ret = regmap_read(max8997->regmap, MAX8997_REG_FLASHSTATUS,
		       &data);
       irq_reg[FLASH_STATUS] = data;
}

This isn't more complicated than replacing bulk read with a loop :).

Best regards,
Krzysztof
