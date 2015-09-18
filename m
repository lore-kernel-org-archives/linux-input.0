From: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] input: Add new sun4i-keypad driver
Date: Fri, 18 Sep 2015 10:19:55 +1000
Message-ID: <CAJzetvvUscEgTQ0Sr-BF7D6rzN_bfWT1KikRqz+BvSV-2+TWrw@mail.gmail.com>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
	<1442325957-10102-4-git-send-email-yassinjaffer@gmail.com>
	<20150917130520.GD4684@lukather>
Reply-To: yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001a1140c226bb23fd051ffa7dc2
Return-path: <linux-sunxi+bncBDCKXM7WZYLRBK5R5WXQKGQEC6JVGJA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150917130520.GD4684@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--001a1140c226bb23fd051ffa7dc2
Content-Type: text/plain; charset=UTF-8

Hi Maxime

I appreciate your time and efforts .

Do you need that rate to be enforced, or is it some leftover from the
> allwinner BSP?


I've found that clock rate works fine with the default denounce and scan
cycle.
By the way do you have any dev board which expose the keypad pins?

I will try to submit a follow up patch to address these issues.
Thank you again for your valuable review.


Regards.



On Thu, Sep 17, 2015 at 11:05 PM, Maxime Ripard <
maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi,
>
> On Wed, Sep 16, 2015 at 12:05:56AM +1000, yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > From: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > Allwinnner SUN4i Keypad controller is used to interface a SoC
> > with a matrix-typekeypad device.
> > The keypad controller supports multiple row and column lines.
> > A key can be placed at each intersection of a unique
> > row and a unique column.
> > The keypad controller can sense a key-press and key-release and report
> the
> > event using a interrupt to the cpu.
> > This patch adds a driver support to this.
> > The keypad controller driver does not give proper information
> > if more that two keys are selected.
> >
> > Signed-off-by: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/input/keyboard/Kconfig        |  11 ++
> >  drivers/input/keyboard/Makefile       |   1 +
> >  drivers/input/keyboard/sun4i-keypad.c | 361
> ++++++++++++++++++++++++++++++++++
> >  3 files changed, 373 insertions(+)
> >  create mode 100644 drivers/input/keyboard/sun4i-keypad.c
> >
> > diff --git a/drivers/input/keyboard/Kconfig
> b/drivers/input/keyboard/Kconfig
> > index 2e80107..4f2f3f8 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -590,6 +590,17 @@ config KEYBOARD_SUN4I_LRADC
> >         To compile this driver as a module, choose M here: the
> >         module will be called sun4i-lradc-keys.
> >
> > +config KEYBOARD_SUN4I_KEYPAD
> > +     tristate "Allwinner sun4i keypad support"
> > +     depends on ARCH_SUNXI
>
> Is this IP found on all the know SoCs, or just a subset of them?
>
> You probably want to add || COMPILE_TEST in that depends on too.
>
> > +     select INPUT_MATRIXKMAP
> > +     help
> > +       This selects support for the Allwinner keypad
> > +       on Allwinner sunxi SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called sun4i-keypad.
> > +
> >  config KEYBOARD_DAVINCI
> >       tristate "TI DaVinci Key Scan"
> >       depends on ARCH_DAVINCI_DM365
> > diff --git a/drivers/input/keyboard/Makefile
> b/drivers/input/keyboard/Makefile
> > index 1d416dd..d9f54b4 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -57,6 +57,7 @@ obj-$(CONFIG_KEYBOARD_STMPE)                +=
> stmpe-keypad.o
> >  obj-$(CONFIG_KEYBOARD_STOWAWAY)              += stowaway.o
> >  obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)    += st-keyscan.o
> >  obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)   += sun4i-lradc-keys.o
> > +obj-$(CONFIG_KEYBOARD_SUN4I_KEYPAD)  += sun4i-keypad.o
> >  obj-$(CONFIG_KEYBOARD_SUNKBD)                += sunkbd.o
> >  obj-$(CONFIG_KEYBOARD_TC3589X)               += tc3589x-keypad.o
> >  obj-$(CONFIG_KEYBOARD_TEGRA)         += tegra-kbc.o
> > diff --git a/drivers/input/keyboard/sun4i-keypad.c
> b/drivers/input/keyboard/sun4i-keypad.c
> > new file mode 100644
> > index 0000000..995f9665
> > --- /dev/null
> > +++ b/drivers/input/keyboard/sun4i-keypad.c
> > @@ -0,0 +1,361 @@
> > +/*
> > + * Allwinner sun4i keypad Controller driver
> > + *
> > + * Copyright (C) 2015 Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > + *
> > + * Parts of this software are based on (derived from):
> > + * Copyright (C) 2013-2015 liming-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
> > + *                    qys<qinyongshen-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/slab.h>
> > +#include <linux/input.h>
> > +#include <linux/input/matrix_keypad.h>
> > +
> > +/*
> > + * Keypad Controller registers
> > + */
> > +#define KP_CTL                       0x00  /* Keypad Control register */
> > +#define KP_TIMING            0x04  /* Keypad Timing register */
> > +#define KP_INT_CFG           0x08  /* Keypad interrupt Config register
> */
> > +#define KP_INT_STA           0x0c  /* Keypad interrupt Status register
> */
> > +
> > +#define KP_IN_OFFSET         0x10 /* Keypad Input Data register 0 */
> > +#define KP_INX_OFFSET(reg_n) (KP_IN_OFFSET + 4 * (reg_n))
> > +
> > +/* KP_CTL bits */
> > +#define ENABLE(x)            ((x) << 0)
> > +#define COLMASK(x)           ((~x & 0xff) << 8)
> > +#define ROWMASK(x)           ((~x & 0xff) << 16)
>
> Having the name of the register in that define would be great, to spot
> more easily issues (writing a value to another register, for example).
>
> Something like KP_CTL_ENABLE(x) in this case.
>
> > +/* KP_TIMING bits */
> > +#define SCAN_CYCLE(x)                ((x) << 0)
> > +#define DBC_CYCLE(x)         ((x) << 16)
> > +
> > +/* KP_INT_CFG bits */
> > +#define KP_IRQ_FEDGE         BIT(0)
> > +#define      KP_IRQ_REDGE            BIT(1)
> > +
> > +/* KP_INT_STA bits */
> > +#define KP_STA_FEDGE         BIT(0)
> > +#define      KP_STA_REDGE            BIT(1)
> > +
> > +#define KP_MAX_ROWS          8
> > +#define KP_MAX_COLS          8
> > +#define N_ROWS_REG           2
> > +#define KP_ROW_SHIFT         3
> > +#define KP_BIT_SHIFT            32
> > +
> > +#define MAX_MATRIX_KEY_NUM   (KP_MAX_ROWS * KP_MAX_COLS)
> > +
> > +#define KP_BASE_CLK          1000000
> > +#define MIN_CYCLE            0x10
> > +#define MIN_SCAN_CYCLE               0x100
> > +#define MIN_DBC_CYCLE                0x200
> > +
> > +/*
> > + * keypad Controller structure: stores sunxi keypad controller
> information
> > + *
> > + * @dev:             parent device
> > + * @input:           pointer to input device object
> > + * @apb_clk:         keypad Controller APB clock
> > + * @clk:             keypad Controller mod clock
> > + * @base:            keypad controller registers
> > + * @irq:             interrupt
> > + * @rows_en_mask:    Masks for enabled rows
> > + * @cols_en_mask:    Masks for enabled cols
> > + * @keymap:          matrix scan code table for keycodes
> > + * @key_press_state: cached keys press state
> > + * @debounce_cycl:   keypad specific debounce cycle
> > + * @scan_cycl:               keypad specific scan cycle
> > + * @autorepeat:         flag for auto repetition
> > + */
> > +struct sun4i_keypad_data {
> > +     struct device *dev;
> > +     struct input_dev *input;
> > +
> > +     struct clk *apb_clk;
> > +     struct clk *clk;
> > +     void __iomem *base;
> > +     int     irq;
> > +
> > +     unsigned short  rows_en_mask;
> > +     unsigned short  cols_en_mask;
> > +
> > +     unsigned short  keymap[MAX_MATRIX_KEY_NUM];
> > +
> > +     unsigned int press_state[N_ROWS_REG];
> > +
> > +     unsigned int debounce_cycl;
> > +     unsigned int scan_cycl;
> > +     bool    autorepeat;
> > +};
> > +
> > +static void sun4i_keypad_scan(struct sun4i_keypad_data *keypad, bool
> edge)
> > +{
> > +     struct input_dev *input_dev = keypad->input;
> > +     u32 key_scan[N_ROWS_REG];
> > +     unsigned long change;
> > +     unsigned short code;
> > +     int reg_nr, bit_nr, key_up;
> > +
> > +     for (reg_nr = 0; reg_nr < N_ROWS_REG; reg_nr++) {
> > +             key_scan[reg_nr] = ~(readl(keypad->base +
> > +                                     KP_INX_OFFSET(reg_nr)));
> > +
> > +             change = edge ? key_scan[reg_nr] :
> > +                     keypad->press_state[reg_nr] ^ key_scan[reg_nr];
> > +
> > +             key_up = edge || (change & keypad->press_state[reg_nr]);
> > +
> > +             for_each_set_bit(bit_nr, &change, BITS_PER_LONG) {
> > +                     code = keypad->keymap[KP_BIT_SHIFT * reg_nr +
> bit_nr];
> > +                     input_report_key(input_dev, code, key_up);
> > +                     input_sync(input_dev);
>
> I don't think you need to do an input_sync call each time for eah
> input_report_key.
>
> > +             }
> > +
> > +             keypad->press_state[reg_nr] = edge ?  0 : key_scan[reg_nr];
> > +     }
> > +}
> > +
> > +static irqreturn_t sun4i_keypad_irq(int irq, void *dev_id)
> > +{
> > +     struct sun4i_keypad_data *keypad = dev_id;
> > +     u32 intr_status;
> > +
> > +     intr_status  = readl(keypad->base + KP_INT_STA);
> > +
> > +     /* release only gives a valid information for a single key release
> */
> > +     if (intr_status & KP_STA_REDGE)
> > +             sun4i_keypad_scan(keypad, true);
> > +
> > +     /* press does not give valid information when
> > +      * multiple rows are selected
> > +     */
>
> /*
>  * This is the multi-line comment style
>  */
>
> > +     if (intr_status & KP_STA_FEDGE)
> > +             sun4i_keypad_scan(keypad, false);
> > +
> > +     writel(intr_status, keypad->base + KP_INT_STA);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int sun4i_keypad_open(struct input_dev *dev)
> > +{
> > +     struct sun4i_keypad_data *keypad = input_get_drvdata(dev);
> > +     int reg_nr;
> > +
> > +     if (clk_prepare_enable(keypad->apb_clk))
> > +             return -EINVAL;
> > +
> > +     if (clk_prepare_enable(keypad->clk)) {
> > +             clk_disable_unprepare(keypad->apb_clk);
> > +             return -EINVAL;
> > +     }
> > +
> > +     for (reg_nr = 0; reg_nr < N_ROWS_REG; reg_nr++)
> > +             keypad->press_state[reg_nr] = ~(readl(keypad->base +
> > +
>  KP_INX_OFFSET(reg_nr)));
> > +
> > +     writel(KP_IRQ_FEDGE | KP_IRQ_REDGE, keypad->base + KP_INT_CFG);
> > +
> > +     writel(SCAN_CYCLE(keypad->scan_cycl) |
> > +             DBC_CYCLE(keypad->debounce_cycl), keypad->base +
> KP_TIMING);
> > +
> > +     writel(ENABLE(1) | ROWMASK(keypad->rows_en_mask) |
> > +             COLMASK(keypad->cols_en_mask), keypad->base + KP_CTL);
> > +
> > +     return 0;
> > +}
> > +
> > +static void sun4i_keypad_close(struct input_dev *dev)
> > +{
> > +     struct sun4i_keypad_data *keypad = input_get_drvdata(dev);
> > +
> > +     writel(ENABLE(0) | ROWMASK(keypad->rows_en_mask) |
> > +             COLMASK(keypad->cols_en_mask), keypad->base + KP_CTL);
> > +
> > +     clk_disable_unprepare(keypad->clk);
> > +     clk_disable_unprepare(keypad->apb_clk);
> > +}
> > +
> > +static int sun4i_keypad_parse_dt(struct device *dev,
> > +                              struct sun4i_keypad_data *keypad)
> > +{
> > +     struct device_node *np;
> > +
> > +     np = dev->of_node;
> > +     if (!np)
> > +             return -EINVAL;
> > +
> > +     of_property_read_u32(np, "debounce-cycle", &keypad->debounce_cycl);
> > +     if (keypad->debounce_cycl < MIN_CYCLE)
> > +             keypad->debounce_cycl = MIN_DBC_CYCLE;
> > +
> > +     of_property_read_u32(np, "scan-cycle", &keypad->scan_cycl);
> > +     if (keypad->scan_cycl < MIN_CYCLE)
> > +             keypad->scan_cycl = MIN_SCAN_CYCLE;
> > +
> > +     if (of_property_read_bool(np, "autorepeat"))
> > +             keypad->autorepeat = true;
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun4i_keypad_probe(struct platform_device *pdev)
> > +{
> > +     struct sun4i_keypad_data *keypad;
> > +     struct device *dev = &pdev->dev;
> > +     int row, col, code;
> > +     int ret = 0;
> > +
> > +     keypad = devm_kzalloc(dev, sizeof(struct sun4i_keypad_data),
> > +                           GFP_KERNEL);
> > +     if (!keypad)
> > +             return -ENOMEM;
> > +
> > +     ret  = sun4i_keypad_parse_dt(dev, keypad);
> > +     if (ret)
> > +             return ret;
> > +
> > +     keypad->base = devm_ioremap_resource(dev,
> > +                           platform_get_resource(pdev, IORESOURCE_MEM,
> 0));
>
> Usually, it gets called on two lines to make it clearer.
>
> > +     if (IS_ERR(keypad->base))
> > +             return PTR_ERR(keypad->base);
> > +
> > +     keypad->dev = dev;
> > +     keypad->input = devm_input_allocate_device(dev);
> > +     if (!keypad->input)
> > +             return -ENOMEM;
> > +
> > +     keypad->input->name = pdev->name;
> > +     keypad->input->phys = "sun4i_keypad/input0";
> > +
> > +     keypad->input->id.bustype = BUS_HOST;
> > +     keypad->input->id.vendor  = 0x0001;
> > +     keypad->input->id.product = 0x0001;
> > +     keypad->input->id.version = 0x0100;
> > +
> > +     keypad->input->open = sun4i_keypad_open;
> > +     keypad->input->close = sun4i_keypad_close;
> > +
> > +     /* matrix keypad keymap as:
> > +      * row << 24 | column << 16 | key-code
> > +      */
> > +     ret = matrix_keypad_build_keymap(NULL, NULL,
> > +                                      KP_MAX_ROWS,
> > +                                      KP_MAX_COLS,
> > +                                      keypad->keymap,
> > +                                      keypad->input);
> > +     if (ret) {
> > +             dev_err(dev, "failed to build keymap\n");
> > +             return ret;
> > +     }
> > +
> > +     /* Search for enabled rows and cols */
> > +     for (row = 0; row < KP_MAX_ROWS; row++) {
> > +             for (col = 0; col < KP_MAX_COLS; col++) {
> > +                     code = MATRIX_SCAN_CODE(row, col, KP_ROW_SHIFT);
> > +                     if (keypad->keymap[code] != KEY_RESERVED) {
> > +                             keypad->rows_en_mask |= 1 << row;
> > +                             keypad->cols_en_mask |= 1 << col;
> > +                     }
> > +             }
> > +     }
> > +
> > +     if (keypad->autorepeat)
> > +             __set_bit(EV_REP, keypad->input->evbit);
> > +
> > +     input_set_capability(keypad->input, EV_MSC, MSC_SCAN);
> > +     input_set_drvdata(keypad->input, keypad);
> > +
> > +     keypad->irq = platform_get_irq(pdev, 0);
> > +     if (keypad->irq < 0) {
> > +             dev_err(dev, "failed to get keypad IRQ\n");
> > +             return -ENXIO;
> > +     }
> > +
> > +     ret = devm_request_irq(dev, keypad->irq,
> > +                            sun4i_keypad_irq, 0,
> > +                            "sun4i-a10-keypad", keypad);
> > +     if (ret) {
> > +             dev_err(dev, "failed to request IRQ\n");
> > +             return ret;
> > +     }
> > +
> > +     keypad->apb_clk = devm_clk_get(dev, "apb");
> > +     if (IS_ERR(keypad->apb_clk)) {
> > +             dev_err(dev, "failed to get a apb clock.\n");
> > +             return PTR_ERR(keypad->apb_clk);
> > +     }
> > +
> > +     keypad->clk = devm_clk_get(dev, "keypad");
> > +     if (IS_ERR(keypad->clk)) {
> > +             dev_err(dev, "failed to get a keypad clock.\n");
> > +             return PTR_ERR(keypad->clk);
> > +     }
> > +
> > +     ret = clk_set_rate(keypad->clk, KP_BASE_CLK);
> > +     if (ret) {
> > +             dev_err(dev, "set keypad base clock failed!\n");
> > +             return ret;
> > +     }
>
> Do you need that rate to be enforced, or is it some leftover from the
> allwinner BSP?
>
> > +     ret = input_register_device(keypad->input);
> > +     if (ret)
> > +             return ret;
> > +
> > +     platform_set_drvdata(pdev, keypad);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sun4i_keypad_remove(struct platform_device *pdev)
> > +{
> > +     struct sun4i_keypad_data *keypad = platform_get_drvdata(pdev);
> > +
> > +     free_irq(keypad->irq, keypad);
> > +     input_unregister_device(keypad->input);
> > +     kfree(keypad);
>
> The point of using devm_ functions is precisely to remove the removal
> code from both the probe error path (and you did so there), and from
> the remove.
>
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id sun4i_keypad_of_match[] = {
> > +     { .compatible = "allwinner,sun4i-a10-keypad", },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sun4i_keypad_of_match);
> > +
> > +static struct platform_driver sun4i_keypad_driver = {
> > +     .driver = {
> > +             .name   = "sun4i-a10-keypad",
> > +             .of_match_table = of_match_ptr(sun4i_keypad_of_match),
> > +     },
> > +     .probe  = sun4i_keypad_probe,
> > +     .remove = sun4i_keypad_remove,
> > +};
> > +
> > +module_platform_driver(sun4i_keypad_driver);
> > +
> > +MODULE_DESCRIPTION("Allwinner sun4i keypad controller driver");
> > +MODULE_AUTHOR("Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> > +MODULE_LICENSE("GPL");
> > +
>
> It looks good otherwise, thanks!
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--001a1140c226bb23fd051ffa7dc2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Maxime<br><br>I appreciate your time and efforts .<br><=
br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(=
204,204,204);padding-left:1ex" class=3D"gmail_quote">Do you need that rate =
to be enforced, or is it some leftover from the<br>
allwinner BSP?</blockquote><div><br></div><div>I&#39;ve found that clock ra=
te works fine with the default denounce and scan cycle.<br></div><div>By th=
e way do you have any dev board which expose the keypad pins?<br><br></div>=
<div>I will try to submit a follow up patch to address these issues.<br></d=
iv><div>Thank you again for your valuable review.<br><br></div><div><br></d=
iv><div>Regards. <br></div>=C2=A0<div><div>=C2=A0<br></div></div></div><div=
 class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Sep 17, 2015 =
at 11:05 PM, Maxime Ripard <span dir=3D"ltr">&lt;<a href=3D"mailto:maxime.r=
ipard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" target=3D"_blank">maxime.ripard-wi1+55ScJUtKEb57/3fJTGGXanvQGlWp@public.gmane.org=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Wed, Sep 16, 2015 at 12:05:56AM +1000, <a href=3D"mailto:yassinjaffer@gm=
ail.com">yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> wrote:<br>
&gt; From: Yassin Jaffer &lt;<a href=3D"mailto:yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">yass=
injaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; Allwinnner SUN4i Keypad controller is used to interface a SoC<br>
&gt; with a matrix-typekeypad device.<br>
&gt; The keypad controller supports multiple row and column lines.<br>
&gt; A key can be placed at each intersection of a unique<br>
&gt; row and a unique column.<br>
&gt; The keypad controller can sense a key-press and key-release and report=
 the<br>
&gt; event using a interrupt to the cpu.<br>
&gt; This patch adds a driver support to this.<br>
&gt; The keypad controller driver does not give proper information<br>
&gt; if more that two keys are selected.<br>
&gt;<br>
&gt; Signed-off-by: Yassin Jaffer &lt;<a href=3D"mailto:yassinjaffer@gmail.=
com">yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/input/keyboard/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 11 ++<br>
&gt;=C2=A0 drivers/input/keyboard/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/input/keyboard/sun4i-keypad.c | 361 ++++++++++++++++++++=
++++++++++++++<br>
&gt;=C2=A0 3 files changed, 373 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/input/keyboard/sun4i-keypad.c<br>
&gt;<br>
&gt; diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/K=
config<br>
&gt; index 2e80107..4f2f3f8 100644<br>
&gt; --- a/drivers/input/keyboard/Kconfig<br>
&gt; +++ b/drivers/input/keyboard/Kconfig<br>
&gt; @@ -590,6 +590,17 @@ config KEYBOARD_SUN4I_LRADC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, c=
hoose M here: the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called sun4i-lradc-key=
s.<br>
&gt;<br>
&gt; +config KEYBOARD_SUN4I_KEYPAD<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;Allwinner sun4i keypad support&quo=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on ARCH_SUNXI<br>
<br>
Is this IP found on all the know SoCs, or just a subset of them?<br>
<br>
You probably want to add || COMPILE_TEST in that depends on too.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0select INPUT_MATRIXKMAP<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0This selects support for the Allwinner key=
pad<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0on Allwinner sunxi SoCs.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, choose=
 M here: the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called sun4i-keypad.<br>
&gt; +<br>
&gt;=C2=A0 config KEYBOARD_DAVINCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;TI DaVinci Key Scan&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_DAVINCI_DM365<br>
&gt; diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/=
Makefile<br>
&gt; index 1d416dd..d9f54b4 100644<br>
&gt; --- a/drivers/input/keyboard/Makefile<br>
&gt; +++ b/drivers/input/keyboard/Makefile<br>
&gt; @@ -57,6 +57,7 @@ obj-$(CONFIG_KEYBOARD_STMPE)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D stmpe-keypad.o<br>
&gt;=C2=A0 obj-$(CONFIG_KEYBOARD_STOWAWAY)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 +=3D stowaway.o<br>
&gt;=C2=A0 obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)=C2=A0 =C2=A0 +=3D st-keyscan.o=
<br>
&gt;=C2=A0 obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)=C2=A0 =C2=A0+=3D sun4i-lradc-=
keys.o<br>
&gt; +obj-$(CONFIG_KEYBOARD_SUN4I_KEYPAD)=C2=A0 +=3D sun4i-keypad.o<br>
&gt;=C2=A0 obj-$(CONFIG_KEYBOARD_SUNKBD)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 +=3D sunkbd.o<br>
&gt;=C2=A0 obj-$(CONFIG_KEYBOARD_TC3589X)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0+=3D tc3589x-keypad.o<br>
&gt;=C2=A0 obj-$(CONFIG_KEYBOARD_TEGRA)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=
=3D tegra-kbc.o<br>
&gt; diff --git a/drivers/input/keyboard/sun4i-keypad.c b/drivers/input/key=
board/sun4i-keypad.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..995f9665<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/input/keyboard/sun4i-keypad.c<br>
&gt; @@ -0,0 +1,361 @@<br>
&gt; +/*<br>
&gt; + * Allwinner sun4i keypad Controller driver<br>
&gt; + *<br>
&gt; + * Copyright (C) 2015 Yassin Jaffer &lt;<a href=3D"mailto:yassinjaffe=
r@gmail.com">yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; + *<br>
&gt; + * Parts of this software are based on (derived from):<br>
&gt; + * Copyright (C) 2013-2015 <a href=3D"mailto:liming-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org=
">liming-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org</a>,<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 qys&lt;<a href=3D"mailto:qinyongshen-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org">qinyongshen@all=
winnertech.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation; either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/clk.h&gt;<br>
&gt; +#include &lt;linux/io.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +#include &lt;linux/err.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +#include &lt;linux/of_platform.h&gt;<br>
&gt; +#include &lt;linux/slab.h&gt;<br>
&gt; +#include &lt;linux/input.h&gt;<br>
&gt; +#include &lt;linux/input/matrix_keypad.h&gt;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Keypad Controller registers<br>
&gt; + */<br>
&gt; +#define KP_CTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00=C2=A0 /* Keypad Control register */<br>
&gt; +#define KP_TIMING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04=C2=A0=
 /* Keypad Timing register */<br>
&gt; +#define KP_INT_CFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08=C2=A0=
 /* Keypad interrupt Config register */<br>
&gt; +#define KP_INT_STA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0c=C2=A0=
 /* Keypad interrupt Status register */<br>
&gt; +<br>
&gt; +#define KP_IN_OFFSET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10 /* Keypad =
Input Data register 0 */<br>
&gt; +#define KP_INX_OFFSET(reg_n) (KP_IN_OFFSET + 4 * (reg_n))<br>
&gt; +<br>
&gt; +/* KP_CTL bits */<br>
&gt; +#define ENABLE(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((x) &lt;&=
lt; 0)<br>
&gt; +#define COLMASK(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((~x &amp;=
 0xff) &lt;&lt; 8)<br>
