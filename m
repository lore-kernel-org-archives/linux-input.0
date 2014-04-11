From: Carlo Caione <carlo@caione.org>
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/9] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Fri, 11 Apr 2014 14:03:06 +0200
Message-ID: <CAOQ7t2bkshF3C0=R-fx1=u379txBN1gXOTUocBSwTkLonk-rnA@mail.gmail.com>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
	<1397209093-10077-2-git-send-email-carlo@caione.org>
	<235623053.nj0gFkxyW5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <235623053.nj0gFkxyW5@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org, boris.brezillon@free-electrons.com, linux-sunxi@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Fri, Apr 11, 2014 at 1:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 11 April 2014 11:38:05 Carlo Caione wrote:
>> +#define AXP20X_IRQ(_irq, _off, _mask) \
>> +       [AXP20X_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_mask) }
>> +
>> +static const struct regmap_irq axp20x_regmap_irqs[] = {
>> +       AXP20X_IRQ(ACIN_OVER_V,         0, 7),
>> +       AXP20X_IRQ(ACIN_PLUGIN,         0, 6),
>> +       AXP20X_IRQ(ACIN_REMOVAL,        0, 5),
>> +       AXP20X_IRQ(VBUS_OVER_V,         0, 4),
>> +       AXP20X_IRQ(VBUS_PLUGIN,         0, 3),
>> +       AXP20X_IRQ(VBUS_REMOVAL,        0, 2),
>> +       AXP20X_IRQ(VBUS_V_LOW,          0, 1),
>> +       AXP20X_IRQ(BATT_PLUGIN,         1, 7),
>> +       AXP20X_IRQ(BATT_REMOVAL,        1, 6),
>> +       AXP20X_IRQ(BATT_ENT_ACT_MODE,   1, 5),
>> +       AXP20X_IRQ(BATT_EXIT_ACT_MODE,  1, 4),
>> +       AXP20X_IRQ(CHARG,               1, 3),
>> +       AXP20X_IRQ(CHARG_DONE,          1, 2),
>> +       AXP20X_IRQ(BATT_TEMP_HIGH,      1, 1),
>
> Why do you have to enumerate the interrupts here? Can't you just
> put all the numbers into the DT nodes of the devices using them?
>
> In general, I would say that the mfd driver should not care about
> what is connected to it.

I need this for the regmap irq chip (to be used in regmap_add_irq_chip()).
I'm not sure if you are suggesting to get rid of the irq chip.

br,

-- 
Carlo Caione