&gt; +#define ROWMASK(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((~x &amp;=
 0xff) &lt;&lt; 16)<br>
<br>
Having the name of the register in that define would be great, to spot<br>
more easily issues (writing a value to another register, for example).<br>
<br>
Something like KP_CTL_ENABLE(x) in this case.<br>
<br>
&gt; +/* KP_TIMING bits */<br>
&gt; +#define SCAN_CYCLE(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ((x) &lt;&lt; 0)<br>
&gt; +#define DBC_CYCLE(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((x) &lt;&lt; 1=
6)<br>
&gt; +<br>
&gt; +/* KP_INT_CFG bits */<br>
&gt; +#define KP_IRQ_FEDGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 KP_IRQ_REDGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 BIT(1)<br>
&gt; +<br>
&gt; +/* KP_INT_STA bits */<br>
&gt; +#define KP_STA_FEDGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 KP_STA_REDGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 BIT(1)<br>
&gt; +<br>
&gt; +#define KP_MAX_ROWS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt; +#define KP_MAX_COLS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt; +#define N_ROWS_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
&gt; +#define KP_ROW_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt; +#define KP_BIT_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32<br>
&gt; +<br>
&gt; +#define MAX_MATRIX_KEY_NUM=C2=A0 =C2=A0(KP_MAX_ROWS * KP_MAX_COLS)<br=
>
&gt; +<br>
&gt; +#define KP_BASE_CLK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1000000<br>
&gt; +#define MIN_CYCLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10<br>
&gt; +#define MIN_SCAN_CYCLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x100<br>
&gt; +#define MIN_DBC_CYCLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x200<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * keypad Controller structure: stores sunxi keypad controller inform=
ation<br>
&gt; + *<br>
&gt; + * @dev:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parent device=
<br>
&gt; + * @input:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pointer to input d=
evice object<br>
&gt; + * @apb_clk:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad Controller APB c=
lock<br>
&gt; + * @clk:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad Contro=
ller mod clock<br>
&gt; + * @base:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad controller =
registers<br>
&gt; + * @irq:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt<br>
&gt; + * @rows_en_mask:=C2=A0 =C2=A0 Masks for enabled rows<br>
&gt; + * @cols_en_mask:=C2=A0 =C2=A0 Masks for enabled cols<br>
&gt; + * @keymap:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matrix scan code table =
for keycodes<br>
&gt; + * @key_press_state: cached keys press state<br>
&gt; + * @debounce_cycl:=C2=A0 =C2=A0keypad specific debounce cycle<br>
&gt; + * @scan_cycl:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
keypad specific scan cycle<br>
&gt; + * @autorepeat:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag for auto repeti=
tion<br>
&gt; + */<br>
&gt; +struct sun4i_keypad_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct input_dev *input;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk *apb_clk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk *clk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0irq;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned short=C2=A0 rows_en_mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned short=C2=A0 cols_en_mask;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned short=C2=A0 keymap[MAX_MATRIX_KEY_NUM];<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int press_state[N_ROWS_REG];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int debounce_cycl;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int scan_cycl;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 autorepeat;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void sun4i_keypad_scan(struct sun4i_keypad_data *keypad, bool =
edge)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct input_dev *input_dev =3D keypad-&gt;input;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 key_scan[N_ROWS_REG];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long change;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned short code;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int reg_nr, bit_nr, key_up;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (reg_nr =3D 0; reg_nr &lt; N_ROWS_REG; reg_nr=
++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0key_scan[reg_nr] =3D =
~(readl(keypad-&gt;base +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KP_INX_OFFSE=
T(reg_nr)));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0change =3D edge ? key=
_scan[reg_nr] :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0keypad-&gt;press_state[reg_nr] ^ key_scan[reg_nr];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0key_up =3D edge || (c=
hange &amp; keypad-&gt;press_state[reg_nr]);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_set_bit(bit_=
nr, &amp;change, BITS_PER_LONG) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0code =3D keypad-&gt;keymap[KP_BIT_SHIFT * reg_nr + bit_nr];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0input_report_key(input_dev, code, key_up);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0input_sync(input_dev);<br>
<br>
I don&#39;t think you need to do an input_sync call each time for eah<br>
input_report_key.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad-&gt;press_stat=
e[reg_nr] =3D edge ?=C2=A0 0 : key_scan[reg_nr];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static irqreturn_t sun4i_keypad_irq(int irq, void *dev_id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun4i_keypad_data *keypad =3D dev_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 intr_status;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0intr_status=C2=A0 =3D readl(keypad-&gt;base + KP_=
INT_STA);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* release only gives a valid information for a s=
ingle key release */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (intr_status &amp; KP_STA_REDGE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sun4i_keypad_scan(key=
pad, true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* press does not give valid information when<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * multiple rows are selected<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
<br>
/*<br>
=C2=A0* This is the multi-line comment style<br>
=C2=A0*/<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (intr_status &amp; KP_STA_FEDGE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sun4i_keypad_scan(key=
pad, false);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(intr_status, keypad-&gt;base + KP_INT_STA)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sun4i_keypad_open(struct input_dev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun4i_keypad_data *keypad =3D input_get_dr=
vdata(dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int reg_nr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (clk_prepare_enable(keypad-&gt;apb_clk))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (clk_prepare_enable(keypad-&gt;clk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare=
(keypad-&gt;apb_clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (reg_nr =3D 0; reg_nr &lt; N_ROWS_REG; reg_nr=
++)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad-&gt;press_stat=
e[reg_nr] =3D ~(readl(keypad-&gt;base +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KP_INX_OFFSET(reg_nr)));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(KP_IRQ_FEDGE | KP_IRQ_REDGE, keypad-&gt;ba=
se + KP_INT_CFG);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(SCAN_CYCLE(keypad-&gt;scan_cycl) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DBC_CYCLE(keypad-&gt;=
debounce_cycl), keypad-&gt;base + KP_TIMING);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(ENABLE(1) | ROWMASK(keypad-&gt;rows_en_mas=
k) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COLMASK(keypad-&gt;co=
ls_en_mask), keypad-&gt;base + KP_CTL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void sun4i_keypad_close(struct input_dev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun4i_keypad_data *keypad =3D input_get_dr=
vdata(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel(ENABLE(0) | ROWMASK(keypad-&gt;rows_en_mas=
k) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COLMASK(keypad-&gt;co=
ls_en_mask), keypad-&gt;base + KP_CTL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(keypad-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(keypad-&gt;apb_clk);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sun4i_keypad_parse_dt(struct device *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sun4i_keypad_data *keypad)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device_node *np;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0np =3D dev-&gt;of_node;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!np)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0of_property_read_u32(np, &quot;debounce-cycle&quo=
t;, &amp;keypad-&gt;debounce_cycl);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (keypad-&gt;debounce_cycl &lt; MIN_CYCLE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad-&gt;debounce_c=
ycl =3D MIN_DBC_CYCLE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0of_property_read_u32(np, &quot;scan-cycle&quot;, =
&amp;keypad-&gt;scan_cycl);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (keypad-&gt;scan_cycl &lt; MIN_CYCLE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad-&gt;scan_cycl =
=3D MIN_SCAN_CYCLE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (of_property_read_bool(np, &quot;autorepeat&qu=
ot;))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad-&gt;autorepeat=
 =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sun4i_keypad_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun4i_keypad_data *keypad;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int row, col, code;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad =3D devm_kzalloc(dev, sizeof(struct sun4i_=
keypad_data),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!keypad)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret=C2=A0 =3D sun4i_keypad_parse_dt(dev, keypad);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;base =3D devm_ioremap_resource(dev,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_get_resource(pdev, IORESOURCE_MEM, 0))=
;<br>
<br>
Usually, it gets called on two lines to make it clearer.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(keypad-&gt;base))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(keypad=
-&gt;base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;dev =3D dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;input =3D devm_input_allocate_device(d=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!keypad-&gt;input)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;input-&gt;name =3D pdev-&gt;name;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;input-&gt;phys =3D &quot;sun4i_keypad/=
input0&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;input-&gt;id.bustype =3D BUS_HOST;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;input-&gt;id.vendor=C2=A0 =3D 0x0001;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;input-&gt;id.product =3D 0x0001;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;input-&gt;id.version =3D 0x0100;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;input-&gt;open =3D sun4i_keypad_open;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;input-&gt;close =3D sun4i_keypad_close=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* matrix keypad keymap as:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * row &lt;&lt; 24 | column &lt;&lt; 16 | key-cod=
e<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D matrix_keypad_build_keymap(NULL, NULL,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 KP_MAX_ROWS=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 KP_MAX_COLS=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad-&gt;=
keymap,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad-&gt;=
input);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;fa=
iled to build keymap\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Search for enabled rows and cols */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (row =3D 0; row &lt; KP_MAX_ROWS; row++) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (col =3D 0; col &=
lt; KP_MAX_COLS; col++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0code =3D MATRIX_SCAN_CODE(row, col, KP_ROW_SHIFT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (keypad-&gt;keymap[code] !=3D KEY_RESERVED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad-&gt;rows_en_mask |=3D 1 &lt;&lt; =
row;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keypad-&gt;cols_en_mask |=3D 1 &lt;&lt; =
col;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (keypad-&gt;autorepeat)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_bit(EV_REP, key=
pad-&gt;input-&gt;evbit);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_set_capability(keypad-&gt;input, EV_MSC, MS=
C_SCAN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_set_drvdata(keypad-&gt;input, keypad);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;irq =3D platform_get_irq(pdev, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (keypad-&gt;irq &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;fa=
iled to get keypad IRQ\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D devm_request_irq(dev, keypad-&gt;irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sun4i_keypad_irq, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sun4i-a10-keypad&quot;, keypad);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;fa=
iled to request IRQ\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;apb_clk =3D devm_clk_get(dev, &quot;ap=
b&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(keypad-&gt;apb_clk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;fa=
iled to get a apb clock.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(keypad=
-&gt;apb_clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0keypad-&gt;clk =3D devm_clk_get(dev, &quot;keypad=
&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(keypad-&gt;clk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;fa=
iled to get a keypad clock.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(keypad=
-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D clk_set_rate(keypad-&gt;clk, KP_BASE_CLK)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;se=
t keypad base clock failed!\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
Do you need that rate to be enforced, or is it some leftover from the<br>
allwinner BSP?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D input_register_device(keypad-&gt;input);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, keypad);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int sun4i_keypad_remove(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sun4i_keypad_data *keypad =3D platform_get=
_drvdata(pdev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0free_irq(keypad-&gt;irq, keypad);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_unregister_device(keypad-&gt;input);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kfree(keypad);<br>
<br>
The point of using devm_ functions is precisely to remove the removal<br>
code from both the probe error path (and you did so there), and from<br>
the remove.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct of_device_id sun4i_keypad_of_match[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;allwinner,sun4i-a10-keypa=
d&quot;, },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ /* sentinel */ }<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(of, sun4i_keypad_of_match);<br>
&gt; +<br>
&gt; +static struct platform_driver sun4i_keypad_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0=3D=
 &quot;sun4i-a10-keypad&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D o=
f_match_ptr(sun4i_keypad_of_match),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =3D sun4i_keypad_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.remove =3D sun4i_keypad_remove,<br>
&gt; +};<br>
&gt; +<br>
&gt; +module_platform_driver(sun4i_keypad_driver);<br>
&gt; +<br>
&gt; +MODULE_DESCRIPTION(&quot;Allwinner sun4i keypad controller driver&quo=
t;);<br>
&gt; +MODULE_AUTHOR(&quot;Yassin Jaffer &lt;<a href=3D"mailto:yassinjaffer@=
gmail.com">yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&quot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt; +<br>
<br>
It looks good otherwise, thanks!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Maxime<br>
<br>
--<br>
Maxime Ripard, Free Electrons<br>
Embedded Linux, Kernel and Android engineering<br>
<a href=3D"http://free-electrons.com" rel=3D"noreferrer" target=3D"_blank">=
http://free-electrons.com</a><br>
</font></span></blockquote></div><br></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--001a1140c226bb23fd051ffa7dc2--
